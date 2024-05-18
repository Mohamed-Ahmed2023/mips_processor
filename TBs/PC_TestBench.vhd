LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY PC_Testbench IS
END PC_Testbench;

ARCHITECTURE Behavioral OF PC_Testbench IS
	COMPONENT PC
		PORT (
			clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			din : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			dout : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;
	SIGNAL clk : STD_LOGIC;
	SIGNAL reset : STD_LOGIC;
	SIGNAL din : STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL dout : STD_LOGIC_VECTOR (31 DOWNTO 0);

BEGIN
	pcc : PC PORT MAP(clk => clk, reset => reset, din => din, dout => dout);
	PROCESS
	BEGIN
		clk <= '1';
		WAIT FOR 100ns;
		Clk <= '0';
		WAIT FOR 100ns;
	END PROCESS;
	PROCESS
	BEGIN
		reset <= '0';
		din <= x"ffffffff";
		WAIT FOR 100ns;
		reset <= '1';
		din <= x"ffffcccc";
		WAIT FOR 100ns;
		reset <= '1';
		din <= x"ffffccca";
		WAIT FOR 100ns;
		reset <= '1';
		din <= x"ffffcccf";
		WAIT FOR 100ns;
	END PROCESS;
END Behavioral;