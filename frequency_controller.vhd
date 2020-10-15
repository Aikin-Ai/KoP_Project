library ieee;
use ieee.std_logic_1164.all;

entity frequency_controller is

	port(
		clk           : in  std_logic;
		clk_button    : out std_logic;
		clk_main      : out std_logic;
		clk_ps2       : out std_logic;
		clk_indicator : out std_logic
	);

end frequency_controller;

architecture rtl of frequency_controller is

begin

end rtl;
