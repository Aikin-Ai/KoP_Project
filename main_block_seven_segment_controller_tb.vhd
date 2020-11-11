library ieee;
use ieee.std_logic_1164.all;

entity main_block_seven_segment_controller_tb is
end entity;

architecture rtl of main_block_seven_segment_controller_tb is
	component main_block is
		port(
			clk             : in  std_logic;
			button_in       : in  std_logic;
			ps2_code_in     : in  std_logic_vector(7 downto 0);
			ps2_code_new_in : in  std_logic;
			ps2_reset		 : out  std_logic;
			indicator_out   : out std_logic_vector(15 downto 0);
			nios            : in  std_logic_vector(31 downto 0);
			nios2           : in  std_logic_vector(31 downto 0);
			nios3           : in  std_logic_vector(31 downto 0);
			ready_7_control : out std_logic
		);

	end component;
	signal clk		     		:  std_logic;
	signal button_in	  		:  std_logic;
	signal ps2_code_in  		:  std_logic_vector(7 downto 0);
	signal ps2_code_new_in  :  std_logic;
	signal ps2_reset     	:  std_logic;
	signal indicator_out  	:  std_logic_vector(15 downto 0);
	signal nios  				:  std_logic_vector(31 downto 0);
	signal nios2  				:  std_logic_vector(31 downto 0);
	signal nios3  				:  std_logic_vector(31 downto 0);
	signal ready_7_control  :  std_logic;
	
	component seven_segment_controller is
		port(
		ready_in     : in  std_logic;
		clk          : in  std_logic;
		indicator_in : in  std_logic_vector(15 downto 0);
		data_out     : out std_logic;
		sck          : out std_logic;
		ready_out    : out std_logic
		);

	end component;
	signal data_out     :  std_logic;
	signal sck     	  :  std_logic;
	signal ready_out    :  std_logic;

begin
	inst0 : main_block port map(clk, button_in, ps2_code_in, ps2_code_new_in, ps2_reset, indicator_out, nios, nios2, nios3, ready_7_control);
	inst1 : seven_segment_controller port map(ready_7_control, clk, indicator_out, data_out, sck, ready_out);
	process
	begin
			clk <= '0';
			wait for 50 ps;
			clk <= '1';
			wait for 50 ps;
	end process;
	process
	begin
		ps2_code_in <= "00010110";
		ps2_code_new_in <= '1';
		wait for 100 ps;
		ps2_code_new_in <= '0';
		wait for 6000 ps;
		ps2_code_in <= "00000000";
		ps2_code_new_in <= '1';
		wait for 100 ps;
		ps2_code_new_in <= '0';
		wait for 6400 ps;
	end process;
	
end rtl;
