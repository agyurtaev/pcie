/* Quartus II Version 10.1 Build 153 11/29/2010 SJ Full Version */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Cfg)
		Device PartName(EP4SGX230KF40) Path("C:/temp/PCIE/PCIE_10_1/") File("pcie_top.sof") MfrSpec(OpMask(1));
	P ActionCode(Ign)
		Device PartName(EPM2210) MfrSpec(OpMask(0));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
