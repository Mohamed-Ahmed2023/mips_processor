library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port ( OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
           --Funct : in  STD_LOGIC_VECTOR (5 downto 0);
           MemtoReg : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
		   MemRead  : out STD_LOGIC;
           Branch : out  STD_LOGIC;
           AluSrc : out  STD_LOGIC;
           RegDst : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
		 
          -- Jump : out std_logic;
           AluOp : out  STD_LOGIC_VECTOR (2 downto 0));
end ControlUnit;

		
architecture Behavioral of ControlUnit is
	signal aux: std_logic_vector (9 downto 0) := (others => '0');
	begin
		with OpCode select 
			aux	<=	"1000001001" when "000000", -- R format, jr
					
					"0100000010" when "000100", -- beq
					"0000011000" when "001000", -- addi
					"0000011011" when "001101", -- ori
					"0000011100" when "001111", -- lui
					"0011011000" when "100011", -- lw
					"0000110000" when "101011", -- sw
					"0000000000" when others ;
					
			RegDst <= aux(9);
			--jump <= aux(9);
			Branch <= aux(8);
			MemRead <= aux(7);
			MemtoReg <= aux(6);
			MemWrite <= aux(5);
			AluSrc <= aux(4);
			RegWrite <= aux(3);
			AluOp <= aux(2 downto 0);
end Behavioral;