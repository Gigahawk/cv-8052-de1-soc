--
-- Shim for CV_8052 to work with default pin names of Altera DEx dev boards
--
-- Version : 0100
--
-- Author: Amar Shah
--

library IEEE;
use IEEE.std_logic_1164.all;

entity CV_8052_DE_SHIM is
	port (
		CLOCK_50	: in std_logic;
		SW			: in std_logic_vector(9 downto 0);
		KEY			: in std_logic_vector(3 downto 0);
		GPIO_0		: inout std_logic_vector(35 downto 0);
		GPIO_1		: inout std_logic_vector(35 downto 0);
		HEX0		: out std_logic_vector(6 downto 0);
		HEX1		: out std_logic_vector(6 downto 0);
		HEX2		: out std_logic_vector(6 downto 0);
		HEX3		: out std_logic_vector(6 downto 0);
		HEX4		: out std_logic_vector(6 downto 0);
		HEX5		: out std_logic_vector(6 downto 0);
		LEDR		: out std_logic_vector(9 downto 0)
	);
end CV_8052_DE_SHIM;

architecture rtl of CV_8052_DE_SHIM is

	component CV_8052 is
		port (
			CLOCK_50	: in std_logic;
			RstIn		: in std_logic;
			LEDR0_in	: in  std_logic_vector(7 downto 0);
			LEDR1_in	: in  std_logic_vector(1 downto 0);
			KEY			: in  std_logic_vector(3 downto 0);
			P0		    : inout std_logic_vector(7 downto 0);
			P1		    : inout std_logic_vector(7 downto 0);
			P2		    : inout std_logic_vector(7 downto 0);
			P3		    : inout std_logic_vector(7 downto 0);
			
			HEX0_out	: out std_logic_vector(6 downto 0);
			HEX1_out	: out std_logic_vector(6 downto 0);
			HEX2_out	: out std_logic_vector(6 downto 0);
			HEX3_out	: out std_logic_vector(6 downto 0);
			HEX4_out	: out std_logic_vector(6 downto 0);
			HEX5_out	: out std_logic_vector(6 downto 0);
			LEDR0_out	: out std_logic_vector(7 downto 0);
			LEDR1_out	: out std_logic_vector(1 downto 0);
			INT0		: in std_logic;
			INT1		: in std_logic;
			T0			: in std_logic;
			T1			: in std_logic;
			T2			: in std_logic;
			T2EX		: in std_logic;
			RXD			: in std_logic;
			TXD			: out std_logic;
			-- FLASH PINS
			FL_RST_N 	: out std_logic;
			FL_WE_N  	: out std_logic;
			FL_OE_N  	: out std_logic;
			FL_CE_N  	: out std_logic;
			-- FL_ADDR  : out std_logic_vector(21 downto 0);
			FL_DQ    	: inout std_logic_vector(7 downto 0);
			-- JTAG PINS
			TDO 		: out std_logic;
			TDI 		: in std_logic;
			TCS 		: in std_logic;
			TCK 		: in std_logic;
			-- LCD pins
			LCD_DATA 	: inout std_logic_vector(7 downto 0);
			LCD_RW 		: out std_logic;
			LCD_EN 		: out std_logic;
			LCD_RS		: out std_logic;
			LCD_ON 		: out std_logic			
		);
	end component CV_8052;
	
	signal reset_n : std_logic;
	signal flash_null : std_logic;
	
begin

--D
reset_n <= not ((not KEY(2)) and (not KEY(1)));

CORE_8052 : CV_8052 port map (
	CLOCK_50	=> CLOCK_50,
	
	RstIn		=> reset_n,
	
	LEDR0_in	=> SW(7 downto 0),
	LEDR1_in	=> SW(9 downto 8),
	KEY		 	=> KEY,
	
	P0			=> GPIO_1(7 downto 0),
	P1 			=> GPIO_1(15 downto 8),
	P2			=> GPIO_1(23 downto 16),
	P3			=> GPIO_1(31 downto 24),
	
	HEX0_out	=> HEX0,
	HEX1_out	=> HEX1,
	HEX2_out 	=> HEX2,
	HEX3_out	=> HEX3,
	HEX4_out	=> HEX4,
	HEX5_out	=> HEX5,
	
	LEDR0_out	=> LEDR(7 downto 0),
	LEDR1_out	=> LEDR(9 downto 8),
	
	INT0		=> GPIO_1(32),
	INT1		=> GPIO_1(33),
	
	T0			=> GPIO_0(32),
	T1			=> GPIO_0(31),
	T2			=> GPIO_0(34),
	T2EX		=> GPIO_0(35),
	
	RXD			=> GPIO_0(13),
	TXD 		=> GPIO_0(11),
	
	FL_RST_N	=> flash_null, --GPIO_0(18),
	FL_WE_N		=> GPIO_0(23),
	FL_OE_N		=> GPIO_0(24),
	FL_CE_N		=> GPIO_0(25),
	FL_DQ		=> GPIO_0(21 downto 14),
	
	TDO			=> GPIO_0(26),
	TDI			=> GPIO_0(27),
	TCS			=> GPIO_0(28),
	TCK			=> GPIO_0(29),
	
	LCD_DATA	=> GPIO_0(7 downto 0),
	LCD_RW		=> GPIO_0(10),
	LCD_EN		=> GPIO_0(8),
	LCD_RS		=> GPIO_0(9),
	LCD_ON		=> GPIO_0(12)
);

end architecture rtl;
