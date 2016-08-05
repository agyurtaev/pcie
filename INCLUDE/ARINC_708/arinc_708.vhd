--------------------------------------------------------------------------------
-- Company: SKIT
-- Engineer: Anton Klimovskikh
--
-- Create Date:    02.02.2014   
-- Design Name:    PCIE   
-- Module Name:    arinc_708   
-- Project Name:   pcie_top
-- Target Device:  EP4SGX230KF40C2
-- Description:    
-- Revision:       Revision 1.02
--
-- Additional Comments:
-- 
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY altera_mf;
USE altera_mf.all;
 
ENTITY arinc_708 IS 
GENERIC 
	(
	A708_DATA     : std_logic_vector(15 downto 0) := X"5000";
	A708_CTRL     : std_logic_vector(15 downto 0) := X"50D0";
	A708_EVENT    : std_logic_vector(15 downto 0) := X"50E0";
	A708_MASK     : std_logic_vector(15 downto 0) := X"50F0";
	A708_AL_FRAME : std_logic_vector(15 downto 0) := X"5100"
	);
PORT 
	(
	-- Global interface
		clk : in std_logic;
		nReset : in std_logic;
	
	-- WRITE DATA
		wr_adr : in std_logic_vector(31 downto 0);
		wr_data_1 : in std_logic_vector(31 downto 0);
		wr_be_1 : in std_logic_vector(3 downto 0);
		wren_1 : in std_logic;
		wr_data_0 : in std_logic_vector(31 downto 0);
		wr_be_0 : in std_logic_vector(3 downto 0);
		wren_0 :  in std_logic;

	-- READ DATA
		rd_adr : in std_logic_vector(31 downto 0);
		rd_adr_change_dff : in std_logic;
		rd_data_0 : out std_logic_vector(31 downto 0);
		rd_data_1 : out std_logic_vector(31 downto 0);

--***TEST
--	txd_out : out std_logic;
--	tx_clk_out : out std_logic;	
--	event_trg_out : out std_logic_vector(31 downto 0);
--***TEST
--TEST
	valid_indata_out : out std_logic;	
	wren_0_out : out std_logic;	
	wren_1_out : out std_logic;	
	tx_sclr_out : out std_logic;	
	tx_fifo_used_out : out std_logic_vector(10 downto 0);
	wx_fifo_rdreq_out : out std_logic;
	end_of_packet : out std_logic;
--TEST	

	-- INT ena
		int_ena : out std_logic;

	-- A708 interface
		a708_TX  : out std_logic;
		a708_TXn : out std_logic;
	
		a708_RX  : in std_logic;
		a708_RXn : in std_logic;
	
		a708_TXINH : out std_logic;
		a708_RXEN  : out std_logic

	);
END arinc_708;

ARCHITECTURE RTL OF arinc_708 IS

--TEST
--	constant PERIOD_CONST  : std_logic_vector(7 downto 0) := X"09"; -- 9
--	constant PACKET_LENGTH : std_logic_vector(12 downto 0) := '0'&X"00F"; -- 15
--	constant PACKET_LENGTH_INT : integer := 15; -- 15
--
--	constant NOP_LENGTH_A  : std_logic_vector(12 downto 0) := '0'&X"01F"; -- 2309
--	constant NOP_LENGTH_B  : std_logic_vector(12 downto 0) := '0'&X"02F"; -- 6219
--TEST

	-- INT ena
	signal int_ena_node : std_logic;

	constant PERIOD_CONST         : std_logic_vector(7 downto 0) := X"7C"; -- 124
	constant HALF_PERIOD_CONST    : std_logic_vector(7 downto 0) := ('0'&PERIOD_CONST(7 downto 1)); --X"3E"; -- 62
	constant QUARTER_PERIOD_CONST : std_logic_vector(7 downto 0) := ('0'&HALF_PERIOD_CONST(7 downto 1)); --X"1F"; -- 31

	constant PACKET_LENGTH : std_logic_vector(12 downto 0) := '0'&X"63F"; -- 1599
	constant PACKET_LENGTH_INT : integer := 1599; -- 1599

	constant NOP_LENGTH_A  : std_logic_vector(12 downto 0) := '0'&X"905"; -- 2309
	constant NOP_LENGTH_B  : std_logic_vector(12 downto 0) := '1'&X"84B"; -- 6219

	constant SYNC_START_STOP_TIME : std_logic_vector(8 downto 0) := (PERIOD_CONST&'0') + ('0'&PERIOD_CONST); 
	 
	
	constant SYNCH_VALID_TIME : std_logic_vector(8 downto 0) := '0'&X"FF";

	signal ctrl_ff : std_logic_vector(7 downto 0);

	signal mask_ff : std_logic_vector(7 downto 0); -- mask register
	
	signal type_sel : std_logic_vector(1 downto 0); -- "00" = tx/rx disable; "01" = rx enable; "10" = tx enable; "11" - reserved;
		signal tx_data_ena : std_logic;
		signal rx_data_ena : std_logic;
		
	signal tx_sclr : std_logic; -- '1' - then synch reset TX
	signal rx_sclr : std_logic; -- '1' - then synch reset RX
	signal tx_nop_sel : std_logic; -- '1' = alarm packet transmit ena; '0' = TX=nTX=0;
	signal alarm_packet : std_logic_vector(1599 downto 0); -- alarm packet
	signal alarm_frame_ff : std_logic_vector(2047 downto 0);
	signal a708_worder : std_logic;

-- reset front impuls
	signal tx_sclr_trg : std_logic;
	signal rx_sclr_trg : std_logic;

	signal event_trg : std_logic; -- status read trg
	signal alarm_frame_trg : std_logic_vector(31 downto 0);
	signal ctrl_trg : std_logic; -- control read trg
	signal mask_trg : std_logic;
	signal event_trg_dff : std_logic;
	signal sts_data : std_logic_vector(63 downto 0); -- status read register
	signal sts_ff : std_logic_vector(29 downto 0); -- status bus
	signal rx_err : std_logic;
	signal event_rxne : std_logic; 
	signal event_txnf : std_logic;
	signal event_rxor : std_logic;
	
	component divider
		PORT
		(
			clock		: IN STD_LOGIC ;
			denom		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			numer		: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
			quotient		: OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
			remain		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
	end component;
	signal rx_fifo_used_in_packet : std_logic_vector(10 downto 0); 
	signal tx_fifo_used_in_packet : std_logic_vector(10 downto 0); 
	
-- fifo data
	signal tx_fifo_used : std_logic_vector(10 downto 0);
	signal tx_data_fifo_empty : std_logic;

	signal tx_data_fifo_empty_trg : std_logic; -- empty trg
	
	signal rx_fifo_used : std_logic_vector(10 downto 0);
	signal rx_data_fifo_full : std_logic;

--==================================================--
--================== Transmitter ===================--
--==================================================--
-- transmit clock divider counter
	signal clk_div_count : std_logic_vector(7 downto 0);
	signal clk_half_period : std_logic;
	signal clk_full_period : std_logic;
	
	signal valid_indata : std_logic;

-- pre safe register 
	signal fifo_data : std_logic_vector(63 downto 0);
	signal wr_req_fifo : std_logic;

-- write fifo
	COMPONENT wx_fifo
	PORT
	(
		aclr		: IN STD_LOGIC  := '0';
		data		: IN STD_LOGIC_VECTOR (63 DOWNTO 0);
		rdclk		: IN STD_LOGIC ;
		rdreq		: IN STD_LOGIC ;
		wrclk		: IN STD_LOGIC ;
		wrreq		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		rdempty		: OUT STD_LOGIC ;
		rdusedw		: OUT STD_LOGIC_VECTOR (10 DOWNTO 0)
	);
	END COMPONENT;

	signal wx_fifo_q : std_logic_vector(7 downto 0);
	signal wx_fifo_rdreq : std_logic;

	-- state
	type state_tx is
	(idle, st_sync_start, st_sync_stop, st_packet_trans, st_pause_trans, st_alarm_trans);
	-- state registers
	signal st_tx_reg, st_tx_next : state_tx;	

	-- straight data
	signal txd_reg, txd_next : std_logic;
	-- transmit alarm active trigger
	signal trans_alarm_active_reg, trans_alarm_active_next : std_logic;
	-- transmit active trigger
	signal trans_active_reg, trans_active_next : std_logic;
	-- packet bit count
	signal packet_bit_count_reg, packet_bit_count_next : std_logic_vector(12 downto 0);
	-- current packet data
	signal cur_packet_reg, cur_packet_next : std_logic_vector(1598 downto 0);
	-- read ack
	signal wx_fifo_rdreq_reg, wx_fifo_rdreq_next : std_logic;
	-- tx clock 
	signal tx_clk_reg, tx_clk_next : std_logic;
	-- sync count
	signal sync_count_reg, sync_count_next : std_logic_vector(1 downto 0);
	-- transmit full active trigger
	signal trans_full_active_reg, trans_full_active_next : std_logic;

--===============================================--
--================== Receiver ===================--
--===============================================--
-- input data trigger
	signal in_data_trg_pos : std_logic;
--	signal in_data_trg_neg : std_logic;
	signal in_data_trg_pos_dff : std_logic;
	signal in_data_trg_pos_dff_dff : std_logic;
	signal in_data_edge_trg : std_logic;
	signal in_data : std_logic;

	signal pos_neg_chech_synch_trg : std_logic; -- pos/neg check synchro trg
	signal pos_neg_chech_synch_count : std_logic_vector(8 downto 0); -- pos/neg check synchro count
	signal fail_pos_neg_check_synch_trg : std_logic; -- pos/neg check synchro fail trg


	-- state
	type state_rx is
	(idle, st_pre_synch, st_synch, st_pre_data_valid, st_data_valid, st_post_synch);
	-- state registers
	signal st_rx_reg, st_rx_next : state_rx;	

	-- pre synch counter
	signal pre_synch_count_reg, pre_synch_count_next : std_logic_vector(7 downto 0);
	-- receive write request fifo	
	signal rx_wr_req_fifo_reg, rx_wr_req_fifo_next : std_logic;
	-- time of (data_in = '1')
	signal synch_count_ff_reg, synch_count_ff_next : std_logic_vector(7 downto 0);
	-- synch counter
	signal synch_count_reg, synch_count_next : std_logic_vector(7 downto 0);
	-- error code
	signal error_code_reg, error_code_next : std_logic_vector(3 downto 0);
	-- pre data valid counter
	signal pre_data_valid_count_reg, pre_data_valid_count_next : std_logic_vector(7 downto 0);
	-- period counter
	signal period_count_reg, period_count_next : std_logic_vector(7 downto 0);
	-- bit counter
	signal bit_count_reg, bit_count_next : std_logic_vector(10 downto 0);
	-- receive write fifo data
	signal rx_wx_fifo_data_reg, rx_wx_fifo_data_next : std_logic_vector(7 downto 0);
	-- bit to byte counter
	signal bit_to_byte_count_reg, bit_to_byte_count_next : std_logic_vector(2 downto 0);
	-- post synch counter
	signal post_synch_count_next, post_synch_count_reg : std_logic_vector(8 downto 0);

	COMPONENT rx_fifo
	PORT
	(
		aclr		: IN STD_LOGIC  := '0';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		rdclk		: IN STD_LOGIC ;
		rdreq		: IN STD_LOGIC ;
		wrclk		: IN STD_LOGIC ;
		wrreq		: IN STD_LOGIC ;
		rdempty		: OUT STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		wrusedw		: OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
		wrfull		: OUT STD_LOGIC 
	);
	END COMPONENT;

	signal rd_fifo_q : std_logic_vector(31 downto 0);
				
-- receive data address detect trigger
	signal rx_data_trg : std_logic;
	signal rx_data_trg_dff : std_logic;
--===============================================--

BEGIN

-- INT ena
	int_ena <= 	(rx_err and mask_ff(3)) or
				(event_rxne and mask_ff(0)) or
				(event_txnf and mask_ff(1)) or
				(event_rxor and mask_ff(7)) or
				(fail_pos_neg_check_synch_trg and mask_ff(2));

-- mask register
	process (clk, nReset)
	begin
		if (nReset = '0') then
			mask_ff <= (others => '0');
		elsif rising_edge(clk) then
			if (wr_adr(15 downto 4) = A708_MASK(15 downto 4)) then
				if (wr_be_0(0) = '1') and (wren_0 = '1') then
					mask_ff(7 downto 0) <= wr_data_0(7 downto 0);
				end if;
			end if;
		end if;
	end process;


-- reset and select mode register
	process (clk, nReset)
	begin
		if (nReset = '0') then
			ctrl_ff <= (others => '0');
		elsif rising_edge(clk) then
			if (wr_adr(15 downto 4) = A708_CTRL(15 downto 4)) then
				if (wr_be_0(0) = '1') and (wren_0 = '1') then
					ctrl_ff(7 downto 0) <= wr_data_0(7 downto 0);
				end if;
			end if;
		end if;
	end process;

-- alarm frame data
	process (clk, nReset)
	begin
		if (nReset = '0') then
			alarm_frame_ff <= (others => '0');
		elsif rising_edge(clk) then
			if (wr_adr(15 downto 8) = A708_AL_FRAME(15 downto 8)) then
				for j in 0 to 31 loop
					if wr_adr(7 downto 3) = j then
						for i in 0 to 3 loop 
							if (wr_be_0(i) = '1') and (wren_0 = '1') then
								alarm_frame_ff(7 + 8*i + 64*j downto 0 + 8*i + 64*j) <= wr_data_0(7 + 8*i downto 0 + 8*i);
							end if;
							if (wr_be_1(i) = '1') and (wren_1 = '1') then
								alarm_frame_ff(39 + 8*i + 64*j downto 32 + 8*i + 64*j) <= wr_data_1(7 + 8*i downto 0 + 8*i);
							end if;
						end loop;
					end if;
				end loop;
			end if;
		end if;
	end process;


-- reset front impuls
	process (clk, nReset)
	begin
		if (nReset = '0') then
			tx_sclr_trg <= '0';
			rx_sclr_trg <= '0';
		elsif rising_edge(clk) then
			tx_sclr_trg <= ctrl_ff(2);
			rx_sclr_trg <= ctrl_ff(3);
		end if;
	end process;	

	type_sel <= ctrl_ff(1 downto 0); -- "00" = tx/rx disable; "01" = rx enable; "10" = tx enable; "11" - reserved;
	tx_data_ena <= '1' when (type_sel = "10") else '0';
	rx_data_ena <= '1' when (type_sel = "01") else '0';
	
	tx_sclr <= ctrl_ff(2) and not tx_sclr_trg; -- '1' - then synch reset TX
	rx_sclr <= ctrl_ff(3) and not rx_sclr_trg; -- '1' - then synch reset RX
	tx_nop_sel <= ctrl_ff(4); -- '1' = alarm packet transmit ena; '0' = TX=nTX=0;
	alarm_packet <= alarm_frame_ff(1599 downto 0); -- alarm packet
	a708_worder <= ctrl_ff(5); -- 0 - �B - non-interlaced�, 1 - �A - in-terlaced�
	a708_TXINH <= ctrl_ff(6);
	a708_RXEN  <= ctrl_ff(7); 

-- status read trg
	process (clk, nReset)
	begin
		if (nReset = '0') then
			alarm_frame_trg <= (others => '0');
			event_trg <= '0';
			ctrl_trg <= '0';
			mask_trg <= '0';
			event_trg_dff <= '0';
		elsif rising_edge(clk) then
			if (rd_adr(15 downto 8) = A708_AL_FRAME(15 downto 8)) then
				for i in 0 to 31 loop
					if (rd_adr(7 downto 3) = i) then
						alarm_frame_trg(i) <= '1';
					else
						alarm_frame_trg(i) <= '0';
					end if;
				end loop;
			elsif (rd_adr(15 downto 4) = A708_EVENT(15 downto 4)) then
				event_trg <= '1';
			elsif (rd_adr(15 downto 4) = A708_CTRL(15 downto 4)) then
				ctrl_trg <= '1';
			elsif (rd_adr(15 downto 4) = A708_MASK(15 downto 4)) then
				mask_trg <= '1';
			else 
				alarm_frame_trg <= (others => '0');
				event_trg <= '0';
				ctrl_trg <= '0';
				mask_trg <= '0';
			end if;
			event_trg_dff <= event_trg;
		end if;
	end process;

-- status read register
	process (clk, nReset)
	begin
		if (nReset = '0') then
			sts_data <= (others => '0');
		elsif rising_edge(clk) then
			if (alarm_frame_trg > 0) then
				for i in 0 to 31 loop
					if (alarm_frame_trg(i) = '1') then
						sts_data <= alarm_frame_ff(63 + 64*i downto 0 + 64*i);
					end if;
				end loop;
			elsif (event_trg = '1') then
				sts_data(63 downto 30) <= (others => '0');
				sts_data(29 downto 0) <= sts_ff(29 downto 0);
			elsif (ctrl_trg = '1') then
				sts_data(63 downto 8) <= (others => '0');
				sts_data(7 downto 0) <= ctrl_ff(7 downto 0);
			elsif (mask_trg = '1') then
				sts_data(63 downto 8) <= (others => '0');
				sts_data(7 downto 0) <= mask_ff(7 downto 0);
			else
				sts_data <= (others => '0');
			end if;
		end if;
	end process;

-- status bus
	sts_ff(0) <= event_rxne; 
	sts_ff(1) <= event_txnf; 
	sts_ff(2) <= fail_pos_neg_check_synch_trg;
	sts_ff(5 downto 3) <= error_code_reg(2 downto 0);
	sts_ff(6) <= '0';
	sts_ff(7) <= event_rxor;
	
	sts_ff(18 downto 8) <= tx_fifo_used; -- [10..0]
	sts_ff(29 downto 19) <= rx_fifo_used; -- [10..0]

	rx_err <= '1' when (error_code_reg(2 downto 0) > 0) else '0';
	event_rxne <= '1' when (rx_fifo_used > 199) else '0';
	event_txnf <= '1' when (tx_fifo_used < 1801) else '0';
	event_rxor <= '1' when (rx_fifo_used > 1999) else '0';

--	tx_fifo_used_in_packet_cmp : divider
--		PORT MAP
--		(
--			clock => clk,
--			denom => X"C8", -- 200 byte
--			numer => tx_fifo_used,
--			quotient => tx_fifo_used_in_packet,
--			remain => open
--		);
--
--	rx_fifo_used_in_packet_cmp : divider
--		PORT MAP
--		(
--			clock => clk,
--			denom => X"C8", -- 200 byte
--			numer => rx_fifo_used,
--			quotient => rx_fifo_used_in_packet,
--			remain => open
--		);
--	
--	rd_data_0 <= sts_data(31 downto 0);
--	rd_data_1 <= sts_data(63 downto 32);

--***TEST
--	txd_out <= txd_reg;
--	tx_clk_out <= tx_clk_reg;	
--	event_trg_out <= event_trg;
--***TEST

--==================================================--
--================== Transmitter ===================--
--==================================================--
-- transmit clock divider counter
	process (clk, nReset)
	begin
		if (nReset = '0') then
			clk_div_count <= (others => '0');
			clk_half_period <= '0';
			clk_full_period <= '0';
		elsif rising_edge(clk) then
			if (tx_sclr = '1') then
				clk_div_count <= (others => '0');
				clk_half_period <= '0';
				clk_full_period <= '0';
			else
				if (clk_div_count = PERIOD_CONST) then
					clk_div_count <= (others => '0');	
				else
					clk_div_count <= clk_div_count + 1;
				end if;
				if    (clk_div_count = HALF_PERIOD_CONST - 2) then
					clk_half_period <= '1';
				elsif (clk_div_count = PERIOD_CONST - 2) then
					clk_full_period <= '1';
				else 
					clk_half_period <= '0';
					clk_full_period <= '0';
				end if;				
			end if;
		end if;
	end process;

	valid_indata <= '1' when (wr_adr(15 downto 4) = A708_DATA(15 downto 4)) else '0';

-- pre safe register 
	process (clk, nReset)
	begin
		if (nReset = '0') then
			fifo_data <= (others => '0');
			wr_req_fifo <= '0';
		elsif rising_edge(clk) then
			if (tx_sclr = '1') then
				fifo_data <= (others => '0');
				wr_req_fifo <= '0';
			else
				if (wren_0 = '1') and (valid_indata = '1') then
					fifo_data(31 downto 0)  <= wr_data_0;
				end if;
				if (wren_1 = '1') and (valid_indata = '1') then
					fifo_data(63 downto 32) <= wr_data_1;
				end if;
				wr_req_fifo <= wren_1 and valid_indata;
			end if;
		end if;
	end process;

-- write fifo
	write_fifo_component : wx_fifo
	PORT MAP (
		wrclk => clk,
		rdreq => wx_fifo_rdreq,
		aclr => not nReset or tx_sclr,
		rdclk => clk,
		wrreq => wr_req_fifo,-- and event_txnf,
		data => fifo_data,
		rdempty => tx_data_fifo_empty,
		q => wx_fifo_q,
		rdusedw => tx_fifo_used
	);

	wx_fifo_rdreq <= wx_fifo_rdreq_reg;

--TEST
	valid_indata_out <= valid_indata;
	wren_0_out <= wren_0;
	wren_1_out <= wren_1;
	tx_sclr_out <= tx_sclr;
	
	tx_fifo_used_out <= tx_fifo_used;
	wx_fifo_rdreq_out <= wx_fifo_rdreq;
	end_of_packet <= trans_full_active_reg;
--TEST	
	
-- empty trg
	process(clk, nReset)
	begin
		if (nReset = '0') then
			tx_data_fifo_empty_trg <= '0';
		elsif rising_edge(clk) then
			if (tx_sclr = '1') then
				tx_data_fifo_empty_trg <= '0';
			elsif (wx_fifo_rdreq = '1') and (tx_data_fifo_empty = '1') then
				tx_data_fifo_empty_trg <= '1';
			end if;
		end if;
	end process;
	
	process (clk, nReset)
	begin
		if (nReset = '0') then 
		-- state
			st_tx_reg <= idle;
		-- straight data
			txd_reg <= '0';
		-- transmit active trigger
			trans_active_reg <= '0';
		-- transmit alarm active trigger
			trans_alarm_active_reg <= '0';
		-- tx clock 
			tx_clk_reg <= '0';
		-- sync count
			sync_count_reg <= (others => '0');
		-- packet byte count
			packet_bit_count_reg <= (others => '0');
		-- current packet data
			cur_packet_reg <= (others => '0');
		-- read ack
			wx_fifo_rdreq_reg <= '0';
		-- transmit full active trigger
			trans_full_active_reg <= '0';
		elsif rising_edge(clk) then
			if (tx_sclr = '1') then
			-- state
				st_tx_reg <= idle;
			-- straight data
				txd_reg <= '0';
			-- transmit active trigger
				trans_active_reg <= '0';
			-- transmit alarm active trigger
				trans_alarm_active_reg <= '0';
			-- tx clock 
				tx_clk_reg <= '0';
			-- sync count
				sync_count_reg <= (others => '0');
			-- packet byte count
				packet_bit_count_reg <= (others => '0');
			-- current packet data
				cur_packet_reg <= (others => '0');
			-- read ack
				wx_fifo_rdreq_reg <= '0';
			-- transmit full active trigger
				trans_full_active_reg <= '0';
			else
			-- state
				st_tx_reg <= st_tx_next;
			-- straight data
				txd_reg <= txd_next;
			-- transmit active trigger
				trans_active_reg <= trans_active_next;
			-- transmit alarm active trigger
				trans_alarm_active_reg <= trans_alarm_active_next;
			-- tx clock 
				tx_clk_reg <= tx_clk_next;
			-- sync count
				sync_count_reg <= sync_count_next;
			-- packet byte count
				packet_bit_count_reg <= packet_bit_count_next;
			-- current packet data
				cur_packet_reg <= cur_packet_next;
			-- read ack
				wx_fifo_rdreq_reg <= wx_fifo_rdreq_next;
			-- transmit full active trigger
				trans_full_active_reg <= trans_full_active_next;
			end if;
		end if;
	end process;
		
-- next state logic
	process (
			st_tx_reg,
			txd_reg,
			trans_active_reg,
			trans_alarm_active_reg,
			tx_clk_reg,
			a708_worder,
			sync_count_reg,
			packet_bit_count_reg,
			cur_packet_reg,
			wx_fifo_rdreq_reg,
			tx_data_ena,
			tx_data_fifo_empty,
			tx_nop_sel,
			clk_full_period,
			alarm_packet,
			wx_fifo_q,
			clk_half_period,
			trans_full_active_reg
			)
	begin
	-- state
		st_tx_next <= st_tx_reg;
	-- straight data
		txd_next <= txd_reg;
	-- transmit active trigger
		trans_active_next <= trans_active_reg;
	-- transmit full active trigger
		trans_full_active_next <= trans_full_active_reg;
	-- transmit alarm active trigger
		trans_alarm_active_next <= trans_alarm_active_reg;
	-- sync count
		sync_count_next <= sync_count_reg;
	-- tx clock 
		tx_clk_next <= tx_clk_reg;
	-- packet byte count
		packet_bit_count_next <= packet_bit_count_reg;
	-- current packet data
		cur_packet_next <= cur_packet_reg;
	-- read ack
		wx_fifo_rdreq_next <= wx_fifo_rdreq_reg;

		case st_tx_reg is
	----------------------------------
			when idle =>
	----------------------------------
				if (tx_data_ena = '1') and (tx_data_fifo_empty = '1') and (tx_nop_sel = '0') then
				-- next state: idle
					st_tx_next <= idle;	
				-- straight data
					txd_next <= '0';
				elsif (clk_full_period = '1') and (tx_data_ena = '1') and (tx_data_fifo_empty = '1') and (tx_nop_sel = '1') then
				-- next state: sync start
					st_tx_next <= st_sync_start;
				-- trans alarm packet trg
					trans_alarm_active_next <= '1';
				-- sync start count
					sync_count_next <= (others => '0');
				-- current packet data
					txd_next <= '1';
				-- transmit full active trigger
					trans_full_active_next <= '1';
				elsif (clk_full_period = '1') and (tx_data_ena = '1') and (tx_data_fifo_empty = '0') and (tx_nop_sel = '0') then
				-- next state: sync start
					st_tx_next <= st_sync_start;
				-- trans alarm packet trg
					trans_alarm_active_next <= '0';
				-- sync start count
					sync_count_next <= (others => '0');
				-- current packet data
					txd_next <= '1';
				-- transmit full active trigger
					trans_full_active_next <= '1';
				else
				-- next state: idle
					st_tx_next <= idle;	
				-- out data
					txd_next <= '0';
				-- transmit full active trigger
					trans_full_active_next <= '0';
				-- packet byte count
					packet_bit_count_next <= (others => '0');
				end if;

	----------------------------------
			when st_sync_start =>
	----------------------------------
				if (trans_alarm_active_reg = '1') and (clk_full_period = '1') and (sync_count_reg = 2) then
				-- next state: alarm packet transmit
					st_tx_next <= st_alarm_trans;
				-- sync count
					sync_count_next <= (others => '0');
				-- trans alarm packet trg
					trans_alarm_active_next <= '0';
				-- transmit active trigger
					trans_active_next <= '1';
				-- clock 
					tx_clk_next <= '1';
				-- packet byte count
					packet_bit_count_next <= (others => '0');
				-- current packet data
					cur_packet_next(PACKET_LENGTH_INT-1 downto 0) <= alarm_packet(PACKET_LENGTH_INT downto 1);
					txd_next <= alarm_packet(0);
				elsif (trans_alarm_active_reg = '0') and (clk_full_period = '1') and (sync_count_reg = 2) then
				-- next state: packet transmit
					st_tx_next <= st_packet_trans;
				-- sync count
					sync_count_next <= (others => '0');
				-- transmit active trigger
					trans_active_next <= '1';
				-- clock 
					tx_clk_next <= '1';
				-- packet byte count
					packet_bit_count_next <= (others => '0');
				-- current packet data
					cur_packet_next(6 downto 0) <= wx_fifo_q(7 downto 1);
					txd_next <= wx_fifo_q(0);
				-- fifo read ack
					wx_fifo_rdreq_next <= '1';
				elsif (clk_full_period = '1') then 
				-- sync count
					sync_count_next <= sync_count_reg + 1;
				-- next state: st_sync_start
					st_tx_next <= st_sync_start;	
				elsif (clk_half_period = '1') and (sync_count_reg = 1) then
				-- current packet data
					txd_next <= '0';
				-- next state: st_sync_start
					st_tx_next <= st_sync_start;	
				else
				-- next state: st_sync_start
					st_tx_next <= st_sync_start;	
				end if;
				
	----------------------------------
			when st_sync_stop =>
	----------------------------------
				if (clk_full_period = '1') and (sync_count_reg = 2) then
				-- next state: pause
					st_tx_next <= st_pause_trans;
				-- current packet data
					txd_next <= '0';
				-- transmit full active trigger
					trans_full_active_next <= '0';
				elsif (clk_full_period = '1') then 
				-- sync start count
					sync_count_next <= sync_count_reg + 1;
				-- next state: st_sync_stop
					st_tx_next <= st_sync_stop;	
				elsif (clk_half_period = '1') and (sync_count_reg = 1) then
				-- current packet data
					txd_next <= '1';
				-- next state: st_sync_stop
					st_tx_next <= st_sync_stop;	
				else
				-- next state: st_sync_stop
					st_tx_next <= st_sync_stop;	
				end if;
				
	----------------------------------
			when st_packet_trans =>
	----------------------------------
				if (packet_bit_count_reg = PACKET_LENGTH) and (clk_full_period = '1') then
				-- next state: st_sync_stop
					st_tx_next <= st_sync_stop;
				-- clock 
					tx_clk_next <= '0';
				-- transmit active trigger
					trans_active_next <= '0';
				-- packet byte count
					packet_bit_count_next <= (others => '0');
				-- current packet data
					txd_next <= '0';
				elsif (clk_half_period = '1') then
				-- next state: st_packet_trans
					st_tx_next <= st_packet_trans;	
				-- clock 
					tx_clk_next <= '0';
				-- read ack
					wx_fifo_rdreq_next <= '0';
				elsif (clk_full_period = '1') and (packet_bit_count_reg(2 downto 0) = "111") then
				-- next state: st_packet_trans
					st_tx_next <= st_packet_trans;	
				-- clock 
					tx_clk_next <= '1';
				-- packet byte count
					packet_bit_count_next <= packet_bit_count_reg + 1;
				-- current packet data
					cur_packet_next(6 downto 0) <= wx_fifo_q(7 downto 1);
					txd_next <= wx_fifo_q(0);
				-- read ack
					wx_fifo_rdreq_next <= '1';
				elsif (clk_full_period = '1') then
				-- next state: st_packet_trans
					st_tx_next <= st_packet_trans;	
				-- clock 
					tx_clk_next <= '1';
				-- packet byte count
					packet_bit_count_next <= packet_bit_count_reg + 1;
				-- current packet data
					cur_packet_next(6 downto 0) <= cur_packet_reg(7 downto 1);
					txd_next <= cur_packet_reg(0);
				-- read ack
					wx_fifo_rdreq_next <= '0';
				else
				-- next state: st_packet_trans
					st_tx_next <= st_packet_trans;	
				-- read ack
					wx_fifo_rdreq_next <= '0';
				end if;

	----------------------------------
			when st_pause_trans =>
	----------------------------------
				if (((packet_bit_count_reg = NOP_LENGTH_A - 6) and (a708_worder = '1')) or ((packet_bit_count_reg = NOP_LENGTH_B - 6) and (a708_worder = '0'))) and (clk_full_period = '1') and (tx_data_ena = '0') then 
				-- next state: idle
					st_tx_next <= idle;	
				-- straight data
					txd_next <= '0';
				-- transmit full active trigger
					trans_full_active_next <= '0';
				elsif (((packet_bit_count_reg = NOP_LENGTH_A - 6) and (a708_worder = '1')) or ((packet_bit_count_reg = NOP_LENGTH_B - 6) and (a708_worder = '0'))) and (clk_full_period = '1') and (tx_data_fifo_empty = '0') and (tx_nop_sel = '0') then
				-- next state: sync start
					st_tx_next <= st_sync_start;
				-- trans alarm packet trg
					trans_alarm_active_next <= '0';
				-- sync start count
					sync_count_next <= (others => '0');
				-- current packet data
					txd_next <= '1';
				-- transmit full active trigger
					trans_full_active_next <= '1';
				elsif (((packet_bit_count_reg = NOP_LENGTH_A - 6) and (a708_worder = '1')) or ((packet_bit_count_reg = NOP_LENGTH_B - 6) and (a708_worder = '0'))) and (clk_full_period = '1') and (tx_nop_sel = '1') then
				-- next state: sync start
					st_tx_next <= st_sync_start;
				-- trans alarm packet trg
					trans_alarm_active_next <= '1';
				-- sync start count
					sync_count_next <= (others => '0');
				-- current packet data
					txd_next <= '1';
				-- transmit full active trigger
					trans_full_active_next <= '1';
				elsif (((packet_bit_count_reg = NOP_LENGTH_A - 6) and (a708_worder = '1')) or ((packet_bit_count_reg = NOP_LENGTH_B - 6) and (a708_worder = '0'))) and (clk_full_period = '1') and (tx_data_fifo_empty = '1') and (tx_nop_sel = '0') then
				-- next state: idle
					st_tx_next <= idle;	
				-- straight data
					txd_next <= '0';
				elsif (clk_full_period = '1') then
				-- next state: st_pause_trans
					st_tx_next <= st_pause_trans;	
				-- packet byte count
					packet_bit_count_next <= packet_bit_count_reg + 1;
				-- current packet data
					txd_next <= '0';
				else
				-- next state: st_pause_trans
					st_tx_next <= st_pause_trans;	
				end if;

	----------------------------------
			when st_alarm_trans =>
	----------------------------------
				if (packet_bit_count_reg = PACKET_LENGTH) and (clk_full_period = '1') then
				-- next state: st_sync_stop
					st_tx_next <= st_sync_stop;
				-- clock
					tx_clk_next <= '0';
				-- transmit active trigger
					trans_active_next <= '0';
				-- packet byte count
					packet_bit_count_next <= (others => '0');
				-- current packet data
					txd_next <= '0';
				elsif (clk_half_period = '1') then
				-- next state: st_alarm_trans
					st_tx_next <= st_alarm_trans;	
				-- clock
					tx_clk_next <= '0';
				elsif (clk_full_period = '1') then
				-- next state: st_alarm_trans
					st_tx_next <= st_alarm_trans;	
				-- clock
					tx_clk_next <= '1';
				-- packet byte count
					packet_bit_count_next <= packet_bit_count_reg + 1;
				-- current packet data
					cur_packet_next(PACKET_LENGTH_INT-2 downto 0) <= cur_packet_reg(PACKET_LENGTH_INT-1 downto 1);
					txd_next <= cur_packet_reg(0);
				else
				-- next state: st_alarm_trans
					st_tx_next <= st_alarm_trans;	
				end if;
		end case;
	end process;

	process(clk, nReset)
	begin
		if (nReset = '0') then
			a708_TX  <= '0';
			a708_TXn <= '0';
		elsif rising_edge(clk) then
			if (trans_active_reg = '1') then
				a708_TX  <= not (txd_reg xor tx_clk_reg);
				a708_TXn <= (txd_reg xor tx_clk_reg);
			elsif (trans_full_active_reg = '0') then
				a708_TX  <= txd_reg;
				a708_TXn <= txd_reg;
			else
				a708_TX  <= txd_reg;
				a708_TXn <= not txd_reg;
			end if;
		end if;
	end process;
--==================================================--

--===============================================--
--================== Receiver ===================--
--===============================================--
-- input data trigger
	process (clk, nReset)
	begin
		if (nReset = '0') then
			in_data_trg_pos <= '0';
			in_data_trg_pos_dff <= '0';
			in_data_trg_pos_dff_dff <= '0';
			in_data_edge_trg <= '0';
--			in_data_trg_neg <= '0';
		elsif rising_edge(clk) then
			in_data_trg_pos <= a708_RX;
			in_data_trg_pos_dff <= in_data_trg_pos;
			in_data_trg_pos_dff_dff <= in_data_trg_pos_dff;
			in_data_edge_trg <= (in_data_trg_pos and not in_data_trg_pos_dff) or (in_data_trg_pos_dff and not in_data_trg_pos);
--			in_data_trg_neg <= a708_RXn;
		end if;
	end process;
		in_data <= in_data_trg_pos_dff_dff;

-- pos/neg check synchro trg
	process (clk, nReset)
	begin
		if (nReset = '0') then
			pos_neg_chech_synch_trg <= '0';
		elsif rising_edge(clk) then
			pos_neg_chech_synch_trg <= a708_RX xor not a708_RXn;
		end if;
	end process;

-- pos/neg check synchro count
	process (clk, nReset)
	begin
		if (nReset = '0') then
			pos_neg_chech_synch_count <= (others => '0');
		elsif rising_edge(clk) then
			if (pos_neg_chech_synch_trg = '0') then
				pos_neg_chech_synch_count <= (others => '0');
			else
				pos_neg_chech_synch_count <= pos_neg_chech_synch_count + 1;
			end if;
		end if;
	end process;

-- pos/neg check synchro fail trg
	process (clk, nReset)
	begin
		if (nReset = '0') then
			fail_pos_neg_check_synch_trg <= '0';
		elsif rising_edge(clk) then
			if (event_trg_dff = '1') then
				fail_pos_neg_check_synch_trg <= '0';
			elsif (pos_neg_chech_synch_count > SYNCH_VALID_TIME) then
				fail_pos_neg_check_synch_trg <= '1';
			end if;
		end if;
	end process;

-- receive state machine
	process (clk, nReset)
	begin
		if (nReset = '0') then 
		-- state
			st_rx_reg <= idle;
		-- pre synch counter
			pre_synch_count_reg <= (others => '0');
		-- receive write request fifo	
			rx_wr_req_fifo_reg <= '0';
		-- time of (data_in = '1')
			synch_count_ff_reg <= (others => '0');
		-- synch counter
			synch_count_reg <= (others => '0');
		-- error code
			error_code_reg <= (others => '0');
		-- pre data valid counter
			pre_data_valid_count_reg <= (others => '0');
		-- period counter
			period_count_reg <= (others => '0');
		-- post synch counter
			post_synch_count_reg <= (others => '0');
		-- bit counter
			bit_count_reg <= (others => '0');
		-- receive write fifo data
			rx_wx_fifo_data_reg <= (others => '0');
		-- bit to byte counter
			bit_to_byte_count_reg <= (others => '0');
		elsif rising_edge(clk) then
			if (rx_sclr = '1') then
			-- state
				st_rx_reg <= idle;
			-- pre synch counter
				pre_synch_count_reg <= (others => '0');
			-- receive write request fifo	
				rx_wr_req_fifo_reg <= '0';
			-- time of (data_in = '1')
				synch_count_ff_reg <= (others => '0');
			-- synch counter
				synch_count_reg <= (others => '0');
			-- error code
				error_code_reg <= (others => '0');
			-- pre data valid counter
				pre_data_valid_count_reg <= (others => '0');
			-- period counter
				period_count_reg <= (others => '0');
			-- bit counter
				bit_count_reg <= (others => '0');
			-- receive write fifo data
				rx_wx_fifo_data_reg <= (others => '0');
			-- bit to byte counter
				bit_to_byte_count_reg <= (others => '0');
			-- post synch counter
				post_synch_count_reg <= (others => '0');
			else
			-- state
				st_rx_reg <= st_rx_next;
			-- pre synch counter
				pre_synch_count_reg <= pre_synch_count_next;
			-- receive write request fifo	
				rx_wr_req_fifo_reg <= rx_wr_req_fifo_next;
			-- time of (data_in = '1')
				synch_count_ff_reg <= synch_count_ff_next;
			-- synch counter
				synch_count_reg <= synch_count_next;
			-- error code
				error_code_reg <= error_code_next;
			-- pre data valid counter
				pre_data_valid_count_reg <= pre_data_valid_count_next;
			-- period counter
				period_count_reg <= period_count_next;
			-- bit counter
				bit_count_reg <= bit_count_next;
			-- receive write fifo data
				rx_wx_fifo_data_reg <= rx_wx_fifo_data_next;
			-- bit to byte counter
				bit_to_byte_count_reg <= bit_to_byte_count_next;
			-- post synch counter
				post_synch_count_reg <= post_synch_count_next;
			end if;
		end if;
	end process;

-- next state logic
	process (
			st_rx_reg,
			pre_synch_count_reg,
			in_data,
			in_data_edge_trg,
			synch_count_reg,
			synch_count_ff_reg,
			pre_data_valid_count_reg,
			error_code_reg,
			bit_count_reg,
			period_count_reg,
			rx_wx_fifo_data_reg,
			rx_wr_req_fifo_reg,
			rx_data_ena,
			bit_to_byte_count_reg,
			post_synch_count_reg
			)
	begin
	-- state
		st_rx_next <= st_rx_reg;
	-- pre synch counter
		pre_synch_count_next <= pre_synch_count_reg;
	-- receive write request fifo	
		rx_wr_req_fifo_next <= rx_wr_req_fifo_reg;
	-- time of (data_in = '1')
		synch_count_ff_next <= synch_count_ff_reg;
	-- synch counter
		synch_count_next <= synch_count_reg;
	-- error code
		error_code_next <= error_code_reg;
	-- pre data valid counter
		pre_data_valid_count_next <= pre_data_valid_count_reg;
	-- period counter
		period_count_next <= period_count_reg;
	-- bit counter
		bit_count_next <= bit_count_reg;
	-- receive write fifo data
		rx_wx_fifo_data_next <= rx_wx_fifo_data_reg;
	-- bit to byte counter
		bit_to_byte_count_next <= bit_to_byte_count_reg;
	-- post synch counter
		post_synch_count_next <= post_synch_count_reg;


		case st_rx_reg is
	----------------------------------
			when idle =>
	----------------------------------
				if (rx_data_ena = '1') and (in_data = '0') and (in_data_edge_trg = '1') then
				-- next state: st_pre_synch
					st_rx_next <= st_pre_synch;	
				-- pre synch counter
					pre_synch_count_next <= (others => '0');
				-- receive write request fifo	
					rx_wr_req_fifo_next <= '0';
				else
				-- next state: idle
					st_rx_next <= idle;	
				-- receive write request fifo	
					rx_wr_req_fifo_next <= '0';
				end if;
	----------------------------------
			when st_pre_synch =>
	----------------------------------
				if (in_data_edge_trg = '1') and (pre_synch_count_reg > (PERIOD_CONST + QUARTER_PERIOD_CONST)) and (pre_synch_count_reg < (PERIOD_CONST + PERIOD_CONST - QUARTER_PERIOD_CONST)) then
				-- next state: st_synch
					st_rx_next <= st_synch;	
				-- time of (data_in = '1')
					synch_count_ff_next <= pre_synch_count_reg;
				-- synch counter
					synch_count_next <= (others => '0');
				-- error code
					error_code_next <= X"0";
				elsif (in_data_edge_trg = '1') and ((pre_synch_count_reg < (PERIOD_CONST + QUARTER_PERIOD_CONST)) or (pre_synch_count_reg > (PERIOD_CONST + PERIOD_CONST - QUARTER_PERIOD_CONST))) then
				-- next state: idle
					st_rx_next <= idle;	
				-- error code
					error_code_next <= X"1";
				else
				-- next state: st_pre_synch
					st_rx_next <= st_pre_synch;	
				-- pre synch counter
					pre_synch_count_next <= pre_synch_count_reg + 1;
				end if;
	----------------------------------
			when st_synch =>
	----------------------------------
				if (synch_count_reg = synch_count_ff_reg) then
				-- next state: st_pre_data_valid
					st_rx_next <= st_pre_data_valid;
				-- pre data valid counter
					pre_data_valid_count_next <= (others => '0');
				else	
				-- next state: st_synch
					st_rx_next <= st_synch;	
				-- synch counter
					synch_count_next <= synch_count_reg + 1;
				end if;
	----------------------------------
			when st_pre_data_valid =>
	----------------------------------
				if (in_data_edge_trg = '1') and (pre_data_valid_count_reg > QUARTER_PERIOD_CONST) and (pre_data_valid_count_reg < (QUARTER_PERIOD_CONST + HALF_PERIOD_CONST)) then
				-- next state: st_data_valid
					st_rx_next <= st_data_valid;
				-- period counter
					period_count_next <= (others => '0');
				-- bit counter
					bit_count_next <= "000"&X"01";
				-- bit to byte counter
					bit_to_byte_count_next <= "001";
				-- receive write fifo data
					rx_wx_fifo_data_next(7) <= in_data;
				elsif (in_data_edge_trg = '1') and (pre_data_valid_count_reg > (QUARTER_PERIOD_CONST + HALF_PERIOD_CONST)) then
				-- next state: idle
					st_rx_next <= idle;	
				-- error code
					error_code_next <= X"2";
				else
				-- next state: st_pre_data_valid
					st_rx_next <= st_pre_data_valid;	
				-- pre data valid counter
					pre_data_valid_count_next <= pre_data_valid_count_reg + 1;
				end if;
	----------------------------------
			when st_data_valid =>
	----------------------------------
--				if (in_data_edge_trg = '1') and (bit_count_reg = PACKET_LENGTH) then
--				-- next state: idle
--					st_rx_next <= idle;
--				-- error code
--					error_code_next <= X"0";
--				-- receive write request fifo	
--					rx_wr_req_fifo_next <= '0';
				if (in_data_edge_trg = '1') and (period_count_reg > (QUARTER_PERIOD_CONST + PERIOD_CONST)) then
				-- next state: idle
					st_rx_next <= idle;
				-- error code
					error_code_next <= X"3";
				-- receive write request fifo	
					rx_wr_req_fifo_next <= '0';
				elsif (in_data_edge_trg = '1') and (period_count_reg > (QUARTER_PERIOD_CONST + HALF_PERIOD_CONST)) and (period_count_reg < (QUARTER_PERIOD_CONST + PERIOD_CONST)) then
					if (bit_count_reg = PACKET_LENGTH) then
					-- next state: st_post_synch
						st_rx_next <= st_post_synch;
					-- post synch counter
						post_synch_count_next <= (others => '0');						
					else
					-- next state: st_data_valid
						st_rx_next <= st_data_valid;
					end if;
				-- period counter
					period_count_next <= (others => '0');
				-- bit counter
					bit_count_next <= bit_count_reg + 1;
				-- receive write request fifo	
					rx_wr_req_fifo_next <= '0';
--				elsif (period_count_reg = QUARTER_PERIOD_CONST + HALF_PERIOD_CONST) then
--				-- next state: st_data_valid
--					st_rx_next <= st_data_valid;
				-- data shifts into bytes and each byte writes to fifo
					if (bit_to_byte_count_reg = 7) then
					-- bit to byte counter
						bit_to_byte_count_next <= (others => '0');
					-- receive write request fifo	
						rx_wr_req_fifo_next <= '1';
					else
						bit_to_byte_count_next <= bit_to_byte_count_reg + 1;
					-- receive write request fifo	
						rx_wr_req_fifo_next <= '0';
					end if;
				-- receive write fifo data
					rx_wx_fifo_data_next(7) <= in_data;
					rx_wx_fifo_data_next(6 downto 0) <= rx_wx_fifo_data_reg(7 downto 1);
--					rx_wx_fifo_data_next(PACKET_LENGTH_INT) <= in_data;
--					rx_wx_fifo_data_next(PACKET_LENGTH_INT-1 downto 0) <= rx_wx_fifo_data_reg(PACKET_LENGTH_INT downto 1);
--				-- period counter
--					period_count_next <= period_count_reg + 1;
				else
				-- next state: st_data_valid
					st_rx_next <= st_data_valid;
				-- period counter
					period_count_next <= period_count_reg + 1;
				-- receive write request fifo	
					rx_wr_req_fifo_next <= '0';
				end if;
	----------------------------------
			when st_post_synch =>
	----------------------------------
				if (in_data_edge_trg = '1') and (post_synch_count_reg > ('0'&PERIOD_CONST) + ('0'&QUARTER_PERIOD_CONST) + ('0'&HALF_PERIOD_CONST)) and (period_count_reg < ('0'&PERIOD_CONST) + ('0'&QUARTER_PERIOD_CONST) + ('0'&PERIOD_CONST)) then
				-- next state: idle
					st_rx_next <= idle;
				-- error code
					if (in_data = '1') then
						error_code_next <= X"4";
					else
						error_code_next <= X"0";
					end if;
				-- receive write request fifo	
					rx_wr_req_fifo_next <= '0';
				-- post synch counter
					post_synch_count_next <= (others => '0');					
				elsif (in_data_edge_trg = '1') and (post_synch_count_reg > ('0'&PERIOD_CONST) + ('0'&QUARTER_PERIOD_CONST) + ('0'&PERIOD_CONST)) then
				-- next state: idle
					st_rx_next <= idle;
				-- error code
					error_code_next <= X"5";
				-- receive write request fifo	
					rx_wr_req_fifo_next <= '0';
				-- post synch counter
					post_synch_count_next <= (others => '0');					
				else
				-- next state: st_post_synch
					st_rx_next <= st_post_synch;
				-- post synch counter
					post_synch_count_next <= post_synch_count_reg + 1;
				-- receive write request fifo	
					rx_wr_req_fifo_next <= '0';
				end if;
		end case;
	end process;
		
-- read fifo
	read_fifo_component : rx_fifo
	PORT MAP (
		wrclk => clk,
		rdreq => rd_adr_change_dff and rx_data_trg_dff,
		aclr => not nReset or rx_sclr,
		rdclk => clk,
		wrreq => rx_wr_req_fifo_reg and not event_rxor,
		rdempty => int_ena_node,
		data => rx_wx_fifo_data_reg,
		wrfull => rx_data_fifo_full,
		q => rd_fifo_q,
		wrusedw => rx_fifo_used
	);
				
	rd_data_0 <= rd_fifo_q(31 downto 0) when (rx_data_trg_dff = '1') else sts_data(31 downto 0);
	rd_data_1 <= sts_data(63 downto 32);				

-- receive data address detect trigger
	process (clk, nReset)
	begin
		if (nReset = '0') then
			rx_data_trg <= '0';
			rx_data_trg_dff <= '0';
		elsif rising_edge(clk) then
			if 
				(rd_adr(15 downto 4) = A708_DATA(15 downto 4)) and 
				(rd_adr(3 downto 0) = X"0") then
				rx_data_trg <= '1';
			else
				rx_data_trg <= '0';
			end if;
			rx_data_trg_dff <= rx_data_trg;
		end if;
	end process;		
--===============================================--


END RTL;