--IP Functional Simulation Model
--VERSION_BEGIN 10.1 cbx_mgl 2010:10:27:21:25:33:SJ cbx_simgen 2010:10:27:21:10:48:SJ  VERSION_END


-- Copyright (C) 1991-2010 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- You may only use these simulation model output files for simulation
-- purposes and expressly not for synthesis or any other purposes (in which
-- event Altera disclaims all warranties of any kind).


--synopsys translate_off

 LIBRARY sgate;
 USE sgate.sgate_pack.all;

--synthesis_resources = lut 147 mux21 285 oper_add 5 oper_less_than 4 oper_mux 22 oper_selector 9 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  altpcie_rs_serdes IS 
	 PORT 
	 ( 
		 busy_altgxb_reconfig	:	IN  STD_LOGIC;
		 fifo_err	:	IN  STD_LOGIC;
		 ltssm	:	IN  STD_LOGIC_VECTOR (4 DOWNTO 0);
		 npor	:	IN  STD_LOGIC;
		 pld_clk	:	IN  STD_LOGIC;
		 pll_locked	:	IN  STD_LOGIC;
		 rc_inclk_eq_125mhz	:	IN  STD_LOGIC;
		 rx_freqlocked	:	IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
		 rx_pll_locked	:	IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
		 rx_signaldetect	:	IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
		 rxanalogreset	:	OUT  STD_LOGIC;
		 rxdigitalreset	:	OUT  STD_LOGIC;
		 test_in	:	IN  STD_LOGIC_VECTOR (39 DOWNTO 0);
		 txdigitalreset	:	OUT  STD_LOGIC;
		 use_c4gx_serdes	:	IN  STD_LOGIC
	 ); 
 END altpcie_rs_serdes;

 ARCHITECTURE RTL OF altpcie_rs_serdes IS

	 ATTRIBUTE synthesis_clearbox : natural;
	 ATTRIBUTE synthesis_clearbox OF RTL : ARCHITECTURE IS 1;
	 SIGNAL	altpcie_rs_serdes_busy_altgxb_reconfig_r_0_245q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_busy_altgxb_reconfig_r_1_244q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_ld_ws_tmr_230q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rxanalogreset_r_203q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rxdigitalreset_r_204q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_serdes_rst_state_strobe_txpll_locked_sd_cnt_226q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_txdigitalreset_r_202q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_0_224q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_10_214q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_11_213q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_12_212q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_13_211q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_14_210q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_15_209q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_16_208q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_17_207q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_18_206q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_19_205q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_1_223q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_2_222q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_3_221q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_4_220q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_5_219q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_6_218q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_7_217q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_8_216q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_waitstate_timer_9_215q	:	STD_LOGIC := '0';
	 SIGNAL  wire_ni_w204w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_0_224q910w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_10_214q890w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_11_213q888w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_12_212q886w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_13_211q884w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_14_210q882w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_15_209q880w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_16_208q878w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_17_207q876w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_18_206q874w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_19_205q873w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_1_223q908w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_2_222q906w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_3_221q904w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_4_220q902w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_5_219q900w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_6_218q898w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_7_217q896w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_8_216q894w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_9_215q892w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL	altpcie_rs_serdes_ld_ws_tmr_short_231q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_pll_locked_cnt_0_252q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_pll_locked_cnt_1_251q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_pll_locked_cnt_2_250q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_pll_locked_cnt_3_249q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_pll_locked_cnt_4_248q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_pll_locked_cnt_5_247q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_pll_locked_cnt_6_246q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_pll_locked_r_0_18q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_pll_locked_r_1_17q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_pll_locked_r_2_16q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_pll_locked_stable_255q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_freq_locked_cnt_0_234q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_freq_locked_cnt_1_233q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_freq_locked_cnt_2_232q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_freq_locked_r_0_21q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_freq_locked_r_1_20q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_freq_locked_r_2_19q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_freq_locked_sync_r_235q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_r_0_22q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_r_1_28q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_r_2_34q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_r_3_40q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_r_4_46q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_r_5_52q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_r_6_58q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_r_7_64q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rr_0_23q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rr_1_29q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rr_2_35q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rr_3_41q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rr_4_47q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rr_5_53q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rr_6_59q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rr_7_65q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rrr_0_24q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rrr_1_30q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rrr_2_36q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rrr_3_42q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rrr_4_48q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rrr_5_54q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rrr_6_60q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_rrr_7_66q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_0_524q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_10_514q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_11_513q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_12_512q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_13_511q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_14_510q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_15_509q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_16_508q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_17_507q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_18_506q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_19_505q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_1_523q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_2_522q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_3_521q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_4_520q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_5_519q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_6_518q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_7_517q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_8_516q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_idl_cnt_9_515q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb0_0_263q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb0_1_262q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb0_2_261q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb0_3_260q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb0_4_259q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb0_5_258q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb0_6_257q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb0_7_256q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb1_0_504q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb1_1_270q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb1_2_269q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb1_3_268q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb1_4_267q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb1_5_266q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb1_6_265q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_sd_strb1_7_264q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_r_0_25q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_r_1_31q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_r_2_37q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_r_3_43q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_r_4_49q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_r_5_55q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_r_6_61q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_r_7_67q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rr_0_26q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rr_1_32q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rr_2_38q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rr_3_44q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rr_4_50q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rr_5_56q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rr_6_62q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rr_7_68q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rrr_0_27q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rrr_1_33q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rrr_2_39q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rrr_3_45q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rrr_4_51q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rrr_5_57q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rrr_6_63q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_signaldetect_rrr_7_200q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_sd_state_0_201q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_sd_state_1_525q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_serdes_rst_state_idle_st_cnt_225q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_serdes_rst_state_stable_tx_pll_st_cnt_227q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_serdes_rst_state_wait_state_st_cnt_228q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_ws_tmr_eq_0_229q	:	STD_LOGIC := '0';
	 SIGNAL  wire_nl_w_lg_w987w988w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w987w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_w_lg_w_lg_w_lg_w_lg_w978w980w982w983w984w986w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_w_lg_w_lg_w_lg_w978w980w982w983w984w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_w_lg_w_lg_w978w980w982w983w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_w_lg_w978w980w982w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_w978w980w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w978w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_w_lg_w_lg_w_lg_w_lg_w970w971w973w974w975w976w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_w_lg_w_lg_w_lg_w970w971w973w974w975w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_w_lg_w_lg_w970w971w973w974w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_w_lg_w970w971w973w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_w970w971w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w970w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_19_505q969w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_ld_ws_tmr_short_231q205w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_pll_locked_r_2_16q109w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w865w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w863w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w862w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w225w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_0_524q995w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_10_514q979w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_11_513q977w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_15_509q972w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_18_506q968w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_1_523q993w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_2_522q991w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_3_521q989w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_6_518q985w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_9_515q981w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_0_504q948w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_1_270q946w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_2_269q944w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_3_268q942w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_4_267q940w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_5_266q938w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_6_265q936w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_7_264q935w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_sync_r_0_243q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_sync_r_1_242q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_sync_r_2_241q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_sync_r_3_240q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_sync_r_4_239q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_sync_r_5_238q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_sync_r_6_237q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_rx_pll_locked_sync_r_7_236q	:	STD_LOGIC := '0';
	 SIGNAL  wire_nlO_w2w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nlO_w4w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nlO_w7w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nlO_w10w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nlO_w13w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nlO_w16w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nlO_w19w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_nlO_w22w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL	altpcie_rs_serdes_arst_r_0_15q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_arst_r_1_5q	:	STD_LOGIC := '0';
	 SIGNAL	altpcie_rs_serdes_arst_r_2_4q	:	STD_LOGIC := '0';
	 SIGNAL  wire_nO_w_lg_altpcie_rs_serdes_arst_r_2_4q24w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL	wire_altpcie_rs_serdes_ld_ws_tmr_172m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_ld_ws_tmr_short_179m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_ld_ws_tmr_short_183m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_pll_locked_cnt_84m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_pll_locked_cnt_85m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_pll_locked_cnt_86m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_pll_locked_cnt_87m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_pll_locked_cnt_88m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_pll_locked_cnt_89m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_pll_locked_cnt_90m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_pll_locked_cnt_91m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_pll_locked_cnt_92m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_pll_locked_cnt_93m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_pll_locked_cnt_94m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_pll_locked_cnt_95m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_pll_locked_cnt_96m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_pll_locked_cnt_97m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rst_rxpcs_sd_254m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_365m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_366m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_367m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_368m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_370m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_481m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_278m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_279m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_280m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_281m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_282m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_283m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_284m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_285m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_286m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_287m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_288m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_289m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_290m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_291m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_292m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_293m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_294m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_295m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_296m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_297m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_300m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_301m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_302m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_303m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_304m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_305m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_306m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_307m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_308m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_309m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_310m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_311m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_312m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_313m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_314m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_315m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_316m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_317m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_318m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_319m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_320m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_321m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_322m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_323m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_324m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_325m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_326m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_327m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_328m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_329m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_330m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_331m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_332m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_333m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_334m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_335m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_336m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_337m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_338m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_339m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_340m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_341m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_342m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_343m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_344m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_345m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_346m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_347m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_348m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_349m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_350m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_351m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_352m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_353m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_354m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_355m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_356m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_357m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_358m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_359m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_372m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_373m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_374m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_375m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_376m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_377m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_378m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_379m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_380m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_381m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_382m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_383m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_384m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_385m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_386m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_387m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_388m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_389m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_390m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_391m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_392m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_393m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_394m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_395m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_396m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_397m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_398m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_399m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_400m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_401m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_402m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_403m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_404m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_405m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_406m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_407m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_408m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_409m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_410m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_411m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_414m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_415m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_416m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_417m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_418m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_419m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_420m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_421m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_422m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_423m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_424m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_425m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_426m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_427m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_428m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_429m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_430m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_431m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_432m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_433m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_436m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_437m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_438m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_439m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_440m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_441m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_442m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_443m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_444m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_445m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_446m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_447m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_448m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_449m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_450m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_451m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_452m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_453m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_454m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_455m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_459m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_460m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_461m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_462m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_463m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_464m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_465m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_466m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_467m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_468m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_469m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_470m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_471m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_472m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_473m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_474m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_475m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_476m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_477m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rx_sd_idl_cnt_478m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rxanalogreset_1m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rxanalogreset_r_178m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_rxdigitalreset_r_187m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_sd_state_360m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_sd_state_361m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_sd_state_412m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_sd_state_413m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_sd_state_434m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_sd_state_435m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_sd_state_456m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_sd_state_457m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_sd_state_479m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_sd_state_480m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_serdes_rst_state_170m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_serdes_rst_state_171m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_serdes_rst_state_177m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_serdes_rst_state_184m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_serdes_rst_state_186m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_101m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_102m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_106m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_107m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_108m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_109m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_110m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_111m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_112m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_113m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_114m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_115m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_116m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_117m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_118m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_119m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_120m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_121m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_122m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_123m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_124m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_125m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_126m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_127m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_128m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_129m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_130m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_131m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_132m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_133m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_134m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_135m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_136m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_137m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_138m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_139m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_140m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_141m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_142m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_143m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_144m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_145m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_146m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_147m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_148m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_149m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_150m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_151m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_152m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_153m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_154m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_155m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_156m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_157m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_158m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_159m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_160m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_161m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_162m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_163m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_164m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_waitstate_timer_165m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_altpcie_rs_serdes_ws_tmr_eq_0_168m_dataout	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_add0_79_a	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_add0_79_b	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_gnd	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_add0_79_o	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_add1_83_a	:	STD_LOGIC_VECTOR (6 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_add1_83_b	:	STD_LOGIC_VECTOR (6 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_add1_83_o	:	STD_LOGIC_VECTOR (6 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_add2_105_a	:	STD_LOGIC_VECTOR (20 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_add2_105_b	:	STD_LOGIC_VECTOR (20 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_add2_105_o	:	STD_LOGIC_VECTOR (20 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_add3_277_a	:	STD_LOGIC_VECTOR (19 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_add3_277_b	:	STD_LOGIC_VECTOR (19 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_add3_277_o	:	STD_LOGIC_VECTOR (19 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_add4_371_a	:	STD_LOGIC_VECTOR (19 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_add4_371_b	:	STD_LOGIC_VECTOR (19 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_add4_371_o	:	STD_LOGIC_VECTOR (19 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_lessthan0_82_a	:	STD_LOGIC_VECTOR (6 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_lessthan0_82_b	:	STD_LOGIC_VECTOR (6 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_lessthan0_82_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_lessthan1_276_a	:	STD_LOGIC_VECTOR (19 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_lessthan1_276_b	:	STD_LOGIC_VECTOR (19 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_lessthan1_276_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_lessthan2_298_a	:	STD_LOGIC_VECTOR (19 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_lessthan2_298_b	:	STD_LOGIC_VECTOR (19 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_lessthan2_298_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_lessthan3_363_a	:	STD_LOGIC_VECTOR (19 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_lessthan3_363_b	:	STD_LOGIC_VECTOR (19 DOWNTO 0);
	 SIGNAL  wire_vcc	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_lessthan3_363_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux0_482_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux0_482_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux0_482_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux10_492_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux10_492_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux10_492_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux11_493_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux11_493_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux11_493_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux12_494_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux12_494_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux12_494_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux13_495_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux13_495_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux13_495_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux14_496_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux14_496_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux14_496_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux15_497_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux15_497_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux15_497_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux16_498_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux16_498_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux16_498_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux17_499_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux17_499_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux17_499_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux18_500_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux18_500_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux18_500_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux19_501_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux19_501_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux19_501_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux1_483_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux1_483_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux1_483_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux20_502_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux20_502_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux20_502_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux21_503_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux21_503_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux21_503_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux2_484_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux2_484_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux2_484_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux3_485_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux3_485_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux3_485_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux4_486_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux4_486_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux4_486_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux5_487_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux5_487_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux5_487_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux6_488_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux6_488_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux6_488_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux7_489_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux7_489_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux7_489_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux8_490_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux8_490_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux8_490_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux9_491_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_mux9_491_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_mux9_491_sel	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector0_188_data	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector0_188_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_selector0_188_sel	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector1_189_data	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector1_189_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_selector1_189_sel	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector2_190_data	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector2_190_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_selector2_190_sel	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector3_192_data	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector3_192_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_selector3_192_sel	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector4_193_data	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector4_193_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_selector4_193_sel	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector5_195_data	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector5_195_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_selector5_195_sel	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector6_196_data	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector6_196_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_selector6_196_sel	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector7_198_data	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector7_198_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_selector7_198_sel	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector8_199_data	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_altpcie_rs_serdes_selector8_199_o	:	STD_LOGIC;
	 SIGNAL  wire_altpcie_rs_serdes_selector8_199_sel	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
	 SIGNAL  wire_w_lg_fifo_err201w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_rc_inclk_eq_125mhz110w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w264w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w207w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w294w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w654w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w526w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w297w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w179w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  s_wire_altpcie_rs_serdes_always10_174_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_always10_181_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_always12_299_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_always12_364_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_pll_locked_stable_625_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_0_617_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_rx_pll_locked_sync_r_7_613_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_rxdigitalreset_r_197_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_sd_state_0_676_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_serdes_rst_state_191_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_stable_sd_274_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_stable_sd_655_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_stable_sd_664_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_txdigitalreset_r_194_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_wideand0_14_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_altpcie_rs_serdes_ws_tmr_eq_0_0_646_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_gnd :	STD_LOGIC;
	 SIGNAL  s_wire_vcc :	STD_LOGIC;
	 SIGNAL  wire_w_rx_freqlocked_range1w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_rx_freqlocked_range3w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_rx_freqlocked_range6w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_rx_freqlocked_range9w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_rx_freqlocked_range12w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_rx_freqlocked_range15w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_rx_freqlocked_range18w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_rx_freqlocked_range21w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
 BEGIN

	wire_gnd <= '0';
	wire_vcc <= '1';
	wire_w_lg_fifo_err201w(0) <= NOT fifo_err;
	wire_w_lg_rc_inclk_eq_125mhz110w(0) <= NOT rc_inclk_eq_125mhz;
	wire_w264w(0) <= NOT s_wire_altpcie_rs_serdes_always10_174_dataout;
	wire_w207w(0) <= NOT s_wire_altpcie_rs_serdes_always10_181_dataout;
	wire_w294w(0) <= NOT s_wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_0_617_dataout;
	wire_w654w(0) <= NOT s_wire_altpcie_rs_serdes_sd_state_0_676_dataout;
	wire_w526w(0) <= NOT s_wire_altpcie_rs_serdes_stable_sd_274_dataout;
	wire_w297w(0) <= NOT s_wire_altpcie_rs_serdes_stable_sd_664_dataout;
	wire_w179w(0) <= NOT s_wire_altpcie_rs_serdes_ws_tmr_eq_0_0_646_dataout;
	rxanalogreset <= wire_altpcie_rs_serdes_rxanalogreset_1m_dataout;
	rxdigitalreset <= (altpcie_rs_serdes_rxdigitalreset_r_204q OR wire_altpcie_rs_serdes_rst_rxpcs_sd_254m_dataout);
	s_wire_altpcie_rs_serdes_always10_174_dataout <= ((altpcie_rs_serdes_pll_locked_r_2_16q AND altpcie_rs_serdes_ws_tmr_eq_0_229q) AND altpcie_rs_serdes_pll_locked_stable_255q);
	s_wire_altpcie_rs_serdes_always10_181_dataout <= (altpcie_rs_serdes_ws_tmr_eq_0_229q AND wire_nl_w_lg_altpcie_rs_serdes_ld_ws_tmr_short_231q205w(0));
	s_wire_altpcie_rs_serdes_always12_299_dataout <= (s_wire_altpcie_rs_serdes_stable_sd_274_dataout AND wire_altpcie_rs_serdes_lessthan2_298_o);
	s_wire_altpcie_rs_serdes_always12_364_dataout <= (wire_altpcie_rs_serdes_lessthan3_363_o AND test_in(0));
	s_wire_altpcie_rs_serdes_pll_locked_stable_625_dataout <= ((((((altpcie_rs_serdes_pll_locked_cnt_6_246q AND altpcie_rs_serdes_pll_locked_cnt_5_247q) AND altpcie_rs_serdes_pll_locked_cnt_4_248q) AND altpcie_rs_serdes_pll_locked_cnt_3_249q) AND altpcie_rs_serdes_pll_locked_cnt_2_250q) AND altpcie_rs_serdes_pll_locked_cnt_1_251q) AND altpcie_rs_serdes_pll_locked_cnt_0_252q);
	s_wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_0_617_dataout <= ((wire_nl_w862w(0) AND wire_nl_w863w(0)) AND wire_nl_w865w(0));
	s_wire_altpcie_rs_serdes_rx_pll_locked_sync_r_7_613_dataout <= (((((((altpcie_rs_serdes_rx_pll_locked_rrr_0_24q AND altpcie_rs_serdes_rx_pll_locked_rrr_1_30q) AND altpcie_rs_serdes_rx_pll_locked_rrr_2_36q) AND altpcie_rs_serdes_rx_pll_locked_rrr_3_42q) AND altpcie_rs_serdes_rx_pll_locked_rrr_4_48q) AND altpcie_rs_serdes_rx_pll_locked_rrr_5_54q) AND altpcie_rs_serdes_rx_pll_locked_rrr_6_60q) AND altpcie_rs_serdes_rx_pll_locked_rrr_7_66q);
	s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout <= (((((NOT ltssm(0)) AND ltssm(1)) AND (NOT ltssm(2))) AND (NOT ltssm(3))) AND (NOT ltssm(4)));
	s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout <= ((((wire_nl_w_lg_w987w988w(0) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_3_521q989w(0)) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_2_522q991w(0)) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_1_523q993w(0)) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_0_524q995w(0));
	s_wire_altpcie_rs_serdes_rxdigitalreset_r_197_dataout <= (altpcie_rs_serdes_serdes_rst_state_strobe_txpll_locked_sd_cnt_226q OR altpcie_rs_serdes_serdes_rst_state_stable_tx_pll_st_cnt_227q);
	s_wire_altpcie_rs_serdes_sd_state_0_676_dataout <= (((((NOT ltssm(0)) AND (NOT ltssm(1))) AND (NOT ltssm(2))) AND (NOT ltssm(3))) AND (NOT ltssm(4)));
	s_wire_altpcie_rs_serdes_serdes_rst_state_191_dataout <= (altpcie_rs_serdes_serdes_rst_state_idle_st_cnt_225q OR altpcie_rs_serdes_serdes_rst_state_strobe_txpll_locked_sd_cnt_226q);
	s_wire_altpcie_rs_serdes_stable_sd_274_dataout <= (s_wire_altpcie_rs_serdes_stable_sd_655_dataout AND wire_w297w(0));
	s_wire_altpcie_rs_serdes_stable_sd_655_dataout <= ((((((((NOT (altpcie_rs_serdes_rx_sd_strb0_0_263q XOR altpcie_rs_serdes_rx_sd_strb1_0_504q)) AND (NOT (altpcie_rs_serdes_rx_sd_strb0_1_262q XOR altpcie_rs_serdes_rx_sd_strb1_1_270q))) AND (NOT (altpcie_rs_serdes_rx_sd_strb0_2_261q XOR altpcie_rs_serdes_rx_sd_strb1_2_269q))) AND (NOT (altpcie_rs_serdes_rx_sd_strb0_3_260q XOR altpcie_rs_serdes_rx_sd_strb1_3_268q))) AND (NOT (altpcie_rs_serdes_rx_sd_strb0_4_259q XOR altpcie_rs_serdes_rx_sd_strb1_4_267q))) AND (NOT (altpcie_rs_serdes_rx_sd_strb0_5_258q XOR altpcie_rs_serdes_rx_sd_strb1_5_266q))) AND (NOT (altpcie_rs_serdes_rx_sd_strb0_6_257q XOR altpcie_rs_serdes_rx_sd_strb1_6_265q))) AND (NOT (altpcie_rs_serdes_rx_sd_strb0_7_256q XOR altpcie_rs_serdes_rx_sd_strb1_7_264q)));
	s_wire_altpcie_rs_serdes_stable_sd_664_dataout <= (((((((wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_7_264q935w(0) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_6_265q936w(0)) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_5_266q938w(0)) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_4_267q940w(0)) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_3_268q942w(0)) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_2_269q944w(0)) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_1_270q946w(0)) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_0_504q948w(0));
	s_wire_altpcie_rs_serdes_txdigitalreset_r_194_dataout <= (altpcie_rs_serdes_serdes_rst_state_stable_tx_pll_st_cnt_227q OR altpcie_rs_serdes_serdes_rst_state_wait_state_st_cnt_228q);
	s_wire_altpcie_rs_serdes_wideand0_14_dataout <= (((((((wire_nlO_w2w(0) AND wire_nlO_w4w(0)) AND wire_nlO_w7w(0)) AND wire_nlO_w10w(0)) AND wire_nlO_w13w(0)) AND wire_nlO_w16w(0)) AND wire_nlO_w19w(0)) AND wire_nlO_w22w(0));
	s_wire_altpcie_rs_serdes_ws_tmr_eq_0_0_646_dataout <= (((((((((((((((((((wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_19_205q873w(0) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_18_206q874w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_17_207q876w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_16_208q878w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_15_209q880w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_14_210q882w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_13_211q884w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_12_212q886w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_11_213q888w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_10_214q890w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_9_215q892w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_8_216q894w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_7_217q896w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_6_218q898w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_5_219q900w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_4_220q902w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_3_221q904w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_2_222q906w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_1_223q908w(0)) AND wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_0_224q910w(0));
	s_wire_gnd <= '0';
	s_wire_vcc <= '1';
	txdigitalreset <= altpcie_rs_serdes_txdigitalreset_r_202q;
	wire_w_rx_freqlocked_range1w(0) <= rx_freqlocked(0);
	wire_w_rx_freqlocked_range3w(0) <= rx_freqlocked(1);
	wire_w_rx_freqlocked_range6w(0) <= rx_freqlocked(2);
	wire_w_rx_freqlocked_range9w(0) <= rx_freqlocked(3);
	wire_w_rx_freqlocked_range12w(0) <= rx_freqlocked(4);
	wire_w_rx_freqlocked_range15w(0) <= rx_freqlocked(5);
	wire_w_rx_freqlocked_range18w(0) <= rx_freqlocked(6);
	wire_w_rx_freqlocked_range21w(0) <= rx_freqlocked(7);
	PROCESS (pld_clk, altpcie_rs_serdes_arst_r_2_4q)
	BEGIN
		IF (altpcie_rs_serdes_arst_r_2_4q = '1') THEN
				altpcie_rs_serdes_busy_altgxb_reconfig_r_0_245q <= '1';
				altpcie_rs_serdes_busy_altgxb_reconfig_r_1_244q <= '1';
				altpcie_rs_serdes_ld_ws_tmr_230q <= '1';
				altpcie_rs_serdes_rxanalogreset_r_203q <= '1';
				altpcie_rs_serdes_rxdigitalreset_r_204q <= '1';
				altpcie_rs_serdes_serdes_rst_state_strobe_txpll_locked_sd_cnt_226q <= '1';
				altpcie_rs_serdes_txdigitalreset_r_202q <= '1';
				altpcie_rs_serdes_waitstate_timer_0_224q <= '1';
				altpcie_rs_serdes_waitstate_timer_10_214q <= '1';
				altpcie_rs_serdes_waitstate_timer_11_213q <= '1';
				altpcie_rs_serdes_waitstate_timer_12_212q <= '1';
				altpcie_rs_serdes_waitstate_timer_13_211q <= '1';
				altpcie_rs_serdes_waitstate_timer_14_210q <= '1';
				altpcie_rs_serdes_waitstate_timer_15_209q <= '1';
				altpcie_rs_serdes_waitstate_timer_16_208q <= '1';
				altpcie_rs_serdes_waitstate_timer_17_207q <= '1';
				altpcie_rs_serdes_waitstate_timer_18_206q <= '1';
				altpcie_rs_serdes_waitstate_timer_19_205q <= '1';
				altpcie_rs_serdes_waitstate_timer_1_223q <= '1';
				altpcie_rs_serdes_waitstate_timer_2_222q <= '1';
				altpcie_rs_serdes_waitstate_timer_3_221q <= '1';
				altpcie_rs_serdes_waitstate_timer_4_220q <= '1';
				altpcie_rs_serdes_waitstate_timer_5_219q <= '1';
				altpcie_rs_serdes_waitstate_timer_6_218q <= '1';
				altpcie_rs_serdes_waitstate_timer_7_217q <= '1';
				altpcie_rs_serdes_waitstate_timer_8_216q <= '1';
				altpcie_rs_serdes_waitstate_timer_9_215q <= '1';
		ELSIF (pld_clk = '1' AND pld_clk'event) THEN
				altpcie_rs_serdes_busy_altgxb_reconfig_r_0_245q <= busy_altgxb_reconfig;
				altpcie_rs_serdes_busy_altgxb_reconfig_r_1_244q <= altpcie_rs_serdes_busy_altgxb_reconfig_r_0_245q;
				altpcie_rs_serdes_ld_ws_tmr_230q <= wire_altpcie_rs_serdes_selector4_193_o;
				altpcie_rs_serdes_rxanalogreset_r_203q <= wire_altpcie_rs_serdes_selector6_196_o;
				altpcie_rs_serdes_rxdigitalreset_r_204q <= wire_altpcie_rs_serdes_selector7_198_o;
				altpcie_rs_serdes_serdes_rst_state_strobe_txpll_locked_sd_cnt_226q <= wire_altpcie_rs_serdes_selector1_189_o;
				altpcie_rs_serdes_txdigitalreset_r_202q <= wire_altpcie_rs_serdes_selector5_195_o;
				altpcie_rs_serdes_waitstate_timer_0_224q <= wire_altpcie_rs_serdes_waitstate_timer_165m_dataout;
				altpcie_rs_serdes_waitstate_timer_10_214q <= wire_altpcie_rs_serdes_waitstate_timer_155m_dataout;
				altpcie_rs_serdes_waitstate_timer_11_213q <= wire_altpcie_rs_serdes_waitstate_timer_154m_dataout;
				altpcie_rs_serdes_waitstate_timer_12_212q <= wire_altpcie_rs_serdes_waitstate_timer_153m_dataout;
				altpcie_rs_serdes_waitstate_timer_13_211q <= wire_altpcie_rs_serdes_waitstate_timer_152m_dataout;
				altpcie_rs_serdes_waitstate_timer_14_210q <= wire_altpcie_rs_serdes_waitstate_timer_151m_dataout;
				altpcie_rs_serdes_waitstate_timer_15_209q <= wire_altpcie_rs_serdes_waitstate_timer_150m_dataout;
				altpcie_rs_serdes_waitstate_timer_16_208q <= wire_altpcie_rs_serdes_waitstate_timer_149m_dataout;
				altpcie_rs_serdes_waitstate_timer_17_207q <= wire_altpcie_rs_serdes_waitstate_timer_148m_dataout;
				altpcie_rs_serdes_waitstate_timer_18_206q <= wire_altpcie_rs_serdes_waitstate_timer_147m_dataout;
				altpcie_rs_serdes_waitstate_timer_19_205q <= wire_altpcie_rs_serdes_waitstate_timer_146m_dataout;
				altpcie_rs_serdes_waitstate_timer_1_223q <= wire_altpcie_rs_serdes_waitstate_timer_164m_dataout;
				altpcie_rs_serdes_waitstate_timer_2_222q <= wire_altpcie_rs_serdes_waitstate_timer_163m_dataout;
				altpcie_rs_serdes_waitstate_timer_3_221q <= wire_altpcie_rs_serdes_waitstate_timer_162m_dataout;
				altpcie_rs_serdes_waitstate_timer_4_220q <= wire_altpcie_rs_serdes_waitstate_timer_161m_dataout;
				altpcie_rs_serdes_waitstate_timer_5_219q <= wire_altpcie_rs_serdes_waitstate_timer_160m_dataout;
				altpcie_rs_serdes_waitstate_timer_6_218q <= wire_altpcie_rs_serdes_waitstate_timer_159m_dataout;
				altpcie_rs_serdes_waitstate_timer_7_217q <= wire_altpcie_rs_serdes_waitstate_timer_158m_dataout;
				altpcie_rs_serdes_waitstate_timer_8_216q <= wire_altpcie_rs_serdes_waitstate_timer_157m_dataout;
				altpcie_rs_serdes_waitstate_timer_9_215q <= wire_altpcie_rs_serdes_waitstate_timer_156m_dataout;
		END IF;
		if (now = 0 ns) then
			altpcie_rs_serdes_busy_altgxb_reconfig_r_0_245q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_busy_altgxb_reconfig_r_1_244q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_ld_ws_tmr_230q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_rxanalogreset_r_203q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_rxdigitalreset_r_204q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_serdes_rst_state_strobe_txpll_locked_sd_cnt_226q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_txdigitalreset_r_202q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_0_224q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_10_214q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_11_213q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_12_212q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_13_211q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_14_210q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_15_209q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_16_208q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_17_207q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_18_206q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_19_205q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_1_223q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_2_222q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_3_221q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_4_220q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_5_219q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_6_218q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_7_217q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_8_216q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_waitstate_timer_9_215q <= '1' after 1 ps;
		end if;
	END PROCESS;
	wire_ni_w204w(0) <= NOT altpcie_rs_serdes_busy_altgxb_reconfig_r_1_244q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_0_224q910w(0) <= NOT altpcie_rs_serdes_waitstate_timer_0_224q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_10_214q890w(0) <= NOT altpcie_rs_serdes_waitstate_timer_10_214q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_11_213q888w(0) <= NOT altpcie_rs_serdes_waitstate_timer_11_213q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_12_212q886w(0) <= NOT altpcie_rs_serdes_waitstate_timer_12_212q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_13_211q884w(0) <= NOT altpcie_rs_serdes_waitstate_timer_13_211q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_14_210q882w(0) <= NOT altpcie_rs_serdes_waitstate_timer_14_210q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_15_209q880w(0) <= NOT altpcie_rs_serdes_waitstate_timer_15_209q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_16_208q878w(0) <= NOT altpcie_rs_serdes_waitstate_timer_16_208q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_17_207q876w(0) <= NOT altpcie_rs_serdes_waitstate_timer_17_207q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_18_206q874w(0) <= NOT altpcie_rs_serdes_waitstate_timer_18_206q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_19_205q873w(0) <= NOT altpcie_rs_serdes_waitstate_timer_19_205q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_1_223q908w(0) <= NOT altpcie_rs_serdes_waitstate_timer_1_223q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_2_222q906w(0) <= NOT altpcie_rs_serdes_waitstate_timer_2_222q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_3_221q904w(0) <= NOT altpcie_rs_serdes_waitstate_timer_3_221q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_4_220q902w(0) <= NOT altpcie_rs_serdes_waitstate_timer_4_220q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_5_219q900w(0) <= NOT altpcie_rs_serdes_waitstate_timer_5_219q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_6_218q898w(0) <= NOT altpcie_rs_serdes_waitstate_timer_6_218q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_7_217q896w(0) <= NOT altpcie_rs_serdes_waitstate_timer_7_217q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_8_216q894w(0) <= NOT altpcie_rs_serdes_waitstate_timer_8_216q;
	wire_ni_w_lg_altpcie_rs_serdes_waitstate_timer_9_215q892w(0) <= NOT altpcie_rs_serdes_waitstate_timer_9_215q;
	PROCESS (pld_clk, altpcie_rs_serdes_arst_r_2_4q)
	BEGIN
		IF (altpcie_rs_serdes_arst_r_2_4q = '1') THEN
				altpcie_rs_serdes_ld_ws_tmr_short_231q <= '0';
				altpcie_rs_serdes_pll_locked_cnt_0_252q <= '0';
				altpcie_rs_serdes_pll_locked_cnt_1_251q <= '0';
				altpcie_rs_serdes_pll_locked_cnt_2_250q <= '0';
				altpcie_rs_serdes_pll_locked_cnt_3_249q <= '0';
				altpcie_rs_serdes_pll_locked_cnt_4_248q <= '0';
				altpcie_rs_serdes_pll_locked_cnt_5_247q <= '0';
				altpcie_rs_serdes_pll_locked_cnt_6_246q <= '0';
				altpcie_rs_serdes_pll_locked_r_0_18q <= '0';
				altpcie_rs_serdes_pll_locked_r_1_17q <= '0';
				altpcie_rs_serdes_pll_locked_r_2_16q <= '0';
				altpcie_rs_serdes_pll_locked_stable_255q <= '0';
				altpcie_rs_serdes_rx_pll_freq_locked_cnt_0_234q <= '0';
				altpcie_rs_serdes_rx_pll_freq_locked_cnt_1_233q <= '0';
				altpcie_rs_serdes_rx_pll_freq_locked_cnt_2_232q <= '0';
				altpcie_rs_serdes_rx_pll_freq_locked_r_0_21q <= '0';
				altpcie_rs_serdes_rx_pll_freq_locked_r_1_20q <= '0';
				altpcie_rs_serdes_rx_pll_freq_locked_r_2_19q <= '0';
				altpcie_rs_serdes_rx_pll_freq_locked_sync_r_235q <= '0';
				altpcie_rs_serdes_rx_pll_locked_r_0_22q <= '0';
				altpcie_rs_serdes_rx_pll_locked_r_1_28q <= '0';
				altpcie_rs_serdes_rx_pll_locked_r_2_34q <= '0';
				altpcie_rs_serdes_rx_pll_locked_r_3_40q <= '0';
				altpcie_rs_serdes_rx_pll_locked_r_4_46q <= '0';
				altpcie_rs_serdes_rx_pll_locked_r_5_52q <= '0';
				altpcie_rs_serdes_rx_pll_locked_r_6_58q <= '0';
				altpcie_rs_serdes_rx_pll_locked_r_7_64q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rr_0_23q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rr_1_29q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rr_2_35q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rr_3_41q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rr_4_47q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rr_5_53q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rr_6_59q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rr_7_65q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rrr_0_24q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rrr_1_30q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rrr_2_36q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rrr_3_42q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rrr_4_48q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rrr_5_54q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rrr_6_60q <= '0';
				altpcie_rs_serdes_rx_pll_locked_rrr_7_66q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_0_524q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_10_514q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_11_513q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_12_512q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_13_511q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_14_510q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_15_509q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_16_508q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_17_507q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_18_506q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_19_505q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_1_523q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_2_522q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_3_521q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_4_520q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_5_519q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_6_518q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_7_517q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_8_516q <= '0';
				altpcie_rs_serdes_rx_sd_idl_cnt_9_515q <= '0';
				altpcie_rs_serdes_rx_sd_strb0_0_263q <= '0';
				altpcie_rs_serdes_rx_sd_strb0_1_262q <= '0';
				altpcie_rs_serdes_rx_sd_strb0_2_261q <= '0';
				altpcie_rs_serdes_rx_sd_strb0_3_260q <= '0';
				altpcie_rs_serdes_rx_sd_strb0_4_259q <= '0';
				altpcie_rs_serdes_rx_sd_strb0_5_258q <= '0';
				altpcie_rs_serdes_rx_sd_strb0_6_257q <= '0';
				altpcie_rs_serdes_rx_sd_strb0_7_256q <= '0';
				altpcie_rs_serdes_rx_sd_strb1_0_504q <= '0';
				altpcie_rs_serdes_rx_sd_strb1_1_270q <= '0';
				altpcie_rs_serdes_rx_sd_strb1_2_269q <= '0';
				altpcie_rs_serdes_rx_sd_strb1_3_268q <= '0';
				altpcie_rs_serdes_rx_sd_strb1_4_267q <= '0';
				altpcie_rs_serdes_rx_sd_strb1_5_266q <= '0';
				altpcie_rs_serdes_rx_sd_strb1_6_265q <= '0';
				altpcie_rs_serdes_rx_sd_strb1_7_264q <= '0';
				altpcie_rs_serdes_rx_signaldetect_r_0_25q <= '0';
				altpcie_rs_serdes_rx_signaldetect_r_1_31q <= '0';
				altpcie_rs_serdes_rx_signaldetect_r_2_37q <= '0';
				altpcie_rs_serdes_rx_signaldetect_r_3_43q <= '0';
				altpcie_rs_serdes_rx_signaldetect_r_4_49q <= '0';
				altpcie_rs_serdes_rx_signaldetect_r_5_55q <= '0';
				altpcie_rs_serdes_rx_signaldetect_r_6_61q <= '0';
				altpcie_rs_serdes_rx_signaldetect_r_7_67q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rr_0_26q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rr_1_32q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rr_2_38q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rr_3_44q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rr_4_50q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rr_5_56q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rr_6_62q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rr_7_68q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rrr_0_27q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rrr_1_33q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rrr_2_39q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rrr_3_45q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rrr_4_51q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rrr_5_57q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rrr_6_63q <= '0';
				altpcie_rs_serdes_rx_signaldetect_rrr_7_200q <= '0';
				altpcie_rs_serdes_sd_state_0_201q <= '0';
				altpcie_rs_serdes_sd_state_1_525q <= '0';
				altpcie_rs_serdes_serdes_rst_state_idle_st_cnt_225q <= '0';
				altpcie_rs_serdes_serdes_rst_state_stable_tx_pll_st_cnt_227q <= '0';
				altpcie_rs_serdes_serdes_rst_state_wait_state_st_cnt_228q <= '0';
				altpcie_rs_serdes_ws_tmr_eq_0_229q <= '0';
		ELSIF (pld_clk = '1' AND pld_clk'event) THEN
				altpcie_rs_serdes_ld_ws_tmr_short_231q <= wire_altpcie_rs_serdes_selector8_199_o;
				altpcie_rs_serdes_pll_locked_cnt_0_252q <= wire_altpcie_rs_serdes_pll_locked_cnt_97m_dataout;
				altpcie_rs_serdes_pll_locked_cnt_1_251q <= wire_altpcie_rs_serdes_pll_locked_cnt_96m_dataout;
				altpcie_rs_serdes_pll_locked_cnt_2_250q <= wire_altpcie_rs_serdes_pll_locked_cnt_95m_dataout;
				altpcie_rs_serdes_pll_locked_cnt_3_249q <= wire_altpcie_rs_serdes_pll_locked_cnt_94m_dataout;
				altpcie_rs_serdes_pll_locked_cnt_4_248q <= wire_altpcie_rs_serdes_pll_locked_cnt_93m_dataout;
				altpcie_rs_serdes_pll_locked_cnt_5_247q <= wire_altpcie_rs_serdes_pll_locked_cnt_92m_dataout;
				altpcie_rs_serdes_pll_locked_cnt_6_246q <= wire_altpcie_rs_serdes_pll_locked_cnt_91m_dataout;
				altpcie_rs_serdes_pll_locked_r_0_18q <= pll_locked;
				altpcie_rs_serdes_pll_locked_r_1_17q <= altpcie_rs_serdes_pll_locked_r_0_18q;
				altpcie_rs_serdes_pll_locked_r_2_16q <= altpcie_rs_serdes_pll_locked_r_1_17q;
				altpcie_rs_serdes_pll_locked_stable_255q <= s_wire_altpcie_rs_serdes_pll_locked_stable_625_dataout;
				altpcie_rs_serdes_rx_pll_freq_locked_cnt_0_234q <= wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_365m_dataout;
				altpcie_rs_serdes_rx_pll_freq_locked_cnt_1_233q <= wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_367m_dataout;
				altpcie_rs_serdes_rx_pll_freq_locked_cnt_2_232q <= wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_370m_dataout;
				altpcie_rs_serdes_rx_pll_freq_locked_r_0_21q <= s_wire_altpcie_rs_serdes_wideand0_14_dataout;
				altpcie_rs_serdes_rx_pll_freq_locked_r_1_20q <= altpcie_rs_serdes_rx_pll_freq_locked_r_0_21q;
				altpcie_rs_serdes_rx_pll_freq_locked_r_2_19q <= altpcie_rs_serdes_rx_pll_freq_locked_r_1_20q;
				altpcie_rs_serdes_rx_pll_freq_locked_sync_r_235q <= wire_w294w(0);
				altpcie_rs_serdes_rx_pll_locked_r_0_22q <= rx_pll_locked(0);
				altpcie_rs_serdes_rx_pll_locked_r_1_28q <= rx_pll_locked(1);
				altpcie_rs_serdes_rx_pll_locked_r_2_34q <= rx_pll_locked(2);
				altpcie_rs_serdes_rx_pll_locked_r_3_40q <= rx_pll_locked(3);
				altpcie_rs_serdes_rx_pll_locked_r_4_46q <= rx_pll_locked(4);
				altpcie_rs_serdes_rx_pll_locked_r_5_52q <= rx_pll_locked(5);
				altpcie_rs_serdes_rx_pll_locked_r_6_58q <= rx_pll_locked(6);
				altpcie_rs_serdes_rx_pll_locked_r_7_64q <= rx_pll_locked(7);
				altpcie_rs_serdes_rx_pll_locked_rr_0_23q <= altpcie_rs_serdes_rx_pll_locked_r_0_22q;
				altpcie_rs_serdes_rx_pll_locked_rr_1_29q <= altpcie_rs_serdes_rx_pll_locked_r_1_28q;
				altpcie_rs_serdes_rx_pll_locked_rr_2_35q <= altpcie_rs_serdes_rx_pll_locked_r_2_34q;
				altpcie_rs_serdes_rx_pll_locked_rr_3_41q <= altpcie_rs_serdes_rx_pll_locked_r_3_40q;
				altpcie_rs_serdes_rx_pll_locked_rr_4_47q <= altpcie_rs_serdes_rx_pll_locked_r_4_46q;
				altpcie_rs_serdes_rx_pll_locked_rr_5_53q <= altpcie_rs_serdes_rx_pll_locked_r_5_52q;
				altpcie_rs_serdes_rx_pll_locked_rr_6_59q <= altpcie_rs_serdes_rx_pll_locked_r_6_58q;
				altpcie_rs_serdes_rx_pll_locked_rr_7_65q <= altpcie_rs_serdes_rx_pll_locked_r_7_64q;
				altpcie_rs_serdes_rx_pll_locked_rrr_0_24q <= altpcie_rs_serdes_rx_pll_locked_rr_0_23q;
				altpcie_rs_serdes_rx_pll_locked_rrr_1_30q <= altpcie_rs_serdes_rx_pll_locked_rr_1_29q;
				altpcie_rs_serdes_rx_pll_locked_rrr_2_36q <= altpcie_rs_serdes_rx_pll_locked_rr_2_35q;
				altpcie_rs_serdes_rx_pll_locked_rrr_3_42q <= altpcie_rs_serdes_rx_pll_locked_rr_3_41q;
				altpcie_rs_serdes_rx_pll_locked_rrr_4_48q <= altpcie_rs_serdes_rx_pll_locked_rr_4_47q;
				altpcie_rs_serdes_rx_pll_locked_rrr_5_54q <= altpcie_rs_serdes_rx_pll_locked_rr_5_53q;
				altpcie_rs_serdes_rx_pll_locked_rrr_6_60q <= altpcie_rs_serdes_rx_pll_locked_rr_6_59q;
				altpcie_rs_serdes_rx_pll_locked_rrr_7_66q <= altpcie_rs_serdes_rx_pll_locked_rr_7_65q;
				altpcie_rs_serdes_rx_sd_idl_cnt_0_524q <= wire_altpcie_rs_serdes_mux19_501_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_10_514q <= wire_altpcie_rs_serdes_mux9_491_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_11_513q <= wire_altpcie_rs_serdes_mux8_490_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_12_512q <= wire_altpcie_rs_serdes_mux7_489_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_13_511q <= wire_altpcie_rs_serdes_mux6_488_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_14_510q <= wire_altpcie_rs_serdes_mux5_487_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_15_509q <= wire_altpcie_rs_serdes_mux4_486_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_16_508q <= wire_altpcie_rs_serdes_mux3_485_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_17_507q <= wire_altpcie_rs_serdes_mux2_484_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_18_506q <= wire_altpcie_rs_serdes_mux1_483_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_19_505q <= wire_altpcie_rs_serdes_mux0_482_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_1_523q <= wire_altpcie_rs_serdes_mux18_500_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_2_522q <= wire_altpcie_rs_serdes_mux17_499_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_3_521q <= wire_altpcie_rs_serdes_mux16_498_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_4_520q <= wire_altpcie_rs_serdes_mux15_497_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_5_519q <= wire_altpcie_rs_serdes_mux14_496_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_6_518q <= wire_altpcie_rs_serdes_mux13_495_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_7_517q <= wire_altpcie_rs_serdes_mux12_494_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_8_516q <= wire_altpcie_rs_serdes_mux11_493_o;
				altpcie_rs_serdes_rx_sd_idl_cnt_9_515q <= wire_altpcie_rs_serdes_mux10_492_o;
				altpcie_rs_serdes_rx_sd_strb0_0_263q <= altpcie_rs_serdes_rx_signaldetect_rrr_0_27q;
				altpcie_rs_serdes_rx_sd_strb0_1_262q <= altpcie_rs_serdes_rx_signaldetect_rrr_1_33q;
				altpcie_rs_serdes_rx_sd_strb0_2_261q <= altpcie_rs_serdes_rx_signaldetect_rrr_2_39q;
				altpcie_rs_serdes_rx_sd_strb0_3_260q <= altpcie_rs_serdes_rx_signaldetect_rrr_3_45q;
				altpcie_rs_serdes_rx_sd_strb0_4_259q <= altpcie_rs_serdes_rx_signaldetect_rrr_4_51q;
				altpcie_rs_serdes_rx_sd_strb0_5_258q <= altpcie_rs_serdes_rx_signaldetect_rrr_5_57q;
				altpcie_rs_serdes_rx_sd_strb0_6_257q <= altpcie_rs_serdes_rx_signaldetect_rrr_6_63q;
				altpcie_rs_serdes_rx_sd_strb0_7_256q <= altpcie_rs_serdes_rx_signaldetect_rrr_7_200q;
				altpcie_rs_serdes_rx_sd_strb1_0_504q <= altpcie_rs_serdes_rx_sd_strb0_0_263q;
				altpcie_rs_serdes_rx_sd_strb1_1_270q <= altpcie_rs_serdes_rx_sd_strb0_1_262q;
				altpcie_rs_serdes_rx_sd_strb1_2_269q <= altpcie_rs_serdes_rx_sd_strb0_2_261q;
				altpcie_rs_serdes_rx_sd_strb1_3_268q <= altpcie_rs_serdes_rx_sd_strb0_3_260q;
				altpcie_rs_serdes_rx_sd_strb1_4_267q <= altpcie_rs_serdes_rx_sd_strb0_4_259q;
				altpcie_rs_serdes_rx_sd_strb1_5_266q <= altpcie_rs_serdes_rx_sd_strb0_5_258q;
				altpcie_rs_serdes_rx_sd_strb1_6_265q <= altpcie_rs_serdes_rx_sd_strb0_6_257q;
				altpcie_rs_serdes_rx_sd_strb1_7_264q <= altpcie_rs_serdes_rx_sd_strb0_7_256q;
				altpcie_rs_serdes_rx_signaldetect_r_0_25q <= rx_signaldetect(0);
				altpcie_rs_serdes_rx_signaldetect_r_1_31q <= rx_signaldetect(1);
				altpcie_rs_serdes_rx_signaldetect_r_2_37q <= rx_signaldetect(2);
				altpcie_rs_serdes_rx_signaldetect_r_3_43q <= rx_signaldetect(3);
				altpcie_rs_serdes_rx_signaldetect_r_4_49q <= rx_signaldetect(4);
				altpcie_rs_serdes_rx_signaldetect_r_5_55q <= rx_signaldetect(5);
				altpcie_rs_serdes_rx_signaldetect_r_6_61q <= rx_signaldetect(6);
				altpcie_rs_serdes_rx_signaldetect_r_7_67q <= rx_signaldetect(7);
				altpcie_rs_serdes_rx_signaldetect_rr_0_26q <= altpcie_rs_serdes_rx_signaldetect_r_0_25q;
				altpcie_rs_serdes_rx_signaldetect_rr_1_32q <= altpcie_rs_serdes_rx_signaldetect_r_1_31q;
				altpcie_rs_serdes_rx_signaldetect_rr_2_38q <= altpcie_rs_serdes_rx_signaldetect_r_2_37q;
				altpcie_rs_serdes_rx_signaldetect_rr_3_44q <= altpcie_rs_serdes_rx_signaldetect_r_3_43q;
				altpcie_rs_serdes_rx_signaldetect_rr_4_50q <= altpcie_rs_serdes_rx_signaldetect_r_4_49q;
				altpcie_rs_serdes_rx_signaldetect_rr_5_56q <= altpcie_rs_serdes_rx_signaldetect_r_5_55q;
				altpcie_rs_serdes_rx_signaldetect_rr_6_62q <= altpcie_rs_serdes_rx_signaldetect_r_6_61q;
				altpcie_rs_serdes_rx_signaldetect_rr_7_68q <= altpcie_rs_serdes_rx_signaldetect_r_7_67q;
				altpcie_rs_serdes_rx_signaldetect_rrr_0_27q <= altpcie_rs_serdes_rx_signaldetect_rr_0_26q;
				altpcie_rs_serdes_rx_signaldetect_rrr_1_33q <= altpcie_rs_serdes_rx_signaldetect_rr_1_32q;
				altpcie_rs_serdes_rx_signaldetect_rrr_2_39q <= altpcie_rs_serdes_rx_signaldetect_rr_2_38q;
				altpcie_rs_serdes_rx_signaldetect_rrr_3_45q <= altpcie_rs_serdes_rx_signaldetect_rr_3_44q;
				altpcie_rs_serdes_rx_signaldetect_rrr_4_51q <= altpcie_rs_serdes_rx_signaldetect_rr_4_50q;
				altpcie_rs_serdes_rx_signaldetect_rrr_5_57q <= altpcie_rs_serdes_rx_signaldetect_rr_5_56q;
				altpcie_rs_serdes_rx_signaldetect_rrr_6_63q <= altpcie_rs_serdes_rx_signaldetect_rr_6_62q;
				altpcie_rs_serdes_rx_signaldetect_rrr_7_200q <= altpcie_rs_serdes_rx_signaldetect_rr_7_68q;
				altpcie_rs_serdes_sd_state_0_201q <= wire_altpcie_rs_serdes_mux21_503_o;
				altpcie_rs_serdes_sd_state_1_525q <= wire_altpcie_rs_serdes_mux20_502_o;
				altpcie_rs_serdes_serdes_rst_state_idle_st_cnt_225q <= wire_altpcie_rs_serdes_selector0_188_o;
				altpcie_rs_serdes_serdes_rst_state_stable_tx_pll_st_cnt_227q <= wire_altpcie_rs_serdes_selector2_190_o;
				altpcie_rs_serdes_serdes_rst_state_wait_state_st_cnt_228q <= wire_altpcie_rs_serdes_selector3_192_o;
				altpcie_rs_serdes_ws_tmr_eq_0_229q <= wire_altpcie_rs_serdes_ws_tmr_eq_0_168m_dataout;
		END IF;
	END PROCESS;
	wire_nl_w_lg_w987w988w(0) <= wire_nl_w987w(0) AND altpcie_rs_serdes_rx_sd_idl_cnt_4_520q;
	wire_nl_w987w(0) <= wire_nl_w_lg_w_lg_w_lg_w_lg_w_lg_w978w980w982w983w984w986w(0) AND altpcie_rs_serdes_rx_sd_idl_cnt_5_519q;
	wire_nl_w_lg_w_lg_w_lg_w_lg_w_lg_w978w980w982w983w984w986w(0) <= wire_nl_w_lg_w_lg_w_lg_w_lg_w978w980w982w983w984w(0) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_6_518q985w(0);
	wire_nl_w_lg_w_lg_w_lg_w_lg_w978w980w982w983w984w(0) <= wire_nl_w_lg_w_lg_w_lg_w978w980w982w983w(0) AND altpcie_rs_serdes_rx_sd_idl_cnt_7_517q;
	wire_nl_w_lg_w_lg_w_lg_w978w980w982w983w(0) <= wire_nl_w_lg_w_lg_w978w980w982w(0) AND altpcie_rs_serdes_rx_sd_idl_cnt_8_516q;
	wire_nl_w_lg_w_lg_w978w980w982w(0) <= wire_nl_w_lg_w978w980w(0) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_9_515q981w(0);
	wire_nl_w_lg_w978w980w(0) <= wire_nl_w978w(0) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_10_514q979w(0);
	wire_nl_w978w(0) <= wire_nl_w_lg_w_lg_w_lg_w_lg_w_lg_w970w971w973w974w975w976w(0) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_11_513q977w(0);
	wire_nl_w_lg_w_lg_w_lg_w_lg_w_lg_w970w971w973w974w975w976w(0) <= wire_nl_w_lg_w_lg_w_lg_w_lg_w970w971w973w974w975w(0) AND altpcie_rs_serdes_rx_sd_idl_cnt_12_512q;
	wire_nl_w_lg_w_lg_w_lg_w_lg_w970w971w973w974w975w(0) <= wire_nl_w_lg_w_lg_w_lg_w970w971w973w974w(0) AND altpcie_rs_serdes_rx_sd_idl_cnt_13_511q;
	wire_nl_w_lg_w_lg_w_lg_w970w971w973w974w(0) <= wire_nl_w_lg_w_lg_w970w971w973w(0) AND altpcie_rs_serdes_rx_sd_idl_cnt_14_510q;
	wire_nl_w_lg_w_lg_w970w971w973w(0) <= wire_nl_w_lg_w970w971w(0) AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_15_509q972w(0);
	wire_nl_w_lg_w970w971w(0) <= wire_nl_w970w(0) AND altpcie_rs_serdes_rx_sd_idl_cnt_16_508q;
	wire_nl_w970w(0) <= wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_19_505q969w(0) AND altpcie_rs_serdes_rx_sd_idl_cnt_17_507q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_19_505q969w(0) <= altpcie_rs_serdes_rx_sd_idl_cnt_19_505q AND wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_18_506q968w(0);
	wire_nl_w_lg_altpcie_rs_serdes_ld_ws_tmr_short_231q205w(0) <= NOT altpcie_rs_serdes_ld_ws_tmr_short_231q;
	wire_nl_w_lg_altpcie_rs_serdes_pll_locked_r_2_16q109w(0) <= NOT altpcie_rs_serdes_pll_locked_r_2_16q;
	wire_nl_w865w(0) <= NOT altpcie_rs_serdes_rx_pll_freq_locked_cnt_0_234q;
	wire_nl_w863w(0) <= NOT altpcie_rs_serdes_rx_pll_freq_locked_cnt_1_233q;
	wire_nl_w862w(0) <= NOT altpcie_rs_serdes_rx_pll_freq_locked_cnt_2_232q;
	wire_nl_w225w(0) <= NOT altpcie_rs_serdes_rx_pll_freq_locked_sync_r_235q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_0_524q995w(0) <= NOT altpcie_rs_serdes_rx_sd_idl_cnt_0_524q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_10_514q979w(0) <= NOT altpcie_rs_serdes_rx_sd_idl_cnt_10_514q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_11_513q977w(0) <= NOT altpcie_rs_serdes_rx_sd_idl_cnt_11_513q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_15_509q972w(0) <= NOT altpcie_rs_serdes_rx_sd_idl_cnt_15_509q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_18_506q968w(0) <= NOT altpcie_rs_serdes_rx_sd_idl_cnt_18_506q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_1_523q993w(0) <= NOT altpcie_rs_serdes_rx_sd_idl_cnt_1_523q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_2_522q991w(0) <= NOT altpcie_rs_serdes_rx_sd_idl_cnt_2_522q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_3_521q989w(0) <= NOT altpcie_rs_serdes_rx_sd_idl_cnt_3_521q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_6_518q985w(0) <= NOT altpcie_rs_serdes_rx_sd_idl_cnt_6_518q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_idl_cnt_9_515q981w(0) <= NOT altpcie_rs_serdes_rx_sd_idl_cnt_9_515q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_0_504q948w(0) <= NOT altpcie_rs_serdes_rx_sd_strb1_0_504q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_1_270q946w(0) <= NOT altpcie_rs_serdes_rx_sd_strb1_1_270q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_2_269q944w(0) <= NOT altpcie_rs_serdes_rx_sd_strb1_2_269q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_3_268q942w(0) <= NOT altpcie_rs_serdes_rx_sd_strb1_3_268q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_4_267q940w(0) <= NOT altpcie_rs_serdes_rx_sd_strb1_4_267q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_5_266q938w(0) <= NOT altpcie_rs_serdes_rx_sd_strb1_5_266q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_6_265q936w(0) <= NOT altpcie_rs_serdes_rx_sd_strb1_6_265q;
	wire_nl_w_lg_altpcie_rs_serdes_rx_sd_strb1_7_264q935w(0) <= NOT altpcie_rs_serdes_rx_sd_strb1_7_264q;
	PROCESS (pld_clk, altpcie_rs_serdes_arst_r_2_4q)
	BEGIN
		IF (altpcie_rs_serdes_arst_r_2_4q = '1') THEN
				altpcie_rs_serdes_rx_pll_locked_sync_r_0_243q <= '0';
				altpcie_rs_serdes_rx_pll_locked_sync_r_1_242q <= '0';
				altpcie_rs_serdes_rx_pll_locked_sync_r_2_241q <= '0';
				altpcie_rs_serdes_rx_pll_locked_sync_r_3_240q <= '0';
				altpcie_rs_serdes_rx_pll_locked_sync_r_4_239q <= '0';
				altpcie_rs_serdes_rx_pll_locked_sync_r_5_238q <= '0';
				altpcie_rs_serdes_rx_pll_locked_sync_r_6_237q <= '0';
				altpcie_rs_serdes_rx_pll_locked_sync_r_7_236q <= '0';
		ELSIF (pld_clk = '1' AND pld_clk'event) THEN
			IF (s_wire_altpcie_rs_serdes_rx_pll_locked_sync_r_7_613_dataout = '1') THEN
				altpcie_rs_serdes_rx_pll_locked_sync_r_0_243q <= s_wire_vcc;
				altpcie_rs_serdes_rx_pll_locked_sync_r_1_242q <= s_wire_vcc;
				altpcie_rs_serdes_rx_pll_locked_sync_r_2_241q <= s_wire_vcc;
				altpcie_rs_serdes_rx_pll_locked_sync_r_3_240q <= s_wire_vcc;
				altpcie_rs_serdes_rx_pll_locked_sync_r_4_239q <= s_wire_vcc;
				altpcie_rs_serdes_rx_pll_locked_sync_r_5_238q <= s_wire_vcc;
				altpcie_rs_serdes_rx_pll_locked_sync_r_6_237q <= s_wire_vcc;
				altpcie_rs_serdes_rx_pll_locked_sync_r_7_236q <= s_wire_vcc;
			END IF;
		END IF;
	END PROCESS;
	wire_nlO_w2w(0) <= altpcie_rs_serdes_rx_pll_locked_sync_r_0_243q OR wire_w_rx_freqlocked_range1w(0);
	wire_nlO_w4w(0) <= altpcie_rs_serdes_rx_pll_locked_sync_r_1_242q OR wire_w_rx_freqlocked_range3w(0);
	wire_nlO_w7w(0) <= altpcie_rs_serdes_rx_pll_locked_sync_r_2_241q OR wire_w_rx_freqlocked_range6w(0);
	wire_nlO_w10w(0) <= altpcie_rs_serdes_rx_pll_locked_sync_r_3_240q OR wire_w_rx_freqlocked_range9w(0);
	wire_nlO_w13w(0) <= altpcie_rs_serdes_rx_pll_locked_sync_r_4_239q OR wire_w_rx_freqlocked_range12w(0);
	wire_nlO_w16w(0) <= altpcie_rs_serdes_rx_pll_locked_sync_r_5_238q OR wire_w_rx_freqlocked_range15w(0);
	wire_nlO_w19w(0) <= altpcie_rs_serdes_rx_pll_locked_sync_r_6_237q OR wire_w_rx_freqlocked_range18w(0);
	wire_nlO_w22w(0) <= altpcie_rs_serdes_rx_pll_locked_sync_r_7_236q OR wire_w_rx_freqlocked_range21w(0);
	PROCESS (pld_clk, npor)
	BEGIN
		IF (npor = '0') THEN
				altpcie_rs_serdes_arst_r_0_15q <= '1';
				altpcie_rs_serdes_arst_r_1_5q <= '1';
				altpcie_rs_serdes_arst_r_2_4q <= '1';
		ELSIF (pld_clk = '1' AND pld_clk'event) THEN
				altpcie_rs_serdes_arst_r_0_15q <= s_wire_gnd;
				altpcie_rs_serdes_arst_r_1_5q <= altpcie_rs_serdes_arst_r_0_15q;
				altpcie_rs_serdes_arst_r_2_4q <= altpcie_rs_serdes_arst_r_1_5q;
		END IF;
		if (now = 0 ns) then
			altpcie_rs_serdes_arst_r_0_15q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_arst_r_1_5q <= '1' after 1 ps;
		end if;
		if (now = 0 ns) then
			altpcie_rs_serdes_arst_r_2_4q <= '1' after 1 ps;
		end if;
	END PROCESS;
	wire_nO_w_lg_altpcie_rs_serdes_arst_r_2_4q24w(0) <= NOT altpcie_rs_serdes_arst_r_2_4q;
	wire_altpcie_rs_serdes_ld_ws_tmr_172m_dataout <= altpcie_rs_serdes_ld_ws_tmr_230q OR NOT(altpcie_rs_serdes_rx_pll_freq_locked_sync_r_235q);
	wire_altpcie_rs_serdes_ld_ws_tmr_short_179m_dataout <= altpcie_rs_serdes_ld_ws_tmr_short_231q OR altpcie_rs_serdes_rx_pll_freq_locked_sync_r_235q;
	wire_altpcie_rs_serdes_ld_ws_tmr_short_183m_dataout <= altpcie_rs_serdes_ld_ws_tmr_short_231q AND NOT(altpcie_rs_serdes_rx_pll_freq_locked_sync_r_235q);
	wire_altpcie_rs_serdes_pll_locked_cnt_84m_dataout <= wire_altpcie_rs_serdes_add1_83_o(6) WHEN wire_altpcie_rs_serdes_lessthan0_82_o = '1'  ELSE altpcie_rs_serdes_pll_locked_cnt_6_246q;
	wire_altpcie_rs_serdes_pll_locked_cnt_85m_dataout <= wire_altpcie_rs_serdes_add1_83_o(5) WHEN wire_altpcie_rs_serdes_lessthan0_82_o = '1'  ELSE altpcie_rs_serdes_pll_locked_cnt_5_247q;
	wire_altpcie_rs_serdes_pll_locked_cnt_86m_dataout <= wire_altpcie_rs_serdes_add1_83_o(4) WHEN wire_altpcie_rs_serdes_lessthan0_82_o = '1'  ELSE altpcie_rs_serdes_pll_locked_cnt_4_248q;
	wire_altpcie_rs_serdes_pll_locked_cnt_87m_dataout <= wire_altpcie_rs_serdes_add1_83_o(3) WHEN wire_altpcie_rs_serdes_lessthan0_82_o = '1'  ELSE altpcie_rs_serdes_pll_locked_cnt_3_249q;
	wire_altpcie_rs_serdes_pll_locked_cnt_88m_dataout <= wire_altpcie_rs_serdes_add1_83_o(2) WHEN wire_altpcie_rs_serdes_lessthan0_82_o = '1'  ELSE altpcie_rs_serdes_pll_locked_cnt_2_250q;
	wire_altpcie_rs_serdes_pll_locked_cnt_89m_dataout <= wire_altpcie_rs_serdes_add1_83_o(1) WHEN wire_altpcie_rs_serdes_lessthan0_82_o = '1'  ELSE altpcie_rs_serdes_pll_locked_cnt_1_251q;
	wire_altpcie_rs_serdes_pll_locked_cnt_90m_dataout <= wire_altpcie_rs_serdes_add1_83_o(0) WHEN wire_altpcie_rs_serdes_lessthan0_82_o = '1'  ELSE altpcie_rs_serdes_pll_locked_cnt_0_252q;
	wire_altpcie_rs_serdes_pll_locked_cnt_91m_dataout <= wire_altpcie_rs_serdes_pll_locked_cnt_84m_dataout AND NOT(wire_nl_w_lg_altpcie_rs_serdes_pll_locked_r_2_16q109w(0));
	wire_altpcie_rs_serdes_pll_locked_cnt_92m_dataout <= wire_altpcie_rs_serdes_pll_locked_cnt_85m_dataout AND NOT(wire_nl_w_lg_altpcie_rs_serdes_pll_locked_r_2_16q109w(0));
	wire_altpcie_rs_serdes_pll_locked_cnt_93m_dataout <= wire_altpcie_rs_serdes_pll_locked_cnt_86m_dataout AND NOT(wire_nl_w_lg_altpcie_rs_serdes_pll_locked_r_2_16q109w(0));
	wire_altpcie_rs_serdes_pll_locked_cnt_94m_dataout <= wire_altpcie_rs_serdes_pll_locked_cnt_87m_dataout AND NOT(wire_nl_w_lg_altpcie_rs_serdes_pll_locked_r_2_16q109w(0));
	wire_altpcie_rs_serdes_pll_locked_cnt_95m_dataout <= wire_altpcie_rs_serdes_pll_locked_cnt_88m_dataout AND NOT(wire_nl_w_lg_altpcie_rs_serdes_pll_locked_r_2_16q109w(0));
	wire_altpcie_rs_serdes_pll_locked_cnt_96m_dataout <= wire_altpcie_rs_serdes_pll_locked_cnt_89m_dataout AND NOT(wire_nl_w_lg_altpcie_rs_serdes_pll_locked_r_2_16q109w(0));
	wire_altpcie_rs_serdes_pll_locked_cnt_97m_dataout <= wire_altpcie_rs_serdes_pll_locked_cnt_90m_dataout AND NOT(wire_nl_w_lg_altpcie_rs_serdes_pll_locked_r_2_16q109w(0));
	wire_altpcie_rs_serdes_rst_rxpcs_sd_254m_dataout <= altpcie_rs_serdes_sd_state_0_201q AND NOT((test_in(32) OR use_c4gx_serdes));
	wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_365m_dataout <= wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_366m_dataout OR altpcie_rs_serdes_rx_pll_freq_locked_r_2_19q;
	wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_366m_dataout <= wire_altpcie_rs_serdes_add0_79_o(1) AND NOT(s_wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_0_617_dataout);
	wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_367m_dataout <= wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_368m_dataout OR altpcie_rs_serdes_rx_pll_freq_locked_r_2_19q;
	wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_368m_dataout <= wire_altpcie_rs_serdes_add0_79_o(2) AND NOT(s_wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_0_617_dataout);
	wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_370m_dataout <= wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_481m_dataout OR altpcie_rs_serdes_rx_pll_freq_locked_r_2_19q;
	wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_481m_dataout <= wire_altpcie_rs_serdes_add0_79_o(3) AND NOT(s_wire_altpcie_rs_serdes_rx_pll_freq_locked_cnt_0_617_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_278m_dataout <= wire_altpcie_rs_serdes_add3_277_o(19) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_279m_dataout <= wire_altpcie_rs_serdes_add3_277_o(18) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_280m_dataout <= wire_altpcie_rs_serdes_add3_277_o(17) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_281m_dataout <= wire_altpcie_rs_serdes_add3_277_o(16) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_282m_dataout <= wire_altpcie_rs_serdes_add3_277_o(15) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_283m_dataout <= wire_altpcie_rs_serdes_add3_277_o(14) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_284m_dataout <= wire_altpcie_rs_serdes_add3_277_o(13) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_285m_dataout <= wire_altpcie_rs_serdes_add3_277_o(12) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_286m_dataout <= wire_altpcie_rs_serdes_add3_277_o(11) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_287m_dataout <= wire_altpcie_rs_serdes_add3_277_o(10) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_288m_dataout <= wire_altpcie_rs_serdes_add3_277_o(9) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_289m_dataout <= wire_altpcie_rs_serdes_add3_277_o(8) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_290m_dataout <= wire_altpcie_rs_serdes_add3_277_o(7) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_291m_dataout <= wire_altpcie_rs_serdes_add3_277_o(6) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_292m_dataout <= wire_altpcie_rs_serdes_add3_277_o(5) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_293m_dataout <= wire_altpcie_rs_serdes_add3_277_o(4) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_294m_dataout <= wire_altpcie_rs_serdes_add3_277_o(3) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_295m_dataout <= wire_altpcie_rs_serdes_add3_277_o(2) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_296m_dataout <= wire_altpcie_rs_serdes_add3_277_o(1) AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_297m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_0_524q AND wire_altpcie_rs_serdes_lessthan1_276_o;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_300m_dataout <= wire_altpcie_rs_serdes_add4_371_o(19) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_19_505q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_301m_dataout <= wire_altpcie_rs_serdes_add4_371_o(18) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_18_506q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_302m_dataout <= wire_altpcie_rs_serdes_add4_371_o(17) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_17_507q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_303m_dataout <= wire_altpcie_rs_serdes_add4_371_o(16) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_16_508q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_304m_dataout <= wire_altpcie_rs_serdes_add4_371_o(15) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_15_509q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_305m_dataout <= wire_altpcie_rs_serdes_add4_371_o(14) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_14_510q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_306m_dataout <= wire_altpcie_rs_serdes_add4_371_o(13) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_13_511q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_307m_dataout <= wire_altpcie_rs_serdes_add4_371_o(12) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_12_512q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_308m_dataout <= wire_altpcie_rs_serdes_add4_371_o(11) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_11_513q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_309m_dataout <= wire_altpcie_rs_serdes_add4_371_o(10) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_10_514q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_310m_dataout <= wire_altpcie_rs_serdes_add4_371_o(9) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_9_515q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_311m_dataout <= wire_altpcie_rs_serdes_add4_371_o(8) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_8_516q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_312m_dataout <= wire_altpcie_rs_serdes_add4_371_o(7) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_7_517q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_313m_dataout <= wire_altpcie_rs_serdes_add4_371_o(6) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_6_518q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_314m_dataout <= wire_altpcie_rs_serdes_add4_371_o(5) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_5_519q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_315m_dataout <= wire_altpcie_rs_serdes_add4_371_o(4) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_4_520q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_316m_dataout <= wire_altpcie_rs_serdes_add4_371_o(3) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_3_521q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_317m_dataout <= wire_altpcie_rs_serdes_add4_371_o(2) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_2_522q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_318m_dataout <= wire_altpcie_rs_serdes_add4_371_o(1) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_1_523q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_319m_dataout <= wire_altpcie_rs_serdes_add4_371_o(0) WHEN s_wire_altpcie_rs_serdes_always12_299_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_0_524q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_320m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_300m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_321m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_301m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_322m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_302m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_323m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_303m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_324m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_304m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_325m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_305m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_326m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_306m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_327m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_307m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_328m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_308m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_329m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_309m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_330m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_310m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_331m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_311m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_332m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_312m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_333m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_313m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_334m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_314m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_335m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_315m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_336m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_316m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_337m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_317m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_338m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_318m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_339m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_319m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_340m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_278m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_320m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_341m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_279m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_321m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_342m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_280m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_322m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_343m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_281m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_323m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_344m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_282m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_324m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_345m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_283m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_325m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_346m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_284m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_326m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_347m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_285m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_327m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_348m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_286m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_328m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_349m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_287m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_329m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_350m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_288m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_330m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_351m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_289m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_331m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_352m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_290m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_332m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_353m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_291m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_333m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_354m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_292m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_334m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_355m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_293m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_335m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_356m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_294m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_336m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_357m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_295m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_337m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_358m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_296m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_338m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_359m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_297m_dataout WHEN s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout = '1'  ELSE wire_altpcie_rs_serdes_rx_sd_idl_cnt_339m_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_372m_dataout <= wire_altpcie_rs_serdes_add4_371_o(19) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_19_505q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_373m_dataout <= wire_altpcie_rs_serdes_add4_371_o(18) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_18_506q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_374m_dataout <= wire_altpcie_rs_serdes_add4_371_o(17) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_17_507q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_375m_dataout <= wire_altpcie_rs_serdes_add4_371_o(16) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_16_508q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_376m_dataout <= wire_altpcie_rs_serdes_add4_371_o(15) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_15_509q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_377m_dataout <= wire_altpcie_rs_serdes_add4_371_o(14) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_14_510q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_378m_dataout <= wire_altpcie_rs_serdes_add4_371_o(13) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_13_511q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_379m_dataout <= wire_altpcie_rs_serdes_add4_371_o(12) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_12_512q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_380m_dataout <= wire_altpcie_rs_serdes_add4_371_o(11) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_11_513q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_381m_dataout <= wire_altpcie_rs_serdes_add4_371_o(10) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_10_514q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_382m_dataout <= wire_altpcie_rs_serdes_add4_371_o(9) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_9_515q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_383m_dataout <= wire_altpcie_rs_serdes_add4_371_o(8) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_8_516q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_384m_dataout <= wire_altpcie_rs_serdes_add4_371_o(7) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_7_517q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_385m_dataout <= wire_altpcie_rs_serdes_add4_371_o(6) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_6_518q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_386m_dataout <= wire_altpcie_rs_serdes_add4_371_o(5) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_5_519q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_387m_dataout <= wire_altpcie_rs_serdes_add4_371_o(4) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_4_520q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_388m_dataout <= wire_altpcie_rs_serdes_add4_371_o(3) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_3_521q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_389m_dataout <= wire_altpcie_rs_serdes_add4_371_o(2) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_2_522q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_390m_dataout <= wire_altpcie_rs_serdes_add4_371_o(1) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_1_523q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_391m_dataout <= wire_altpcie_rs_serdes_add4_371_o(0) WHEN s_wire_altpcie_rs_serdes_stable_sd_274_dataout = '1'  ELSE altpcie_rs_serdes_rx_sd_idl_cnt_0_524q;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_392m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_372m_dataout OR s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_393m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_373m_dataout AND NOT(s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_394m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_374m_dataout OR s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_395m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_375m_dataout OR s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_396m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_376m_dataout AND NOT(s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_397m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_377m_dataout OR s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_398m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_378m_dataout OR s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_399m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_379m_dataout OR s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_400m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_380m_dataout AND NOT(s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_401m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_381m_dataout AND NOT(s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_402m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_382m_dataout AND NOT(s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_403m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_383m_dataout OR s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_404m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_384m_dataout OR s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_405m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_385m_dataout AND NOT(s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_406m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_386m_dataout OR s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_407m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_387m_dataout OR s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_408m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_388m_dataout AND NOT(s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_409m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_389m_dataout AND NOT(s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_410m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_390m_dataout AND NOT(s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_411m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_391m_dataout AND NOT(s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_414m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_392m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_415m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_393m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_416m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_394m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_417m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_395m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_418m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_396m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_419m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_397m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_420m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_398m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_421m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_399m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_422m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_400m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_423m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_401m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_424m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_402m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_425m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_403m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_426m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_404m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_427m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_405m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_428m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_406m_dataout OR s_wire_altpcie_rs_serdes_always12_364_dataout;
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_429m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_407m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_430m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_408m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_431m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_409m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_432m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_410m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_433m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_411m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_436m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_414m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_437m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_415m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_438m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_416m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_439m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_417m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_440m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_418m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_441m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_419m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_442m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_420m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_443m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_421m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_444m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_422m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_445m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_423m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_446m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_424m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_447m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_425m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_448m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_426m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_449m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_427m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_450m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_428m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_451m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_429m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_452m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_430m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_453m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_431m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_454m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_432m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_455m_dataout <= wire_altpcie_rs_serdes_rx_sd_idl_cnt_433m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_459m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_19_505q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_460m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_18_506q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_461m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_17_507q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_462m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_16_508q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_463m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_15_509q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_464m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_14_510q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_465m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_13_511q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_466m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_12_512q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_467m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_11_513q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_468m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_10_514q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_469m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_9_515q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_470m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_8_516q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_471m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_7_517q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_472m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_6_518q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_473m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_5_519q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_474m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_4_520q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_475m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_3_521q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_476m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_2_522q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_477m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_1_523q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rx_sd_idl_cnt_478m_dataout <= altpcie_rs_serdes_rx_sd_idl_cnt_0_524q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_rxanalogreset_1m_dataout <= altpcie_rs_serdes_arst_r_2_4q WHEN use_c4gx_serdes = '1'  ELSE altpcie_rs_serdes_rxanalogreset_r_203q;
	wire_altpcie_rs_serdes_rxanalogreset_r_178m_dataout <= altpcie_rs_serdes_busy_altgxb_reconfig_r_1_244q OR NOT(s_wire_altpcie_rs_serdes_always10_174_dataout);
	wire_altpcie_rs_serdes_rxdigitalreset_r_187m_dataout <= wire_w207w(0) OR NOT(altpcie_rs_serdes_rx_pll_freq_locked_sync_r_235q);
	wire_altpcie_rs_serdes_sd_state_360m_dataout <= altpcie_rs_serdes_sd_state_1_525q AND NOT(s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout);
	wire_altpcie_rs_serdes_sd_state_361m_dataout <= altpcie_rs_serdes_sd_state_0_201q OR s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_0_670_dataout;
	wire_altpcie_rs_serdes_sd_state_412m_dataout <= altpcie_rs_serdes_sd_state_1_525q OR s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout;
	wire_altpcie_rs_serdes_sd_state_413m_dataout <= altpcie_rs_serdes_sd_state_0_201q AND NOT(s_wire_altpcie_rs_serdes_rx_sd_idl_cnt_1_697_dataout);
	wire_altpcie_rs_serdes_sd_state_434m_dataout <= wire_altpcie_rs_serdes_sd_state_412m_dataout OR s_wire_altpcie_rs_serdes_always12_364_dataout;
	wire_altpcie_rs_serdes_sd_state_435m_dataout <= wire_altpcie_rs_serdes_sd_state_413m_dataout AND NOT(s_wire_altpcie_rs_serdes_always12_364_dataout);
	wire_altpcie_rs_serdes_sd_state_456m_dataout <= wire_altpcie_rs_serdes_sd_state_434m_dataout AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_sd_state_457m_dataout <= wire_w654w(0) WHEN wire_w526w(0) = '1'  ELSE wire_altpcie_rs_serdes_sd_state_435m_dataout;
	wire_altpcie_rs_serdes_sd_state_479m_dataout <= wire_w654w(0) WHEN wire_w526w(0) = '1'  ELSE altpcie_rs_serdes_sd_state_1_525q;
	wire_altpcie_rs_serdes_sd_state_480m_dataout <= altpcie_rs_serdes_sd_state_0_201q AND NOT(wire_w526w(0));
	wire_altpcie_rs_serdes_serdes_rst_state_170m_dataout <= wire_w_lg_fifo_err201w(0) AND altpcie_rs_serdes_rx_pll_freq_locked_sync_r_235q;
	wire_altpcie_rs_serdes_serdes_rst_state_171m_dataout <= fifo_err AND altpcie_rs_serdes_rx_pll_freq_locked_sync_r_235q;
	wire_altpcie_rs_serdes_serdes_rst_state_177m_dataout <= wire_ni_w204w(0) AND s_wire_altpcie_rs_serdes_always10_174_dataout;
	wire_altpcie_rs_serdes_serdes_rst_state_184m_dataout <= s_wire_altpcie_rs_serdes_always10_181_dataout AND altpcie_rs_serdes_rx_pll_freq_locked_sync_r_235q;
	wire_altpcie_rs_serdes_serdes_rst_state_186m_dataout <= wire_w207w(0) AND altpcie_rs_serdes_rx_pll_freq_locked_sync_r_235q;
	wire_altpcie_rs_serdes_waitstate_timer_101m_dataout <= wire_w_lg_rc_inclk_eq_125mhz110w(0) AND NOT(test_in(0));
	wire_altpcie_rs_serdes_waitstate_timer_102m_dataout <= rc_inclk_eq_125mhz AND NOT(test_in(0));
	wire_altpcie_rs_serdes_waitstate_timer_106m_dataout <= wire_altpcie_rs_serdes_add2_105_o(20) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_19_205q;
	wire_altpcie_rs_serdes_waitstate_timer_107m_dataout <= wire_altpcie_rs_serdes_add2_105_o(19) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_18_206q;
	wire_altpcie_rs_serdes_waitstate_timer_108m_dataout <= wire_altpcie_rs_serdes_add2_105_o(18) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_17_207q;
	wire_altpcie_rs_serdes_waitstate_timer_109m_dataout <= wire_altpcie_rs_serdes_add2_105_o(17) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_16_208q;
	wire_altpcie_rs_serdes_waitstate_timer_110m_dataout <= wire_altpcie_rs_serdes_add2_105_o(16) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_15_209q;
	wire_altpcie_rs_serdes_waitstate_timer_111m_dataout <= wire_altpcie_rs_serdes_add2_105_o(15) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_14_210q;
	wire_altpcie_rs_serdes_waitstate_timer_112m_dataout <= wire_altpcie_rs_serdes_add2_105_o(14) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_13_211q;
	wire_altpcie_rs_serdes_waitstate_timer_113m_dataout <= wire_altpcie_rs_serdes_add2_105_o(13) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_12_212q;
	wire_altpcie_rs_serdes_waitstate_timer_114m_dataout <= wire_altpcie_rs_serdes_add2_105_o(12) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_11_213q;
	wire_altpcie_rs_serdes_waitstate_timer_115m_dataout <= wire_altpcie_rs_serdes_add2_105_o(11) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_10_214q;
	wire_altpcie_rs_serdes_waitstate_timer_116m_dataout <= wire_altpcie_rs_serdes_add2_105_o(10) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_9_215q;
	wire_altpcie_rs_serdes_waitstate_timer_117m_dataout <= wire_altpcie_rs_serdes_add2_105_o(9) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_8_216q;
	wire_altpcie_rs_serdes_waitstate_timer_118m_dataout <= wire_altpcie_rs_serdes_add2_105_o(8) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_7_217q;
	wire_altpcie_rs_serdes_waitstate_timer_119m_dataout <= wire_altpcie_rs_serdes_add2_105_o(7) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_6_218q;
	wire_altpcie_rs_serdes_waitstate_timer_120m_dataout <= wire_altpcie_rs_serdes_add2_105_o(6) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_5_219q;
	wire_altpcie_rs_serdes_waitstate_timer_121m_dataout <= wire_altpcie_rs_serdes_add2_105_o(5) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_4_220q;
	wire_altpcie_rs_serdes_waitstate_timer_122m_dataout <= wire_altpcie_rs_serdes_add2_105_o(4) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_3_221q;
	wire_altpcie_rs_serdes_waitstate_timer_123m_dataout <= wire_altpcie_rs_serdes_add2_105_o(3) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_2_222q;
	wire_altpcie_rs_serdes_waitstate_timer_124m_dataout <= wire_altpcie_rs_serdes_add2_105_o(2) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_1_223q;
	wire_altpcie_rs_serdes_waitstate_timer_125m_dataout <= wire_altpcie_rs_serdes_add2_105_o(1) WHEN wire_w179w(0) = '1'  ELSE altpcie_rs_serdes_waitstate_timer_0_224q;
	wire_altpcie_rs_serdes_waitstate_timer_126m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_106m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_127m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_107m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_128m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_108m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_129m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_109m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_130m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_110m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_131m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_111m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_132m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_112m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_133m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_113m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_134m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_114m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_135m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_115m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_136m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_116m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_137m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_117m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_138m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_118m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_139m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_119m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_140m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_120m_dataout OR altpcie_rs_serdes_ld_ws_tmr_short_231q;
	wire_altpcie_rs_serdes_waitstate_timer_141m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_121m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_142m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_122m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_143m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_123m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_144m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_124m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_145m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_125m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_short_231q);
	wire_altpcie_rs_serdes_waitstate_timer_146m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_126m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_230q);
	wire_altpcie_rs_serdes_waitstate_timer_147m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_127m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_230q);
	wire_altpcie_rs_serdes_waitstate_timer_148m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_101m_dataout WHEN altpcie_rs_serdes_ld_ws_tmr_230q = '1'  ELSE wire_altpcie_rs_serdes_waitstate_timer_128m_dataout;
	wire_altpcie_rs_serdes_waitstate_timer_149m_dataout <= (NOT test_in(0)) WHEN altpcie_rs_serdes_ld_ws_tmr_230q = '1'  ELSE wire_altpcie_rs_serdes_waitstate_timer_129m_dataout;
	wire_altpcie_rs_serdes_waitstate_timer_150m_dataout <= (NOT test_in(0)) WHEN altpcie_rs_serdes_ld_ws_tmr_230q = '1'  ELSE wire_altpcie_rs_serdes_waitstate_timer_130m_dataout;
	wire_altpcie_rs_serdes_waitstate_timer_151m_dataout <= (NOT test_in(0)) WHEN altpcie_rs_serdes_ld_ws_tmr_230q = '1'  ELSE wire_altpcie_rs_serdes_waitstate_timer_131m_dataout;
	wire_altpcie_rs_serdes_waitstate_timer_152m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_102m_dataout WHEN altpcie_rs_serdes_ld_ws_tmr_230q = '1'  ELSE wire_altpcie_rs_serdes_waitstate_timer_132m_dataout;
	wire_altpcie_rs_serdes_waitstate_timer_153m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_101m_dataout WHEN altpcie_rs_serdes_ld_ws_tmr_230q = '1'  ELSE wire_altpcie_rs_serdes_waitstate_timer_133m_dataout;
	wire_altpcie_rs_serdes_waitstate_timer_154m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_102m_dataout WHEN altpcie_rs_serdes_ld_ws_tmr_230q = '1'  ELSE wire_altpcie_rs_serdes_waitstate_timer_134m_dataout;
	wire_altpcie_rs_serdes_waitstate_timer_155m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_135m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_230q);
	wire_altpcie_rs_serdes_waitstate_timer_156m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_136m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_230q);
	wire_altpcie_rs_serdes_waitstate_timer_157m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_137m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_230q);
	wire_altpcie_rs_serdes_waitstate_timer_158m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_101m_dataout WHEN altpcie_rs_serdes_ld_ws_tmr_230q = '1'  ELSE wire_altpcie_rs_serdes_waitstate_timer_138m_dataout;
	wire_altpcie_rs_serdes_waitstate_timer_159m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_102m_dataout WHEN altpcie_rs_serdes_ld_ws_tmr_230q = '1'  ELSE wire_altpcie_rs_serdes_waitstate_timer_139m_dataout;
	wire_altpcie_rs_serdes_waitstate_timer_160m_dataout <= test_in(0) WHEN altpcie_rs_serdes_ld_ws_tmr_230q = '1'  ELSE wire_altpcie_rs_serdes_waitstate_timer_140m_dataout;
	wire_altpcie_rs_serdes_waitstate_timer_161m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_101m_dataout WHEN altpcie_rs_serdes_ld_ws_tmr_230q = '1'  ELSE wire_altpcie_rs_serdes_waitstate_timer_141m_dataout;
	wire_altpcie_rs_serdes_waitstate_timer_162m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_102m_dataout WHEN altpcie_rs_serdes_ld_ws_tmr_230q = '1'  ELSE wire_altpcie_rs_serdes_waitstate_timer_142m_dataout;
	wire_altpcie_rs_serdes_waitstate_timer_163m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_143m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_230q);
	wire_altpcie_rs_serdes_waitstate_timer_164m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_144m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_230q);
	wire_altpcie_rs_serdes_waitstate_timer_165m_dataout <= wire_altpcie_rs_serdes_waitstate_timer_145m_dataout AND NOT(altpcie_rs_serdes_ld_ws_tmr_230q);
	wire_altpcie_rs_serdes_ws_tmr_eq_0_168m_dataout <= s_wire_altpcie_rs_serdes_ws_tmr_eq_0_0_646_dataout AND NOT((altpcie_rs_serdes_ld_ws_tmr_230q OR altpcie_rs_serdes_ld_ws_tmr_short_231q));
	wire_altpcie_rs_serdes_add0_79_a <= ( altpcie_rs_serdes_rx_pll_freq_locked_cnt_2_232q & altpcie_rs_serdes_rx_pll_freq_locked_cnt_1_233q & altpcie_rs_serdes_rx_pll_freq_locked_cnt_0_234q & "1");
	wire_altpcie_rs_serdes_add0_79_b <= ( "1" & "1" & "0" & "1");
	altpcie_rs_serdes_add0_79 :  oper_add
	  GENERIC MAP (
		sgate_representation => 0,
		width_a => 4,
		width_b => 4,
		width_o => 4
	  )
	  PORT MAP ( 
		a => wire_altpcie_rs_serdes_add0_79_a,
		b => wire_altpcie_rs_serdes_add0_79_b,
		cin => wire_gnd,
		o => wire_altpcie_rs_serdes_add0_79_o
	  );
	wire_altpcie_rs_serdes_add1_83_a <= ( altpcie_rs_serdes_pll_locked_cnt_6_246q & altpcie_rs_serdes_pll_locked_cnt_5_247q & altpcie_rs_serdes_pll_locked_cnt_4_248q & altpcie_rs_serdes_pll_locked_cnt_3_249q & altpcie_rs_serdes_pll_locked_cnt_2_250q & altpcie_rs_serdes_pll_locked_cnt_1_251q & altpcie_rs_serdes_pll_locked_cnt_0_252q);
	wire_altpcie_rs_serdes_add1_83_b <= ( "0" & "0" & "0" & "0" & "0" & "0" & "1");
	altpcie_rs_serdes_add1_83 :  oper_add
	  GENERIC MAP (
		sgate_representation => 0,
		width_a => 7,
		width_b => 7,
		width_o => 7
	  )
	  PORT MAP ( 
		a => wire_altpcie_rs_serdes_add1_83_a,
		b => wire_altpcie_rs_serdes_add1_83_b,
		cin => wire_gnd,
		o => wire_altpcie_rs_serdes_add1_83_o
	  );
	wire_altpcie_rs_serdes_add2_105_a <= ( altpcie_rs_serdes_waitstate_timer_19_205q & altpcie_rs_serdes_waitstate_timer_18_206q & altpcie_rs_serdes_waitstate_timer_17_207q & altpcie_rs_serdes_waitstate_timer_16_208q & altpcie_rs_serdes_waitstate_timer_15_209q & altpcie_rs_serdes_waitstate_timer_14_210q & altpcie_rs_serdes_waitstate_timer_13_211q & altpcie_rs_serdes_waitstate_timer_12_212q & altpcie_rs_serdes_waitstate_timer_11_213q & altpcie_rs_serdes_waitstate_timer_10_214q & altpcie_rs_serdes_waitstate_timer_9_215q & altpcie_rs_serdes_waitstate_timer_8_216q & altpcie_rs_serdes_waitstate_timer_7_217q & altpcie_rs_serdes_waitstate_timer_6_218q & altpcie_rs_serdes_waitstate_timer_5_219q & altpcie_rs_serdes_waitstate_timer_4_220q & altpcie_rs_serdes_waitstate_timer_3_221q & altpcie_rs_serdes_waitstate_timer_2_222q & altpcie_rs_serdes_waitstate_timer_1_223q & altpcie_rs_serdes_waitstate_timer_0_224q & "1");
	wire_altpcie_rs_serdes_add2_105_b <= ( "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "0" & "1");
	altpcie_rs_serdes_add2_105 :  oper_add
	  GENERIC MAP (
		sgate_representation => 0,
		width_a => 21,
		width_b => 21,
		width_o => 21
	  )
	  PORT MAP ( 
		a => wire_altpcie_rs_serdes_add2_105_a,
		b => wire_altpcie_rs_serdes_add2_105_b,
		cin => wire_gnd,
		o => wire_altpcie_rs_serdes_add2_105_o
	  );
	wire_altpcie_rs_serdes_add3_277_a <= ( altpcie_rs_serdes_rx_sd_idl_cnt_19_505q & altpcie_rs_serdes_rx_sd_idl_cnt_18_506q & altpcie_rs_serdes_rx_sd_idl_cnt_17_507q & altpcie_rs_serdes_rx_sd_idl_cnt_16_508q & altpcie_rs_serdes_rx_sd_idl_cnt_15_509q & altpcie_rs_serdes_rx_sd_idl_cnt_14_510q & altpcie_rs_serdes_rx_sd_idl_cnt_13_511q & altpcie_rs_serdes_rx_sd_idl_cnt_12_512q & altpcie_rs_serdes_rx_sd_idl_cnt_11_513q & altpcie_rs_serdes_rx_sd_idl_cnt_10_514q & altpcie_rs_serdes_rx_sd_idl_cnt_9_515q & altpcie_rs_serdes_rx_sd_idl_cnt_8_516q & altpcie_rs_serdes_rx_sd_idl_cnt_7_517q & altpcie_rs_serdes_rx_sd_idl_cnt_6_518q & altpcie_rs_serdes_rx_sd_idl_cnt_5_519q & altpcie_rs_serdes_rx_sd_idl_cnt_4_520q & altpcie_rs_serdes_rx_sd_idl_cnt_3_521q & altpcie_rs_serdes_rx_sd_idl_cnt_2_522q & altpcie_rs_serdes_rx_sd_idl_cnt_1_523q & "1");
	wire_altpcie_rs_serdes_add3_277_b <= ( "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "1" & "0" & "1" & "0" & "1");
	altpcie_rs_serdes_add3_277 :  oper_add
	  GENERIC MAP (
		sgate_representation => 0,
		width_a => 20,
		width_b => 20,
		width_o => 20
	  )
	  PORT MAP ( 
		a => wire_altpcie_rs_serdes_add3_277_a,
		b => wire_altpcie_rs_serdes_add3_277_b,
		cin => wire_gnd,
		o => wire_altpcie_rs_serdes_add3_277_o
	  );
	wire_altpcie_rs_serdes_add4_371_a <= ( altpcie_rs_serdes_rx_sd_idl_cnt_19_505q & altpcie_rs_serdes_rx_sd_idl_cnt_18_506q & altpcie_rs_serdes_rx_sd_idl_cnt_17_507q & altpcie_rs_serdes_rx_sd_idl_cnt_16_508q & altpcie_rs_serdes_rx_sd_idl_cnt_15_509q & altpcie_rs_serdes_rx_sd_idl_cnt_14_510q & altpcie_rs_serdes_rx_sd_idl_cnt_13_511q & altpcie_rs_serdes_rx_sd_idl_cnt_12_512q & altpcie_rs_serdes_rx_sd_idl_cnt_11_513q & altpcie_rs_serdes_rx_sd_idl_cnt_10_514q & altpcie_rs_serdes_rx_sd_idl_cnt_9_515q & altpcie_rs_serdes_rx_sd_idl_cnt_8_516q & altpcie_rs_serdes_rx_sd_idl_cnt_7_517q & altpcie_rs_serdes_rx_sd_idl_cnt_6_518q & altpcie_rs_serdes_rx_sd_idl_cnt_5_519q & altpcie_rs_serdes_rx_sd_idl_cnt_4_520q & altpcie_rs_serdes_rx_sd_idl_cnt_3_521q & altpcie_rs_serdes_rx_sd_idl_cnt_2_522q & altpcie_rs_serdes_rx_sd_idl_cnt_1_523q & altpcie_rs_serdes_rx_sd_idl_cnt_0_524q);
	wire_altpcie_rs_serdes_add4_371_b <= ( "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "1");
	altpcie_rs_serdes_add4_371 :  oper_add
	  GENERIC MAP (
		sgate_representation => 0,
		width_a => 20,
		width_b => 20,
		width_o => 20
	  )
	  PORT MAP ( 
		a => wire_altpcie_rs_serdes_add4_371_a,
		b => wire_altpcie_rs_serdes_add4_371_b,
		cin => wire_gnd,
		o => wire_altpcie_rs_serdes_add4_371_o
	  );
	wire_altpcie_rs_serdes_lessthan0_82_a <= ( altpcie_rs_serdes_pll_locked_cnt_6_246q & altpcie_rs_serdes_pll_locked_cnt_5_247q & altpcie_rs_serdes_pll_locked_cnt_4_248q & altpcie_rs_serdes_pll_locked_cnt_3_249q & altpcie_rs_serdes_pll_locked_cnt_2_250q & altpcie_rs_serdes_pll_locked_cnt_1_251q & altpcie_rs_serdes_pll_locked_cnt_0_252q);
	wire_altpcie_rs_serdes_lessthan0_82_b <= ( "1" & "1" & "1" & "1" & "1" & "1" & "1");
	altpcie_rs_serdes_lessthan0_82 :  oper_less_than
	  GENERIC MAP (
		sgate_representation => 0,
		width_a => 7,
		width_b => 7
	  )
	  PORT MAP ( 
		a => wire_altpcie_rs_serdes_lessthan0_82_a,
		b => wire_altpcie_rs_serdes_lessthan0_82_b,
		cin => wire_gnd,
		o => wire_altpcie_rs_serdes_lessthan0_82_o
	  );
	wire_altpcie_rs_serdes_lessthan1_276_a <= ( "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "1" & "0" & "1" & "0");
	wire_altpcie_rs_serdes_lessthan1_276_b <= ( altpcie_rs_serdes_rx_sd_idl_cnt_19_505q & altpcie_rs_serdes_rx_sd_idl_cnt_18_506q & altpcie_rs_serdes_rx_sd_idl_cnt_17_507q & altpcie_rs_serdes_rx_sd_idl_cnt_16_508q & altpcie_rs_serdes_rx_sd_idl_cnt_15_509q & altpcie_rs_serdes_rx_sd_idl_cnt_14_510q & altpcie_rs_serdes_rx_sd_idl_cnt_13_511q & altpcie_rs_serdes_rx_sd_idl_cnt_12_512q & altpcie_rs_serdes_rx_sd_idl_cnt_11_513q & altpcie_rs_serdes_rx_sd_idl_cnt_10_514q & altpcie_rs_serdes_rx_sd_idl_cnt_9_515q & altpcie_rs_serdes_rx_sd_idl_cnt_8_516q & altpcie_rs_serdes_rx_sd_idl_cnt_7_517q & altpcie_rs_serdes_rx_sd_idl_cnt_6_518q & altpcie_rs_serdes_rx_sd_idl_cnt_5_519q & altpcie_rs_serdes_rx_sd_idl_cnt_4_520q & altpcie_rs_serdes_rx_sd_idl_cnt_3_521q & altpcie_rs_serdes_rx_sd_idl_cnt_2_522q & altpcie_rs_serdes_rx_sd_idl_cnt_1_523q & altpcie_rs_serdes_rx_sd_idl_cnt_0_524q);
	altpcie_rs_serdes_lessthan1_276 :  oper_less_than
	  GENERIC MAP (
		sgate_representation => 0,
		width_a => 20,
		width_b => 20
	  )
	  PORT MAP ( 
		a => wire_altpcie_rs_serdes_lessthan1_276_a,
		b => wire_altpcie_rs_serdes_lessthan1_276_b,
		cin => wire_gnd,
		o => wire_altpcie_rs_serdes_lessthan1_276_o
	  );
	wire_altpcie_rs_serdes_lessthan2_298_a <= ( altpcie_rs_serdes_rx_sd_idl_cnt_19_505q & altpcie_rs_serdes_rx_sd_idl_cnt_18_506q & altpcie_rs_serdes_rx_sd_idl_cnt_17_507q & altpcie_rs_serdes_rx_sd_idl_cnt_16_508q & altpcie_rs_serdes_rx_sd_idl_cnt_15_509q & altpcie_rs_serdes_rx_sd_idl_cnt_14_510q & altpcie_rs_serdes_rx_sd_idl_cnt_13_511q & altpcie_rs_serdes_rx_sd_idl_cnt_12_512q & altpcie_rs_serdes_rx_sd_idl_cnt_11_513q & altpcie_rs_serdes_rx_sd_idl_cnt_10_514q & altpcie_rs_serdes_rx_sd_idl_cnt_9_515q & altpcie_rs_serdes_rx_sd_idl_cnt_8_516q & altpcie_rs_serdes_rx_sd_idl_cnt_7_517q & altpcie_rs_serdes_rx_sd_idl_cnt_6_518q & altpcie_rs_serdes_rx_sd_idl_cnt_5_519q & altpcie_rs_serdes_rx_sd_idl_cnt_4_520q & altpcie_rs_serdes_rx_sd_idl_cnt_3_521q & altpcie_rs_serdes_rx_sd_idl_cnt_2_522q & altpcie_rs_serdes_rx_sd_idl_cnt_1_523q & altpcie_rs_serdes_rx_sd_idl_cnt_0_524q);
	wire_altpcie_rs_serdes_lessthan2_298_b <= ( "1" & "0" & "1" & "1" & "0" & "1" & "1" & "1" & "0" & "0" & "0" & "1" & "1" & "0" & "1" & "1" & "0" & "0" & "0" & "0");
	altpcie_rs_serdes_lessthan2_298 :  oper_less_than
	  GENERIC MAP (
		sgate_representation => 0,
		width_a => 20,
		width_b => 20
	  )
	  PORT MAP ( 
		a => wire_altpcie_rs_serdes_lessthan2_298_a,
		b => wire_altpcie_rs_serdes_lessthan2_298_b,
		cin => wire_gnd,
		o => wire_altpcie_rs_serdes_lessthan2_298_o
	  );
	wire_altpcie_rs_serdes_lessthan3_363_a <= ( "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0");
	wire_altpcie_rs_serdes_lessthan3_363_b <= ( altpcie_rs_serdes_rx_sd_idl_cnt_19_505q & altpcie_rs_serdes_rx_sd_idl_cnt_18_506q & altpcie_rs_serdes_rx_sd_idl_cnt_17_507q & altpcie_rs_serdes_rx_sd_idl_cnt_16_508q & altpcie_rs_serdes_rx_sd_idl_cnt_15_509q & altpcie_rs_serdes_rx_sd_idl_cnt_14_510q & altpcie_rs_serdes_rx_sd_idl_cnt_13_511q & altpcie_rs_serdes_rx_sd_idl_cnt_12_512q & altpcie_rs_serdes_rx_sd_idl_cnt_11_513q & altpcie_rs_serdes_rx_sd_idl_cnt_10_514q & altpcie_rs_serdes_rx_sd_idl_cnt_9_515q & altpcie_rs_serdes_rx_sd_idl_cnt_8_516q & altpcie_rs_serdes_rx_sd_idl_cnt_7_517q & altpcie_rs_serdes_rx_sd_idl_cnt_6_518q & altpcie_rs_serdes_rx_sd_idl_cnt_5_519q & altpcie_rs_serdes_rx_sd_idl_cnt_4_520q & altpcie_rs_serdes_rx_sd_idl_cnt_3_521q & altpcie_rs_serdes_rx_sd_idl_cnt_2_522q & altpcie_rs_serdes_rx_sd_idl_cnt_1_523q & altpcie_rs_serdes_rx_sd_idl_cnt_0_524q);
	altpcie_rs_serdes_lessthan3_363 :  oper_less_than
	  GENERIC MAP (
		sgate_representation => 0,
		width_a => 20,
		width_b => 20
	  )
	  PORT MAP ( 
		a => wire_altpcie_rs_serdes_lessthan3_363_a,
		b => wire_altpcie_rs_serdes_lessthan3_363_b,
		cin => wire_vcc,
		o => wire_altpcie_rs_serdes_lessthan3_363_o
	  );
	wire_altpcie_rs_serdes_mux0_482_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_459m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_436m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_340m_dataout);
	wire_altpcie_rs_serdes_mux0_482_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux0_482 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux0_482_data,
		o => wire_altpcie_rs_serdes_mux0_482_o,
		sel => wire_altpcie_rs_serdes_mux0_482_sel
	  );
	wire_altpcie_rs_serdes_mux10_492_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_469m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_446m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_350m_dataout);
	wire_altpcie_rs_serdes_mux10_492_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux10_492 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux10_492_data,
		o => wire_altpcie_rs_serdes_mux10_492_o,
		sel => wire_altpcie_rs_serdes_mux10_492_sel
	  );
	wire_altpcie_rs_serdes_mux11_493_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_470m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_447m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_351m_dataout);
	wire_altpcie_rs_serdes_mux11_493_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux11_493 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux11_493_data,
		o => wire_altpcie_rs_serdes_mux11_493_o,
		sel => wire_altpcie_rs_serdes_mux11_493_sel
	  );
	wire_altpcie_rs_serdes_mux12_494_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_471m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_448m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_352m_dataout);
	wire_altpcie_rs_serdes_mux12_494_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux12_494 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux12_494_data,
		o => wire_altpcie_rs_serdes_mux12_494_o,
		sel => wire_altpcie_rs_serdes_mux12_494_sel
	  );
	wire_altpcie_rs_serdes_mux13_495_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_472m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_449m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_353m_dataout);
	wire_altpcie_rs_serdes_mux13_495_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux13_495 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux13_495_data,
		o => wire_altpcie_rs_serdes_mux13_495_o,
		sel => wire_altpcie_rs_serdes_mux13_495_sel
	  );
	wire_altpcie_rs_serdes_mux14_496_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_473m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_450m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_354m_dataout);
	wire_altpcie_rs_serdes_mux14_496_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux14_496 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux14_496_data,
		o => wire_altpcie_rs_serdes_mux14_496_o,
		sel => wire_altpcie_rs_serdes_mux14_496_sel
	  );
	wire_altpcie_rs_serdes_mux15_497_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_474m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_451m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_355m_dataout);
	wire_altpcie_rs_serdes_mux15_497_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux15_497 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux15_497_data,
		o => wire_altpcie_rs_serdes_mux15_497_o,
		sel => wire_altpcie_rs_serdes_mux15_497_sel
	  );
	wire_altpcie_rs_serdes_mux16_498_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_475m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_452m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_356m_dataout);
	wire_altpcie_rs_serdes_mux16_498_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux16_498 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux16_498_data,
		o => wire_altpcie_rs_serdes_mux16_498_o,
		sel => wire_altpcie_rs_serdes_mux16_498_sel
	  );
	wire_altpcie_rs_serdes_mux17_499_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_476m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_453m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_357m_dataout);
	wire_altpcie_rs_serdes_mux17_499_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux17_499 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux17_499_data,
		o => wire_altpcie_rs_serdes_mux17_499_o,
		sel => wire_altpcie_rs_serdes_mux17_499_sel
	  );
	wire_altpcie_rs_serdes_mux18_500_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_477m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_454m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_358m_dataout);
	wire_altpcie_rs_serdes_mux18_500_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux18_500 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux18_500_data,
		o => wire_altpcie_rs_serdes_mux18_500_o,
		sel => wire_altpcie_rs_serdes_mux18_500_sel
	  );
	wire_altpcie_rs_serdes_mux19_501_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_478m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_455m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_359m_dataout);
	wire_altpcie_rs_serdes_mux19_501_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux19_501 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux19_501_data,
		o => wire_altpcie_rs_serdes_mux19_501_o,
		sel => wire_altpcie_rs_serdes_mux19_501_sel
	  );
	wire_altpcie_rs_serdes_mux1_483_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_460m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_437m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_341m_dataout);
	wire_altpcie_rs_serdes_mux1_483_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux1_483 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux1_483_data,
		o => wire_altpcie_rs_serdes_mux1_483_o,
		sel => wire_altpcie_rs_serdes_mux1_483_sel
	  );
	wire_altpcie_rs_serdes_mux20_502_data <= ( "0" & wire_altpcie_rs_serdes_sd_state_479m_dataout & wire_altpcie_rs_serdes_sd_state_456m_dataout & wire_altpcie_rs_serdes_sd_state_360m_dataout);
	wire_altpcie_rs_serdes_mux20_502_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux20_502 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux20_502_data,
		o => wire_altpcie_rs_serdes_mux20_502_o,
		sel => wire_altpcie_rs_serdes_mux20_502_sel
	  );
	wire_altpcie_rs_serdes_mux21_503_data <= ( "0" & wire_altpcie_rs_serdes_sd_state_480m_dataout & wire_altpcie_rs_serdes_sd_state_457m_dataout & wire_altpcie_rs_serdes_sd_state_361m_dataout);
	wire_altpcie_rs_serdes_mux21_503_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux21_503 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux21_503_data,
		o => wire_altpcie_rs_serdes_mux21_503_o,
		sel => wire_altpcie_rs_serdes_mux21_503_sel
	  );
	wire_altpcie_rs_serdes_mux2_484_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_461m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_438m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_342m_dataout);
	wire_altpcie_rs_serdes_mux2_484_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux2_484 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux2_484_data,
		o => wire_altpcie_rs_serdes_mux2_484_o,
		sel => wire_altpcie_rs_serdes_mux2_484_sel
	  );
	wire_altpcie_rs_serdes_mux3_485_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_462m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_439m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_343m_dataout);
	wire_altpcie_rs_serdes_mux3_485_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux3_485 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux3_485_data,
		o => wire_altpcie_rs_serdes_mux3_485_o,
		sel => wire_altpcie_rs_serdes_mux3_485_sel
	  );
	wire_altpcie_rs_serdes_mux4_486_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_463m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_440m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_344m_dataout);
	wire_altpcie_rs_serdes_mux4_486_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux4_486 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux4_486_data,
		o => wire_altpcie_rs_serdes_mux4_486_o,
		sel => wire_altpcie_rs_serdes_mux4_486_sel
	  );
	wire_altpcie_rs_serdes_mux5_487_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_464m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_441m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_345m_dataout);
	wire_altpcie_rs_serdes_mux5_487_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux5_487 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux5_487_data,
		o => wire_altpcie_rs_serdes_mux5_487_o,
		sel => wire_altpcie_rs_serdes_mux5_487_sel
	  );
	wire_altpcie_rs_serdes_mux6_488_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_465m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_442m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_346m_dataout);
	wire_altpcie_rs_serdes_mux6_488_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux6_488 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux6_488_data,
		o => wire_altpcie_rs_serdes_mux6_488_o,
		sel => wire_altpcie_rs_serdes_mux6_488_sel
	  );
	wire_altpcie_rs_serdes_mux7_489_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_466m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_443m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_347m_dataout);
	wire_altpcie_rs_serdes_mux7_489_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux7_489 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux7_489_data,
		o => wire_altpcie_rs_serdes_mux7_489_o,
		sel => wire_altpcie_rs_serdes_mux7_489_sel
	  );
	wire_altpcie_rs_serdes_mux8_490_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_467m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_444m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_348m_dataout);
	wire_altpcie_rs_serdes_mux8_490_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux8_490 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux8_490_data,
		o => wire_altpcie_rs_serdes_mux8_490_o,
		sel => wire_altpcie_rs_serdes_mux8_490_sel
	  );
	wire_altpcie_rs_serdes_mux9_491_data <= ( "0" & wire_altpcie_rs_serdes_rx_sd_idl_cnt_468m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_445m_dataout & wire_altpcie_rs_serdes_rx_sd_idl_cnt_349m_dataout);
	wire_altpcie_rs_serdes_mux9_491_sel <= ( altpcie_rs_serdes_sd_state_1_525q & altpcie_rs_serdes_sd_state_0_201q);
	altpcie_rs_serdes_mux9_491 :  oper_mux
	  GENERIC MAP (
		width_data => 4,
		width_sel => 2
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_mux9_491_data,
		o => wire_altpcie_rs_serdes_mux9_491_o,
		sel => wire_altpcie_rs_serdes_mux9_491_sel
	  );
	wire_altpcie_rs_serdes_selector0_188_data <= ( wire_altpcie_rs_serdes_serdes_rst_state_170m_dataout & "0" & wire_altpcie_rs_serdes_serdes_rst_state_184m_dataout);
	wire_altpcie_rs_serdes_selector0_188_sel <= ( altpcie_rs_serdes_serdes_rst_state_idle_st_cnt_225q & s_wire_altpcie_rs_serdes_rxdigitalreset_r_197_dataout & altpcie_rs_serdes_serdes_rst_state_wait_state_st_cnt_228q);
	altpcie_rs_serdes_selector0_188 :  oper_selector
	  GENERIC MAP (
		width_data => 3,
		width_sel => 3
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_selector0_188_data,
		o => wire_altpcie_rs_serdes_selector0_188_o,
		sel => wire_altpcie_rs_serdes_selector0_188_sel
	  );
	wire_altpcie_rs_serdes_selector1_189_data <= ( wire_nl_w225w & wire_altpcie_rs_serdes_rxanalogreset_r_178m_dataout & "0");
	wire_altpcie_rs_serdes_selector1_189_sel <= ( altpcie_rs_serdes_serdes_rst_state_idle_st_cnt_225q & altpcie_rs_serdes_serdes_rst_state_strobe_txpll_locked_sd_cnt_226q & s_wire_altpcie_rs_serdes_txdigitalreset_r_194_dataout);
	altpcie_rs_serdes_selector1_189 :  oper_selector
	  GENERIC MAP (
		width_data => 3,
		width_sel => 3
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_selector1_189_data,
		o => wire_altpcie_rs_serdes_selector1_189_o,
		sel => wire_altpcie_rs_serdes_selector1_189_sel
	  );
	wire_altpcie_rs_serdes_selector2_190_data <= ( wire_altpcie_rs_serdes_serdes_rst_state_171m_dataout & wire_altpcie_rs_serdes_serdes_rst_state_177m_dataout & wire_nl_w225w & wire_nl_w225w);
	wire_altpcie_rs_serdes_selector2_190_sel <= ( altpcie_rs_serdes_serdes_rst_state_idle_st_cnt_225q & altpcie_rs_serdes_serdes_rst_state_strobe_txpll_locked_sd_cnt_226q & altpcie_rs_serdes_serdes_rst_state_stable_tx_pll_st_cnt_227q & altpcie_rs_serdes_serdes_rst_state_wait_state_st_cnt_228q);
	altpcie_rs_serdes_selector2_190 :  oper_selector
	  GENERIC MAP (
		width_data => 4,
		width_sel => 4
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_selector2_190_data,
		o => wire_altpcie_rs_serdes_selector2_190_o,
		sel => wire_altpcie_rs_serdes_selector2_190_sel
	  );
	wire_altpcie_rs_serdes_selector3_192_data <= ( "0" & altpcie_rs_serdes_rx_pll_freq_locked_sync_r_235q & wire_altpcie_rs_serdes_serdes_rst_state_186m_dataout);
	wire_altpcie_rs_serdes_selector3_192_sel <= ( s_wire_altpcie_rs_serdes_serdes_rst_state_191_dataout & altpcie_rs_serdes_serdes_rst_state_stable_tx_pll_st_cnt_227q & altpcie_rs_serdes_serdes_rst_state_wait_state_st_cnt_228q);
	altpcie_rs_serdes_selector3_192 :  oper_selector
	  GENERIC MAP (
		width_data => 3,
		width_sel => 3
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_selector3_192_data,
		o => wire_altpcie_rs_serdes_selector3_192_o,
		sel => wire_altpcie_rs_serdes_selector3_192_sel
	  );
	wire_altpcie_rs_serdes_selector4_193_data <= ( wire_altpcie_rs_serdes_ld_ws_tmr_172m_dataout & "0" & altpcie_rs_serdes_ld_ws_tmr_230q);
	wire_altpcie_rs_serdes_selector4_193_sel <= ( altpcie_rs_serdes_serdes_rst_state_idle_st_cnt_225q & altpcie_rs_serdes_serdes_rst_state_strobe_txpll_locked_sd_cnt_226q & s_wire_altpcie_rs_serdes_txdigitalreset_r_194_dataout);
	altpcie_rs_serdes_selector4_193 :  oper_selector
	  GENERIC MAP (
		width_data => 3,
		width_sel => 3
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_selector4_193_data,
		o => wire_altpcie_rs_serdes_selector4_193_o,
		sel => wire_altpcie_rs_serdes_selector4_193_sel
	  );
	wire_altpcie_rs_serdes_selector5_195_data <= ( altpcie_rs_serdes_txdigitalreset_r_202q & wire_w264w & "0");
	wire_altpcie_rs_serdes_selector5_195_sel <= ( altpcie_rs_serdes_serdes_rst_state_idle_st_cnt_225q & altpcie_rs_serdes_serdes_rst_state_strobe_txpll_locked_sd_cnt_226q & s_wire_altpcie_rs_serdes_txdigitalreset_r_194_dataout);
	altpcie_rs_serdes_selector5_195 :  oper_selector
	  GENERIC MAP (
		width_data => 3,
		width_sel => 3
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_selector5_195_data,
		o => wire_altpcie_rs_serdes_selector5_195_o,
		sel => wire_altpcie_rs_serdes_selector5_195_sel
	  );
	wire_altpcie_rs_serdes_selector6_196_data <= ( altpcie_rs_serdes_rxanalogreset_r_203q & wire_altpcie_rs_serdes_rxanalogreset_r_178m_dataout & "0");
	wire_altpcie_rs_serdes_selector6_196_sel <= ( altpcie_rs_serdes_serdes_rst_state_idle_st_cnt_225q & altpcie_rs_serdes_serdes_rst_state_strobe_txpll_locked_sd_cnt_226q & s_wire_altpcie_rs_serdes_txdigitalreset_r_194_dataout);
	altpcie_rs_serdes_selector6_196 :  oper_selector
	  GENERIC MAP (
		width_data => 3,
		width_sel => 3
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_selector6_196_data,
		o => wire_altpcie_rs_serdes_selector6_196_o,
		sel => wire_altpcie_rs_serdes_selector6_196_sel
	  );
	wire_altpcie_rs_serdes_selector7_198_data <= ( altpcie_rs_serdes_rxdigitalreset_r_204q & "1" & wire_altpcie_rs_serdes_rxdigitalreset_r_187m_dataout);
	wire_altpcie_rs_serdes_selector7_198_sel <= ( altpcie_rs_serdes_serdes_rst_state_idle_st_cnt_225q & s_wire_altpcie_rs_serdes_rxdigitalreset_r_197_dataout & altpcie_rs_serdes_serdes_rst_state_wait_state_st_cnt_228q);
	altpcie_rs_serdes_selector7_198 :  oper_selector
	  GENERIC MAP (
		width_data => 3,
		width_sel => 3
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_selector7_198_data,
		o => wire_altpcie_rs_serdes_selector7_198_o,
		sel => wire_altpcie_rs_serdes_selector7_198_sel
	  );
	wire_altpcie_rs_serdes_selector8_199_data <= ( altpcie_rs_serdes_ld_ws_tmr_short_231q & wire_altpcie_rs_serdes_ld_ws_tmr_short_179m_dataout & wire_altpcie_rs_serdes_ld_ws_tmr_short_183m_dataout);
	wire_altpcie_rs_serdes_selector8_199_sel <= ( s_wire_altpcie_rs_serdes_serdes_rst_state_191_dataout & altpcie_rs_serdes_serdes_rst_state_stable_tx_pll_st_cnt_227q & altpcie_rs_serdes_serdes_rst_state_wait_state_st_cnt_228q);
	altpcie_rs_serdes_selector8_199 :  oper_selector
	  GENERIC MAP (
		width_data => 3,
		width_sel => 3
	  )
	  PORT MAP ( 
		data => wire_altpcie_rs_serdes_selector8_199_data,
		o => wire_altpcie_rs_serdes_selector8_199_o,
		sel => wire_altpcie_rs_serdes_selector8_199_sel
	  );

 END RTL; --altpcie_rs_serdes
--synopsys translate_on
--VALID FILE
