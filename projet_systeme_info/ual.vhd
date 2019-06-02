----------------------------------------------------------------------------------
-- Ecole : 					INSA Toulouse
-- Etudiants : 			Laure FEUILLET et Maël PLANTEC
--
-- Nom du projet :	Projet Système Informatique
-- Nom du module :	Unité Arithmétique et Logique
-- Description:			Réalise les opérations arithmétiques
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ual is
	generic (Nsys:natural := 16; Nope:natural := 8);
    Port (
		A: in std_logic_vector (Nsys-1 downto 0);
		B: in std_logic_vector (Nsys-1 downto 0);
		OPE: in std_logic_vector (Nsys/2-1 downto 0);
		Sout: out std_logic_vector (Nsys-1 downto 0);
		N, O, C, Z: out std_logic
	);
end ual;

architecture Behavioral of ual is
	-- Sortie temporaire sur 32 bits pour la multiplication
	signal Stmp : STD_LOGIC_VECTOR(2*Nsys-1 downto 0);
begin
	-- Opérations arithmétiques avec padding si nécessaire
	Stmp <= 	'0' & '0' & '0' & x"000" & (('0'&A)+('0'&B)) when OPE=x"01" else
				A*B when OPE=x"02" else
				x"0000" & (A-B) when OPE=x"03" else
				x"ffffffff";
	-- On sort que 16 bits
	Sout <= Stmp(Nsys-1 downto 0);
	
	-- Flags
	-- -- Négatif
	N <= Stmp(Nsys-1);
	-- -- Carry
	C <= Stmp(Nsys) when OPE=x"01" else
		'0';
	-- -- Overflow
	O <= '1' when ((A(Nsys-1) = B(Nsys-1)) and (Stmp(Nsys-1) /= A(Nsys-1)) and (OPE=x"01")) or
	((A(Nsys-1) /= B(Nsys-1)) and (Stmp(Nsys-1) = B(Nsys-1)) and (OPE=x"03")) or
	((Stmp(2*Nsys-1 downto Nsys) /= x"00") and (OPE=x"02")) else
		'0';
	-- -- Zeros
	Z <= '1' when (Stmp = x"0000") else
		'0';
end Behavioral;
