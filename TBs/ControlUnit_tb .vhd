LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ControlUnit_tb IS
    -- Testbench has no ports
END ControlUnit_tb;

ARCHITECTURE Behavioral OF ControlUnit_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT ControlUnit IS
        PORT (
            OpCode : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
            MemtoReg : OUT STD_LOGIC;
            MemWrite : OUT STD_LOGIC;
            MemRead : OUT STD_LOGIC;
            Branch : OUT STD_LOGIC;
            AluSrc : OUT STD_LOGIC;
            RegDst : OUT STD_LOGIC;
            RegWrite : OUT STD_LOGIC;
            AluOp : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        );
    END COMPONENT;

    -- Signals to connect to UUT
    SIGNAL OpCode : STD_LOGIC_VECTOR (5 DOWNTO 0) := (OTHERS => '0');
    SIGNAL MemtoReg : STD_LOGIC;
    SIGNAL MemWrite : STD_LOGIC;
    SIGNAL MemRead : STD_LOGIC;
    SIGNAL Branch : STD_LOGIC;
    SIGNAL AluSrc : STD_LOGIC;
    SIGNAL RegDst : STD_LOGIC;
    SIGNAL RegWrite : STD_LOGIC;
    SIGNAL AluOp : STD_LOGIC_VECTOR (2 DOWNTO 0);

BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut : ControlUnit PORT MAP(
        OpCode => OpCode,
        MemtoReg => MemtoReg,
        MemWrite => MemWrite,
        MemRead => MemRead,
        Branch => Branch,
        AluSrc => AluSrc,
        RegDst => RegDst,
        RegWrite => RegWrite,
        AluOp => AluOp
    );

    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        -- Test case 1: R-type instruction (e.g., jr)
        OpCode <= "000000";
        WAIT FOR 100 ns;
        -- Check outputs expected for R-type instruction
        ASSERT (RegDst = '1' AND Branch = '0' AND MemRead = '0' AND MemtoReg = '0' AND MemWrite = '0' AND AluSrc = '0' AND RegWrite = '1' AND AluOp = "001") REPORT "Test case 1 failed" SEVERITY error;

        -- Test case 2: Branch on equal (beq)
        OpCode <= "000100";
        WAIT FOR 100 ns;
        -- Check outputs expected for beq
        ASSERT (RegDst = '0' AND Branch = '1' AND MemRead = '0' AND MemtoReg = '0' AND MemWrite = '0' AND AluSrc = '0' AND RegWrite = '0' AND AluOp = "010") REPORT "Test case 2 failed" SEVERITY error;

        -- Test case 3: Add immediate (addi)
        OpCode <= "001000";
        WAIT FOR 100 ns;
        -- Check outputs expected for addi
        ASSERT (RegDst = '0' AND Branch = '0' AND MemRead = '0' AND MemtoReg = '0' AND MemWrite = '0' AND AluSrc = '1' AND RegWrite = '1' AND AluOp = "000") REPORT "Test case 3 failed" SEVERITY error;

        -- Test case 4: OR immediate (ori)
        OpCode <= "001101";
        WAIT FOR 100 ns;
        -- Check outputs expected for ori
        ASSERT (RegDst = '0' AND Branch = '0' AND MemRead = '0' AND MemtoReg = '0' AND MemWrite = '0' AND AluSrc = '1' AND RegWrite = '1' AND AluOp = "011") REPORT "Test case 4 failed" SEVERITY error;

        -- Test case 5: Load upper immediate (lui)
        OpCode <= "001111";
        WAIT FOR 100 ns;
        -- Check outputs expected for lui
        ASSERT (RegDst = '0' AND Branch = '0' AND MemRead = '0' AND MemtoReg = '0' AND MemWrite = '0' AND AluSrc = '1' AND RegWrite = '1' AND AluOp = "100") REPORT "Test case 5 failed" SEVERITY error;

        -- Test case 6: Load word (lw)
        OpCode <= "100011";
        WAIT FOR 100 ns;
        -- Check outputs expected for lw
        ASSERT (RegDst = '0' AND Branch = '0' AND MemRead = '1' AND MemtoReg = '1' AND MemWrite = '0' AND AluSrc = '1' AND RegWrite = '1' AND AluOp = "000") REPORT "Test case 6 failed" SEVERITY error;

        -- Test case 7: Store word (sw)
        OpCode <= "101011";
        WAIT FOR 100 ns;
        -- Check outputs expected for sw
        ASSERT (RegDst = '0' AND Branch = '0' AND MemRead = '0' AND MemtoReg = '0' AND MemWrite = '1' AND AluSrc = '1' AND RegWrite = '0' AND AluOp = "000") REPORT "Test case 7 failed" SEVERITY error;

        -- Test case 8: Default case (invalid OpCode)
        OpCode <= "111111";
        WAIT FOR 100 ns;
        -- Check outputs expected for default case
        ASSERT (RegDst = '0' AND Branch = '0' AND MemRead = '0' AND MemtoReg = '0' AND MemWrite = '0' AND AluSrc = '0' AND RegWrite = '0' AND AluOp = "000") REPORT "Test case 8 failed" SEVERITY error;

        WAIT;
    END PROCESS;

END Behavioral;