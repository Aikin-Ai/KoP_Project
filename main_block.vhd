library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main_block is

	port(
		clk             : in  std_logic;
		button_in       : in  std_logic;
		ps2_code_in     : in  std_logic_vector(7 downto 0);
		ps2_code_new_in : in  std_logic;
		ps2_reset		: out std_logic;
		indicator_out   : out std_logic_vector(7 downto 0);
		nios            : in  std_logic_vector(31 downto 0);
		nios2           : in  std_logic_vector(31 downto 0);
		nios3           : in  std_logic_vector(31 downto 0);
		ready_7_control : out std_logic
	);

end main_block;

architecture rtl of main_block is
	function SegmentsConverter(data : in std_logic_vector(7 downto 0)) return std_logic_vector is
	begin
		case data is
			when "00000000" => return "11011110";
			when "00000001" => return "10001000";
			when "00000010" => return "11100110";
			when "00000011" => return "11101010";
			when "00000100" => return "10111000";
			when "00000101" => return "01111010";
			when "00000110" => return "01111110";
			when "00000111" => return "11001000";
			when "00001000" => return "11111110";
			when "00001001" => return "11111010";
			when "00001010" => return "11111100";
			when "00001011" => return "00111110";
			when "00001100" => return "01010110";
			when "00001101" => return "10101110";
			when "00001110" => return "01110110";
			when "00001111" => return "01110100";
			when others 	 => return "XXXXXXXX";
		end case;
	end function;
	signal tmp_indicator_out : std_logic_vector(7 downto 0);
begin
	process(clk) is
	begin
		if (ps2_code_new_in = '1') then
			ready_7_control <= '1';
			indicator_out <= SegmentsConverter(std_logic_vector(unsigned(ps2_code_in) rem 10));
			ready_7_control <= '0';
			tmp_indicator_out <= std_logic_vector(unsigned(ps2_code_in) / 10);
			ready_7_control <= '1';
			indicator_out <= SegmentsConverter(std_logic_vector(unsigned(tmp_indicator_out) rem 10));
		end if;
	end process;

end rtl;
