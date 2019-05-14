----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:31:52 05/14/2019 
-- Design Name: 
-- Module Name:    MUX - Behavioral 
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
	x"0000";
end Behavioral;

