LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux_32bits IS
	PORT (
		selector : IN STD_LOGIC; -- selector line
		input_1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- input 1
		input_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- input 2
		output : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) -- output
	);
END mux_32bits;

ARCHITECTURE Behavioral OF mux_32bits IS
BEGIN
	output <= input_1 WHEN (selector = '0') ELSE
		input_2;
END Behavioral;