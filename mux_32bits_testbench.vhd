LIBRARY ieee;
USE ieee.std_logic_1164.all;

 
ENTITY mux_32bits_testBench IS
end mux_32bits_testBench;
 
ARCHITECTURE behavior OF mux_32bits_testBench IS 
 
   
 
    COMPONENT mux_32bits
    port(
         selector : in  std_logic;
         input_1 : in  std_logic_vector(31 downto 0);
         input_2 : in  std_logic_vector(31 downto 0);
         output : out  std_logic_vector(31 downto 0)
        );
    end COMPONENT;
    

   
   signal selector : std_logic := '0';
   signal input_1 : std_logic_vector(31 downto 0) := (others => '0');
   signal input_2 : std_logic_vector(31 downto 0) := (others => '0');

 	
   signal output : std_logic_vector(31 downto 0);
   
begin
 
	
   uut: mux_32bits port map (
          selector => selector,
          input_1 => input_1,
          input_2 => input_2,
          output => output
        );

   
   stim_proc: process
   begin		
      
      wait for 20 ns;	
		input_1 <= X"0000_0005";
		input_2 <= X"0000_0003";

      
		selector <= '0';
		
		wait for 20 ns;
		
		selector <= '1';
		
		wait for 20 ns;
		
		input_2 <= X"0000_0007";
		
		wait for 20 ns;
		
		selector <= '0';
		
		wait for 20 ns;
		
		input_1 <= X"0000_0010";
		

      wait;
   end process;

end;