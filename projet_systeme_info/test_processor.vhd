----------------------------------------------------------------------------------
-- Ecole : 					INSA Toulouse
-- Etudiants : 			Laure FEUILLET et Maël PLANTEC
--
-- Nom du projet :	Projet Système Informatique
-- Module :	        Test du processeur
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY test_processeur IS
END test_processeur;

ARCHITECTURE behavior OF test_processeur IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Processor
    PORT(
         Ck : IN  std_logic;
			RST : IN std_logic;
			EN: in STD_LOGIC
        );
    END COMPONENT;

   --Inputs
   signal Ck : std_logic := '0';
	signal RST : std_logic := '0';
	signal EN : std_logic := '0';
   constant Ck_period : time := 10 ns;

BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: Processor PORT MAP (
      Ck => Ck,
		RST => RST,
		EN => EN);

   -- Clock process definitions
   Ck_process :process
   begin
		Ck <= '0';
		wait for Ck_period/2;
		Ck <= '1';
		wait for Ck_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin
     -- hold reset state for 100 ns.
     wait for 100 ns;
		 RST <= '1';
		 EN <= '1';
		 wait for Ck_period*5;
    wait;
   end process;
END;