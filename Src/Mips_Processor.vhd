LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY Mips_Processor IS PORT (
	clk : IN STD_LOGIC;
	reset : IN STD_LOGIC);
END Mips_Processor;

ARCHITECTURE behave OF Mips_Processor IS
	SIGNAL pc_Mux, pc_instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL instruction_output : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL opcode : STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL rs : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL rt : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL rd : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL fun_extend : STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL immediate : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL sign_extend_output : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL write_Data : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL readData1, readData2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL mux_Reg : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL mux_Alu : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL alu_alu_control : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL zero : STD_LOGIC;
	SIGNAL alu_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL shift_adder : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL adder_mux : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL and_out : STD_LOGIC;
	SIGNAL memory_mux : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL MemtoReg, MemWrite, Branch, AluSrc, RegDst, RegWrite, MemRead : STD_LOGIC;
	SIGNAL AluOp : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL next_pc : STD_LOGIC_VECTOR(31 DOWNTO 0);
	COMPONENT PC IS

		PORT (
			clk :
			IN STD_LOGIC;
			reset : IN STD_LOGIC;
			din : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			dout : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
	END COMPONENT;

	COMPONENT instruction_memory IS
		PORT (

			READ_ADDRESS : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			INSTRUCTION : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	--Mux 32 bit
	COMPONENT mux_32bits IS
		PORT (
			selector : IN STD_LOGIC; -- selector line
			input_1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- input 1
			input_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- input 2
			output : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) -- output
		);
	END COMPONENT;
	COMPONENT mux_5bits IS
		PORT (
			selector : IN STD_LOGIC; -- selector line
			input_1 : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- input 1
			input_2 : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- input 2
			output : OUT STD_LOGIC_VECTOR (4 DOWNTO 0) -- output
		);
	END COMPONENT;

	--Control unit	  
	COMPONENT ControlUnit IS
		PORT (
			OpCode : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
			--  Funct  : in  STD_LOGIC_VECTOR (5 downto 0);
			MemtoReg : OUT STD_LOGIC;

			MemWrite : OUT STD_LOGIC;
			MemRead : OUT STD_LOGIC;
			Branch : OUT STD_LOGIC;
			AluSrc : OUT STD_LOGIC;
			RegDst : OUT STD_LOGIC;
			RegWrite : OUT STD_LOGIC;
			AluOp : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
	END COMPONENT;
	-- ALU control 
	COMPONENT Alu_Control IS
		PORT (
			funct : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			alu_op : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			alu_ctrl : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
		);
	END COMPONENT;

	--Data Memory
	COMPONENT Data_Memory IS
		PORT (
			clk : IN STD_LOGIC;

			MemRead, MemWrite : IN STD_LOGIC;
			Address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			WriteData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			ReadData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	--shift left 2 bit
	COMPONENT Shift_left_2 IS
		PORT (

			input : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			output : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;
	-- sign Extend
	COMPONENT SignExtend IS
		PORT (
			INPUT : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			OUTPUT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
	END COMPONENT;
	--Alu 
	COMPONENT alu IS
		PORT (
			a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			cntrl : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			zero : OUT STD_LOGIC;
			result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT adder IS
		PORT (
			a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			c : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT;
	COMPONENT Registers IS PORT (
		clk, rst, rw : IN STD_LOGIC;
		readRg1, readRg2, writeRg : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		readData1, readData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		writeData : IN STD_LOGIC_VECTOR(31 DOWNTO 0)

		);
	END COMPONENT;

BEGIN

	opcode <= instruction_output(31 DOWNTO 26);
	rs <= instruction_output(25 DOWNTO 21);
	rt <= instruction_output(20 DOWNTO 16);
	rd <= instruction_output(15 DOWNTO 11);
	fun_extend <= instruction_output(5 DOWNTO 0);
	immediate <= instruction_output(15 DOWNTO 0);
	and_out <= zero AND Branch;

	pc_map : PC PORT MAP(clk, reset, next_pc, pc_instruction);
	instruction_map : instruction_memory PORT MAP(pc_instruction, instruction_output);
	control_map : ControlUnit PORT MAP(Opcode, MemtoReg, MemWrite, MemRead, Branch, AluSrc, RegDst, RegWrite, AluOp);
	pc_adder : adder PORT MAP(pc_instruction, "00000000000000000000000000000001", next_pc);
	mux_reg5 : mux_5bits PORT MAP(RegDst, rt, rd, mux_Reg);
	Reg_file : Registers PORT MAP(clk, reset, RegWrite, rs, rt, mux_Reg, readData1, readData2, write_Data);
	sign_extend : SignExtend PORT MAP(immediate, sign_extend_output);
	mux_alu_map : mux_32bits PORT MAP(AluSrc, readData2, sign_extend_output, mux_Alu);
	Alu_contol_map : Alu_Control PORT MAP(fun_extend, AluOp, alu_alu_control);
	Alu_map : alu PORT MAP(readData1, mux_Alu, alu_alu_control, zero, alu_result);
	shift_l : Shift_left_2 PORT MAP(sign_extend_output, shift_adder);
	adder_mux_map : adder PORT MAP(next_pc, shift_adder, adder_mux);

	last_mux_map : mux_32bits PORT MAP(and_out, next_pc, adder_mux, pc_Mux);

	data_memory_map : Data_Memory PORT MAP(clk, MemRead, MemWrite, alu_result, readData2, memory_mux);
	data_memory_mux : mux_32bits PORT MAP(MemtoReg, alu_result, memory_mux, write_Data);

END behave;