

--===================================================--
--================ Global registers =================--
--===================================================--
	CONSTANT VERSION_REG_ADR = h"0000";
	CONSTANT TEST_REG_ADR    = h"0010";
	CONSTANT INT_EVENT_L     = h"0020";
	CONSTANT INT_EVENT_H     = h"0030";
	CONSTANT EXT_MUX         = h"0040";
--===================================================--

--=======================================================--
--================ ARINC825(SPI) registers ==============--	
--=======================================================--

	CONSTANT SPI_DATA      = h"0000";
--	CONSTANT SPI_CTRL      = h"0010";
	CONSTANT SPI_EVENT     = h"0020";
	CONSTANT SPI_MASK      = h"0030";
	
	CONSTANT SPI_OFFSET_A = h"1000";
	CONSTANT SPI_OFFSET_B = h"1100";
--=======================================================--
