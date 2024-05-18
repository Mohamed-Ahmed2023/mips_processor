
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Data_Memory IS
	PORT (
		clk : IN STD_LOGIC;
		MemRead, MemWrite : IN STD_LOGIC;
		Address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		WriteData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		ReadData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END Data_Memory;

ARCHITECTURE Data_Memory OF Data_Memory IS
BEGIN
	PROCESS (clk, MemRead, Address)

		SUBTYPE Register0 IS STD_LOGIC_VECTOR(31 DOWNTO 0);
		TYPE REG_Bank IS ARRAY(31 DOWNTO 0) OF Register0;
		VARIABLE DataMemory : REG_Bank := (
			x"0000_0003",
			x"0000_0004",
			x"0000_0005",
			x"0000_0006",
			OTHERS => (OTHERS => '0')
		);

	BEGIN
		IF falling_edge(clk) THEN
			IF (MemWrite = '1') THEN
				ReadData <= (OTHERS => '0');
				DataMemory(To_Integer(unsigned(Address(6 DOWNTO 2)))) := WriteData;
			END IF;
		END IF;
		IF (MemRead = '1') THEN
			ReadData <= DataMemory(To_Integer(unsigned(Address(6 DOWNTO 2))));
		END IF;

	END PROCESS;

END Data_Memory;