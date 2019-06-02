----------------------------------------------------------------------------------
-- Ecole : 					INSA Toulouse
-- Etudiants : 			Laure FEUILLET et Maël PLANTEC
--
-- Nom du module :	Mémoire d'instructions
-- Nom du projet :	Projet Système Informatique
-- Description:			Mémoire des instructions situées dans le fichier "ins.asm"
--									jusqu'à 256 instructions stockées
--									accessibles via le pointeur d'instruction ins_a
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.common.ALL;

entity memIns is
	generic (Nins:natural := 32; Nsys:natural := 16; TmemI:natural := 256);
    Port ( ins_a : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           ins_di : out  STD_LOGIC_VECTOR(Nins-1 downto 0));
end memIns;

architecture Behavioral of memIns is
-- 256 lignes d'instructions
type memoireIType is array (TmemI-1 downto 0) of STD_LOGIC_VECTOR(Nins-1 downto 0);
signal memoireI : instrArray := init_rom("ins.asm");
begin
	ins_di <= memoireI(to_integer(unsigned(ins_a)));
end Behavioral;
