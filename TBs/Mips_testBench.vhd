LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY Mips_testBench IS
END Mips_testBench;

ARCHITECTURE behavior OF Mips_testBench IS
   COMPONENT Mips_Processor
      PORT (
         clk : IN STD_LOGIC;
         reset : IN STD_LOGIC
      );
   END COMPONENT;
   SIGNAL clk : STD_LOGIC := '0';
   SIGNAL reset : STD_LOGIC := '1';
   CONSTANT clk_period : TIME := 100 ns;
BEGIN
   uut : MIPS_processor PORT MAP(
      clk,
      reset
   );
   clk_input : PROCESS
   BEGIN
      clk <= '0';
      WAIT FOR clk_period/2;
      clk <= '1';
      WAIT FOR clk_period/2;
   END PROCESS;
   stimulus_process : PROCESS
   BEGIN
      WAIT FOR clk_period;
      reset <= '0';
      WAIT FOR clk_period * 10;
      reset <= '1';
WAIT;
   END PROCESS;

END;