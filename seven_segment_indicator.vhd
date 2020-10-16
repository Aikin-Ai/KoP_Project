library ieee;
use ieee.std_logic_1164.all;

entity seven_segment_indicator is

	port(
		ready_in	 : in std_logic;
		clk          : in  std_logic;
		indicator_in : in  std_logic_vector(0 to 7);
		data_out     : out std_logic;
		sck          : out std_logic;
		ready_out	 : out std_logic
	);

end seven_segment_indicator;

architecture rtl of seven_segment_indicator is

begin

end rtl;
