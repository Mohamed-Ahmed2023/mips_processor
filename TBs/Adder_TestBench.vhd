
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Adder_TestBench IS
END Adder_TestBench;

ARCHITECTURE behavior OF Adder_TestBench IS
   COMPONENT Adder
      PORT (
         a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         c : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
      );
   END COMPONENT;
   SIGNAL a : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
   SIGNAL b : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
   SIGNAL c : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
   uut : adder PORT MAP(
      a => a,
      b => b,
      c => c
   );
   stim_proc : PROCESS
   BEGIN

      WAIT FOR 100 ns;
      a <= X"0000_0001";
      b <= X"0000_0005";

      WAIT FOR 30 ns;

      a <= X"FFFF_FFFF";
      b <= X"0000_0001";

      WAIT FOR 30 ns;

      a <= X"0000_0002";
      b <= X"0000_0002";

      WAIT FOR 30 ns;

      a <= X"0000_0000";
      b <= X"0000_0000";

      WAIT;
   END PROCESS;
END;