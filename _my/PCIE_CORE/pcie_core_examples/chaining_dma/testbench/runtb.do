global env ;

set QUARTUS_ROOTDIR "c:/altera/10.1/quartus"
set PHY_TYPE_STRATIXVGX 0

set MSIM_AE ""

if [regexp {ModelSim ALTERA} [vsim -version]] {
        # Using Altera OEM Version need to add one more library mapping
        set altgxb_path $env(MODEL_TECH)\/../altera/vhdl/altgxb ;
        vmap altgxb_lib $altgxb_path ;
        if { $PHY_TYPE_STRATIXVGX == 1 } {
           set MSIM_AE "-L altera_lnsim_ver -L altera_ver -L altera_mf -L stratixiigx_hssi -L stratixiv_hssi -L stratixiv_pcie_hip -L stratixv_hssi_ver -L stratixv_pcie_hip_ver"
        }
   vlib altera
} else {
        # Using non-OEM Version, compile all of the libraries
        vlib lpm
        vmap lpm lpm
        vcom -work lpm $QUARTUS_ROOTDIR/eda/sim_lib/220pack.vhd $QUARTUS_ROOTDIR/eda/sim_lib/220model.vhd

        vlib altera_mf
        vmap altera_mf altera_mf
        vcom -work altera_mf $QUARTUS_ROOTDIR/eda/sim_lib/altera_mf_components.vhd $QUARTUS_ROOTDIR/eda/sim_lib/altera_mf.vhd

        vlib sgate
        vmap sgate sgate
        vcom -work sgate $QUARTUS_ROOTDIR/eda/sim_lib/sgate_pack.vhd $QUARTUS_ROOTDIR/eda/sim_lib/sgate.vhd

        vlib stratixiigx_hssi
        vmap stratixiigx_hssi stratixiigx_hssi
        vcom -work stratixiigx_hssi $QUARTUS_ROOTDIR/eda/sim_lib/stratixiigx_hssi_components.vhd
        vcom -work stratixiigx_hssi $QUARTUS_ROOTDIR/eda/sim_lib/stratixiigx_hssi_atoms.vhd

        vlib altera
        vmap altera altera
        vcom -work altera $QUARTUS_ROOTDIR/eda/sim_lib/altera_primitives_components.vhd
        vcom -work altera $QUARTUS_ROOTDIR/eda/sim_lib/altera_primitives.vhd

   if [ file exists  $QUARTUS_ROOTDIR/eda/sim_lib/stratixiv_hssi_components.vhd ] {

       vlib stratixiv_hssi
       vmap stratixiv_hssi stratixiv_hssi
       vcom -work stratixiv_hssi $QUARTUS_ROOTDIR/eda/sim_lib/stratixiv_hssi_components.vhd
       vcom -work stratixiv_hssi $QUARTUS_ROOTDIR/eda/sim_lib/stratixiv_hssi_atoms.vhd

       vlib stratixiv_pcie_hip
       vmap stratixiv_pcie_hip stratixiv_pcie_hip
       vcom -work stratixiv_pcie_hip $QUARTUS_ROOTDIR/eda/sim_lib/stratixiv_pcie_hip_components.vhd
       vcom -work stratixiv_pcie_hip $QUARTUS_ROOTDIR/eda/sim_lib/stratixiv_pcie_hip_atoms.vhd

       if { $PHY_TYPE_STRATIXVGX == 0 } {

         vlib arriaii_hssi
         vmap arriaii_hssi arriaii_hssi
         vcom -work arriaii_hssi $QUARTUS_ROOTDIR/eda/sim_lib/arriaii_hssi_components.vhd
         vcom -work arriaii_hssi $QUARTUS_ROOTDIR/eda/sim_lib/arriaii_hssi_atoms.vhd

         vlib arriaii_pcie_hip
         vmap arriaii_pcie_hip arriaii_pcie_hip
         vcom -work arriaii_pcie_hip $QUARTUS_ROOTDIR/eda/sim_lib/arriaii_pcie_hip_components.vhd
         vcom -work arriaii_pcie_hip $QUARTUS_ROOTDIR/eda/sim_lib/arriaii_pcie_hip_atoms.vhd

         vlib arriaiigz_hssi
         vmap arriaiigz_hssi arriaiigz_hssi
         vcom -work arriaiigz_hssi $QUARTUS_ROOTDIR/eda/sim_lib/arriaiigz_hssi_components.vhd
         vcom -work arriaiigz_hssi $QUARTUS_ROOTDIR/eda/sim_lib/arriaiigz_hssi_atoms.vhd

         vlib arriaiigz_pcie_hip
         vmap arriaiigz_pcie_hip arriaiigz_pcie_hip
         vcom -work arriaiigz_pcie_hip $QUARTUS_ROOTDIR/eda/sim_lib/arriaiigz_pcie_hip_components.vhd
         vcom -work arriaiigz_pcie_hip $QUARTUS_ROOTDIR/eda/sim_lib/arriaiigz_pcie_hip_atoms.vhd

         vlib cycloneiv_hssi
         vmap cycloneiv_hssi cycloneiv_hssi
         vcom -work cycloneiv_hssi $QUARTUS_ROOTDIR/eda/sim_lib/cycloneiv_hssi_components.vhd
         vcom -work cycloneiv_hssi $QUARTUS_ROOTDIR/eda/sim_lib/cycloneiv_hssi_atoms.vhd

         vlib cycloneiv_pcie_hip
         vmap cycloneiv_pcie_hip cycloneiv_pcie_hip
         vcom -work cycloneiv_pcie_hip $QUARTUS_ROOTDIR/eda/sim_lib/cycloneiv_pcie_hip_components.vhd
         vcom -work cycloneiv_pcie_hip $QUARTUS_ROOTDIR/eda/sim_lib/cycloneiv_pcie_hip_atoms.vhd

         vlib hardcopyiv_hssi
         vmap hardcopyiv_hssi hardcopyiv_hssi
         vcom -work hardcopyiv_hssi $QUARTUS_ROOTDIR/eda/sim_lib/hardcopyiv_hssi_components.vhd
         vcom -work hardcopyiv_hssi $QUARTUS_ROOTDIR/eda/sim_lib/hardcopyiv_hssi_atoms.vhd

         vlib hardcopyiv_pcie_hip
         vmap hardcopyiv_pcie_hip hardcopyiv_pcie_hip
         vcom -work hardcopyiv_pcie_hip $QUARTUS_ROOTDIR/eda/sim_lib/hardcopyiv_pcie_hip_components.vhd
         vcom -work hardcopyiv_pcie_hip $QUARTUS_ROOTDIR/eda/sim_lib/hardcopyiv_pcie_hip_atoms.vhd
       }
   }
}

# Create the work library
vlib work

# Verilog co-sim when PHY_TYPE_STRATIXVGX (e.g Stratix V)
if { $PHY_TYPE_STRATIXVGX == 1 } {
   vlog -work work $QUARTUS_ROOTDIR/eda/sim_lib/mentor/stratixv_hssi_atoms_for_vhdl.v
   vlog -work work $QUARTUS_ROOTDIR/eda/sim_lib/mentor/stratixv_hssi_atoms_ncrypt.v
   vlog -work work $QUARTUS_ROOTDIR/eda/sim_lib/mentor/stratixv_pcie_hip_atoms_for_vhdl.v
   vlog -work work $QUARTUS_ROOTDIR/eda/sim_lib/mentor/stratixv_pcie_hip_atoms_ncrypt.v
   vlog -sv -work work $QUARTUS_ROOTDIR/eda/sim_lib/mentor/altera_lnsim_for_vhdl.sv

   if [ file exists $QUARTUS_ROOTDIR/../ip/altera/pci_express_compiler/mentor ] {
      vlog +define+ALTPCIETB_COSIM_MENTOR -work work $QUARTUS_ROOTDIR/../ip/altera/pci_express_compiler/mentor/altpcie_hip_256_pipen1b.v
   } else {
      vlog +define+ALTPCIETB_COSIM_MENTOR -work work ../../../pci_express_compiler-library/altpcie_hip_256_pipen1b.v
   }

   if [ file exists $QUARTUS_ROOTDIR/../ip/altera/altera_pcie_pipe/mentor ] {
      vlog -work work $QUARTUS_ROOTDIR/../ip/altera/altera_pcie_pipe/mentor/altera_pcie_phy_pipe.v
   } else {
      vlog -work work ../../../altera_pcie_pipe-library/altera_pcie_phy_pipe.v
   }

   if [ file exists $QUARTUS_ROOTDIR/../ip/altera/altera_xcvr_generic/mentor ] {
      vlog     -work work $QUARTUS_ROOTDIR/../ip/altera/altera_xcvr_generic/mentor/sv/sv_8g_pcs.v
      vlog -sv -work work $QUARTUS_ROOTDIR/../ip/altera/altera_xcvr_generic/mentor/sv/sv_generic_csr_h.sv
      vlog -sv -work work $QUARTUS_ROOTDIR/../ip/altera/altera_xcvr_generic/mentor/sv/sv_generic_csr.sv
      vlog     -work work $QUARTUS_ROOTDIR/../ip/altera/altera_xcvr_generic/mentor/sv/sv_rx_8g_pcs.v
      vlog     -work work $QUARTUS_ROOTDIR/../ip/altera/altera_xcvr_generic/mentor/sv/sv_tx_10g_pcs.v
      vlog     -work work $QUARTUS_ROOTDIR/../ip/altera/altera_xcvr_generic/mentor/sv/sv_tx_pma_ch.v
      vlog     -work work $QUARTUS_ROOTDIR/../ip/altera/altera_xcvr_generic/mentor/sv/sv_rx_10g_pcs.v
      vlog     -work work $QUARTUS_ROOTDIR/../ip/altera/altera_xcvr_generic/mentor/sv/sv_rx_pma.v
      vlog     -work work $QUARTUS_ROOTDIR/../ip/altera/altera_xcvr_generic/mentor/sv/sv_tx_8g_pcs.v
      vlog     -work work $QUARTUS_ROOTDIR/../ip/altera/altera_xcvr_generic/mentor/sv/sv_tx_pma.v
   } else {
      vlog     -work work ../../../altera_xcvr_generic-sv-library/sv_8g_pcs.v
      vlog -sv -work work ../../../altera_xcvr_generic-sv-library/sv_generic_csr_h.sv
      vlog -sv -work work ../../../altera_xcvr_generic-sv-library/sv_generic_csr.sv
      vlog     -work work ../../../altera_xcvr_generic-sv-library/sv_rx_8g_pcs.v
      vlog     -work work ../../../altera_xcvr_generic-sv-library/sv_tx_10g_pcs.v
      vlog     -work work ../../../altera_xcvr_generic-sv-library/sv_tx_pma_ch.v
      vlog     -work work ../../../altera_xcvr_generic-sv-library/sv_rx_10g_pcs.v
      vlog     -work work ../../../altera_xcvr_generic-sv-library/sv_rx_pma.v
      vlog     -work work ../../../altera_xcvr_generic-sv-library/sv_tx_8g_pcs.v
      vlog     -work work ../../../altera_xcvr_generic-sv-library/sv_tx_pma.v
   }
}


# Map the support library from the example_top file
vmap altera work
vcom -work altera $QUARTUS_ROOTDIR/libraries/vhdl/altera/altera_europa_support_lib.vhd

# Now compile the testbench/reference design files
vcom -work work -f sim_filelist

# Now run the simulation
eval vsim -novopt -t ps $MSIM_AE pcie_core_chaining_testbench
set NumericStdNoWarnings 1
set StdArithNoWarnings 1
onbreak { resume }

# Log all nets
# log -r /*

run -all
