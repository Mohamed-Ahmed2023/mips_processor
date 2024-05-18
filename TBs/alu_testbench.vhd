LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alu_testbench IS
END alu_testbench;

ARCHITECTURE behavior OF alu_testbench IS

   COMPONENT alu
      PORT (
         a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         cntrl : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
         zero : OUT STD_LOGIC;
         result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
      );
   END COMPONENT;
   --inputs
   SIGNAL a : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
   SIGNAL b : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
   SIGNAL cntrl : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');

   --outputs
   SIGNAL zero : STD_LOGIC;
   SIGNAL result : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

   -- instantiate the Unit Under Test (UUT)
   uut : alu PORT MAP(
      a => a,
      b => b,
      cntrl => cntrl,
      zero => zero,
      result => result
   );

   -- Stimulus process
   stim_proc : PROCESS
   BEGIN
      -- hold reset state for 100 ns.
      WAIT FOR 100 ns;

      -- insert stimulus here 
      cntrl <= "000";
      a <= x"0000_0003";
      b <= x"0000_0002";

      WAIT FOR 40 ns;

      cntrl <= "001";

      WAIT FOR 40 ns;

      cntrl <= "010";

      WAIT FOR 40 ns;

      cntrl <= "011";

      WAIT FOR 40 ns;

      cntrl <= "100";

      WAIT FOR 40 ns;

      cntrl <= "110";

      WAIT FOR 40 ns;

      cntrl <= "111";

      WAIT FOR 40 ns;

      WAIT;
   END PROCESS;

END behavior;