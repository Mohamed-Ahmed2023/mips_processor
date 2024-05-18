LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY Tb_Alu_Control IS
END Tb_Alu_Control;

ARCHITECTURE Behavioral OF Tb_Alu_Control IS
	SIGNAL Tb_funct : STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Tb_alu_op : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Tb_alu_ctrl : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN
	utt : ENTITY work.ALU_Control(Behavioral) PORT MAP (
		funct => Tb_funct,
		alu_op => Tb_alu_op,
		alu_ctrl => Tb_alu_ctrl
		);
	PROCESS
	BEGIN
		Tb_alu_op <= "001"; --010
		Tb_funct <= "100000";
		WAIT FOR 50ns;

		Tb_alu_op <= "001"; --101
		Tb_funct <= "000000";
		WAIT FOR 50ns;

		Tb_alu_op <= "001"; --110
		Tb_funct <= "100010";
		WAIT FOR 50ns;

		Tb_alu_op <= "001"; --001
		Tb_funct <= "100101";
		WAIT FOR 50ns;

		Tb_alu_op <= "001"; --111
		Tb_funct <= "101010";
		WAIT FOR 50ns;

	END PROCESS;
END Behavioral;