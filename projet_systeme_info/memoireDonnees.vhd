----------------------------------------------------------------------------------
-- Ecole : 					INSA Toulouse
-- Etudiants : 			Laure FEUILLET et Maël PLANTEC
--
-- Nom du projet :	Projet Système Informatique
-- Nom du module :	Mémoire de données
-- Description:			Mémoire de données de 256 cases de 16 bits
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memoireDonnees is
	generic (Nsys:natural := 16; Tmem:natural := 256);
   Port ( Ck: in std_logic;
			  	data_out : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
          data_addr : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
          data_write : in  STD_LOGIC;
          data_in : out  STD_LOGIC_VECTOR(Nsys-1 downto 0)
			  );
end memoireDonnees;

architecture Behavioral of memoireDonnees is
-- 256 cases de 16 bits
type memoireType is array (Tmem-1 downto 0) of STD_LOGIC_VECTOR(Nsys-1 downto 0);
signal memoire : memoireType;
begin
	-- Lecture asynchrone
	data_in <= memoire(to_integer(unsigned(data_addr))) when data_write = '0' else
		x"FFFF";
	-- Ecriture synchrone à l'horloge
	process
	begin
		wait until Ck'event and Ck='1';
		-- Ecriture
		if data_write = '1' then
			memoire(to_integer(unsigned(data_addr))) <= data_out;
		end if;
	end process;
end Behavioral;
