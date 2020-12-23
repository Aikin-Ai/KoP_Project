library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity button_controller is
    generic(
        clk_freq    : integer := 1_000;
        stable_time : integer := 10
    );
    port(
        clk        : in  std_logic;
        button_in  : in  std_logic;
        button_out : out std_logic
    );

end button_controller;

architecture rtl of button_controller is
    signal flipflops   : std_logic_vector(1 downto 0);
    signal counter_set : std_logic;
begin
    counter_set <= flipflops(0) xor flipflops(1);
    process(clk)
        variable count : integer range 0 to clk_freq * stable_time / 1000;
    begin
        if (clk'event and clk = '1') then
            flipflops(0) <= button_in;
            flipflops(1) <= flipflops(0);
            if (counter_set = '1') then
                count := 0;
            elsif (count < clk_freq * stable_time / 1000) then
                count := count + 1;
            else
                button_out <= flipflops(1);
            end if;
        end if;
    end process;
end rtl;
