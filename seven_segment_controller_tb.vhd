library ieee;
use ieee.std_logic_1164.all;

entity seven_segment_controller_tb is
end entity;

architecture rtl of seven_segment_controller_tb is
	component seven_segment_controller is
		port(
		ready_in     : in  std_logic;
		clk          : in  std_logic;
		indicator_in : in  std_logic_vector(7 downto 0);
		data_out     : out std_logic;
		sck          : out std_logic;
		ready_out    : out std_logic
		);

	end component;
	signal ready_in     :  std_logic;
	signal clk		     :  std_logic;
	signal indicator_in :  std_logic_vector(7 downto 0);
	signal data_out     :  std_logic;
	signal sck     	  :  std_logic;
	signal ready_out    :  std_logic;

begin
	inst0 : seven_segment_controller port map(ready_in, clk, indicator_in, data_out, sck, ready_out);
	process
	begin
			clk <= '0';
			wait for 50 ps;
			clk <= '1';
			wait for 50 ps;
	end process;
	process
	begin
		indicator_in <= "00010001";
		ready_in <= '0';
		wait for 3000 ps;
		ready_in <= '1';
		wait for 100 ps;
		ready_in <= '0';
		indicator_in <= "01111011";
		wait for 3200 ps;
		ready_in <= '1';
		wait for 100 ps;
		ready_in <= '0';
	end process;
	
end rtl;
