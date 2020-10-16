library ieee;
use ieee.std_logic_1164.all;

entity main_block is

	port(
		clk             : in  std_logic;
		button_in       : in  std_logic;
		ps2_code_in     : in  std_logic_vector(7 downto 0);
		ps2_code_new_in : in  std_logic;
		indicator_out   : out std_logic_vector(7 downto 0);
		nios            : in  std_logic_vector(31 downto 0);
		nios2			: in  std_logic_vector(31 downto 0);
		nios3			: in  std_logic_vector(31 downto 0)
	);

end main_block;

architecture rtl of main_block is

begin

end rtl;
