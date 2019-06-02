----------------------------------------------------------------------------------
-- Ecole : 					INSA Toulouse
-- Etudiants : 			Laure FEUILLET et Maël PLANTEC
--
-- Nom du projet :	Projet Système Informatique
-- Nom du module :	Banc de registres
-- Description:			Gestion de 16 registres de 16 bits
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BR is
	generic (Nsys:natural := 16; Naddr:natural := 4);
   Port (	Ck: in std_logic;
			  	RST : in  STD_LOGIC;
          addrA : in  STD_LOGIC_VECTOR(Naddr-1 downto 0);
          addrB : in  STD_LOGIC_VECTOR(Naddr-1 downto 0);
          QA : out  STD_LOGIC_VECTOR(Nsys-1 downto 0);
          QB : out  STD_LOGIC_VECTOR(Nsys-1 downto 0);
          addrW : in  STD_LOGIC_VECTOR(Naddr-1 downto 0);
          W : in  STD_LOGIC;
          DATA : in  STD_LOGIC_VECTOR(Nsys-1 downto 0)
			  );
end BR;

architecture Behavioral of BR is
-- 16 registres de 16 bits
type registersType is array (2**Naddr-1 downto 0) of STD_LOGIC_VECTOR(Nsys-1 downto 0);
signal registers : registersType;
begin
	-- Lecture asynchrone
	-- Lorsque l'écriture est activée, si écriture et lecture sur le même registre, alors QX <= DATA
	-- Sinon lecture simple
	QA <= DATA when ((RST='1') and (W='1') and (addrA = addrW)) else
	registers(to_integer(unsigned(addrA)));
	QB <= DATA when ((RST='1') and (W='1') and (addrB = addrW)) else
	registers(to_integer(unsigned(addrB)));

	-- Ecriture synchrone à l'horloge (RST et W)
	process
	begin
		wait until Ck'event and Ck='1';
		-- Quand le signal RST est actif à '0', le contenu du BR est initialisé à 0x0000.
		if RST = '0' then
			registers <= (others => x"0000");
		else
			-- Ecriture simple
			if W = '1' then
				registers(to_integer(unsigned(addrW))) <= DATA;
			end if;
		end if;
	end process;
end Behavioral;
