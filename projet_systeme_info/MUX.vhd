----------------------------------------------------------------------------------
-- Ecole : 					INSA Toulouse
-- Etudiants : 			Laure FEUILLET et Maël PLANTEC
--
-- Nom du projet :	Projet Système Informatique
-- Nom du module :	Multiplexeur
-- Description:			in0 ou in1 en sortie en fonction du sélecteur selec
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
	 generic (Nsys:natural := 16);
    Port ( selec : in  STD_LOGIC;
           in0 : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           in1 : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           Sout : out  STD_LOGIC_VECTOR(Nsys-1 downto 0)
			  );
end MUX;

architecture Behavioral of MUX is
begin
	Sout <= in0 when selec='0' else
	in1 when selec='1' else
	x"FFFF";
end Behavioral;
