LIBRARY ieee;
USE ieee.std_logic_1164.all;
 

USE ieee.numeric_std.all;
 
ENTITY alu_testbench IS
end alu_testbench;
 
ARCHITECTURE behavior OF alu_testbench IS 
 	
    COMPONENT alu
    port(
         a : in  std_logic_vector(31 downto 0);
         b : in  std_logic_vector(31 downto 0);
         cntrl : in  std_logic_vector(2 downto 0);
         zero : out  std_logic;
         result : out  std_logic_vector(31 downto 0)
        );
    end COMPONENT;
    

   --inputs
   signal a : std_logic_vector(31 downto 0) := (others => '0');
   signal b : std_logic_vector(31 downto 0) := (others => '0');
   signal cntrl : std_logic_vector(2 downto 0) := (others => '0');

 	--outputs
   signal zero : std_logic;
   signal result : std_logic_vector(31 downto 0);
   
begin
 
	-- instantiate the Unit Under Test (UUT)
   uut: alu port map (
          a => a,
          b => b,
          cntrl => cntrl,
          zero => zero,
          result => result
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 
		cntrl <= "000";
		a <= x"0000_0003";
		b <= x"0000_0002";
		
		wait for 40 ns;
		
		cntrl <= "001";
		
		wait for 40 ns;
		
		cntrl <= "010";
		
		wait for 40 ns;
		
		cntrl <= "011";
		
		wait for 40 ns;
		
		cntrl <= "100";
		
		wait for 40 ns;
		
		cntrl <= "110";

		wait for 40 ns;
		
		cntrl <= "111";
		
		wait for 40 ns;
		
      wait;
   end process;

end behavior;