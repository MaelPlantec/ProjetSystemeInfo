----------------------------------------------------------------------------------
-- Ecole : 					INSA Toulouse
-- Etudiants : 			Laure FEUILLET et Maël PLANTEC
--
-- Nom du projet :	Projet Système Informatique
-- Module :	        Test de la mémoire de données
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY test_MEM IS
END test_MEM;

ARCHITECTURE behavior OF test_MEM IS
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT memoireDonnees
    PORT(
         data_out : IN  std_logic_vector(15 downto 0);
         data_addr : IN  std_logic_vector(15 downto 0);
         data_write : IN  std_logic;
         data_in : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal data_out : std_logic_vector(15 downto 0) := (others => '0');
   signal data_addr : std_logic_vector(15 downto 0) := (others => '0');
   signal data_write : std_logic := '0';
 	--Outputs
   signal data_in : std_logic_vector(15 downto 0);

BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: memoireDonnees PORT MAP (
          data_out => data_out,
          data_addr => data_addr,
          data_write => data_write,
          data_in => data_in
        );
   -- Stimulus process
   stim_proc: process
   begin
      wait for 100 ns;
		-- On écrit "0005" à l'addr x"0001"
		data_write <= '1';
		data_out <= x"0005";
		data_addr <= x"0001";

		wait for 100ns;
		data_out <= x"0006";
		data_addr <= x"0002";

		wait for 100ns;
		-- On doit voir dans data_in x"0006"
		data_out <= x"0007";
		data_write <= '0';
		data_addr <= x"0002";

		wait for 100ns;
		-- On doit voir dans data_in x"0005"
		data_out <= x"0008";
		data_addr <= x"0001";

      wait;
   end process;
END;
