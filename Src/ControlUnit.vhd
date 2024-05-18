LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ControlUnit IS
	PORT (
		OpCode : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		MemtoReg : OUT STD_LOGIC;
		MemWrite : OUT STD_LOGIC;
		MemRead : OUT STD_LOGIC;
		Branch : OUT STD_LOGIC;
		AluSrc : OUT STD_LOGIC;
		RegDst : OUT STD_LOGIC;
		RegWrite : OUT STD_LOGIC;
		AluOp : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
END ControlUnit;
ARCHITECTURE Behavioral OF ControlUnit IS
	SIGNAL aux : STD_LOGIC_VECTOR (9 DOWNTO 0) := (OTHERS => '0');
BEGIN
	WITH OpCode SELECT
		aux <= "1000001001" WHEN "000000", -- R format

		"0100000010" WHEN "000100", -- beq
		"0000011000" WHEN "001000", -- addi
		"0000011011" WHEN "001101", -- ori
		"0000011100" WHEN "001111", -- lui
		"0011011000" WHEN "100011", -- lw
		"0000110000" WHEN "101011", -- sw
		"0000000000" WHEN OTHERS;

	RegDst <= aux(9);
	Branch <= aux(8);
	MemRead <= aux(7);
	MemtoReg <= aux(6);
	MemWrite <= aux(5);
	AluSrc <= aux(4);
	RegWrite <= aux(3);
	AluOp <= aux(2 DOWNTO 0);
END Behavioral;