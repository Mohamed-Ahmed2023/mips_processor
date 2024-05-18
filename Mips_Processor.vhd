library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity  Mips_Processor is port (
		clk : in std_logic;
		reset: in std_logic );
end Mips_Processor;

Architecture behave of Mips_Processor is 
	
	
	signal pc_Mux , pc_instruction : std_logic_vector(31 downto 0);
	signal instruction_output : std_logic_vector(31 downto 0 ); 
	signal opcode :std_logic_vector(5 downto 0 ); 
	signal rs : std_logic_vector( 4 downto 0  ) ;
	signal rt : std_logic_vector( 4 downto 0  ) ; 
	signal rd : std_logic_vector( 4 downto 0  ) ;
	signal fun_extend : std_logic_vector(5 downto 0 ) ;
	signal immediate  : std_logic_vector(15 downto 0 );
	signal sign_extend_output : std_logic_vector(31 downto 0);
	signal write_Data : std_logic_vector(31 downto 0 );
	signal readData1 , readData2 : std_logic_vector(31 downto 0); 
	signal mux_Reg : std_logic_vector(4 downto 0 ); 
	signal mux_Alu : std_logic_vector(31 downto 0);
	signal alu_alu_control : std_logic_vector( 2 downto 0); 
	signal zero : 	 std_logic;
	signal alu_result : std_logic_vector(31 downto 0);
	signal shift_adder : std_logic_vector(31 downto 0);
	signal adder_mux :  std_logic_vector(31 downto 0);	
	signal and_out : std_logic;
	signal memory_mux:std_logic_vector(31 downto 0);	 	   
	signal  MemtoReg ,MemWrite,  Branch , AluSrc , RegDst ,  RegWrite , MemRead :std_logic; 
	signal   AluOp : std_logic_vector(2 downto 0); 
	signal   next_pc :std_logic_vector(31 downto 0);
	signal   increment : std_logic_vector(31 downto 0 ) := ( 2=>'1' , others=> '0');  
	
	
	
												
	component PC is						
		
		Port ( clk : 
		in  STD_LOGIC;						  	
			reset : in  STD_LOGIC;
			din : in  STD_LOGIC_VECTOR (31 downto 0);
			dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component ;
	--component and_gate is 
--		port (
--			a , b :in std_logic;
--			c :out std_logic
--			) ;
--	end component;
--	
--	--** instruction memory
	
	component instruction_memory is
		port(  
		
			READ_ADDRESS : in std_logic_vector(31 downto 0);
			INSTRUCTION : out std_logic_vector(31 downto 0)
			);
	end component ; 
	--Mux 32 bit
	component mux_32bits is 
		port (
			selector: in std_logic; -- selector line
			input_1: in std_logic_vector (31 downto 0); -- input 1
			input_2: in std_logic_vector (31 downto 0); -- input 2
			output: out std_logic_vector (31 downto 0) 	-- output
			);
	end component ; 
	component mux_5bits is 
		port (
			selector: in std_logic; -- selector line
			input_1: in std_logic_vector (4 downto 0); -- input 1
			input_2: in std_logic_vector (4 downto 0); -- input 2
			output: out std_logic_vector (4 downto 0)  -- output
			);
	end component ;
	--Control unit	  
	
	component ControlUnit is
		Port ( OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
			--  Funct  : in  STD_LOGIC_VECTOR (5 downto 0);
			MemtoReg : out  STD_LOGIC;
			
			MemWrite : out  STD_LOGIC;
			MemRead  : out STD_LOGIC;
			Branch :  out  STD_LOGIC;
			AluSrc : out  STD_LOGIC;
			RegDst : out  STD_LOGIC;
			RegWrite : out  STD_LOGIC;
			-- Jump : out std_logic;
			AluOp : out  STD_LOGIC_VECTOR (2 downto 0));
	end component ;
	-- ALU control 
	component  Alu_Control is
		port (
			funct : in std_logic_vector(5 downto 0);
			alu_op: in std_logic_vector(2 downto 0);
			alu_ctrl: out std_logic_vector(2 downto 0)
			--JR: out std_logic
			);
	end component;  
	 
	--Data Memory
	component Data_Memory is	
		port(		  
			clk     :in  std_logic;
			
			MemRead,MemWrite :in  std_logic;	 
			Address          :in  std_logic_vector(31 downto 0);	
			WriteData        :in  std_logic_vector(31 downto 0); 
			ReadData         :out std_logic_vector(31 downto 0)
			);
	end component ; 
	--shift left 2 bit
	component Shift_left_2 is
		port (		
		
			input : in  std_logic_vector (31 downto 0);
			output : out  std_logic_vector (31 downto 0)
			); 
	end component ;
	-- sign Extend
	component SignExtend is
		Port ( INPUT : in  STD_LOGIC_VECTOR (15 downto 0);
			OUTPUT :  out  STD_LOGIC_VECTOR (31 downto 0));
	end component ; 
	--Alu 
	component  alu is
		port (
			a : in std_logic_vector(31 downto 0);
			b : in std_logic_vector(31 downto 0);
			cntrl : in std_logic_vector(2 downto 0);
			zero : out std_logic;
			result : out std_logic_vector(31 downto 0)
			);
	end component ;	
	component adder IS
		port (a : in std_logic_vector(31 downto 0);
			b : in std_logic_vector(31 downto 0);
			c : out std_logic_vector(31 downto 0));
	end component ; 
	component Registers is port(
			clk,rst,rw: IN std_logic;	
			readRg1,readRg2,writeRg:IN std_logic_vector(4 downto 0);
			readData1,readData2:  out std_logic_vector(31 downto 0);
			writeData: IN std_logic_vector(31 downto 0)
			
			);
	end component;
	
begin 
	
	opcode <= instruction_output(31 downto 26);
	rs <= instruction_output(25 downto 21);
	rt <= instruction_output(20 downto 16);
	rd <= instruction_output(15 downto 11);
	fun_extend <= instruction_output(5 downto 0);
	immediate <= instruction_output(15 downto 0);
	and_out<= zero and Branch;
	

	
	pc_map: PC port map (clk , reset , next_pc , pc_instruction);
	instruction_map : instruction_memory port map(pc_instruction ,instruction_output);
	control_map : ControlUnit port map(Opcode,MemtoReg ,MemWrite,MemRead, Branch , AluSrc , RegDst ,  RegWrite  ,AluOp);
	pc_adder :	adder port map(pc_instruction ,"00000000000000000000000000000001", next_pc );
	mux_reg5 : 	mux_5bits port map(RegDst , rt , rd , mux_Reg );
	Reg_file : Registers port map (clk , reset ,RegWrite , rs , rt ,mux_Reg , readData1 , readData2 ,write_Data );
	sign_extend :  SignExtend port map(immediate ,sign_extend_output);
	mux_alu_map : mux_32bits port map(AluSrc , readData2 ,sign_extend_output , mux_Alu);
	Alu_contol_map:Alu_Control port map(fun_extend , AluOp , alu_alu_control ); 
	Alu_map:alu port map (readData1 ,mux_Alu,alu_alu_control , zero , alu_result );
	shift_l:	Shift_left_2 port map(sign_extend_output , shift_adder ); 
	adder_mux_map :adder port map(next_pc,shift_adder,adder_mux);
	
	--and_map:and_gate port map(Branch , zero ,and_out ); 
	last_mux_map : mux_32bits port map(and_out , next_pc  , adder_mux  , pc_Mux );
	
	data_memory_map:Data_Memory port map(clk ,MemRead ,MemWrite, alu_result ,readData2,memory_mux );
	data_memory_mux :mux_32bits port map(MemtoReg , alu_result , memory_mux ,write_Data ) ;
	
	
	
end behave;
























