----------------------------------------------------------------------------------
-- Ecole : 					INSA Toulouse
-- Etudiants : 			Laure FEUILLET et Maël PLANTEC
--
-- Nom du projet :	Projet Système Informatique
-- Module :	        Test du banc de registres
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY test_BR IS
END test_BR;

ARCHITECTURE behavior OF test_BR IS
    -- Component Declaration for the Unit Under Test (UUT)
	COMPONENT BR
		generic (Nsys:natural := 16; Naddr:natural := 4);
		Port (  Ck: in std_logic;
				  RST : in  STD_LOGIC;
				  addrA : in  STD_LOGIC_VECTOR(Naddr-1 downto 0);
				  addrB : in  STD_LOGIC_VECTOR(Naddr-1 downto 0);
				  QA : out  STD_LOGIC_VECTOR(Nsys-1 downto 0);
				  QB : out  STD_LOGIC_VECTOR(Nsys-1 downto 0);
				  addrW : in  STD_LOGIC_VECTOR(Naddr-1 downto 0);
				  W : in  STD_LOGIC;
				  DATA : in  STD_LOGIC_VECTOR(Nsys-1 downto 0)
				  );

	END COMPONENT;

  -- Constantes
  constant Nsys:natural := 16;
	constant Naddr:natural := 4;
  -- Inputs
	signal Ck : std_logic := '0';
  signal RST : std_logic := '0';
  signal addrA : std_logic_vector(Naddr-1 downto 0) := (others => '0');
  signal addrB : std_logic_vector(Naddr-1 downto 0) := (others => '0');
  signal addrW : std_logic_vector(Naddr-1 downto 0) := (others => '0');
  signal W : std_logic := '0';
  signal DATA : std_logic_vector(Nsys-1 downto 0) := (others => '0');
 	-- Outputs
  signal QA : std_logic_vector(Nsys-1 downto 0);
  signal QB : std_logic_vector(Nsys-1 downto 0);
  -- Clock
	constant Ck_period : time := 10 ns;

BEGIN
	-- Instantiate the Unit Under Test (UUT)
  uut: BR
	PORT MAP (
			    Ck => Ck,
          RST => RST,
          addrA => addrA,
          addrB => addrB,
          QA => QA,
          QB => QB,
          addrW => addrW,
          W => W,
          DATA => DATA);

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

    wait for 100 ns;
		-- QA = 0000
		addrA <= x"1";
		-- QB = 0000
		addrB <= x"2";

    wait for 100 ns;
		-- Rien
		W <= '1';
		addrA <= x"3";
		addrW <= x"4";
		DATA <= x"1111";

    wait for 100 ns;
		-- QA = x"1111"
		W <= '0';
		addrA <= x"4";
		wait for 100 ns;

		-- QB = 3333
		W <= '1';
		addrA <= x"5";
		addrW <= x"6";
		addrB <= x"6";
		DATA <= x"3333";

    wait for 100 ns;
		RST <= '0';
		-- QA = 0000
		-- QB = 0000
    wait;
   end process;
END;
