library ieee;
use ieee.std_logic_1164.all;

entity seven_segment_controller is

	port(
		ready_in     : in  std_logic;
		clk          : in  std_logic;
		indicator_in : in  std_logic_vector(7 downto 0);
		data_out     : out std_logic;
		sck          : out std_logic;
		ready_out    : out std_logic
	);

end seven_segment_controller;

architecture rtl of seven_segment_controller is

	type state_type is (state_start, state_data_out, state_sck_H, state_sck_L);
	signal state : state_type;
	signal data_to_slave: std_logic_vector(7 downto 0);
begin
	process(clk) is
		variable i: integer := 0;
	begin
		if (rising_edge(clk)) then 
			case state is
				when state_start =>
					data_out <= '0';
					sck <= '0';
					if (ready_in = '1') then
						state <= state_data_out;
						ready_out <= '1';
						data_to_slave <= indicator_in;
						i := 0;
					else
						ready_out <= '0';
					end if;
				when state_data_out =>
					if(i < 8) then
						state <= state_sck_H;
						data_out <= data_to_slave(i);
					else
						state <= state_start;
						ready_out <= '0';
					end if;
				when state_sck_H =>
					state <= state_sck_L;
					sck <= '1';
				when state_sck_L =>
					state <= state_data_out;
					sck <= '0';
					i := i + 1;
				end case;		
		end if;
	end process;
end rtl;
