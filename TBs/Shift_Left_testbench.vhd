LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Shift_Left_testbench IS
END Shift_Left_testbench;

ARCHITECTURE Behavioral OF Shift_Left_testbench IS
    COMPONENT Shift_left_2
        PORT (
            input : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL input : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL output : STD_LOGIC_VECTOR (31 DOWNTO 0);
BEGIN
    ss : Shift_left_2 PORT MAP(input => input, output => output);
    PROCESS
    BEGIN
        input <= X"ffffffff";
        WAIT FOR 100ns;
        input <= X"fffffffC";
        WAIT FOR 100ns;
    END PROCESS;
END Behavioral;