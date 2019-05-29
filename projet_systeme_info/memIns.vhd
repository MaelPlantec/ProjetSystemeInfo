----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:03:41 05/29/2019 
-- Design Name: 
-- Module Name:    memIns - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use work.common.ALL;

entity memIns is
	generic (Nins:natural := 32; Nsys:natural := 16; TmemI:natural := 256);
    Port ( ins_a : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           ins_di : out  STD_LOGIC_VECTOR(Nins-1 downto 0));
end memIns;

architecture Behavioral of memIns is
-- 256 lignes d'instructions 
type memoireIType is array (TmemI-1 downto 0) of STD_LOGIC_VECTOR(Nins-1 downto 0);
signal memoireI : instrArray := init_rom("ins.asm");
begin
	ins_di <= memoireI(to_integer(unsigned(ins_a)));

end Behavioral;

