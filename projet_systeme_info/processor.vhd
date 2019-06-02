----------------------------------------------------------------------------------
-- Ecole : 					INSA Toulouse
-- Etudiants : 			Laure FEUILLET et Maël PLANTEC
--
-- Nom du projet :	Projet Système Informatique
-- Nom du module :	Processeur
-- Description:			Regroupe tous les composants et gère le chemin de données.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Processor is
	 generic (Nsys:natural := 16; Naddr:natural := 4; Npartie:natural := 8; Nins:natural := 32);
	 Port(
		Ck: in STD_LOGIC;
		addrWout: out STD_LOGIC_VECTOR(Naddr-1 downto 0);
		Wout: out STD_LOGIC;
		DATAout: out STD_LOGIC_VECTOR(Nsys-1 downto 0);
		EN: in STD_LOGIC
	 );
end Processor;

architecture Behavioral of Processor is
	-- Mémoire d'instructions
	Component memIns is
		generic (TmemI:natural := 256);
		 Port ( ins_a : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
				  ins_di : out  STD_LOGIC_VECTOR(Nins-1 downto 0));
	end Component;
	-- Pipeline
	Component Pipeline Port (
			  Ck : in std_logic;
			  OPi : in  std_logic_vector(Nsys/2-1 downto 0);
           Ai : in  std_logic_vector(Nsys-1 downto 0);
           Bi : in  std_logic_vector(Nsys-1 downto 0);
           Ci : in  std_logic_vector(Nsys-1 downto 0);
           OPo : out  std_logic_vector(Nsys/2-1 downto 0);
           Ao : out  std_logic_vector(Nsys-1 downto 0);
           Bo : out  std_logic_vector(Nsys-1 downto 0);
           Co : out  std_logic_vector(Nsys-1 downto 0)
	);
	end Component;
	-- Unité arithmétique et logique
	Component UAL port(
		A: in std_logic_vector (Nsys-1 downto 0);
		B: in std_logic_vector (Nsys-1 downto 0);
		OPE: in std_logic_vector (Nsys/2-1 downto 0);
		Sout: out std_logic_vector (Nsys-1 downto 0);
		N, O, C, Z: out std_logic
	);
	end Component;
	-- Banc de registres
	Component BR
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
	end Component;
	-- Multiplexeur
	Component MUX
    Port ( selec : in  STD_LOGIC;
           in0 : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           in1 : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           Sout : out  STD_LOGIC_VECTOR(Nsys-1 downto 0)
			  );
	end Component;
	-- Décodeur
	Component decodeur
    Port ( ins : in  STD_LOGIC_VECTOR(Nins-1 downto 0);
           OP : out  STD_LOGIC_VECTOR(Npartie-1 downto 0);
           A : out  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           B : out  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           C : out  STD_LOGIC_VECTOR(Nsys-1 downto 0)
			  );
	end Component;
	-- Mémoire de données
	Component memoireDonnees is
	generic (Tmem:natural := 256);
   Port (  Ck: in std_logic;
			  data_out : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           data_addr : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           data_write : in  STD_LOGIC;
           data_in : out  STD_LOGIC_VECTOR(Nsys-1 downto 0)
			  );
	end Component;

	-- Structure des signaux de sortie des pipelines
	type FormatDeDonnees is record
		op: std_logic_vector(Npartie-1 downto 0);
		a, b, c: std_logic_vector(Nsys-1 downto 0);
	end record;
	Signal MI_BRout, BRout, muxBRout, muxEBRout, BR_UALout, ALUout, muxALUout, UAL_MEMout, MEMout, muxMEMout, MEM_EBRout, DECout : FormatDeDonnees;
	Signal W, RST, selecBR, selecALU, selecEBR, dataW, selecMEM: STD_LOGIC;
	Signal IP: STD_LOGIC_VECTOR(Nsys-1 downto 0) := (others => '0');
	Signal ins_di: STD_LOGIC_VECTOR(Nins-1 downto 0);
begin
	-- Mise à jour de IP, synchrone à l'horloge
	process
	begin
		wait until Ck'event and Ck='1';
		-- Pas de jump, donc on incrémente juste de 1
		if EN = '1' then
			IP <= IP + x"01";
		end if;
	end process;

	-- Mémoire d'instructions
	MEMinstru: memIns port map(IP, ins_di);

	-- Décodeur d'instructions
	DEC: decodeur port map(ins_di, DECout.op, DECout.a, DECout.b, DECout.c);

	-- Pipeline MI <-> BR
	MI_BR: Pipeline port map(Ck, DECout.op, DECout.a, DECout.b, DECout.c, MI_BRout.op, MI_BRout.a, MI_BRout.b, MI_BRout.c);

	-- Banc de registres
	-- -- Il faut prendre les 4 bits de poids faible pour les addresses
	BancRegistres: BR port map(Ck, RST, MI_BRout.b(Naddr-1 downto 0), MI_BRout.c(Naddr-1 downto 0), BRout.b, BRout.c, MEM_EBRout.a(Naddr-1 downto 0), W, muxEBRout.b);

	-- MUX BR
	-- -- Transformation de l'opérande en sélecteur pour le MUX
	-- -- '1' si on lit dans un registre
	selecBR <= '1' when MI_BRout.op = x"01" or MI_BRout.op = x"02" or MI_BRout.op = x"03" or MI_BRout.op = x"04" or MI_BRout.op = x"05" or MI_BRout.op = x"08" or MI_BRout.op = x"05" or MI_BRout.op = x"09" or MI_BRout.op = x"0A" or MI_BRout.op = x"0B" or MI_BRout.op = x"0C" or MI_BRout.op = x"0D" else
		'0';
	muxBR: MUX port map(selecBR, MI_BRout.b, BRout.b, muxBRout.b);

	-- Pipeline BR <-> UAL
	BR_UAL: Pipeline port map(Ck, MI_BRout.op, MI_BRout.a, muxBRout.b, BRout.c, BR_UALout.op, BR_UALout.a, BR_UALout.b, BR_UALout.c);

	-- UAL
	ALU: UAL port map(BR_UALout.b, BR_UALout.c, BR_UALout.op, ALUout.b);

	-- MUX ALU
	-- -- Transformation de l'opérande en sélecteur pour le MUX
	-- -- '1' pour les opérations arithmétiques
	selecALU <= '1' when BR_UALout.op=x"01" or BR_UALout.op=x"02" or BR_UALout.op=x"03" else
		'0';
	muxALU: MUX port map(selecALU, BR_UALout.b, ALUout.b, muxALUout.b);

	-- Pipeline UAL <-> MEM
	UAL_MEM: Pipeline port map(Ck, BR_UALout.op, BR_UALout.a, muxALUout.b, x"0000", UAL_MEMout.op, UAL_MEMout.a, UAL_MEMout.b, open);

	-- MUX MEM
	-- -- Transformation de l'opérande en sélecteur pour le MUX sur l'@ de la mémoire
	-- -- Les instructions utilisant la mémoire sont "LOAD Ri @j" (x07) et "STORE @i Rj" (x08)
	selecMEM <= '1' when UAL_MEMout.op = x"07" else
		'0';
	muxMEM: MUX port map(selecMEM, UAL_MEMout.a, UAL_MEMout.b, muxMEMout.b);

	-- Mémoire
	-- -- Transformation de l'opérande en critère d'écriture dans la mémoire
	dataW <= '1' when UAL_MEMout.op=x"08" else
		'0';
	MEM: memoireDonnees port map(Ck, UAL_MEMout.b, muxMEMout.b, dataW, MEMout.b);

	-- Pipeline MEM <-> écriture BR
	MEM_EBR: Pipeline port map (Ck, UAL_MEMout.op, UAL_MEMout.a, UAL_MEMout.b, x"0000", MEM_EBRout.op, MEM_EBRout.a, MEM_EBRout.b, open);

	-- écriture BR
	-- -- Transformation de l'opérande en critère d'écriture dans le banc de registres
	W <= '1' when MEM_EBRout.op=x"01" or MEM_EBRout.op=x"02" or MEM_EBRout.op=x"03" or MEM_EBRout.op=x"04" or MEM_EBRout.op=x"05" or MEM_EBRout.op=x"06" or MEM_EBRout.op=x"07" or MEM_EBRout.op=x"09" or MEM_EBRout.op=x"0A" or MEM_EBRout.op=x"0B" or MEM_EBRout.op=x"0C" or MEM_EBRout.op=x"0D" else
	'0';

	-- MUX écriture BR
	-- -- Transformation de l'opérande en sélecteur pour le MUX sur la DATA du banc de registres
	-- -- On passe la DATA dans le bus de données que si on fait une lecture dans la mémoire
	selecEBR <= '1' when MEM_EBRout.op=x"07" else
		'0';
	muxEBR: MUX port map(selecEBR, MEM_EBRout.b, MEMout.b, muxEBRout.b);

	-- Sorties du processeur
	addrWout <=  MEM_EBRout.a(Naddr-1 downto 0);
	Wout <=  W;
	DATAout <=  muxEBRout.b;

end Behavioral;
