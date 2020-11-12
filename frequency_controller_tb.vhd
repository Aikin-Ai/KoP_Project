library ieee;
use ieee.std_logic_1164.all;

entity frequency_controller_tb is
end frequency_controller_tb;

architecture rtl of frequency_controller_tb is
	component frequency_controller is
	port(
		clk           : in  std_logic;
		clk_button    : out std_logic;
		clk_main      : out std_logic;
		clk_indicator : out std_logic
	);
    end component frequency_controller;
    signal clk: std_logic;
    signal clk_button: std_logic;
    signal clk_main: std_logic;
    signal clk_indicator: std_logic;
begin
    inst0: frequency_controller port map(clk,clk_button,clk_main,clk_indicator);
    process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;
end rtl;