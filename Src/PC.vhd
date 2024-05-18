LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY PC IS
	PORT (
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		din : IN STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
		dout : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
END PC;

ARCHITECTURE Behavioral OF PC IS
	SIGNAL temp : STD_LOGIC_VECTOR (31 DOWNTO 0);
BEGIN
	PROCESS (clk, reset)
	BEGIN
		IF (reset = '1') THEN
			temp <= (OTHERS => '0');
		ELSIF (clk'event AND clk = '1') THEN
			temp <= din;
		END IF;
	END PROCESS;
	dout <= temp;

END Behavioral;