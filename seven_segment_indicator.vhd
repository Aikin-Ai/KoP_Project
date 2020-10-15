library ieee;
use ieee.std_logic_1164.all;

entity seven_segment_indicator is

	port 
	(
		sck		  : in std_logic;
		indicator_in  : in std_logic_vector(0 to 7);
		data_out : out std_logic_vector(0 to 15)
	);

end seven_segment_indicator;

architecture rtl of seven_segment_indicator is

begin

	

end rtl;
