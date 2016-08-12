
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY altera_mf;
USE altera_mf.all;
 
LIBRARY lpm;
USE lpm.lpm_components.all;

ENTITY arinc_429_tx IS 
GENERIC 
	(
	A429_TX_DATA     : std_logic_vector(15 downto 0) := X"2000";
	A429_TX_CTRL     : std_logic_vector(15 downto 0) := X"2010";
	A429_TX_TEST    : std_logic_vector(15 downto 0) := X"2020"

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
		rd_data_0 : out std_logic_vector(31 downto 0);
		rd_data_1 : out std_logic_vector(31 downto 0);

	-- INT
		int_ena : out std_logic;
		
	-- ARINC 429 TX
		rk_tx : out std_logic_vector(15 downto 0);
		rk_tx_test : in std_logic_vector(15 downto 0);
		rk_tx_test_type : out std_logic_vector(1 downto 0)
		
	);
END arinc_429_tx;

ARCHITECTURE RTL OF arinc_429_tx IS

	signal tx_rk_data : std_logic;
	signal tx_rk_ctrl : std_logic;
	signal tx_rk_test : std_logic;
	signal data_rx : std_logic_vector(31 downto 0):= X"00000000";

	
	signal data_reg : std_logic_vector(31 downto 0):= X"00000000";
	signal ctrl_reg : std_logic_vector(31 downto 0):= X"00000000";
	signal test_reg : std_logic_vector(31 downto 0):= X"00000000";	
	
BEGIN

-- read

	process (clk, nReset)
	begin
		if (nReset = '0') then
			tx_rk_data <= '0';
			tx_rk_ctrl <= '0';
			tx_rk_test <= '0';
		elsif rising_edge(clk) then
			if (rd_adr(15 downto 4) = A429_TX_DATA(15 downto 4)) then
				tx_rk_data <= '1';
			else 
				tx_rk_data <= '0';
			end if;
			if (rd_adr(15 downto 4) = A429_TX_CTRL(15 downto 4)) then
				tx_rk_ctrl <= '1';
			else 
				tx_rk_ctrl <= '0';
			end if;
			if (rd_adr(15 downto 4) = A429_TX_TEST(15 downto 4)) then
				tx_rk_test <= '1';
			else 
				tx_rk_test <= '0';
			end if;		
		end if;
	end process;

	process (clk, nReset)
	begin
		if (nReset = '0') then
			data_rx <= (others => '0');
		elsif rising_edge(clk) then
			if (tx_rk_data = '1') then
				data_rx(31 downto 16) <= (others => '0');
				data_rx(15 downto 0) <= data_reg(15 downto 0);
			elsif (tx_rk_ctrl = '1') then
				data_rx(31 downto 2) <= (others => '0');
				data_rx(1 downto 0) <= ctrl_reg(1 downto 0);
			elsif (tx_rk_test = '1') then
				data_rx(31 downto 16) <= (others => '0');
				data_rx(15 downto 0) <= test_reg(15 downto 0);
			else	
				data_rx <= (others => '0');
			end if;
		end if;
	end process;

	rd_data_0 <= data_rx(31 downto 0);
	rd_data_1 <= (others => '0');

	
--write	

--data

	process (clk, nReset)
	begin
		if (nReset = '0') then
			data_reg <= (others => '0');
		elsif rising_edge(clk) then
			if (wr_adr(15 downto 4) = A429_TX_DATA(15 downto 4)) then
				if (wr_be_0(0) = '1') and (wren_0 = '1') then
					data_reg(31 downto 16) <= (others => '0');
					data_reg(15 downto 0) <= wr_data_0(15 downto 0);
				else
					data_reg(31 downto 0) <= data_reg(31 downto 0);	
				end if;
			else
				data_reg(31 downto 0) <= data_reg(31 downto 0);	
			end if;
		end if;
	end process;

--ctrl

	process (clk, nReset)
	begin
		if (nReset = '0') then
			ctrl_reg <= (others => '0');
		elsif rising_edge(clk) then
			if (wr_adr(15 downto 4) = A429_TX_CTRL(15 downto 4)) then
				if (wr_be_0(0) = '1') and (wren_0 = '1') then	
					ctrl_reg(31 downto 2) <= (others => '0');
					ctrl_reg(1 downto 0) <= wr_data_0(1 downto 0);
				else
					ctrl_reg(31 downto 0) <= ctrl_reg(31 downto 0);
				end if;
			else
				ctrl_reg(31 downto 0) <= ctrl_reg(31 downto 0);			
			end if;
		end if;
	end process;

	

-- connect rk
	
	--rk_tx <= data_reg(15 downto 0);
	test_reg(15 downto 0) <= rk_tx_test;
	rk_tx_test_type <= ctrl_reg(1 downto 0);
	
	process (clk, nReset)
	begin
		if (nReset = '0') then
			rk_tx <= data_reg(15 downto 0);
		elsif rising_edge(clk) then
			if (data_reg(0) = '1' and data_reg(1) = '1') then
				rk_tx(0)	<= '0';
				rk_tx(1)	<= '0';
			else
				rk_tx(0)	<= data_reg(0);
				rk_tx(1)	<= data_reg(1);
			end if;
			
			if (data_reg(2) = '1' and data_reg(3) = '1') then
				rk_tx(2)	<= '0';
				rk_tx(3)	<= '0';
			else
				rk_tx(2)	<= data_reg(2);
				rk_tx(3)	<= data_reg(3);
			end if;
			
			if (data_reg(4) = '1' and data_reg(5) = '1') then
				rk_tx(4)	<= '0';
				rk_tx(5)	<= '0';
			else
				rk_tx(4)	<= data_reg(4);
				rk_tx(5)	<= data_reg(5);
			end if;
			
			if (data_reg(6) = '1' and data_reg(7) = '1') then
				rk_tx(6)	<= '0';
				rk_tx(7)	<= '0';
			else
				rk_tx(6)	<= data_reg(6);
				rk_tx(7)	<= data_reg(7);
			end if;
			
			if (data_reg(8) = '1' and data_reg(9) = '1') then
				rk_tx(8)	<= '0';
				rk_tx(9)	<= '0';
			else
				rk_tx(8)	<= data_reg(8);
				rk_tx(9)	<= data_reg(9);
			end if;	
			
			if (data_reg(10) = '1' and data_reg(11) = '1') then
				rk_tx(10)	<= '0';
				rk_tx(11)	<= '0';
			else
				rk_tx(10)	<= data_reg(10);
				rk_tx(11)	<= data_reg(11);
			end if;
			
			if (data_reg(12) = '1' and data_reg(13) = '1') then
				rk_tx(12)	<= '0';
				rk_tx(13)	<= '0';
			else
				rk_tx(12)	<= data_reg(12);
				rk_tx(13)	<= data_reg(13);
			end if;	
			
			if (data_reg(14) = '1' and data_reg(15) = '1') then
				rk_tx(14)	<= '0';
				rk_tx(15)	<= '0';
			else
				rk_tx(14)	<= data_reg(14);
				rk_tx(15)	<= data_reg(15);
			end if;	
		end if;
	end process;
	
-- interupt rk	

	int_ena <= '0';
	

END RTL;











		