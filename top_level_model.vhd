library ieee;
use ieee.std_logic_1164.all;

entity top_level_model is

	port(
		clk                   : in  std_logic;
		clk_ps2				  : in  std_logic;
		button_in             : in  std_logic;
		indicator_out_display : out std_logic;
		clk_display           : out std_logic;
		ps2_data              : in  std_logic;
		ready_disp            : out std_logic;
		nios				  : out std_logic_vector(31 downto 0);
		nios2				  : in std_logic_vector(31 downto 0);
		nios3				  : in std_logic_vector(31 downto 0);
		result_out			  : out std_logic_vector(31 downto 0)
	);

end top_level_model;

architecture rtl of top_level_model is

	component main_block is

		port(
			clk             : in  std_logic;
			button_in       : in  std_logic;
			ps2_code_in     : in  std_logic_vector(7 downto 0);
			ps2_code_new_in : in  std_logic;
			ps2_reset       : out std_logic;
			indicator_out   : out std_logic_vector(15 downto 0);
			nios            : out  std_logic_vector(31 downto 0);
			nios2           : in  std_logic_vector(31 downto 0);
			nios3           : in  std_logic_vector(31 downto 0);
			result_out	 	: out std_logic_vector(31 downto 0);
			ready_7_control : out std_logic
		);

	end component main_block;

	component button_controller is

		port(
			clk        : in  std_logic;
			button_in  : in  std_logic;
			button_out : out std_logic
		);

	end component button_controller;

	component frequency_controller is

		port(
			clk           : in  std_logic;
			clk_button    : out std_logic;
			clk_main      : out std_logic;
			clk_indicator : out std_logic
		);

	end component frequency_controller;

	component PS2_controller is

		port(
			clk          : in  std_logic;
			reset        : in  std_logic;
			ps2_data     : in  std_logic;
			ps2_code_new : out std_logic;
			ps2_code     : out std_logic_vector(7 downto 0)
		);

	end component PS2_controller;

	component seven_segment_controller is

		port(
			ready_in     : in  std_logic;
			clk          : in  std_logic;
			indicator_in : in  std_logic_vector(15 downto 0);
			data_out     : out std_logic;
			sck          : out std_logic;
			ready_out    : out std_logic
		);

	end component seven_segment_controller;

	signal clk_button         : std_logic;
	signal button_out         : std_logic;
	signal clk_main           : std_logic;
	signal clk_indicator      : std_logic;
	signal ps2_code           : std_logic_vector(7 downto 0);
	signal ps2_code_new       : std_logic;
	signal ps2_reset          : std_logic;
	--signal nios               : std_logic_vector(31 downto 0);
	--signal nios2              : std_logic_vector(31 downto 0);
	--signal nios3              : std_logic_vector(31 downto 0);
	signal indicator_out_main : std_logic_vector(15 downto 0);
	signal ready              : std_logic;
begin

	l_bc : button_controller
		port map(
			clk        => clk_button,
			button_in  => button_in,
			button_out => button_out
		);
	l_fc : frequency_controller
		port map(
			clk           => clk,
			clk_button    => clk_button,
			clk_main      => clk_main,
			clk_indicator => clk_indicator
		);
	l_ps2 : PS2_controller
		port map(
			clk          => clk_ps2,
			reset        => ps2_reset,
			ps2_data     => ps2_data,
			ps2_code_new => ps2_code_new,
			ps2_code     => ps2_code
		);
	l_main : main_block
		port map(
			clk             => clk_main,
			button_in       => button_out,
			ps2_code_in     => ps2_code,
			ps2_code_new_in => ps2_code_new,
			ps2_reset       => ps2_reset,
			nios            => nios,
			nios2           => nios2,
			nios3           => nios3,
			result_out		=> result_out,
			indicator_out   => indicator_out_main,
			ready_7_control => ready
		);
	l_seven_segm : seven_segment_controller
		port map(
			ready_in     => ready,
			clk          => clk_indicator,
			indicator_in => indicator_out_main,
			data_out     => indicator_out_display,
			sck          => clk_display,
			ready_out    => ready_disp
		);
end rtl;
