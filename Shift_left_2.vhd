library ieee;
use ieee.std_logic_1164.ALL;

entity Shift_left_2 is
    port (
        input : in  std_logic_vector (31 downto 0);
        output : out  std_logic_vector (31 downto 0)
    );
end Shift_left_2;

architecture Behavioral of Shift_left_2 is

begin
    output <= input(29 downto 0) & "00";
end Behavioral;