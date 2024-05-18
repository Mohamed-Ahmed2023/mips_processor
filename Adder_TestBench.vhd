
LIBRARY ieee;
USE ieee.std_logic_1164.all;
 
ENTITY Adder_TestBench IS
end Adder_TestBench;
 
ARCHITECTURE behavior OF Adder_TestBench IS 
 
    
 
    COMPONENT Adder
    port(
         a : in  std_logic_vector(31 downto 0);
         b : in  std_logic_vector(31 downto 0);
         c : out  std_logic_vector(31 downto 0)
        );
    end COMPONENT;

   
   signal a : std_logic_vector(31 downto 0) := (others => '0');
   signal b : std_logic_vector(31 downto 0) := (others => '0');

 	
   signal c : std_logic_vector(31 downto 0);
    
 
begin
 
	
   uut: adder port map (
          a => a,
          b => b,
          c => c
        );
 
  
   stim_proc: process
   begin		
      
      wait for 100 ns;	

      
		a <= X"0000_0001";
		b <= X"0000_0005";
		
		wait for 30 ns;
		
		a <= X"FFFF_FFFF";
		b <= X"0000_0001";
		
		wait for 30 ns;
		
		a <= X"0000_0002";
		b <= X"0000_0002";
		
		wait for 30 ns;
		
		a <= X"0000_0000";
		b <= X"0000_0000";
		
      wait;
   end process;

end;