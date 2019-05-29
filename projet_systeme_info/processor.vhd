----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:25:59 05/07/2019 
-- Design Name: 
-- Module Name:    Processor - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Processor is
	 generic (Nsys:natural := 16; Naddr:natural := 4; Nop:natural := 8);
end Processor;

architecture Behavioral of Processor is
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
	Component UAL port(
		A: in std_logic_vector (Nsys-1 downto 0);
		B: in std_logic_vector (Nsys-1 downto 0);
		Op: in std_logic_vector (Nsys/2-1 downto 0);
		S: out std_logic_vector (Nsys-1 downto 0);
		N, O, C, Z: out std_logic
	);
	end Component;
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
	Component MUX 
    Port ( selec : in  STD_LOGIC;
           in0 : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           in1 : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           Sout : out  STD_LOGIC_VECTOR(Nsys-1 downto 0)
			  );
	end Component;
	
	-- Pour créer les signaux intermédiaires plus facilement
	type FormatDeDonnees is record
		op: std_logic_vector(Nop-1 downto 0);
		a, b, c: std_logic_vector(Nsys-1 downto 0);
	end record;
	
	Signal MI_BRout, BRout, muxBRout, muxEBRout, BR_UALout, ALUout, muxALUout, UAL_MEMout, MEM_EBRout: FormatDeDonnees;
	Signal W, RST, selecBR, selecALU, selecEBR: STD_LOGIC;
begin
	-- Décodeur d'instructions
	
	-- Pipeline MI <-> BR
	MI_BR: Pipeline port map(dec.op, dec.a, dec.b, dec.c, MI_BRout.op, MI_BRout.a, MI_BRout.b, MI_BRout.c);
	
	-- Banc de registres
	-- in Ck, in RST, in addrA, in addrB, out QA, out QB, in addrW, in W, in DATA
	-- Il faut prendre les 4 bits de poids faible pour les addresses
	BancRegistres: BR port map(Ck, RST, MI_BRout.b(Naddr-1 downto 0), MI_BRout.b(Naddr-1 downto 0), BRout.b, BRout.c, MEM_EBRout.a, W, muxEBRout.c);
	
	-- MUX BR
	-- Il faut transformer l'opérande en sélectionneur pour le MUX
	-- Attention : Il manque surement des instructions !
	-- in selec, in0, in1, Sout
	selecBR <= '0' when MI_BRout.op = x"06" or MI_BRout.op = x"07" else
		'1';
	muxBR: MUX port map(selecBR, MI_BRout.b, BRout.b, muxBRout.b);
	
	-- Pipeline BR <-> UAL
	BR_UAL: Pipeline port map(MI_BRout.op, MI_BRout.a, muxBRout.b, BRout.c, BR_UALout.op, BR_UALout.a, BR_UALout.b, BR_UALout.c);
	
	-- UAL
	-- in A, in B, in Op, out S, N, O, C, Z
	ALU: UAL port map(BR_UALout.b, BR_UALout.c, BR_UALout.op, UALout.b);
	
	-- MUX ALU
	selecALU <= '1' when BR_UALout.op=x"01" or BR_UALout.op=x"02" or BR_UALout.op=x"03" else
		'0';
	muxALU: MUX port map(selecALU, BR_ALUout.b, ALUout.b, muxALUout.b);
	
	-- Pipeline UAL <-> MEM
	UAL_MEM: Pipeline port map(BR_UALout.op, BR_UALout.a, muxALUout.b, x"0000", UAL_MEMout.op, UAL_MEMout.a, UAL_MEMout.b, x"0000");
	
	-- Mémoire
	-- Je comprends pas trop comment ça se passe ici
	
	-- Pipeline MEM <-> écriture BR
	MEM_EBR: Pipeline port map (UAL_MEMout.op, UAL_MEMout.a, UAL_MEMout.b, x"0000", MEM_EBRout.op, MEM_EBRout.a, MEM_EBRout.b, x"0000");
	
	-- écriture BR
	-- W du BR
	W <= '1' when MEM_EBRout.op=x"01" or MEM_EBRout.op=x"02" or MEM_EBRout.op=x"03" or MEM_EBRout.op=x"04" or MEM_EBRout.op=x"05" or MEM_EBRout.op=x"06" or MEM_EBRout.op=x"07" or MEM_EBRout.op=x"09" or MEM_EBRout.op=x"0A" or MEM_EBRout.op=x"0B" or MEM_EBRout.op=x"0C" or MEM_EBRout.op=x"0D" else 
	'0';
	-- MUX écriture BR
	-- On passe la DATA dans le bus de données que si on fait un STORE
	selecEBR <= '1' when x"08" else 
		'0';
	-- C'est quoi DATA_DI ?
	muxEBR: MUX port map(selecEBR, MEM_EBRout.b, DATA_DI);
	
end Behavioral;

