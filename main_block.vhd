library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main_block is

	port(
		clk             : in  std_logic;
		button_in       : in  std_logic;
		ps2_code_in     : in  std_logic_vector(7 downto 0);
		ps2_code_new_in : in  std_logic;
		ps2_reset		 : out  std_logic;
		indicator_out   : out std_logic_vector(15 downto 0);
		nios            : out  std_logic_vector(31 downto 0);
		nios2           : in  std_logic_vector(31 downto 0);
		nios3           : in  std_logic;
		result_out 		: out std_logic_vector(31 downto 0);
		ready_7_control : out std_logic
	);

end main_block;

architecture rtl of main_block is
	component segments_converter_manager
	
	port(
		clk 						: in std_logic;
		button_in       		: in  std_logic;
		ps2_code_new_in		: in std_logic;
		ps2_code_in   		   : in  std_logic_vector(7 downto 0);
		indicator_out		   : out std_logic_vector(15 downto 0);
		ready_7_control 		: out std_logic
	);

	end component segments_converter_manager;
begin
	l_s_c : segments_converter_manager
	port map(
		clk     => clk,
		button_in => button_in,
		ps2_code_new_in => ps2_code_new_in,
		ps2_code_in => ps2_code_in,
		indicator_out => indicator_out,
		ready_7_control => ready_7_control
	);
	ps2_reset <= button_in;
	process(ps2_code_new_in)
	begin
		nios(31 downto 24) <= ps2_code_in;
		nios(23 downto 0) <= (others => '0');
	end process;
	process(nios2)
	begin
		result_out <= nios2;
	end process;
end rtl;
