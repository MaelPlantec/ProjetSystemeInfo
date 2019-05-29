--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:01:39 05/15/2019
-- Design Name:   
-- Module Name:   /home/feuillet/Bureau/4A/S2/Projet info/projet_systeme_info/test_processeur.vhd
-- Project Name:  projet_systeme_info
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Processor
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
 
ENTITY test_processeur IS
END test_processeur;
 
ARCHITECTURE behavior OF test_processeur IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Processor
    PORT(
         Ck : IN  std_logic;
         ins_di : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Ck : std_logic := '0';
   signal ins_di : std_logic_vector(31 downto 0) := (others => '0');
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant Ck_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Processor PORT MAP (
          Ck => Ck,
          ins_di => ins_di
        );

   -- Clock process definitions
   Ck_process :process
   begin
		Ck <= '0';
		wait for Ck_period/2;
		Ck <= '1';
		wait for Ck_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		-- AFC R1 0005
		ins_di <= x"06010005";
		
		wait for 100 ns;	
		-- AFC R2 000a
		ins_di <= x"0602000a";

		wait for 100ns;
		-- ADD R3 = R1 + R2
		ins_di <= x"01030102";
		
		wait for 100 ns;	
		-- STORE 00 R3
		ins_di <= x"08000003";
		

      wait;
   end process;

END;
