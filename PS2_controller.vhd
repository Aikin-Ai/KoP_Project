library ieee;
use ieee.std_logic_1164.all;

entity PS2_controller is

	port(
		clk          : in  std_logic;
		reset        : in  std_logic;
		ps2_data     : in  std_logic;
		ps2_code_new : out std_logic;
		ps2_code     : out std_logic_vector(7 downto 0)
	);

end PS2_controller;

architecture rtl of PS2_controller is

	type state_type is (start, s0, s1, s2, s3, s4, s5, s6, s7, p, stop);

	signal state : state_type;

	signal tmp : std_logic_vector(7 downto 0);

begin

	process (clk, reset)
	begin
		if reset = '1' then
			state <= start;
		elsif (clk'event and clk = '0') then
			case state is
				when start => 
					if(ps2_data = '0') then
						state <= s0;
					else
						state <= start;
					end if;
				when s0 => state <= s1;
				when s1 => state <= s2;
				when s2 => state <= s3;
				when s3 => state <= s4;
				when s4 => state <= s5;
				when s5 => state <= s6;
				when s6 => state <= s7;
				when s7 => state <= p;
				when p => state <= stop;
				when stop => state <= start;
			end case;
		end if;
	end process;

	process (state)
	begin
		ps2_code <= (others => '0');
		case state is
			when start => ps2_code_new <= '0';
			when s0 => tmp(0) <= ps2_data; ps2_code_new <= '0';
			when s1 => tmp(1) <= ps2_data; ps2_code_new <= '0';
			when s2 => tmp(2) <= ps2_data; ps2_code_new <= '0';
			when s3 => tmp(3) <= ps2_data; ps2_code_new <= '0';
			when s4 => tmp(4) <= ps2_data; ps2_code_new <= '0';
			when s5 => tmp(5) <= ps2_data; ps2_code_new <= '0';
			when s6 => tmp(6) <= ps2_data; ps2_code_new <= '0';
			when s7 => tmp(7) <= ps2_data; ps2_code_new <= '0';
			when p => ps2_code_new <= '0';
			when stop => 
				if(ps2_data = '1') then
					ps2_code_new <= '1';
					ps2_code <= tmp;
				else ps2_code_new <= '0';
				end if;
		end case;
	end process;
end rtl;
