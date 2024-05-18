
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Data_Memory_Testbench IS
END Data_Memory_Testbench;

ARCHITECTURE Data_Memory_Testbench OF Data_Memory_Testbench IS

	COMPONENT Data_Memory
		PORT (
			clk : IN STD_LOGIC;
			MemRead, MemWrite : IN STD_LOGIC;
			Address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			WriteData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			ReadData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL clk : STD_LOGIC := '0';
	SIGNAL MemRead, MemWrite : STD_LOGIC := '0';
	SIGNAL Address : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL WriteData : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL ReadData : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

	CONSTANT clk_period : TIME := 10 ns;

BEGIN

	tree : Data_Memory PORT MAP(
		clk => clk,
		MemRead => MemRead,
		MemWrite => MemWrite,
		Address => Address,
		WriteData => WriteData,
		ReadData => ReadData
	);

	-- clk process
	PROCESS
	BEGIN
		clk <= '0';
		WAIT FOR clk_period/2;
		clk <= '1';
		WAIT FOR clk_period/2;
	END PROCESS;

	PROCESS
	BEGIN

		WAIT FOR clk_period * 10;

		MemRead <= '1';
		MemWrite <= '0';
		Address <= x"0000_0000";
		WriteData <= x"0000_0000";

		WAIT FOR clk_period * 10;

		Address <= x"0000_0004";

		WAIT FOR clk_period * 10;
		----------------------------
		MemRead <= '0';
		MemWrite <= '1';
		writeData <= x"0000_1111";

		WAIT FOR clk_period * 10;
		----------------------------
		MemWrite <= '0';
		MemRead <= '1';
		writeData <= x"0000_0000";

		WAIT;
	END PROCESS;

END Data_Memory_Testbench;