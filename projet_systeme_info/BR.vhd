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
	generic (Nreg:natural := 8; Nsys:natural := 16);
   Port ( RST : in  STD_LOGIC;
           addrA : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           addrB : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           QA : out  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           QB : out  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           addrW : in  STD_LOGIC_VECTOR(Nsys-1 downto 0);
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR(Nsys-1 downto 0));
end BR;

architecture Behavioral of BR is
type registersType is array (3 downto 0) of STD_LOGIC_VECTOR(Nreg-1 downto 0);
signal registers : registersType;
begin
	QA <= registers(to_integer(unsigned(addrA)));
	
end Behavioral;

