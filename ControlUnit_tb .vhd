library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit_tb is
-- Testbench has no ports
end ControlUnit_tb;

architecture Behavioral of ControlUnit_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component ControlUnit is
        Port (
            OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
            MemtoReg : out  STD_LOGIC;
            MemWrite : out  STD_LOGIC;
            MemRead  : out STD_LOGIC;
            Branch : out  STD_LOGIC;
            AluSrc : out  STD_LOGIC;
            RegDst : out  STD_LOGIC;
            RegWrite : out  STD_LOGIC;
            AluOp : out  STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal OpCode : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
    signal MemtoReg : STD_LOGIC;
    signal MemWrite : STD_LOGIC;
    signal MemRead  : STD_LOGIC;
    signal Branch : STD_LOGIC;
    signal AluSrc : STD_LOGIC;
    signal RegDst : STD_LOGIC;
    signal RegWrite : STD_LOGIC;
    signal AluOp : STD_LOGIC_VECTOR (2 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: ControlUnit Port Map (
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
    stim_proc: process
    begin
        -- Test case 1: R-type instruction (e.g., jr)
        OpCode <= "000000"; wait for 100 ns;
        -- Check outputs expected for R-type instruction
        assert (RegDst = '1' and Branch = '0' and MemRead = '0' and MemtoReg = '0' and MemWrite = '0' and AluSrc = '0' and RegWrite = '1' and AluOp = "001") report "Test case 1 failed" severity error;

        -- Test case 2: Branch on equal (beq)
        OpCode <= "000100"; wait for 100 ns;
        -- Check outputs expected for beq
        assert (RegDst = '0' and Branch = '1' and MemRead = '0' and MemtoReg = '0' and MemWrite = '0' and AluSrc = '0' and RegWrite = '0' and AluOp = "010") report "Test case 2 failed" severity error;

        -- Test case 3: Add immediate (addi)
        OpCode <= "001000"; wait for 100 ns;
        -- Check outputs expected for addi
        assert (RegDst = '0' and Branch = '0' and MemRead = '0' and MemtoReg = '0' and MemWrite = '0' and AluSrc = '1' and RegWrite = '1' and AluOp = "000") report "Test case 3 failed" severity error;

        -- Test case 4: OR immediate (ori)
        OpCode <= "001101"; wait for 100 ns;
        -- Check outputs expected for ori
        assert (RegDst = '0' and Branch = '0' and MemRead = '0' and MemtoReg = '0' and MemWrite = '0' and AluSrc = '1' and RegWrite = '1' and AluOp = "011") report "Test case 4 failed" severity error;

        -- Test case 5: Load upper immediate (lui)
        OpCode <= "001111"; wait for 100 ns;
        -- Check outputs expected for lui
        assert (RegDst = '0' and Branch = '0' and MemRead = '0' and MemtoReg = '0' and MemWrite = '0' and AluSrc = '1' and RegWrite = '1' and AluOp = "100") report "Test case 5 failed" severity error;

        -- Test case 6: Load word (lw)
        OpCode <= "100011"; wait for 100 ns;
        -- Check outputs expected for lw
        assert (RegDst = '0' and Branch = '0' and MemRead = '1' and MemtoReg = '1' and MemWrite = '0' and AluSrc = '1' and RegWrite = '1' and AluOp = "000") report "Test case 6 failed" severity error;

        -- Test case 7: Store word (sw)
        OpCode <= "101011"; wait for 100 ns;
        -- Check outputs expected for sw
        assert (RegDst = '0' and Branch = '0' and MemRead = '0' and MemtoReg = '0' and MemWrite = '1' and AluSrc = '1' and RegWrite = '0' and AluOp = "000") report "Test case 7 failed" severity error;

        -- Test case 8: Default case (invalid OpCode)
        OpCode <= "111111"; wait for 100 ns;
        -- Check outputs expected for default case
        assert (RegDst = '0' and Branch = '0' and MemRead = '0' and MemtoReg = '0' and MemWrite = '0' and AluSrc = '0' and RegWrite = '0' and AluOp = "000") report "Test case 8 failed" severity error;

        wait;
    end process;

end Behavioral;
