library ieee;
use ieee.std_logic_1164.all;

entity button_controller_tb is
end button_controller_tb;

architecture rtl of button_controller_tb is
    component button_controller is

        port(
            clk        : in  std_logic;
            button_in  : in  std_logic;
            button_out : out std_logic
        );

    end component button_controller;
    signal clk        : std_logic;
    signal button_in  : std_logic;
    signal button_out : std_logic;
begin
    inst0 : button_controller port map(clk, button_in, button_out);
    process
    begin
        clk <= '0';
        wait for 500 us;
        clk <= '1';
        wait for 500 us;
    end process;
    process
    begin
        button_in <= '0';
        wait for 10 ms;
        button_in <= '1';
        wait for 5 ms;
        button_in <= '0';
        wait for 4 ms;
        button_in <= '1';
        wait for 9 ms;
        button_in <= '0';
        wait for 15 ms;
        button_in <= '1';
        wait for 200 ms;
        button_in <= '0';
        wait for 400 ms;
    end process;
end rtl;
