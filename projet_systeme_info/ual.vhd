----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:35:27 04/19/2019 
-- Design Name: 
-- Module Name:    ual - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ual is
	generic (Nreg:natural := 16; Nope:natural := 8);
    Port ( OPE : in  STD_LOGIC_VECTOR(Nope-1 downto 0);
           A : in  STD_LOGIC_VECTOR(Nreg-1 downto 0);
           B : in  STD_LOGIC_VECTOR(Nreg-1 downto 0);
           Sout : out  STD_LOGIC_VECTOR(Nreg-1 downto 0);
			  N, O, C, Z : out std_logic -- Flags
	);
end ual;

architecture Behavioral of ual is
	signal Stmp : STD_LOGIC_VECTOR(2*Nreg-1 downto 0);
begin
	Stmp <= 	'0' & '0' & '0' & x"000" & (('0'&A)+('0'&B)) when OPE=x"01" else
				A*B when OPE=x"02" else 
				x"0000" & (A-B) when OPE=x"03" else
				x"ffffffff";	
	Sout <= Stmp(Nreg-1 downto 0);
	C <= Stmp(Nreg) when OPE=x"01" else 
		'0';
	O <= '1' when (((A(Nreg-1) = B(Nreg-1)) and (Stmp(Nreg-1) /= A(Nreg-1)) and (OPE=x"01"))) or
	((A(Nreg-1) /= B(Nreg-1)) and (Stmp(Nreg-1) = B(Nreg-1)) and (OPE=x"03")) or 
	((Stmp(2*Nreg-1 downto Nreg) /= x"00") and (OPE=x"02")) else
		'0';
	N <= Stmp(Nreg-1);
	Z <= '1' when (Stmp = x"0000") else
		'0';

end Behavioral;
