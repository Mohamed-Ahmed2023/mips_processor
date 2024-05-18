LIBRARY ieee;
USE ieee.std_logic_1164.all;
 
ENTITY mux_5bits_testBench IS
end mux_5bits_testBench;
 
ARCHITECTURE behavior OF mux_5bits_testBench IS 
 
   
 
    COMPONENT mux_5bits
    port(
         selector : in  std_logic;
         input_1 : in  std_logic_vector(4 downto 0);
         input_2 : in  std_logic_vector(4 downto 0);
         output : out  std_logic_vector(4 downto 0)
        );
    end COMPONENT;
    

   
   signal selector : std_logic := '0';
   signal input_1 : std_logic_vector(4 downto 0) := (others => '0');
   signal input_2 : std_logic_vector(4 downto 0) := (others => '0');

 	
   signal output : std_logic_vector(4 downto 0);
   
 
begin
 
	
   uut: mux_5bits port map (
          selector => selector,
          input_1 => input_1,
          input_2 => input_2,
          output => output
        );

  
   stim_proc: process
   begin		
     
      wait for 20 ns;	
		input_1 <= "00001";
		input_2 <= "00010";

      
		selector <= '0';
		
		wait for 20 ns;
		
		selector <= '1';
		
		wait for 20 ns;
		
		input_2 <= "00011";
		
		wait for 20 ns;
		
		selector <= '0';
		
		wait for 20 ns;
		
		input_1 <= "00100"; 

      wait;
   end process;

end;