----------------------------------------------------------------------------------
-- Ecole : 					INSA Toulouse
-- Etudiants : 			Laure FEUILLET et Maël PLANTEC
--
-- Nom du projet :	Projet Système Informatique
-- Module :	        Test du décodeur
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY test_decodeur IS
END test_decodeur;

ARCHITECTURE behavior OF test_decodeur IS
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT decodeur
    PORT(
         ins : IN  std_logic_vector(31 downto 0);
         OP : OUT  std_logic_vector(7 downto 0);
         A : OUT  std_logic_vector(15 downto 0);
         B : OUT  std_logic_vector(15 downto 0);
         C : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal ins : std_logic_vector(31 downto 0) := (others => '0');
 	--Outputs
   signal OP : std_logic_vector(7 downto 0);
   signal A : std_logic_vector(15 downto 0);
   signal B : std_logic_vector(15 downto 0);
   signal C : std_logic_vector(15 downto 0);

BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: decodeur PORT MAP (
          ins => ins,
          OP => OP,
          A => A,
          B => B,
          C => C
        );

   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;
		-- OP = 01
		-- A = 0001
		-- B = 0002
		-- C = 0003
		ins <= x"01010203";

		wait for 100 ns;
		-- OP = 05
		-- A = 0004
		-- B = 0005
		-- C = xxxx
		ins <= x"050405ff";

		wait for 100ns;
		-- OP = 06
		-- A = 0007
		-- B = aaaa
		-- C = xxxx
		ins <= x"0607aaaa";

		wait for 100 ns;
		-- OP = 08
		-- A = bbbb
		-- B = xxxx
		-- C = 0009
		ins <= x"08bbbb09";

		wait for 100 ns;
		-- OP = 0E
		-- A = cccc
		-- B = xxxx
		-- C = xxxx
		ins <= x"0Eccccdd";
      wait;
   end process;
END;
