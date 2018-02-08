library IEEE;
use IEEE.std_logic_1164.all;

entity TEST is
	port (
		CLOCK_50	: in std_logic;
		SW			: in std_logic_vector(9 downto 0);
		KEY			: in std_logic_vector(3 downto 0);
		GPIO_0		: inout std_logic_vector(35 downto 0);
		GPIO_1		: inout std_logic_vector(35 downto 0);
		HEX0		: out std_logic_vector(6 downto 0);
		LEDR		: out std_logic_vector(9 downto 0)
	);
end TEST;

architecture rtl of TEST is

begin


LEDR(0) <= KEY(0) nor KEY(3);


end architecture rtl;
