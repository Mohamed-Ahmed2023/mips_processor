
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY alu IS
	PORT (
		a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		cntrl : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		zero : OUT STD_LOGIC;
		result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END alu;

ARCHITECTURE Behavioral OF alu IS
	SIGNAL aux_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
	PROCESS (a, b, cntrl)
	BEGIN
		CASE cntrl IS
			WHEN "000" => aux_result <= (a AND b); --And operation
			WHEN "001" => aux_result <= (a OR b); --Or operation
			WHEN "010" => aux_result <= (a + b); --Add operator
			WHEN "011" => aux_result <= (a); --equal
			WHEN "100" => aux_result <= (b(15 DOWNTO 0) & "0000000000000000"); --Concatenate Operation
			WHEN "101" => NULL; --null
			WHEN "110" => aux_result <= (a - b); --subtraction operation
			WHEN "111" =>
				IF a < b THEN --If (a<b), then equal to 1
					aux_result <= ("00000000000000000000000000000001");
				ELSE --else, equal to 0
					aux_result <= ("00000000000000000000000000000000");
				END IF;
			WHEN OTHERS => NULL;
		END CASE;
	END PROCESS;

	PROCESS (aux_result)
	BEGIN
		IF (aux_result = "00000000000000000000000000000000") THEN
			zero <= '1';
		ELSE
			zero <= '0';
		END IF;
		result <= aux_result;
	END PROCESS;
END Behavioral;