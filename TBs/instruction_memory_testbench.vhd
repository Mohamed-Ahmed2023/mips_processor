LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY instruction_memory_testbench IS
END instruction_memory_testbench;

ARCHITECTURE behavior OF instruction_memory_testbench IS

   COMPONENT instruction_memory
      PORT (
         READ_ADDRESS : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         INSTRUCTION : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
      );
   END COMPONENT;
   --inputs
   SIGNAL READ_ADDRESS : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
   --outputs
   SIGNAL INSTRUCTION : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
   -- instantiate the Unit Under Test (UUT)
   uut : instruction_memory PORT MAP(
      READ_ADDRESS => READ_ADDRESS,
      INSTRUCTION => INSTRUCTION
   );
   -- Stimulus process
   stim_proc : PROCESS
   BEGIN
      -- hold reset state for 100 ns.
      WAIT FOR 100 ns;

      READ_ADDRESS <= x"0000_0000";
      WAIT FOR 30 ns;

      READ_ADDRESS <= x"0000_0004";
      WAIT FOR 30 ns;

      READ_ADDRESS <= x"0000_0008";
      WAIT FOR 30 ns;

      READ_ADDRESS <= x"0000_000C";
      WAIT FOR 30 ns;

      READ_ADDRESS <= x"0000_0010";
      WAIT FOR 30 ns;

      READ_ADDRESS <= x"0000_0014";
      WAIT FOR 30 ns;
      WAIT;
   END PROCESS;
END;