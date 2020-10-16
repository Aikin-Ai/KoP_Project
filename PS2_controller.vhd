library ieee;
use ieee.std_logic_1164.all;

entity PS2_controller is

	port(
		clk          : in  std_logic;
		ps2_clk      : in  std_logic;
		ps2_data     : in  std_logic;
		ps2_code_new : out std_logic;
		ps2_code     : out std_logic_vector(7 downto 0)
	);

end PS2_controller;

architecture rtl of PS2_controller is

begin

end rtl;
