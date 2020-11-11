library ieee;
use ieee.std_logic_1164.all;

entity PS2_controller_tb is
end entity;

architecture rtl of PS2_controller_tb is
	component PS2_controller is

        port(
            clk          : in  std_logic;
            reset        : in  std_logic;
            ps2_data     : in  std_logic;
            ps2_code_new : out std_logic;
            ps2_code     : out std_logic_vector(7 downto 0)
        );
    
    end component;
	signal clk               :  std_logic;
	signal reset		     :  std_logic;
	signal ps2_data          :  std_logic;
	signal ps2_code_new      :  std_logic;
	signal ps2_code     	 :  std_logic_vector(7 downto 0);

begin
    inst0 : PS2_controller port map(clk, reset, ps2_data, ps2_code_new, ps2_code);
    process
        begin
            clk <= '1';
            wait for 100 us;
            for i in 1 to 11 loop
                clk <= '1';
                wait for 50 us;
                clk <= '0';
                wait for 50 us;
            end loop;
            clk <= '1';
            wait for 600 us;
    end process;
	process
        begin
            reset    <= '0'; --Начальное состояние
            ps2_data <= '1';
            wait for 100 us;
            ps2_data <= '0'; --Обозначение начала передачи
            wait for 100 us;

            ps2_data <= '0';
            wait for 100 us;
            ps2_data <= '0';
            wait for 100 us;
            ps2_data <= '1';
            wait for 100 us;
            ps2_data <= '1';
            wait for 100 us;
            ps2_data <= '0';
            wait for 100 us;
            ps2_data <= '0';
            wait for 100 us;
            ps2_data <= '1';
            wait for 100 us;
            ps2_data <= '0';
            wait for 100 us;

            ps2_data <= '1'; --Хэш код переданного числа (XOR всех цифр)
            wait for 100 us;

            ps2_data <= '1'; --Обозначение окончания передачи
            wait for 400 us;
            reset    <= '1'; --Сброс
            wait for 200 us;
	end process;
end rtl;