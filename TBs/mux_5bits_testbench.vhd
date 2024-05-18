LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux_5bits_testBench IS
END mux_5bits_testBench;

ARCHITECTURE behavior OF mux_5bits_testBench IS

   COMPONENT mux_5bits
      PORT (
         selector : IN STD_LOGIC;
         input_1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
         input_2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
         output : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
      );
   END COMPONENT;

   SIGNAL selector : STD_LOGIC := '0';
   SIGNAL input_1 : STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
   SIGNAL input_2 : STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
   SIGNAL output : STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN
   uut : mux_5bits PORT MAP(
      selector => selector,
      input_1 => input_1,
      input_2 => input_2,
      output => output
   );
   stim_proc : PROCESS
   BEGIN

      WAIT FOR 20 ns;
      input_1 <= "00001";
      input_2 <= "00010";
      selector <= '0';

      WAIT FOR 20 ns;

      selector <= '1';

      WAIT FOR 20 ns;

      input_2 <= "00011";

      WAIT FOR 20 ns;

      selector <= '0';

      WAIT FOR 20 ns;

      input_1 <= "00100";

      WAIT;
   END PROCESS;

END;