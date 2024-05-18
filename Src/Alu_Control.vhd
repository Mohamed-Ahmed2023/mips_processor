LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Alu_Control IS
	PORT (
		funct : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		alu_op : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		alu_ctrl : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END Alu_Control;

ARCHITECTURE Behavioral OF Alu_Control IS
BEGIN

	alu_ctrl <= "010" WHEN (alu_op = "000") OR (alu_op = "001" AND funct = "100000")
		ELSE
		"101" WHEN (alu_op = "001" AND funct = "000000")
		ELSE
		"110" WHEN (alu_op = "001" AND funct = "100010") OR (alu_op = "010")
		ELSE
		"000" WHEN alu_op = "001" AND funct = "100100"
		ELSE
		"001" WHEN (alu_op = "001" AND funct = "100101") OR (alu_op = "011")
		ELSE
		"111" WHEN alu_op = "001" AND funct = "101010"
		ELSE
		"000" WHEN alu_op = "001" AND funct = "001000"
		ELSE
		"100" WHEN alu_op = "100";
END Behavioral;