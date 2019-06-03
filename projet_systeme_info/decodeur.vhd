----------------------------------------------------------------------------------
-- Ecole : 					INSA Toulouse
-- Etudiants : 			Laure FEUILLET et Maël PLANTEC
--
-- Nom du projet :	Projet Système Informatique
-- Nom du module :	Décodeur
-- Description:			Décodeur d'instructions en hexadecimal sur 32 bits, en
-- 											- OP sur 8 bits
-- 											- A sur 16 bits
-- 											- B sur 16 bits
-- 											- C sur 16 bits
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decodeur is
	 generic (Nins:natural := 32; Nsys:natural := 16; Npartie:natural := 8);
    Port ( ins : in  STD_LOGIC_VECTOR(Nins-1 downto 0);
           OP : out  STD_LOGIC_VECTOR(Npartie-1 downto 0);
           A : out  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           B : out  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           C : out  STD_LOGIC_VECTOR(Nsys-1 downto 0)
			  );
end decodeur;

architecture Behavioral of decodeur is
	-- Opération à effectuer, pour pouvoir la comparer
	Signal opInter: STD_LOGIC_VECTOR(Npartie-1 downto 0);
	-- Pour concaténer lorsque l'on passe de 8 bits à 16 bits
	constant zero: STD_LOGIC_VECTOR(Nsys-1 downto 0) := (others => '0');
	-- Lorsque certains champs ne sont pas utilisés
	constant undefined: STD_LOGIC_VECTOR(Nsys-1 downto 0) := (others => 'X');
begin
	opInter <= ins((Nins-1) downto (Nins-Npartie));
	OP <= opInter;
	A <= ins(Nins-1-Npartie downto Nins-3*Npartie) when opInter=x"08" or opInter=x"0E" or opInter=x"0F" else
		zero(Npartie-1 downto 0) & ins(Nins-1-Npartie downto Nins-2*Npartie);
	B <= undefined when opInter=x"0E" or opInter=x"0F" else
		ins(Nins-1-2*Npartie downto 0) when opInter=x"06" or opInter=x"07" else
		zero(Npartie-1 downto 0) & ins(Nins-1-3*Npartie downto 0) when opInter=x"08" else
		zero(Npartie-1 downto 0) & ins(Nins-1-2*Npartie downto Nins-3*Npartie);
	C <= undefined when opInter=x"05" or opInter=x"0E" or opInter=x"06" or opInter=x"07" or opInter=x"08" else
		zero(Npartie-1 downto 0) & ins(Nins-1-3*Npartie downto 0);
end Behavioral;
