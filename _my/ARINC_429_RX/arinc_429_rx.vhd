
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

LIBRARY altera_mf; 
USE altera_mf.all;
 
LIBRARY lpm;
USE lpm.lpm_components.all;

ENTITY arinc_429_rx IS 
GENERIC 
	(
	A429_RX_DATA  : std_logic_vector(15 downto 0) := X"3000";
	A429_RX_CTRL  : std_logic_vector(15 downto 0) := X"3010"
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

-- INT ena
	int_ena : out std_logic;

-- ARINC 429 RX
	

	rk_rx : in std_logic_vector(3 downto 0);
	rk_rx_type : out std_logic_vector(1 downto 0)
	
	);
END arinc_429_rx;

ARCHITECTURE RTL OF arinc_429_rx IS
	
	signal rx_rk_data : std_logic;
	signal rx_rk_ctrl : std_logic;
	signal data_rx : std_logic_vector(31 downto 0):= X"00000000";
	
	signal data_reg : std_logic_vector(31 downto 0):= X"00000000";
	signal data_reg_old : std_logic_vector(31 downto 0):= X"00000000";	
	signal ctrl_reg : std_logic_vector(31 downto 0):= X"0000000C";
	
	signal rx_rk_change : std_logic_vector(1 downto 0) := "00";
	signal adr_change : std_logic;
	signal rd_adr_old : std_logic_vector(31 downto 0):= X"00000000";
	
BEGIN

-- read

	process (clk, nReset)
	begin
		if (nReset = '0') then
			rx_rk_data <= '0';
			rx_rk_ctrl <= '0';
		elsif rising_edge(clk) then
			if (rd_adr(15 downto 4) = A429_RX_DATA(15 downto 4)) then
				rx_rk_data <= '1';
			else 
				rx_rk_data <= '0';
			end if;
			if (rd_adr(15 downto 4) = A429_RX_CTRL(15 downto 4)) then
				rx_rk_ctrl <= '1';
			else 
				rx_rk_ctrl <= '0';
			end if;
		end if;
	end process;

	process (clk, nReset)
	begin
		if (nReset = '0') then
			data_rx <= (others => '0');
		elsif rising_edge(clk) then
			if (rx_rk_data = '1') then
				data_rx(31 downto 4) <= (others => '0');
				data_rx(3 downto 0) <= data_reg(3 downto 0);
			elsif (rx_rk_ctrl = '1') then
				data_rx(31 downto 4) <= (others => '0');
				data_rx(3 downto 0) <= ctrl_reg(3 downto 0);
			else	
				data_rx <= (others => '0');
			end if;
		end if;
	end process;

	rd_data_0 <= data_rx(31 downto 0);
	rd_data_1 <= (others => '0');

	

--write	

--ctrl

	process (clk, nReset)
	begin
		if (nReset = '0') then
			ctrl_reg(31 downto 4) <= (others => '0');
			ctrl_reg(1 downto 0) <= (others => '0');
			ctrl_reg(3 downto 2) <= (others => '1');
		elsif rising_edge(clk) then
			if (wr_adr(15 downto 4) = A429_RX_CTRL(15 downto 4)) then
				if (wr_be_0(0) = '1') and (wren_0 = '1') then	
					ctrl_reg(31 downto 4) <= (others => '0');
					ctrl_reg(3 downto 0) <= wr_data_0(3 downto 0);
				else
					ctrl_reg(31 downto 0) <= ctrl_reg(31 downto 0);
				end if;
			else
				ctrl_reg(31 downto 0) <= ctrl_reg(31 downto 0);			
			end if;
		end if;
	end process;


	
-- connect rk
	
	data_reg(3 downto 0) <= rk_rx;
	rk_rx_type <= ctrl_reg(1 downto 0);

	
-- interupt rk	

	process (clk, nReset)
	begin
		if (nReset = '0') then
			rx_rk_change(1 downto 0) <= (others => '0');
		elsif rising_edge(clk) then
			if (data_reg(1 downto 0) = data_reg_old(1 downto 0)) then
				data_reg_old(1 downto 0) <= data_reg(1 downto 0);
				rx_rk_change(0) <= rx_rk_change(0) and not adr_change;
			else 
				data_reg_old(1 downto 0) <= data_reg(1 downto 0);
				rx_rk_change(0) <= '1';
			end if;
			
			if (data_reg(3 downto 2) = data_reg_old(3 downto 2)) then
				data_reg_old(3 downto 2) <= data_reg(3 downto 2);
				rx_rk_change(1) <= rx_rk_change(1) and not adr_change;
			else 
				data_reg_old(3 downto 2) <= data_reg(3 downto 2);
				rx_rk_change(1) <= '1';
			end if;
			
		end if;
	end process;
	
	process (clk, nReset)
	begin
		if (nReset = '0') then
			adr_change <= '0';
		elsif rising_edge(clk) then
			if ( rd_adr_old = rd_adr) then
				rd_adr_old <= rd_adr;
				adr_change <= '0';
			elsif rd_adr(15 downto 4) = A429_RX_DATA(15 downto 4) then  
				adr_change <= '1';
				rd_adr_old <= rd_adr;
			end if;
		end if;
	end process;

	
	
	int_ena <= (rx_rk_change(1) and ctrl_reg(3)) or (rx_rk_change(0)and ctrl_reg(2));

END RTL;