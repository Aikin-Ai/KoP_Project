library ieee;
use ieee.std_logic_1164.all;

entity top_level_model is

	generic 
	(
		DATA_WIDTH : natural := 8;
		ADDR_WIDTH : natural := 6
	);

	port 
	(
		clk	: in std_logic;
		button_in	: in std_logic;
		indicator_out	: out std_logic;
		keyboair_in	: in std_logic;
		ps2_clk   : in std_logic;
        ps2_data  : in std_logic
	);

end top_level_model;

architecture rtl of top_level_model is

	component main_block is

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

	end component main_block;
	
	component button_controller is

	port 
	(
		clk		  : in std_logic;
		button_in  : in std_logic;
		button_out : out std_logic
	);

	end component button_controller;
	
	component frequency_controller is

	port 
	(
		clk	        : in std_logic;
		clk_button    : out std_logic;
		clk_main      : out std_logic;
		clk_ps2       : out std_logic;
		clk_indicator : out std_logic
	);

	end component frequency_controller;

	component PS2_controller is

		port 
		(
			clk		  : in std_logic;
			ps2_clk   : in std_logic;
			ps2_data  : in std_logic;
			ps2_code_new : out std_logic;
			ps2_code     : out std_logic_vector(0 to 8)
		);
	
	end component PS2_controller;
   --Скопировать entity и переименовать в component для всех блоков
	
	--Создаем сигналы для контроллеров
	signal clk_button 	: std_logic;
	signal button_out 	: std_logic;
	signal clk_main		: std_logic;
	signal clk_ps2		: std_logic;
	signal clk_indicator: std_logic;
	signal ps2_code		: std_logic_vector(0 to 8);
	signal ps2_code_new : std_logic;
begin

	l_bc : button_controller port map(
		clk		  => clk_button,
		button_in  => button_in,
		button_out => button_out
		); --оператор создания компонентов, добавлять port map и/или generic map
	l_fc : frequency_controller port map(
		clk	        => clk,
		clk_button    => clk_button,
		clk_main      => clk_main,
		clk_ps2       => clk_ps2,
		clk_indicator => clk_indicator
		);
	l_ps2 : PS2_controller port map(
		clk	=> clk,
		ps2_clk	=> ps2_clk,
		ps2_data => ps2_data,
		ps2_code_new => ps2_code_new,
		ps2_code => ps2_code
	);
end rtl;
