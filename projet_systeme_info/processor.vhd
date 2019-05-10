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
	 generic (N: natural := 16);
end Processor;

architecture Behavioral of Processor is
	Component Pipeline Port ( 
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
	end Component;
	Component UAL port(
		A: in std_logic_vector (N-1 downto 0);
		B: in std_logic_vector (N-1 downto 0);
		Op: in std_logic_vector (N/2-1 downto 0);
		S: out std_logic_vector (N-1 downto 0);
		N, O, C, Z: out std_logic
	);
	end Component;
	Signal a1,b1,c1,a2,b2,c2,a3,b3,c3,a4,b4,c4,a5,b5,c5 : std_logic_vector (N-1 downto 0);
	Signal op1,op2,op3,op4,op5 : std_logic_vector (N/2-1 downto 0);
	Signal ALUo : std_logic_vector(N-1 downto 0);
begin
	MIBR: Pipeline	port map(Ck,op1,a1,b1,c1,op2,a2,b2,c2);
	BRUAL: Pipeline port map(Ck,op2,a2,b2,c2,op3,a3,b3,c3);
	ALU: UAL port map(b3,c3,op3,ALUo);
	c3 <= x"0000";
	BRUAL: Pipeline port map(Ck,op3,a3,ALUo,c3,op4,a4,b4,c4);
end Behavioral;

