-- Quartus II VHDL Template
-- Simple Dual-Port RAM with different read/write addresses and
-- different read/write clock

library ieee;
use ieee.std_logic_1164.all;

entity main_block is

	generic 
	(
		DATA_WIDTH : natural := 8;
		ADDR_WIDTH : natural := 6
	);

	port 
	(
		clk	: in std_logic;
		button_in	: in std_logic;
		ps2_code_in	: in std_logic_vector(0 to 7);
		ps2_code_new_in : in std_logic;
		indicator_out	: out natural range 0 to 7;
		nios	: in std_logic
	);

end main_block;

architecture rtl of main_block is


begin

	

end rtl;
