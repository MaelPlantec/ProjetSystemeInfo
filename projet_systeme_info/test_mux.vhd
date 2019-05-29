--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:36:20 05/14/2019
-- Design Name:   
-- Module Name:   /home/feuillet/Bureau/4A/S2/Projet info/projet_systeme_info/test_mux.vhd
-- Project Name:  projet_systeme_info
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_mux IS
END test_mux;
 
ARCHITECTURE behavior OF test_mux IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX
	 generic (Nsys:natural:=16);
    PORT(
         selec : IN  std_logic;
         in0 : IN  std_logic_vector(Nsys-1 downto 0);
         in1 : IN  std_logic_vector(Nsys-1 downto 0);
         Sout : OUT  std_logic_vector(Nsys-1 downto 0)
        );
    END COMPONENT;
    
	constant Nsys:natural:=16;
	
   --Inputs
   signal selec : std_logic := '0';
   signal in0 : std_logic_vector(Nsys-1 downto 0) := (others => '0');
   signal in1 : std_logic_vector(Nsys-1 downto 0) := (others => '0');

 	--Outputs
   signal Sout : std_logic_vector(Nsys-1 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX PORT MAP (
          selec => selec,
          in0 => in0,
          in1 => in1,
          Sout => Sout
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		selec <= '0';
		in0 <= x"0001";
		in1 <= x"0002";
		
		wait for 100 ns;
		
		selec <= '1';
		
      wait;
   end process;

END;
