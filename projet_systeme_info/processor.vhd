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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Processor is
	 generic (Nsys:natural := 16; Naddr:natural := 4; Npartie:natural := 8; Nins:natural := 32);
	 Port(
		Ck: in STD_LOGIC;
		--ins_di: in STD_LOGIC_VECTOR(Nins-1 downto 0);
		addrWout: out STD_LOGIC_VECTOR(Naddr-1 downto 0);
		Wout: out STD_LOGIC;
		DATAout: out STD_LOGIC_VECTOR(Nsys-1 downto 0);
		EN: in STD_LOGIC
	 );
end Processor;

architecture Behavioral of Processor is
	Component memIns is
		generic (TmemI:natural := 256);
		 Port ( ins_a : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
				  ins_di : out  STD_LOGIC_VECTOR(Nins-1 downto 0));
	end Component;
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
		OPE: in std_logic_vector (Nsys/2-1 downto 0);
		Sout: out std_logic_vector (Nsys-1 downto 0);
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
	Component decodeur
    Port ( ins : in  STD_LOGIC_VECTOR(Nins-1 downto 0);
           OP : out  STD_LOGIC_VECTOR(Npartie-1 downto 0);
           A : out  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           B : out  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           C : out  STD_LOGIC_VECTOR(Nsys-1 downto 0)
			  );
	end Component;
	Component memoireDonnees is
	generic (Tmem:natural := 256);
   Port (  Ck: in std_logic;
			  data_out : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           data_addr : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           data_write : in  STD_LOGIC;
           data_in : out  STD_LOGIC_VECTOR(Nsys-1 downto 0)
			  );
	end Component;
	
	-- Pour créer les signaux intermédiaires plus facilement
	type FormatDeDonnees is record
		op: std_logic_vector(Npartie-1 downto 0);
		a, b, c: std_logic_vector(Nsys-1 downto 0);
	end record;
	
	constant undefined: STD_LOGIC_VECTOR(Nsys-1 downto 0) := (others => 'X');
	
	Signal MI_BRout, BRout, muxBRout, muxEBRout, BR_UALout, ALUout, muxALUout, UAL_MEMout, MEMout, muxMEMout, MEM_EBRout, DECout : FormatDeDonnees;
	Signal W, RST, selecBR, selecALU, selecEBR, dataW, selecMEM: STD_LOGIC;
	Signal IP: STD_LOGIC_VECTOR(Nsys-1 downto 0) := (others => '0');
	Signal ins_di: STD_LOGIC_VECTOR(Nins-1 downto 0);
	-- Signal ins_di: STD_LOGIC_VECTOR(Nins-1 downto 0);
begin
	-- Mise à jour de IP
	process
	begin
		wait until Ck'event and Ck='1';
		-- Puisqu'on n'a pas de jump, on incrémente juste de 1 
		if EN = '1' then
			IP <= IP + x"01";
		end if;
	end process;
	
	-- Mémoire d'instructions
	-- in ins_a, out ins_di
	MEMinstru: memIns port map(IP, ins_di);
		
	-- Décodeur d'instructions
	-- in ins, out OP, out A, out B, out C
	DEC: decodeur port map(ins_di, DECout.op, DECout.a, DECout.b, DECout.c);
	
	-- Pipeline MI <-> BR
	MI_BR: Pipeline port map(Ck, DECout.op, DECout.a, DECout.b, DECout.c, MI_BRout.op, MI_BRout.a, MI_BRout.b, MI_BRout.c);
	
	-- Banc de registres
	-- in Ck, in RST, in addrA, in addrB, out QA, out QB, in addrW, in W, in DATA
	-- Il faut prendre les 4 bits de poids faible pour les addresses
	BancRegistres: BR port map(Ck, RST, MI_BRout.b(Naddr-1 downto 0), MI_BRout.c(Naddr-1 downto 0), BRout.b, BRout.c, MEM_EBRout.a(Naddr-1 downto 0), W, muxEBRout.b);
	
	-- MUX BR
	-- Il faut transformer l'opérande en sélectionneur pour le MUX
	-- in selec, in0, in1, Sout
	selecBR <= '1' when MI_BRout.op = x"01" or MI_BRout.op = x"02" or MI_BRout.op = x"03" or MI_BRout.op = x"04" or MI_BRout.op = x"05" or MI_BRout.op = x"08" or MI_BRout.op = x"05" or MI_BRout.op = x"09" or MI_BRout.op = x"0A" or MI_BRout.op = x"0B" or MI_BRout.op = x"0C" or MI_BRout.op = x"0D" else
		'0';
	muxBR: MUX port map(selecBR, MI_BRout.b, BRout.b, muxBRout.b);
	
	-- Pipeline BR <-> UAL
	BR_UAL: Pipeline port map(Ck, MI_BRout.op, MI_BRout.a, muxBRout.b, BRout.c, BR_UALout.op, BR_UALout.a, BR_UALout.b, BR_UALout.c);
	
	-- UAL
	-- in A, in B, in Op, out S, N, O, C, Z
	ALU: UAL port map(BR_UALout.b, BR_UALout.c, BR_UALout.op, ALUout.b);
	
	-- MUX ALU
	selecALU <= '1' when BR_UALout.op=x"01" or BR_UALout.op=x"02" or BR_UALout.op=x"03" else
		'0';
	muxALU: MUX port map(selecALU, BR_UALout.b, ALUout.b, muxALUout.b);
	
	-- Pipeline UAL <-> MEM
	UAL_MEM: Pipeline port map(Ck, BR_UALout.op, BR_UALout.a, muxALUout.b, x"0000", UAL_MEMout.op, UAL_MEMout.a, UAL_MEMout.b, open);
	
	-- MUX MEM
	selecMEM <= '1' when UAL_MEMout.op = x"07" else 
		'0';
	muxMEM: MUX port map(selecMEM, UAL_MEMout.a, UAL_MEMout.b, muxMEMout.b);
	
	-- Mémoire
	dataW <= '1' when UAL_MEMout.op=x"08" else
		'0';
	-- data_out, data_addr, data_write, data_in
	MEM: memoireDonnees port map(Ck, UAL_MEMout.b, muxMEMout.b, dataW, MEMout.b);
	-- Pipeline MEM <-> écriture BR
	MEM_EBR: Pipeline port map (Ck, UAL_MEMout.op, UAL_MEMout.a, UAL_MEMout.b, x"0000", MEM_EBRout.op, MEM_EBRout.a, MEM_EBRout.b, open);
	
	-- écriture BR
	-- W du BR
	W <= '1' when MEM_EBRout.op=x"01" or MEM_EBRout.op=x"02" or MEM_EBRout.op=x"03" or MEM_EBRout.op=x"04" or MEM_EBRout.op=x"05" or MEM_EBRout.op=x"06" or MEM_EBRout.op=x"07" or MEM_EBRout.op=x"09" or MEM_EBRout.op=x"0A" or MEM_EBRout.op=x"0B" or MEM_EBRout.op=x"0C" or MEM_EBRout.op=x"0D" else 
	'0';
	-- MUX écriture BR
	-- On passe la DATA dans le bus de données que si on fait une lecture dans la mémoire 
	selecEBR <= '1' when MEM_EBRout.op=x"07" else 
		'0';
	-- MUX EBR
	muxEBR: MUX port map(selecEBR, MEM_EBRout.b, MEMout.b, muxEBRout.b);
	
	addrWout <=  MEM_EBRout.a(Naddr-1 downto 0);
	Wout <=  W;
	DATAout <=  muxEBRout.b;
		
end Behavioral;

