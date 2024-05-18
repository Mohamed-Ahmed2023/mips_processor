library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shift_Left_testbench is
end Shift_Left_testbench;

architecture Behavioral of Shift_Left_testbench is
    component Shift_left_2
        port(
            input : in  std_logic_vector (31 downto 0);
            output : out  std_logic_vector (31 downto 0)
        );
    end component;

    signal input : std_logic_vector (31 downto 0);
    signal output : std_logic_vector (31 downto 0);
begin 
	ss: Shift_left_2 port map(input => input, output => output);
	process	 
	begin
	input <= X"ffffffff";
	wait for 100ns;
	input <= X"fffffffC";
	wait for 100ns;
end process;
end Behavioral;