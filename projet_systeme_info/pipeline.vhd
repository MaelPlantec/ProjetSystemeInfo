----------------------------------------------------------------------------------
-- Ecole : 					INSA Toulouse
-- Etudiants : 			Laure FEUILLET et Maël PLANTEC
--
-- Nom du projet :	Projet Système Informatique
-- Nom du module :	Pipeline
-- Description:			Propage les entrées à chaque clock d'horloge
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Pipeline is
	 generic (N: natural := 16);
    Port (
			  Ck : in std_logic;
			  OPi : in  std_logic_vector(N/2-1 downto 0);
           Ai : in  std_logic_vector(N-1 downto 0);
           Bi : in  std_logic_vector(N-1 downto 0);
           Ci : in  std_logic_vector(N-1 downto 0);
           OPo : out  std_logic_vector(N/2-1 downto 0);
           Ao : out  std_logic_vector(N-1 downto 0);
           Bo : out  std_logic_vector(N-1 downto 0);
           Co : out  std_logic_vector(N-1 downto 0)
	);
end Pipeline;

architecture Behavioral of Pipeline is
begin
	process
	begin
		wait until Ck'event and Ck = '1';
		OPo <= OPi;
		Ao <= Ai;
		Bo <= Bi;
		Co <= Ci;
	end process;
end Behavioral;
