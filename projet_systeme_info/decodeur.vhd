----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:37:23 05/14/2019 
-- Design Name: 
-- Module Name:    decodeur - Behavioral 
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

entity decodeur is
	 generic (Nins:natural:=32; Nsys:natural:=16; Npartie:natural:=8);
    Port ( ins : in  STD_LOGIC_VECTOR(Nins-1 downto 0);
           OP : out  STD_LOGIC_VECTOR(Npartie-1 downto 0);
           A : out  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           B : out  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           C : out  STD_LOGIC_VECTOR(Nsys-1 downto 0)
			  );
end decodeur;

architecture Behavioral of decodeur is
	Signal opInter: STD_LOGIC_VECTOR(Npartie-1 downto 0);
	constant zero: STD_LOGIC_VECTOR(Nsys-1 downto 0):= (others => '0');
begin
	opInter <= ins(Nins-1 downto Nins-1-Npartie);
	OP <= opInter;
	A <= ins(Nins-1-Npartie downto Nins-1-3*Npartie) when opInter=x"08" or opInter=x"0E" or opInter=x"0F" else 
		zero(Npartie-1 downto 0) & ins(Nins-1-Npartie downto Nins-1-2*Npartie);
	B <= 
	C <= 

end Behavioral;

