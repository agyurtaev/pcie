--------------------------------------------------------------------------------
-- Company: 
-- Engineer: Anton Klimovskikh
--
-- Create Date:    26.09.2013   
-- Design Name:    PCIE   
-- Module Name:    pcie_wrapper   
-- Project Name:   pcie_top
-- Target Device:  EP4SGX230KF40C2
-- Description:    "read/write description block from Avalon-ST PCIE MegaCore"
-- Revision:       Revision 1.05
--
-- Additional Comments:
-- 1. Write works (don't try in sizeable packets)
-- 2. Read works (don't try in sizeable packets)
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY altera_mf;
USE altera_mf.all;
 
ENTITY  pcie_wrapper IS 
	PORT 
	( 

	--===================================--
	--======== PCIe PHY interface =======--
	--===================================--
	local_rstn : in std_logic;
	pcie_rstn : in std_logic;

	refclk : in std_logic;

	rx_in0 : in std_logic;

	tx_out0 : out std_logic;
	--===================================--

	reconfig_clk : in std_logic;-- := '0'; -- 50 MHz
	pclk_in : in std_logic := '0'; -- virtual PIN
	
	app_clk : out std_logic;
	test_out_icm : out std_logic_vector(8 downto 0);
	pll_locked : out std_logic;
	app_int_sts : in std_logic;
	app_int_ack : out std_logic;
	
	--==================================--
	--====== rx/tx FIFO/RAM side =======--
	--==================================--
	-- data to RAMs	
	dt_ram_1 : out std_logic_vector(31 downto 0);
	dt_ram_0 : out std_logic_vector(31 downto 0);
	-- byte enables
	wren_1 : out std_logic;
	wren_0 : out std_logic;
	-- byte enables
	be_1 : out std_logic_vector(3 downto 0);
	be_0 : out std_logic_vector(3 downto 0);
	-- write Address
	write_addr : out std_logic_vector(63 downto 0);
	
	-- read Address
	read_addr : out std_logic_vector(63 downto 0);
	-- data from RAMs (valid after 2 tacts then read_adr)
	tx_dt_ram_0 : in std_logic_vector(31 downto 0);
	tx_dt_ram_1 : in std_logic_vector(31 downto 0);

--TEST***
	prefetch_wrreq_trg_trg_out : out std_logic;
	tx_dt_ram_0_out : out std_logic_vector(31 downto 0);
	tx_dt_ram_1_out : out std_logic_vector(31 downto 0);
--TEST***
	
	-- Ready (min. 5 tact wren delay)
	rx_ready : in std_logic := '1'
	--==================================--
	
	);
END pcie_wrapper;

ARCHITECTURE RTL OF pcie_wrapper IS

	--===========================--
	--====== Global nodes =======--
	--===========================--
	signal clk : std_logic;
	signal nReset : std_logic;
	signal rc_pll_locked : std_logic;
	
	--===========================--
	--====== receive side =======--
	--===========================--
	signal rx_st_data0 : std_logic_vector(63 downto 0);
	signal rx_st_eop0 : std_logic;
	signal rx_st_err0 : std_logic;
	signal rx_st_sop0 : std_logic;
	signal rx_st_valid0 : std_logic;

	signal rx_st_data0_ip : std_logic_vector(63 downto 0);
	signal rx_st_eop0_ip : std_logic;
	signal rx_st_err0_ip : std_logic;
	signal rx_st_sop0_ip : std_logic;
	signal rx_st_valid0_ip : std_logic;
	
	signal rx_st_ready0 : std_logic;
	signal rx_st_mask0 : std_logic;
	
	-- addtitional receiver signals
	signal rx_st_be0 : std_logic_vector(7 downto 0); 
	signal rx_st_bardec0 : std_logic_vector(7 downto 0);
	signal rx_fifo_empty0 : std_logic; 
	signal rx_fifo_full0 : std_logic; 
	--===========================--

	--============================--
	--====== transmit side =======--
	--============================--
	signal tx_st_data0 : std_logic_vector(63 downto 0);
	signal tx_st_eop0 : std_logic; 
	signal tx_st_err0 : std_logic; 
	signal tx_st_sop0 : std_logic; 
	signal tx_st_valid0 : std_logic; 
	
	signal tx_st_ready0 : std_logic;
	
	-- addtitional transmitter signals
	signal tx_cred0 : std_logic_vector(35 downto 0);
	signal tx_fifo_empty0 : std_logic;
	signal tx_fifo_full0 : std_logic;
	signal tx_fifo_rdptr0 : std_logic_vector(3 downto 0);
	signal tx_fifo_wrptr0 : std_logic_vector(3 downto 0);
	--============================--

--===================================--
--========== Reset scheme ===========--	
--===================================--
	-- Div down 250Mhz clk with T-Flop
	signal cal_blk_clk : std_logic;

	signal npor : std_logic;
	signal npor_pll : std_logic;
	signal pll_powerdown : std_logic;

	-- pipe line exit conditions
	signal dlup_exit_r : std_logic;
	signal hotrst_exit_r : std_logic;
	signal l2_exit_r : std_logic;
	signal exits_r : std_logic;
	signal dlup_exit : std_logic;
	signal hotrst_exit : std_logic;
	signal l2_exit : std_logic;
	
	-- LTSSM pipeline
	signal dl_ltssm_r : std_logic_vector(4 downto 0);
	signal ltssm : std_logic_vector(4 downto 0);
	
	-- reset Synchronizer
	signal any_rstn_r : std_logic;
	signal any_rstn_rr : std_logic;

	-- reset counter
	signal rsnt_cntn : std_logic_vector(10 downto 0);
	
	signal srstn : std_logic;
	signal test_in : std_logic_vector(39 downto 0);

	-- sync and config reset
	signal srst0 : std_logic;
	signal crst0 : std_logic;
	signal app_rstn0 : std_logic;

	-- sync and config reset pipeline
	signal app_rstn : std_logic;
	signal srst : std_logic;
	signal crst : std_logic;
--===================================--	
	
--==================================================================================--
--==================================== PCIE core ===================================--
--==================================================================================--
-- PCIE core component
	COMPONENT pcie_core
		PORT
		(
			app_int_sts		:	 IN STD_LOGIC;
			app_msi_num		:	 IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			app_msi_req		:	 IN STD_LOGIC;
			app_msi_tc		:	 IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			busy_altgxb_reconfig		:	 IN STD_LOGIC;
			cal_blk_clk		:	 IN STD_LOGIC;
			cpl_err		:	 IN STD_LOGIC_VECTOR(6 DOWNTO 0);
			cpl_pending		:	 IN STD_LOGIC;
			crst		:	 IN STD_LOGIC;
			fixedclk_serdes		:	 IN STD_LOGIC;
			gxb_powerdown		:	 IN STD_LOGIC;
			hpg_ctrler		:	 IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			lmi_addr		:	 IN STD_LOGIC_VECTOR(11 DOWNTO 0);
			lmi_din		:	 IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			lmi_rden		:	 IN STD_LOGIC;
			lmi_wren		:	 IN STD_LOGIC;
			npor		:	 IN STD_LOGIC;
			pclk_in		:	 IN STD_LOGIC;
			pex_msi_num		:	 IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			phystatus_ext		:	 IN STD_LOGIC;
			pipe_mode		:	 IN STD_LOGIC;
			pld_clk		:	 IN STD_LOGIC;
			pll_powerdown		:	 IN STD_LOGIC;
			pm_auxpwr		:	 IN STD_LOGIC;
			pm_data		:	 IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			pm_event		:	 IN STD_LOGIC;
			pme_to_cr		:	 IN STD_LOGIC;
			reconfig_clk		:	 IN STD_LOGIC;
			reconfig_togxb		:	 IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			refclk		:	 IN STD_LOGIC;
			rx_in0		:	 IN STD_LOGIC;
			rx_st_mask0		:	 IN STD_LOGIC;
			rx_st_ready0		:	 IN STD_LOGIC;
			rxdata0_ext		:	 IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			rxdatak0_ext		:	 IN STD_LOGIC;
			rxelecidle0_ext		:	 IN STD_LOGIC;
			rxstatus0_ext		:	 IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			rxvalid0_ext		:	 IN STD_LOGIC;
			srst		:	 IN STD_LOGIC;
			test_in		:	 IN STD_LOGIC_VECTOR(39 DOWNTO 0);
			tx_st_data0		:	 IN STD_LOGIC_VECTOR(63 DOWNTO 0);
			tx_st_eop0		:	 IN STD_LOGIC;
			tx_st_err0		:	 IN STD_LOGIC;
			tx_st_sop0		:	 IN STD_LOGIC;
			tx_st_valid0		:	 IN STD_LOGIC;
			app_clk		:	 OUT STD_LOGIC;
			app_int_ack		:	 OUT STD_LOGIC;
			app_msi_ack		:	 OUT STD_LOGIC;
			clk250_out		:	 OUT STD_LOGIC;
			clk500_out		:	 OUT STD_LOGIC;
			core_clk_out		:	 OUT STD_LOGIC;
			derr_cor_ext_rcv0		:	 OUT STD_LOGIC;
			derr_cor_ext_rpl		:	 OUT STD_LOGIC;
			derr_rpl		:	 OUT STD_LOGIC;
			dlup_exit		:	 OUT STD_LOGIC;
			hotrst_exit		:	 OUT STD_LOGIC;
			ko_cpl_spc_vc0		:	 OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
			l2_exit		:	 OUT STD_LOGIC;
			lane_act		:	 OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			lmi_ack		:	 OUT STD_LOGIC;
			lmi_dout		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			ltssm		:	 OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
			pme_to_sr		:	 OUT STD_LOGIC;
			powerdown_ext		:	 OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			r2c_err0		:	 OUT STD_LOGIC;
			rate_ext		:	 OUT STD_LOGIC;
			rc_pll_locked		:	 OUT STD_LOGIC;
			rc_rx_digitalreset		:	 OUT STD_LOGIC;
			reconfig_fromgxb		:	 OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
			reset_status		:	 OUT STD_LOGIC;
			rx_fifo_empty0		:	 OUT STD_LOGIC;
			rx_fifo_full0		:	 OUT STD_LOGIC;
			rx_st_bardec0		:	 OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			rx_st_be0		:	 OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			rx_st_data0		:	 OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
			rx_st_eop0		:	 OUT STD_LOGIC;
			rx_st_err0		:	 OUT STD_LOGIC;
			rx_st_sop0		:	 OUT STD_LOGIC;
			rx_st_valid0		:	 OUT STD_LOGIC;
			rxpolarity0_ext		:	 OUT STD_LOGIC;
			suc_spd_neg		:	 OUT STD_LOGIC;
			tl_cfg_add		:	 OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			tl_cfg_ctl		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			tl_cfg_ctl_wr		:	 OUT STD_LOGIC;
			tl_cfg_sts		:	 OUT STD_LOGIC_VECTOR(52 DOWNTO 0);
			tl_cfg_sts_wr		:	 OUT STD_LOGIC;
			tx_cred0		:	 OUT STD_LOGIC_VECTOR(35 DOWNTO 0);
			tx_fifo_empty0		:	 OUT STD_LOGIC;
			tx_fifo_full0		:	 OUT STD_LOGIC;
			tx_fifo_rdptr0		:	 OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			tx_fifo_wrptr0		:	 OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			tx_out0		:	 OUT STD_LOGIC;
			tx_st_ready0		:	 OUT STD_LOGIC;
			txcompl0_ext		:	 OUT STD_LOGIC;
			txdata0_ext		:	 OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			txdatak0_ext		:	 OUT STD_LOGIC;
			txdetectrx_ext		:	 OUT STD_LOGIC;
			txelecidle0_ext		:	 OUT STD_LOGIC
		);
	END COMPONENT;

-- additional signals
	signal reconfig_busy : std_logic;
	signal pme_to_sr : std_logic;
	signal reconfig_togxb : std_logic_vector(3 downto 0);
	signal lane_act : std_logic_vector(3 downto 0);
	signal reconfig_fromgxb : std_logic_vector(4 downto 0);
	
-- reconfiguration component
	component reconfig
		PORT
		(
			reconfig_clk		: IN STD_LOGIC ;
			reconfig_fromgxb		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			busy		: OUT STD_LOGIC ;
			reconfig_togxb		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
		);
	end component;
--==================================================================================--

--=======================================================--
--========= Configuration space registers reads =========--	
--=======================================================--
	signal cfg_busdev_ff : std_logic_vector(12 downto 0);
	signal cfg_busdev : std_logic_vector(12 downto 0);
	
	signal tl_cfg_add_equals_xF : std_logic;
	signal tl_cfg_add_trg : std_logic;
	signal tl_cfg_add_trg_trg : std_logic;
	signal tl_cfg_add_trg_trg_trg : std_logic;

	signal tl_cfg_ctl : std_logic_vector(31 downto 0);
	signal tl_cfg_add : std_logic_vector(3 downto 0);

	--===============================--
	--====== bus/device number ======--
	--===============================--
	signal bus_number : std_logic_vector(7 downto 0);
	signal device_number : std_logic_vector(4 downto 0);
	--===============================--
	
--=======================================================--

	signal tx_st_ready_trg : std_logic;
 
-- TLP descriptor
	signal TLP_Fmt : std_logic_vector(1 downto 0);
	signal TLP_Type : std_logic_vector(4 downto 0);
	signal TLP_Length : std_logic_vector(9 downto 0);
	signal TLP_TC : std_logic_vector(2 downto 0);
	signal TLP_Attr : std_logic_vector(1 downto 0);
	
	signal TLP_RequesterID : std_logic_vector(15 downto 0);
	signal TLP_BusNumber : std_logic_vector(7 downto 0);
	signal TLP_DeviceNumber : std_logic_vector(4 downto 0);
	signal TLP_FunctionNumber : std_logic_vector(2 downto 0);
	
	signal TLP_Tag : std_logic_vector(7 downto 0);
	
	signal TLP_LastBE : std_logic_vector(3 downto 0);
	signal TLP_FirstBE : std_logic_vector(3 downto 0);
	
	signal TLP_Addr : std_logic_vector(63 downto 0);
	
	signal TLP_Addr_32b : std_logic_vector(63 downto 0);
	signal TLP_Addr_64b : std_logic_vector(63 downto 0);
 
--===============================--
--====== write data to RAM ======--
--===============================--
	-- state
	type state_TLP_descriptor is
	(idle, st_data_ram);
	-- state registers
	signal st_TLP_desc_reg, st_TLP_desc_next : state_TLP_descriptor;
	-- First Data Byte
	signal first_dt_reg, first_dt_next : std_logic;
	-- header type
	signal four_DWord_reg, four_DWord_next : std_logic;
	signal three_DWord_reg, three_DWord_next : std_logic;
	-- data to RAMs	
	signal dt_ram_1_reg, dt_ram_1_next : std_logic_vector(31 downto 0);
	signal dt_ram_0_reg, dt_ram_0_next : std_logic_vector(31 downto 0);
	-- byte enables
	signal wren_1_reg, wren_1_next : std_logic;
	signal wren_0_reg, wren_0_next : std_logic;
	-- byte enables
	signal be_1_reg, be_1_next : std_logic_vector(3 downto 0);
	signal be_0_reg, be_0_next : std_logic_vector(3 downto 0);
	-- length 
	signal length_reg, length_next : std_logic_vector(9 downto 0);
	-- write Address
	signal write_addr_reg, write_addr_next : std_logic_vector(63 downto 0);
	-- TLP Byte enables
	signal first_be_reg, first_be_next : std_logic_vector(3 downto 0);
	signal last_be_reg, last_be_next : std_logic_vector(3 downto 0);
	-- RequesterID
	signal TLP_BusNumber_reg, TLP_BusNumber_next : std_logic_vector(7 downto 0);
	signal TLP_DeviceNumber_reg, TLP_DeviceNumber_next : std_logic_vector(4 downto 0);
	signal TLP_FunctionNumber_reg, TLP_FunctionNumber_next : std_logic_vector(2 downto 0);
	signal TLP_Tag_reg, TLP_Tag_next : std_logic_vector(7 downto 0);
 	signal TLP_TC_next, TLP_TC_reg : std_logic_vector(2 downto 0);
	signal TLP_Attr_next, TLP_Attr_reg : std_logic_vector(1 downto 0);
	-- Start write Address
	signal req_addr_next, req_addr_reg : std_logic_vector(63 downto 0); 
	-- request write enable
	signal req_write_ena_next, req_write_ena_reg : std_logic;
	-- write request length 
	signal req_length_next, req_length_reg : std_logic_vector(9 downto 0);
	-- read request first byte detected
	signal rd_req_first_dt_reg, rd_req_first_dt_next : std_logic;
--===============================--

--===================================--
--===== requests fifo component =====--
--===================================--
	component req_fifo
		PORT
		(
			aclr		: IN STD_LOGIC ;
			clock		: IN STD_LOGIC ;
			data		: IN STD_LOGIC_VECTOR (102 DOWNTO 0);
			rdreq		: IN STD_LOGIC ;
			wrreq		: IN STD_LOGIC ;
			empty		: OUT STD_LOGIC ;
			full		: OUT STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (102 DOWNTO 0);
			usedw		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
	end component;

	signal req_fifo_data_in : std_logic_vector(102 downto 0);
	signal req_fifo_rdreq : std_logic;
	signal req_fifo_wrreq : std_logic;
	signal req_fifo_empty : std_logic;
	signal req_fifo_full : std_logic;
	signal req_fifo_data_out : std_logic_vector(102 downto 0);
	signal req_fifo_usedw : std_logic_vector(7 downto 0);

	signal req_addr_tx : std_logic_vector(63 downto 0);
	signal req_length_tx : std_logic_vector(9 downto 0);
	signal TLP_BusNumber_tx : std_logic_vector(7 downto 0);
	signal TLP_DeviceNumber_tx : std_logic_vector(4 downto 0);
	signal TLP_FunctionNumber_tx : std_logic_vector(2 downto 0);
	signal TLP_Tag_tx : std_logic_vector(7 downto 0);
	signal TLP_TC_tx : std_logic_vector(2 downto 0);
	signal TLP_Attr_tx : std_logic_vector(1 downto 0);

	component prefetch_fifo
		PORT
		(
			aclr		: IN STD_LOGIC ;
			clock		: IN STD_LOGIC ;
			data		: IN STD_LOGIC_VECTOR (63 DOWNTO 0);
			rdreq		: IN STD_LOGIC ;
			sclr		: IN STD_LOGIC ;
			wrreq		: IN STD_LOGIC ;
			almost_empty		: OUT STD_LOGIC ;
			empty		: OUT STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
		);
	end component;


	signal prefetch_rdreq : std_logic; 
	signal prefetch_wrreq : std_logic;
	signal prefetch_wrreq_trg : std_logic;
	signal prefetch_wrreq_trg_trg : std_logic;
	signal tx_data : std_logic_vector(63 downto 0);
	--signal prefetch_usedw : std_logic_vector(4 downto 0);
	signal prefetch_wrreq_ena : std_logic;
	signal prefetch_empty : std_logic;
	
	-- tx additional constant
	signal tx_CpLD : std_logic_vector(6 downto 0);
	signal tx_TD : std_logic;
	signal tx_ED : std_logic;
	
	signal tx_header_0 : std_logic_vector(31 downto 0);
	signal tx_header_1 : std_logic_vector(31 downto 0);
	signal tx_header_2 : std_logic_vector(31 downto 0);
	signal tx_current_status : std_logic_vector(2 downto 0);
	signal tx_byte_count : std_logic_vector(11 downto 0);

	-- read RAM Address
	signal read_addr_count : std_logic_vector(63 downto 0);
	
	-- tx_transfer_active_trg_dff
	signal tx_transfer_active_trg_dff : std_logic;
	signal tx_transfer_active_trg_dff_dff : std_logic;
	signal tx_transfer_active_trg_dff_dff_dff : std_logic;
--===================================--

--================================--
--====== read data from RAM ======--
--================================--
	-- tx_transfer_active_trg
	signal tx_transfer_active_trg : std_logic;

	-- state
	type state_TLP_encriptor is
	(idle, st_H1_H0, st_H2, st_data_transmit);
	-- state registers
	signal st_TLP_tx_reg, st_TLP_tx_next : state_TLP_encriptor;

	-- transmit data 
	signal tx_st_data_1_next, tx_st_data_1_reg : std_logic_vector(31 downto 0);
	signal tx_st_data_0_next, tx_st_data_0_reg : std_logic_vector(31 downto 0);
	-- transmit signals
	signal tx_st_eop_next, tx_st_eop_reg : std_logic;
	signal tx_st_err_next, tx_st_err_reg : std_logic;
	signal tx_st_sop_next, tx_st_sop_reg : std_logic;
	signal tx_st_valid_next, tx_st_valid_reg : std_logic;
	-- end of packet
	signal end_of_transfer_packet_next, end_of_transfer_packet_reg : std_logic;
	-- read request from data fifo (SHOW-AHEAD)
	signal prefetch_rdreq_next, prefetch_rdreq_reg : std_logic;
	-- length of packet
	signal tx_packet_length_next, tx_packet_length_reg : std_logic_vector(9 downto 0);

BEGIN

--TEST***
	tx_dt_ram_0_out <= tx_dt_ram_0;
	tx_dt_ram_1_out <= tx_dt_ram_1;
--TEST***


	process (clk)
	begin
		if rising_edge(clk) then
			tx_st_ready_trg <= tx_st_ready0;
		end if;
	end process;
 
-- TLP descriptor
	TLP_Fmt <= rx_st_data0(30 downto 29);
	TLP_Type <= rx_st_data0(28 downto 24);
	TLP_Length <= rx_st_data0(9 downto 0);
	TLP_TC <= rx_st_data0(22 downto 20);
	TLP_Attr <= rx_st_data0(13 downto 12);
	
	TLP_RequesterID <= rx_st_data0(63 downto 48);
	TLP_BusNumber <= TLP_RequesterID(15 downto 8);
	TLP_DeviceNumber <= TLP_RequesterID(7 downto 3);
	TLP_FunctionNumber <= TLP_RequesterID(2 downto 0);
	
	TLP_Tag <= rx_st_data0(47 downto 40);
	
	TLP_LastBE <= rx_st_data0(39 downto 36);
	TLP_FirstBE <= rx_st_data0(35 downto 32);
	
	TLP_Addr <= TLP_Addr_32b when (three_DWord_reg = '1') else TLP_Addr_64b;
	
	TLP_Addr_32b <= (X"00000000"&rx_st_data0(31 downto 0));
	TLP_Addr_64b <= (rx_st_data0(31 downto 0)&rx_st_data0(63 downto 32));
 
--===============================--
--====== write data to RAM ======--
--===============================--
-- state registers
process (clk, nReset)
begin
	if (nReset = '0') then 
		-- state
		st_TLP_desc_reg <= idle;
		-- First Data Byte
		first_dt_reg <= '0';
		-- header type
		four_DWord_reg <= '0';
		three_DWord_reg <= '0';
		-- data to RAMs	
		dt_ram_1_reg <= (others => '0');
		dt_ram_0_reg <= (others => '0');
		-- byte enables
		wren_1_reg <= '0';
		wren_0_reg <= '0';
		-- byte enables
		be_1_reg <= (others => '0');
		be_0_reg <= (others => '0');
		-- length 
		length_reg <= (others => '0');
		-- write Address
		write_addr_reg <= (others => '0');
		-- TLP Byte enables
		first_be_reg <= (others => '0');
		last_be_reg <= (others => '0');
		-- RequesterID
		TLP_BusNumber_reg <= (others => '0');
		TLP_DeviceNumber_reg <= (others => '0');
		TLP_FunctionNumber_reg <= (others => '0');
		TLP_Tag_reg <= (others => '0');
		TLP_TC_reg <= (others => '0');
		TLP_Attr_reg <= (others => '0');
		-- Start write Address
		req_addr_reg <= (others => '0'); 
		-- request write enable
		req_write_ena_reg <= '0';
		-- write request length 
		req_length_reg <= (others => '0');
		-- read request first byte detected
		rd_req_first_dt_reg <= '0';
	elsif rising_edge(clk) then
		-- state
		st_TLP_desc_reg <= st_TLP_desc_next;
		-- First Data Byte
		first_dt_reg <= first_dt_next;
		-- header type
		four_DWord_reg <= four_DWord_next;
		three_DWord_reg <= three_DWord_next;
		-- data to RAMs	
		dt_ram_1_reg <= dt_ram_1_next;
		dt_ram_0_reg <= dt_ram_0_next;
		-- byte enables
		wren_1_reg <= wren_1_next;
		wren_0_reg <= wren_0_next;
		-- byte enables
		be_1_reg <= be_1_next;
		be_0_reg <= be_0_next;
		-- length 
		length_reg <= length_next;
		-- write Address
		write_addr_reg <= write_addr_next;
		-- TLP Byte enables
		first_be_reg <= first_be_next;
		last_be_reg <= last_be_next;
		-- RequesterID
		TLP_BusNumber_reg <= TLP_BusNumber_next;
		TLP_DeviceNumber_reg <= TLP_DeviceNumber_next;
		TLP_FunctionNumber_reg <= TLP_FunctionNumber_next;
		TLP_Tag_reg <= TLP_Tag_next;
		TLP_TC_reg <= TLP_TC_next;
		TLP_Attr_reg <= TLP_Attr_next;
		-- Start write Address
		req_addr_reg <= req_addr_next; 
		-- request write enable
		req_write_ena_reg <= req_write_ena_next;
		-- write request length 
		req_length_reg <= req_length_next;
		-- read request first byte detected
		rd_req_first_dt_reg <= rd_req_first_dt_next;
	end if;
end process;

-- next state logic
process (	
			st_TLP_desc_reg,
			TLP_Fmt,
			TLP_Type,
			TLP_Addr,
			rx_st_sop0,
			rx_st_eop0,
			rx_st_valid0,
			first_dt_reg,
			write_addr_reg,
			four_DWord_reg,
			three_DWord_reg,
			dt_ram_1_reg,
			dt_ram_0_reg,
			wren_1_reg,
			wren_0_reg,
			be_1_reg,
			be_0_reg,
			rx_st_data0,
			length_reg,
			first_be_reg,
			last_be_reg,
			TLP_BusNumber_reg,
			TLP_DeviceNumber_reg,
			TLP_FunctionNumber_reg,
			TLP_Tag_reg,
			TLP_BusNumber,
			TLP_DeviceNumber,
			TLP_FunctionNumber,
			TLP_Tag,
			TLP_FirstBE,
			TLP_Length,
			TLP_LastBE,
			TLP_TC,
			TLP_TC_reg,
			TLP_Attr,
			TLP_Attr_reg,
			req_addr_reg,
			req_write_ena_reg,
			req_length_reg,
			rd_req_first_dt_reg
		)
begin
	st_TLP_desc_next <= st_TLP_desc_reg;
	-- First Data Byte
	first_dt_next <= first_dt_reg;
	-- header type
	four_DWord_next <= four_DWord_reg;
	three_DWord_next <= three_DWord_reg;
	-- data to RAMs	
	dt_ram_1_next <= dt_ram_1_reg;
	dt_ram_0_next <= dt_ram_0_reg;
	-- byte enables
	wren_1_next <= wren_1_reg;
	wren_0_next <= wren_0_reg;
	-- byte enables
	be_1_next <= be_1_reg;
	be_0_next <= be_0_reg;
	-- length 
	length_next <= length_reg;
	-- write Address
	write_addr_next <= write_addr_reg;
	-- TLP Byte enables
	first_be_next <= first_be_reg;
	last_be_next <= last_be_reg;
	-- RequesterID
	TLP_BusNumber_next <= TLP_BusNumber_reg;
	TLP_DeviceNumber_next <= TLP_DeviceNumber_reg;
	TLP_FunctionNumber_next <= TLP_FunctionNumber_reg;
	TLP_Tag_next <= TLP_Tag_reg;
	TLP_TC_next <= TLP_TC_reg;
	TLP_Attr_next <= TLP_Attr_reg;
	-- Start write Address
	req_addr_next <= req_addr_reg; 
	-- request write enable
	req_write_ena_next <= req_write_ena_reg;
	-- write request length 
	req_length_next <= req_length_reg;
	-- read request first byte detected
	rd_req_first_dt_next <= rd_req_first_dt_reg;
	
	case st_TLP_desc_reg is
----------------------------------
		when idle =>
----------------------------------
		-- H0 and H1 detected
			if (TLP_Fmt(1) = '1') and -- 3 or 4 DWord header, with data payload
				(TLP_Type = "00000") and -- Memory Write Request (Fmt = 10b indicates a 32b address)
				(rx_st_sop0 = '1') and -- Indicates that this is the first cycle of the TLP
				(rx_st_valid0 = '1') then
			-- next state: idle
				st_TLP_desc_next <= idle;
			-- First Data Byte
				first_dt_next <= '1';  
			-- Length
				length_next <= TLP_Length;
			-- header type
				if (TLP_Fmt(0) = '1') then
					four_DWord_next <= '1';
					three_DWord_next <= '0';
				else
					four_DWord_next <= '0';
					three_DWord_next <= '1';
				end if;
			-- Byte enables
				first_be_next <= TLP_FirstBE;
				last_be_next <= TLP_LastBE;
			-- RequesterID
				TLP_BusNumber_next <= TLP_BusNumber;
				TLP_DeviceNumber_next <= TLP_DeviceNumber;
				TLP_FunctionNumber_next <= TLP_FunctionNumber;
				TLP_Tag_next <= TLP_Tag;
			-- request write enable
				req_write_ena_next <= '0';
		
		-- 3DWORD header and non QWord alligned and Length <= 4
			elsif (three_DWord_reg = '1') and 
				(TLP_Addr(2) = '1') and
				(rx_st_valid0 = '1') and
				(first_dt_reg = '1') then
				if (rx_st_eop0 = '1') then
				-- next state: idle
					st_TLP_desc_next <= idle;
				-- First Data Byte
					first_dt_next <= '0';  
				else
				-- next state: st_data_ram
					st_TLP_desc_next <= st_data_ram;
				-- First Data Byte
					first_dt_next <= '1';  
				end if;
			-- Start write Address
				write_addr_next <= TLP_Addr;
			-- data to RAMs	
				dt_ram_1_next <= rx_st_data0(63 downto 32);
				dt_ram_0_next <= (others => '0');
			-- write enables
				wren_1_next <= '1';
				wren_0_next <= '0';
			-- byte enables
				be_1_next <= first_be_reg;
				be_0_next <= "0000";
			-- Length decrement
				length_next <= length_reg - 1;
	
		-- 3DWORD or 4DWORD header and QWord alligned
			elsif (TLP_Addr(2) = '0') and
				(rx_st_eop0 = '0') and
				(rx_st_valid0 = '1') and
				(first_dt_reg = '1') then
			-- next state: st_data_ram
				st_TLP_desc_next <= st_data_ram;
			-- First Data Byte
				first_dt_next <= '1';  
			-- Start write Address
				write_addr_next <= TLP_Addr;

		--================================--
		--===== read request detects =====--
		--================================--
		-- H0 and H1 detected 
			elsif (TLP_Fmt(1) = '0') and -- 3DWord or 4DWord header, with no data payload
				(TLP_Type = "00000") and -- Memory Read Request 
				(rx_st_sop0 = '1') and -- Indicates that this is the first cycle of the TLP
				(rx_st_valid0 = '1') then
			-- next state: idle
				st_TLP_desc_next <= idle;
			-- read request first byte detected
				rd_req_first_dt_next <= '1';
			-- header type
				if (TLP_Fmt(0) = '1') then
					four_DWord_next <= '1';
					three_DWord_next <= '0';
				else
					four_DWord_next <= '0';
					three_DWord_next <= '1';
				end if;
			-- write request length 
				req_length_next <= TLP_Length;
			-- RequesterID
				TLP_BusNumber_next <= TLP_BusNumber;
				TLP_DeviceNumber_next <= TLP_DeviceNumber;
				TLP_FunctionNumber_next <= TLP_FunctionNumber;
				TLP_Tag_next <= TLP_Tag;
				TLP_TC_next <= TLP_TC;
				TLP_Attr_next <= TLP_Attr;

		-- 3DWORD or 4DWORD header
			elsif (rd_req_first_dt_reg = '1') and
					(rx_st_valid0 = '1') then
			-- next state: idle
				st_TLP_desc_next <= idle;
			-- read request first byte detected
				rd_req_first_dt_next <= '0';
			-- Start write Address
				req_addr_next <= TLP_Addr; 
			-- request write enable
				req_write_ena_next <= '1';
		--================================--
			else
			-- next state: idle
				st_TLP_desc_next <= idle;
			-- write enables
				wren_1_next <= '0';
				wren_0_next <= '0';
			-- byte enables
				be_1_next <= "0000";
				be_0_next <= "0000";
			-- request write enable
				req_write_ena_next <= '0';
			end if;

----------------------------------
		when st_data_ram =>
----------------------------------
		 -- first and not last data
			if (rx_st_valid0 = '1') and (rx_st_eop0 = '0') and (first_dt_reg = '1') then
			-- next state : st_data_ram
				st_TLP_desc_next <= st_data_ram;
			-- data to RAMs	
				dt_ram_1_next <= rx_st_data0(63 downto 32);
				dt_ram_0_next <= rx_st_data0(31 downto 0);
				if (three_DWord_reg = '1') and (write_addr_reg(2) = '1') then
				-- address + 64 bit (2*32)
					write_addr_next <= write_addr_reg + 8;
				-- write enables
					wren_1_next <= '1';
					wren_0_next <= '1';
				-- byte enables
					be_1_next <= "1111";
					be_0_next <= "1111";
				-- Length decrement
					length_next <= length_reg - 2;
				elsif (four_DWord_reg = '1') and (write_addr_reg(2) = '1') then
				-- address
					write_addr_next <= write_addr_reg;
				-- write enables
					wren_1_next <= '1';
					wren_0_next <= '0';
				-- byte enables
					be_1_next <= first_be_reg;
					be_0_next <= "0000";
				-- Length decrement
					length_next <= length_reg - 1;
				elsif (write_addr_reg(2) = '0') then
				-- address
					write_addr_next <= write_addr_reg;
				-- write enables
					wren_1_next <= '1';
					wren_0_next <= '1';
				-- byte enables
					be_1_next <= "1111";
					be_0_next <= first_be_reg;
				-- Length decrement
					length_next <= length_reg - 2;
				end if;
			-- disable first data trigger
				first_dt_next <= '0';

		-- first and last data
			elsif (rx_st_valid0 = '1') and (rx_st_eop0 = '1') and (first_dt_reg = '1') then
			-- next state : idle
				st_TLP_desc_next <= idle;
			-- data to RAMs	
				dt_ram_1_next <= rx_st_data0(63 downto 32);
				dt_ram_0_next <= rx_st_data0(31 downto 0);
				if (three_DWord_reg = '1') and (write_addr_reg(2) = '1') then
				-- address + 64 bit (2*32)
					write_addr_next <= write_addr_reg + 8;
					if length_reg = 2 then
					-- write enables
						wren_1_next <= '1';
						wren_0_next <= '1';
					-- byte enables
						be_1_next <= last_be_reg;
						be_0_next <= "1111";
					-- Length decrement
						length_next <= length_reg - 2;
					else
					-- write enables
						wren_1_next <= '0';
						wren_0_next <= '1';
					-- byte enables
						be_1_next <= "0000";
						be_0_next <= last_be_reg;
					-- Length decrement
						length_next <= length_reg - 1;
					end if;
				elsif (four_DWord_reg = '1') and (write_addr_reg(2) = '1') then
				-- address
					write_addr_next <= write_addr_reg;
				-- write enables
					wren_1_next <= '1';
					wren_0_next <= '0';
				-- byte enables
					be_1_next <= first_be_reg;
					be_0_next <= "0000";
				-- Length decrement
					length_next <= length_reg - 1;
				elsif (write_addr_reg(2) = '0') then
				-- address
					write_addr_next <= write_addr_reg;
					if length_reg = 2 then
					-- write enables
						wren_1_next <= '1';
						wren_0_next <= '1';
					-- byte enables
						be_1_next <= last_be_reg;
						be_0_next <= first_be_reg;
					-- Length decrement
						length_next <= length_reg - 2;
					else
					-- write enables
						wren_1_next <= '0';
						wren_0_next <= '1';
					-- byte enables
						be_1_next <= "0000";
						be_0_next <= first_be_reg;
					-- Length decrement
						length_next <= length_reg - 1;
					end if;
				end if;
			-- disable first data trigger
				first_dt_next <= '0';

		-- not first and last data 
			elsif (rx_st_valid0 = '1') and (rx_st_eop0 = '1') and (first_dt_reg = '0') then
			-- next state : idle
				st_TLP_desc_next <= idle;
			-- address + 64 bit (2*32)
				write_addr_next <= write_addr_reg + 8;
			-- data to RAMs	
				dt_ram_1_next <= rx_st_data0(63 downto 32);
				dt_ram_0_next <= rx_st_data0(31 downto 0);
				if length_reg = 2 then
				-- write enables
					wren_1_next <= '1';
					wren_0_next <= '1';
				-- byte enables
					be_1_next <= last_be_reg;
					be_0_next <= "1111";
				-- Length decrement
					length_next <= length_reg - 2;
				else
				-- write enables
					wren_1_next <= '0';
					wren_0_next <= '1';
				-- byte enables
					be_1_next <= "0000";
					be_0_next <= last_be_reg;
				-- Length decrement
					length_next <= length_reg - 1;
				end if;
		
		-- not first and not last data 
			else
			-- next state : st_data_ram
				st_TLP_desc_next <= st_data_ram;
			-- address + 64 bit (2*32)
				write_addr_next <= write_addr_reg + 8;
			-- data to RAMs	
				dt_ram_1_next <= rx_st_data0(63 downto 32);
				dt_ram_0_next <= rx_st_data0(31 downto 0);
			-- write enables
				wren_1_next <= '1';
				wren_0_next <= '1';
			-- byte enables
				be_1_next <= "1111";
				be_0_next <= "1111";
			-- Length decrement
				length_next <= length_reg - 2;
			end if;
	end case;
end process; 
--===============================--

--=====================================--
--====== receiver FIFO/RAM side =======--
--=====================================--
	-- data to RAMs	
	dt_ram_1 <= dt_ram_1_reg;
	dt_ram_0 <= dt_ram_0_reg;
	-- byte enables
	wren_1 <= wren_1_reg;
	wren_0 <= wren_0_reg;
	-- byte enables
	be_1 <= be_1_reg;
	be_0 <= be_0_reg;
	-- write Address
	write_addr <= write_addr_reg;
	-- Ready (min. 5 tact wren delay)
	rx_st_ready0 <= rx_ready;

	rx_st_mask0 <= '0';
--=====================================--

--===================================--
--===== requests fifo component =====--
--===================================--
	req_fifo_component : req_fifo
		PORT MAP
		(
			aclr => not nReset,
			clock => clk,
			data => req_fifo_data_in,
			rdreq => req_fifo_rdreq,
			wrreq => req_write_ena_reg,
			empty => req_fifo_empty,
			full => req_fifo_full,
			q => req_fifo_data_out,
			usedw => req_fifo_usedw
		);

	req_fifo_data_in <= (
								req_addr_reg&
								req_length_reg&
								TLP_BusNumber_reg&
								TLP_DeviceNumber_reg&
								TLP_FunctionNumber_reg&
								TLP_Tag_reg&
								TLP_TC_reg&
								TLP_Attr_reg
								);
	
	req_addr_tx <= req_fifo_data_out(102 downto 39);
	req_length_tx <= req_fifo_data_out(38 downto 29);
	TLP_BusNumber_tx <= req_fifo_data_out(28 downto 21);
	TLP_DeviceNumber_tx <= req_fifo_data_out(20 downto 16);
	TLP_FunctionNumber_tx <= req_fifo_data_out(15 downto 13);
	TLP_Tag_tx <= req_fifo_data_out(12 downto 5);
	TLP_TC_tx <= req_fifo_data_out(4 downto 2);
	TLP_Attr_tx <= req_fifo_data_out(1 downto 0);
	
	-- tx additional constant
	tx_CpLD <= "1001010";
	tx_TD <= '0'; 
	tx_ED <= '0';
	
	tx_header_0 <= (
						'0'&tx_CpLD& -- bits 31 downto 24
						'0'&TLP_TC_tx&X"0"& -- bits 23 downto 16
						tx_TD&tx_ED&TLP_Attr_tx&"00"& -- bits 15 downto 10
						req_length_tx -- bits 9 downto 0
						);

	tx_current_status <= "000"; -- status always is OK
	tx_byte_count <= (req_length_tx&"00"); -- byte count always equals the length value shift left by 2
						
	tx_header_1 <= (
						bus_number&device_number&"000"& -- bits 31 downto 16: Completer ID = (bus_number, device_number, function_number)
						tx_current_status&'0'& -- bits 15 downto 12
						tx_byte_count -- bits 11 downto 0
						);
	
	tx_header_2 <= (
						TLP_BusNumber_tx&TLP_DeviceNumber_tx&TLP_FunctionNumber_tx& -- bits 31 downto 16: Requester ID
						TLP_Tag_tx&'0'& -- bits 15 downto 7 
						req_addr_tx(6 downto 0) -- bits 6 downto 0 
						);

	-- prefetch data from RAM fifo
	prefetch_fifo_component: prefetch_fifo
	PORT MAP
	(
		aclr => not nReset,
		clock => clk,
		data => (tx_dt_ram_1&tx_dt_ram_0),
		rdreq	=> prefetch_rdreq,
		sclr => req_fifo_rdreq,
		wrreq => prefetch_wrreq_trg_trg,
		almost_empty => prefetch_wrreq_ena,
		empty => prefetch_empty,
		q => tx_data
	);
	
	prefetch_wrreq_trg_trg_out <= prefetch_wrreq_trg_trg;
	prefetch_wrreq <= '1' when (tx_transfer_active_trg_dff_dff_dff = '1') and (prefetch_wrreq_ena = '1') else '0';
	prefetch_rdreq <= prefetch_rdreq_reg;
	
	-- delayed prefetch_wrreq while data don't equal data
	process (clk, nReset)
	begin
		if (nReset = '0') then
			prefetch_wrreq_trg <= '0';
			prefetch_wrreq_trg_trg <= '0';
		elsif rising_edge(clk) then
			prefetch_wrreq_trg <= prefetch_wrreq;
			prefetch_wrreq_trg_trg <= prefetch_wrreq_trg;
		end if;
	end process;
	
	-- read RAM Address
	process (clk, nReset)
	begin
		if (nReset = '0') then
			read_addr_count <= (others => '0');
		elsif rising_edge(clk) then
			if (req_fifo_rdreq = '1') then
				read_addr_count <= (others => '0');
			elsif (tx_transfer_active_trg = '1') and (tx_transfer_active_trg_dff = '0') then
				read_addr_count <= req_addr_tx;
			elsif (prefetch_wrreq = '1') then
				read_addr_count <= read_addr_count + 8;
			end if;
		end if;
	end process;

	read_addr <= read_addr_count;
	
	-- tx_transfer_active_trg_dff
	process (clk, nReset)
	begin
		if (nReset = '0') then
			tx_transfer_active_trg_dff <= '0';
			tx_transfer_active_trg_dff_dff <= '0';
			tx_transfer_active_trg_dff_dff_dff <= '0';
		elsif rising_edge(clk) then
			if (end_of_transfer_packet_reg = '1') then
				tx_transfer_active_trg_dff <= '0';
				tx_transfer_active_trg_dff_dff <= '0';
				tx_transfer_active_trg_dff_dff_dff <= '0';
			else
				tx_transfer_active_trg_dff <= tx_transfer_active_trg;
				tx_transfer_active_trg_dff_dff <= tx_transfer_active_trg_dff;
				tx_transfer_active_trg_dff_dff_dff <= tx_transfer_active_trg_dff_dff;
			end if;
		end if;
	end process;
--===================================--

--================================--
--====== read data from RAM ======--
--================================--
-- tx_transfer_active_trg
	process (clk, nReset)
	begin
		if (nReset = '0') then
			tx_transfer_active_trg <= '0';
		elsif rising_edge(clk) then
			if (tx_st_ready_trg = '1') and (req_fifo_empty = '0') and (tx_transfer_active_trg = '0') then
				tx_transfer_active_trg <= '1';
			elsif (tx_transfer_active_trg = '1') and (end_of_transfer_packet_reg = '1') then
				tx_transfer_active_trg <= '0';
			end if;
		end if;
	end process;

-- read request for fifo
	req_fifo_rdreq <= '1' when (tx_st_ready_trg = '1') and (req_fifo_empty = '0') and (tx_transfer_active_trg = '0') else '0';

-- state registers
	process (clk, nReset)
	begin
		if (nReset = '0') then 
			-- state
			st_TLP_tx_reg <= idle;
			-- transmit data 
			tx_st_data_1_reg <= (others => '0');
			tx_st_data_0_reg <= (others => '0');
			-- transmit signals
			tx_st_eop_reg <= '0';
			tx_st_err_reg <= '0';
			tx_st_sop_reg <= '0';
			tx_st_valid_reg <= '0'; 
			-- end of packet
			end_of_transfer_packet_reg <= '0';
			-- read request from data fifo (SHOW-AHEAD)
			prefetch_rdreq_reg <= '0';
			-- length of packet
			tx_packet_length_reg <= (others => '0');
		elsif rising_edge(clk) then
			-- state
			st_TLP_tx_reg <= st_TLP_tx_next;
			-- transmit data 
			tx_st_data_1_reg <= tx_st_data_1_next;
			tx_st_data_0_reg <= tx_st_data_0_next;
			-- transmit signals
			tx_st_eop_reg <= tx_st_eop_next;
			tx_st_err_reg <= tx_st_err_next;
			tx_st_sop_reg <= tx_st_sop_next;
			tx_st_valid_reg <= tx_st_valid_next; 
			-- end of packet
			end_of_transfer_packet_reg <= end_of_transfer_packet_next;
			-- read request from data fifo (SHOW-AHEAD)
			prefetch_rdreq_reg <= prefetch_rdreq_next;
			-- length of packet
			tx_packet_length_reg <= tx_packet_length_next;
		end if;
	end process;

-- next state logic
	process (	
				st_TLP_tx_reg,
				end_of_transfer_packet_reg,
				tx_st_data_1_reg,
				tx_st_data_0_reg,
				tx_st_eop_reg,
				tx_st_err_reg,
				tx_st_sop_reg,
				tx_st_valid_reg,
				tx_st_ready_trg,
				prefetch_rdreq_reg,
				tx_packet_length_reg,
				req_length_tx,
				req_fifo_rdreq,
				req_addr_tx,
				prefetch_empty,
				tx_header_0,
				tx_header_1,
				tx_header_2,
				tx_data
				)
	begin
		-- state
		st_TLP_tx_next <= st_TLP_tx_reg;
		-- transmit data 
		tx_st_data_1_next <= tx_st_data_1_reg;
		tx_st_data_0_next <= tx_st_data_0_reg;
		-- transmit signals
		tx_st_eop_next <= tx_st_eop_reg;
		tx_st_err_next <= tx_st_err_reg;
		tx_st_sop_next <= tx_st_sop_reg;
		tx_st_valid_next <= tx_st_valid_reg; 
		-- end of packet
		end_of_transfer_packet_next <= end_of_transfer_packet_reg;
		-- read request from data fifo (SHOW-AHEAD)
		prefetch_rdreq_next <= prefetch_rdreq_reg;
		-- length of packet
		tx_packet_length_next <= tx_packet_length_reg;
	
		case st_TLP_tx_reg is
	----------------------------------
			when idle =>
	----------------------------------
			-- go to prepare for transmit mode
				if (req_fifo_rdreq = '1') then
				-- next state : st_H1_H0
					st_TLP_tx_next <= st_H1_H0;
				-- transmit signals
					tx_st_eop_next <= '0';
					tx_st_err_next <= '0';
					tx_st_sop_next <= '0';
					tx_st_valid_next <= '0'; 
				-- read request from data fifo (SHOW-AHEAD)
					prefetch_rdreq_next <= '0';
				-- end of packet
					end_of_transfer_packet_next <= '0';
					
			-- stay in idle
				else 
				-- next state : idle
					st_TLP_tx_next <= idle;
				-- transmit data 
					tx_st_data_1_next <= (others => '0');
					tx_st_data_0_next <= (others => '0');
				-- transmit signals
					tx_st_eop_next <= '0';
					tx_st_err_next <= '0';
					tx_st_sop_next <= '0';
					tx_st_valid_next <= '0'; 
				-- read request from data fifo (SHOW-AHEAD)
					prefetch_rdreq_next <= '0';
				-- end of packet
					end_of_transfer_packet_next <= '0';
				end if;
			
	----------------------------------
			when st_H1_H0 =>
	----------------------------------
			-- go to data transmit 
				if (prefetch_empty = '0') then 
					-- next state : st_H2
						st_TLP_tx_next <= st_H2;
					-- length of packet
						tx_packet_length_next <= req_length_tx;
					-- transmit data 
						tx_st_data_1_next <= tx_header_1;
						tx_st_data_0_next <= tx_header_0;
					-- transmit signals
						tx_st_sop_next <= '1';
						tx_st_valid_next <= '1'; 
				end if;

	----------------------------------
			when st_H2 =>
	----------------------------------
			-- if Length = 1 and data with headers
				if (tx_st_ready_trg = '1') and (req_addr_tx(2) = '1') and (req_length_tx = 1) then
				-- next state : idle
					st_TLP_tx_next <= idle;
				-- transmit data 
					tx_st_data_1_next <= tx_data(63 downto 32);
					tx_st_data_0_next <= tx_header_2;
				-- transmit signals
					tx_st_eop_next <= '1';
					tx_st_sop_next <= '0';
					tx_st_valid_next <= '1'; 
				-- read request from data fifo (SHOW-AHEAD)
					prefetch_rdreq_next <= '1';
				-- end of packet
					end_of_transfer_packet_next <= '1';
				-- length of packet
					tx_packet_length_next <= (others => '0');

			-- if Length > 1 and data with headers
				elsif (tx_st_ready_trg = '1') and (req_addr_tx(2) = '1') and (req_length_tx > 1) then
				-- next state : st_data_transmit
					st_TLP_tx_next <= st_data_transmit;
				-- transmit data 
					tx_st_data_1_next <= tx_data(63 downto 32);
					tx_st_data_0_next <= tx_header_2;
				-- transmit signals
					tx_st_sop_next <= '0';
					tx_st_valid_next <= '1'; 
				-- read request from data fifo (SHOW-AHEAD)
					prefetch_rdreq_next <= '1';
				-- length of packet
					tx_packet_length_next <= tx_packet_length_reg - 1;

			-- if Length > 1 and headers without data
				elsif (tx_st_ready_trg = '1') and (req_addr_tx(2) = '0') then
				-- next state : st_data_transmit
					st_TLP_tx_next <= st_data_transmit;
				-- transmit data 
					tx_st_data_1_next <= (others => '0');
					tx_st_data_0_next <= tx_header_2;
				-- transmit signals
					tx_st_sop_next <= '0';
					tx_st_valid_next <= '1'; 
				end if;

	----------------------------------
			when st_data_transmit =>
	----------------------------------
			-- if Length > 4
				if (tx_st_ready_trg = '1') and (tx_packet_length_reg > 4) then
				-- next state : st_data_transmit
					st_TLP_tx_next <= st_data_transmit;
				-- transmit data 
					tx_st_data_1_next <= tx_data(63 downto 32);
					tx_st_data_0_next <= tx_data(31 downto 0);
				-- transmit signals
					tx_st_valid_next <= '1'; 
				-- read request from data fifo (SHOW-AHEAD)
					prefetch_rdreq_next <= '1';
				-- length of packet
					tx_packet_length_next <= tx_packet_length_reg - 4;
			
			-- if Length < 4
				elsif (tx_st_ready_trg = '1') and (tx_packet_length_reg < 4) then
				-- next state : idle
					st_TLP_tx_next <= idle;
				-- transmit data 
					tx_st_data_1_next <= tx_data(63 downto 32);
					tx_st_data_0_next <= tx_data(31 downto 0);
				-- transmit signals
					tx_st_valid_next <= '1'; 
					tx_st_eop_next <= '1';
				-- read request from data fifo (SHOW-AHEAD)
					prefetch_rdreq_next <= '1';
				-- length of packet
					tx_packet_length_next <= (others => '0');
				-- end of packet
					end_of_transfer_packet_next <= '1';

			-- stay in st_data_transmit
				else
				-- next state : st_data_transmit
					st_TLP_tx_next <= st_data_transmit;
				-- transmit signals
					tx_st_valid_next <= '0'; 
				-- read request from data fifo (SHOW-AHEAD)
					prefetch_rdreq_next <= '0';
				end if;
		end case;
	end process;
--================================--

--=====================================--
--====== transmit FIFO/RAM side =======--
--=====================================--
	tx_st_data0(63 downto  32) <= tx_st_data_1_reg;
	tx_st_data0(31 downto   0) <= tx_st_data_0_reg;
	tx_st_eop0 <= tx_st_eop_reg;
	tx_st_err0 <= tx_st_err_reg;
	tx_st_sop0 <= tx_st_sop_reg;
	tx_st_valid0 <= tx_st_valid_reg; 
--=====================================--


--=======================================================--
--========= Configuration space registers reads =========--	
--=======================================================--
	process (clk, nReset)
	begin
		if (nReset = '0') then
			cfg_busdev_ff <= (others => '0');
			cfg_busdev <= (others => '0');
		elsif rising_edge(clk) then
			cfg_busdev_ff <= tl_cfg_ctl(12 downto 0);
			if (tl_cfg_add_trg_trg_trg = '1') then
				cfg_busdev <= cfg_busdev_ff;
			end if;
		end if;
	end process;
	
	tl_cfg_add_equals_xF <= '1' when (tl_cfg_add = X"F") else '0';
	
	process (clk, nReset, tl_cfg_add)
	begin
		if (nReset = '0') then
			tl_cfg_add_trg <= '0';
			tl_cfg_add_trg_trg <= '0';
			tl_cfg_add_trg_trg_trg <= '0';
		elsif rising_edge(clk) then
			tl_cfg_add_trg <= tl_cfg_add_equals_xF;
			tl_cfg_add_trg_trg <= tl_cfg_add_equals_xF and not tl_cfg_add_trg;
			tl_cfg_add_trg_trg_trg <= tl_cfg_add_trg_trg;
		end if;
	end process;
	
	--===============================--
	--====== bus/device number ======--
	--===============================--
	bus_number <= cfg_busdev(12 downto 5);
	device_number <= cfg_busdev(4 downto 0);
	--===============================--
--=======================================================--

--===================================--
--========== Reset scheme ===========--	
--===================================--
	-- Div down 250Mhz clk with T-Flop
	process (clk, npor)
	begin
		if (npor = '0') then
			cal_blk_clk <= '0';
		elsif rising_edge(clk) then
			cal_blk_clk <= not cal_blk_clk;
		end if;
	end process;

	npor <= pcie_rstn and local_rstn;
	npor_pll <= pcie_rstn and local_rstn and rc_pll_locked;
	pll_powerdown <= not npor;

	-- pipe line exit conditions
	process (clk, any_rstn_rr)
	begin
		if (any_rstn_rr = '0') then
			dlup_exit_r <= '1';
			hotrst_exit_r <= '1';
			l2_exit_r <= '1';
			exits_r <= '0';
		elsif rising_edge(clk) then
			dlup_exit_r <= dlup_exit;
			hotrst_exit_r <= hotrst_exit;
			l2_exit_r <= l2_exit;
			if (l2_exit_r = '0') or (hotrst_exit_r = '0') or (dlup_exit_r = '0') or (dl_ltssm_r = "10000") then
				exits_r <= '1';
			else
				exits_r <= '0';
			end if;
		end if;
	end process;
	
	-- LTSSM pipeline
	process (clk, any_rstn_rr)
	begin
		if (any_rstn_rr = '0') then
			dl_ltssm_r <= (others => '0');
		elsif rising_edge(clk) then
			dl_ltssm_r <= ltssm;
		end if;
	end process;
	
	-- reset Synchronizer
	process(clk, npor_pll) 
	begin
		if (npor_pll = '0') then
			any_rstn_r <= '0';
			any_rstn_rr <= '0';
		elsif rising_edge(clk) then
			any_rstn_r <= '1';
			any_rstn_rr <= any_rstn_r;
		end if;
	end process;

	-- reset counter
	process (clk, any_rstn_rr)
	begin
		if (any_rstn_rr = '0') then
			rsnt_cntn <= (others => '0');
		elsif rising_edge(clk) then
			if ((local_rstn = '0') or (exits_r = '1')) then
				rsnt_cntn <= "011"&X"F0";
			elsif (rsnt_cntn /= 1024) then
				rsnt_cntn <= rsnt_cntn + 1;
			end if;
		end if;
	end process;

	nReset <= app_rstn;
	test_in <= X"00000000A8";
	pll_locked <= rc_pll_locked;

	-- sync and config reset
	process (clk, any_rstn_rr)
	begin
		if (any_rstn_rr = '0') then
			srst0 <= '1';
			crst0 <= '1';
			app_rstn0 <= '0';
		elsif rising_edge(clk) then
			if ((local_rstn = '0') or (exits_r = '1')) then
				srst0 <= '1';
				crst0 <= '1';
				app_rstn0 <= '0';
			elsif ((test_in(0) = '1') and (rsnt_cntn >= 32)) then 
				srst0 <= '0';
				crst0 <= '0';
				app_rstn0 <= '1';
			elsif (rsnt_cntn = 1024) then 
				srst0 <= '0';
				crst0 <= '0';
				app_rstn0 <= '1';
			end if;
		end if;
	end process;	

	-- sync and config reset pipeline
	process (clk, any_rstn_rr)
	begin
		if (any_rstn_rr = '0') then
			app_rstn <= '0';
			srst <= '1';
			crst <= '1';
		elsif rising_edge(clk) then
			app_rstn <= app_rstn0;
			srst <= srst0;
			crst <= crst0;
		end if;
	end process;
--===================================--

--==================================================================================--
--==================================== PCIE core ===================================--
--==================================================================================--
-- PCIE core component
	pcie_core_component : pcie_core
		PORT MAP
		(
			app_int_sts	=> app_int_sts,
			app_msi_num	=> (others => '0'),
			app_msi_req	=> '0',
			app_msi_tc => (others => '0'),
				busy_altgxb_reconfig	=> reconfig_busy,
				cal_blk_clk => cal_blk_clk,
			cpl_err => (others => '0'),
			cpl_pending => '0',
				crst => crst,
				fixedclk_serdes => reconfig_clk,
			gxb_powerdown => '0',
			hpg_ctrler => (others => '0'),
			lmi_addr => (others => '0'),
			lmi_din => (others => '0'),
			lmi_rden => '0',
			lmi_wren => '0',
				npor => npor,
				pclk_in => pclk_in,
			pex_msi_num => (others => '0'),
			phystatus_ext => '0',
			pipe_mode => '0',
				pld_clk => clk,
				pll_powerdown => pll_powerdown,
			pm_auxpwr => '0',
			pm_data => (others => '0'),
			pm_event => '0',
				pme_to_cr => pme_to_sr,
				reconfig_clk => reconfig_clk,
				reconfig_togxb => reconfig_togxb,
				refclk => refclk,
				rx_in0 => rx_in0,
				rx_st_mask0 => rx_st_mask0,
				rx_st_ready0 => rx_st_ready0,
			rxdata0_ext => (others => '1'),
			rxdatak0_ext => '1',
			rxelecidle0_ext => '1',
			rxstatus0_ext => (others => '1'),
			rxvalid0_ext => '1',
				srst => srst,
				test_in => test_in,
				tx_st_data0 => tx_st_data0,
				tx_st_eop0 => tx_st_eop0,
				tx_st_err0 => tx_st_err0,
				tx_st_sop0 => tx_st_sop0,
				tx_st_valid0 => tx_st_valid0,
			app_int_ack => app_int_ack,
			app_msi_ack => open,
			clk250_out => open,
			clk500_out => open,
			core_clk_out => clk,
			derr_cor_ext_rcv0 => open,
			derr_cor_ext_rpl => open,
			derr_rpl => open,
				dlup_exit => dlup_exit,
				hotrst_exit => hotrst_exit,
			ko_cpl_spc_vc0 => open,
				l2_exit => l2_exit,
				lane_act => lane_act,
			lmi_ack => open,
			lmi_dout => open,
				ltssm => ltssm,
--			npd_alloc_1cred_vc0 => open,
--			npd_cred_vio_vc0 => open,
--			nph_alloc_1cred_vc0 => open,
--			nph_cred_vio_vc0 => open,
				pme_to_sr => pme_to_sr,
			powerdown_ext => open,
			r2c_err0 => open,
			rate_ext => open,
				rc_pll_locked => rc_pll_locked,
			rc_rx_digitalreset => open,
				reconfig_fromgxb => reconfig_fromgxb,
			reset_status => open,
				rx_fifo_empty0 => rx_fifo_empty0,
				rx_fifo_full0 => rx_fifo_full0,
				rx_st_bardec0 => rx_st_bardec0,
				rx_st_be0 => rx_st_be0,
				rx_st_data0 => rx_st_data0_ip,
				rx_st_eop0 => rx_st_eop0_ip,
				rx_st_err0 => rx_st_err0_ip,
				rx_st_sop0 => rx_st_sop0_ip,
				rx_st_valid0 => rx_st_valid0_ip,
			rxpolarity0_ext => open,
			suc_spd_neg => open,
				tl_cfg_add => tl_cfg_add,
				tl_cfg_ctl => tl_cfg_ctl,
			tl_cfg_ctl_wr => open,
			tl_cfg_sts => open,
			tl_cfg_sts_wr => open,
				tx_cred0 => tx_cred0,
				tx_fifo_full0 => tx_fifo_full0,
				tx_fifo_rdptr0 => tx_fifo_rdptr0,
				tx_fifo_wrptr0 => tx_fifo_wrptr0,
				tx_out0 => tx_out0,
				tx_st_ready0 => tx_st_ready0,
			txcompl0_ext => open,
			txdata0_ext => open,	
			txdatak0_ext => open,
			txdetectrx_ext => open,
			txelecidle0_ext => open
		);

	test_out_icm <= (lane_act&ltssm);		
	app_clk <= clk;

	process(clk)
	begin
		if rising_edge(clk) then
			rx_st_data0 <= rx_st_data0_ip;
			rx_st_eop0 <= rx_st_eop0_ip;
			rx_st_err0 <= rx_st_err0_ip;
			rx_st_sop0 <= rx_st_sop0_ip;
			rx_st_valid0 <= rx_st_valid0_ip;
		end if;
	end process;
	
-- reconfiguration component
	reconfig_component : reconfig
		PORT MAP
		(
			reconfig_clk => reconfig_clk,
			reconfig_fromgxb => reconfig_fromgxb,
			busy => reconfig_busy,
			reconfig_togxb => reconfig_togxb
		);
--==================================================================================--


END RTL;
 
 
 
