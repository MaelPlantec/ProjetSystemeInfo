----------------------------------------------------------------------------------
-- Ecole : 					INSA Toulouse
-- Etudiants : 			Laure FEUILLET et Maël PLANTEC
--
-- Nom du projet :	Projet Système Informatique
-- Module :	        Test du multiplexeur
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY test_mux IS
END test_mux;

ARCHITECTURE behavior OF test_mux IS
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT MUX
	 generic (Nsys:natural:=16);
    PORT(
         selec : IN  std_logic;
         in0 : IN  std_logic_vector(Nsys-1 downto 0);
         in1 : IN  std_logic_vector(Nsys-1 downto 0);
         Sout : OUT  std_logic_vector(Nsys-1 downto 0)
        );
    END COMPONENT;

	constant Nsys:natural:=16;
   --Inputs
   signal selec : std_logic := '0';
   signal in0 : std_logic_vector(Nsys-1 downto 0) := (others => '0');
   signal in1 : std_logic_vector(Nsys-1 downto 0) := (others => '0');
   --Outputs
   signal Sout : std_logic_vector(Nsys-1 downto 0);
   -- No clocks detected in port list. Replace <clock> below with
   -- appropriate port name


BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX PORT MAP (
          selec => selec,
          in0 => in0,
          in1 => in1,
          Sout => Sout
        );
   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
    wait for 100 ns;
    --Sout = x"0001"
		selec <= '0';
		in0 <= x"0001";
		in1 <= x"0002";

		wait for 100 ns;
    -- Sout = x"0002"
		selec <= '1';

      wait;
   end process;
END;
