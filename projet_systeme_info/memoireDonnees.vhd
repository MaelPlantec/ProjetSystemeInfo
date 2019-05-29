----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:30:32 05/15/2019 
-- Design Name: 
-- Module Name:    memoireDonnees - Behavioral 
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

entity memoireDonnees is
	generic (Nsys:natural := 16; Tmem:natural := 256);
   Port (  Ck: in std_logic;
			  data_out : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           data_addr : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           data_write : in  STD_LOGIC;
           data_in : out  STD_LOGIC_VECTOR(Nsys-1 downto 0)
			  );
end memoireDonnees;

architecture Behavioral of memoireDonnees is
-- 256 cases de 16 bits
type memoireType is array (Tmem-1 downto 0) of STD_LOGIC_VECTOR(Nsys-1 downto 0);
signal memoire : memoireType;
begin
	process
	begin
		wait until Ck'event and Ck='1';
		-- On lit si on n'écrit pas
		if data_write = '0' then 
			data_in <= memoire(to_integer(unsigned(data_addr)));
		else 
		data_in <= x"FFFF";
		end if;
		-- Si w='1', on écrit
		if data_write = '1' then
			memoire(to_integer(unsigned(data_addr))) <= data_out; 
		end if;
	end process;
end Behavioral;

