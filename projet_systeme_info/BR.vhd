----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:38:17 05/10/2019 
-- Design Name: 
-- Module Name:    BR - Behavioral 
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

entity BR is
	generic (Nsys:natural := 16; Naddr:natural := 4);
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

end BR;

architecture Behavioral of BR is
-- 16 registres de  bits
type registersType is array (2**Naddr-1 downto 0) of STD_LOGIC_VECTOR(Nsys-1 downto 0);
signal registers : registersType;
begin

	QA <= DATA when ((RST='1') and (W='1') and (addrA = addrW)) else 
	registers(to_integer(unsigned(addrA)));
	QB <= DATA when ((RST='1') and (W='1') and (addrB = addrW)) else 
	registers(to_integer(unsigned(addrB)));
	
	-- RST et W sont synchrones à l'horloge
	process
	begin
		wait until Ck'event and Ck='1';
		-- Quand le signal RST est actif à '0', le contenu du BR est initialisé à 0x00.
		if RST = '0' then
			registers <= (others => x"0000");
		else
			-- Lorsque l'écriture est activée, si écriture et lecture sur le même registre, alors QX <= DATA
			registers(to_integer(unsigned(addrW(3 downto 0)))) <= DATA;
		end if;
	end process;
	
end Behavioral;

