library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity segments_converter_manager is

	port(
		clk 						: in std_logic;
		button_in       		: in  std_logic;
		ps2_code_new_in		: in std_logic;
		ps2_code_in    	   : in  std_logic_vector(7 downto 0);
		indicator_out 			: out std_logic_vector(15 downto 0);
		ready_7_control 		: out std_logic
	);

end segments_converter_manager;

architecture rtl of segments_converter_manager is
	function SegmentsConverter(data : in std_logic_vector(3 downto 0)) return std_logic_vector is
	begin
		case data is
			when "0000" => return "01111011";
			when "0001" => return "00010001";
			when "0010" => return "01100111";
			when "0011" => return "01010111";
			when "0100" => return "00011101";
			when "0101" => return "01011110";
			when "0110" => return "01111110";
			when "0111" => return "00010011";
			when "1000" => return "01111111";
			when "1001" => return "01011111";
			when "1010" => return "00111111";
			when "1011" => return "01111100";
			when "1100" => return "01101010";
			when "1101" => return "01110101";
			when "1110" => return "01101110";
			when "1111" => return "00101110";
			when others 	 => return "XXXXXXXX";
		end case;
	end function;
begin
	process(clk) is
		variable i: integer := 0;
		variable j: integer := 0;
	begin
		if (button_in = '1') then
			indicator_out <= "0000000000000000";
			
			if (j>0) then
				ready_7_control <= '1';
			else
				ready_7_control <= '0';
				j:=j+1;
			end if;
		else
			ready_7_control <= '0';
			j:=0;
			if (ps2_code_new_in = '1') then
				indicator_out(15 downto 8) <= SegmentsConverter(ps2_code_in(7 downto 4));
				indicator_out(7 downto 0) <= SegmentsConverter(ps2_code_in(3 downto 0));
				if (i>0) then
					ready_7_control <= '0';
				else
					ready_7_control <= '1';
					i:=i+1;
				end if;
			else
				ready_7_control <= '0';
				i:=0;
			end if;
		end if;
	end process;

end rtl;
