library ieee;
use ieee.std_logic_1164.all;

entity top_level_model_tb is
end entity;

architecture rtl of top_level_model_tb is
    component top_level_model is
        port(
            clk                   : in  std_logic;
            clk_ps2               : in  std_logic;
            button_in             : in  std_logic;
            indicator_out_display : out std_logic;
            clk_display           : out std_logic;
            ps2_data              : in  std_logic;
            ready_disp            : out std_logic
        );
    end component;
    signal clk                   : std_logic;
    signal clk_ps2               : std_logic;
    signal button_in             : std_logic;
    signal indicator_out_display : std_logic;
    signal clk_display           : std_logic;
    signal ps2_data              : std_logic;
    signal ready_disp            : std_logic;

begin
    inst0 : top_level_model port map(clk, clk_ps2, button_in, indicator_out_display, clk_display, ps2_data, ready_disp);
    process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;
    process
    begin
        clk_ps2 <= '1';
        wait for 100 us;
        for i in 1 to 11 loop
            clk_ps2 <= '1';
            wait for 50 us;
            clk_ps2 <= '0';
            wait for 50 us;
        end loop;
        clk_ps2 <= '1';
        wait for 700 us;
    end process;
    process
    begin
        button_in <= '0';               --Начальное состояние
        ps2_data  <= '1';
        wait for 100 us;
        ps2_data  <= '0';               --Обозначение начала передачи
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

        ps2_data <= '1';                --Хэш код переданного числа (XOR всех цифр)
        wait for 100 us;

        ps2_data  <= '1';               --Обозначение окончания передачи
        wait for 400 us;
        button_in <= '1';               --Сброс
        wait for 400 us;
    end process;
end rtl;
