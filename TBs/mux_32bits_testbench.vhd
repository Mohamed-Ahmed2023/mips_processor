LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY mux_32bits_testBench IS
END mux_32bits_testBench;

ARCHITECTURE behavior OF mux_32bits_testBench IS

   COMPONENT mux_32bits
      PORT (
         selector : IN STD_LOGIC;
         input_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         input_2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
      );
   END COMPONENT;

   SIGNAL selector : STD_LOGIC := '0';
   SIGNAL input_1 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
   SIGNAL input_2 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
   SIGNAL output : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
   uut : mux_32bits PORT MAP(
      selector => selector,
      input_1 => input_1,
      input_2 => input_2,
      output => output
   );
   stim_proc : PROCESS
   BEGIN

      WAIT FOR 20 ns;
      input_1 <= X"0000_0005";
      input_2 <= X"0000_0003";
      selector <= '0';

      WAIT FOR 20 ns;

      selector <= '1';

      WAIT FOR 20 ns;

      input_2 <= X"0000_0007";

      WAIT FOR 20 ns;

      selector <= '0';

      WAIT FOR 20 ns;

      input_1 <= X"0000_0010";
      WAIT;
   END PROCESS;

END;