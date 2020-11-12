library ieee;
use ieee.std_logic_1164.all;

entity frequency_controller is

	generic(
		FREQUENCY_IN    : natural := 50_000_000;
		FREQUENCY_OUT_B : natural := 1_000;
		FREQUENCY_OUT_M : natural := 1_000_000;
		FREQUENCY_OUT_I : natural := 16_000_000
	);

	port(
		clk           : in  std_logic;
		clk_button    : out std_logic;
		clk_main      : out std_logic;
		clk_indicator : out std_logic
	);

end frequency_controller;

architecture rtl of frequency_controller is
	component frequency_manager is

		generic(
			FREQUENCY_IN  : natural := 50_000_000;
			FREQUENCY_OUT : natural := 1_000_000
		);

		port(
			clk     : in  std_logic;
			clk_out : out std_logic
		);

	end component frequency_manager;
begin
	l_b : frequency_manager
		generic map(FREQUENCY_IN, FREQUENCY_OUT_B)
		port map(
			clk     => clk,
			clk_out => clk_button
		);
	l_m : frequency_manager
		generic map(FREQUENCY_IN, FREQUENCY_OUT_M)
		port map(
			clk     => clk,
			clk_out => clk_main
		);
	l_i : frequency_manager
		generic map(FREQUENCY_IN, FREQUENCY_OUT_I)
		port map(
			clk     => clk,
			clk_out => clk_indicator
		);
end rtl;
