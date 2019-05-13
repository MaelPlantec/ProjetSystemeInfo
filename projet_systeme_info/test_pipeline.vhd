--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:09:57 05/13/2019
-- Design Name:   
-- Module Name:   /home/feuillet/Bureau/4A/S2/Projet info/projet_systeme_info/test_pipeline.vhd
-- Project Name:  projet_systeme_info
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Pipeline
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
 
ENTITY test_pipeline IS
END test_pipeline;
 
ARCHITECTURE behavior OF test_pipeline IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Pipeline
    PORT(
         Ck : IN  std_logic;
         OPi : IN  std_logic_vector(7 downto 0);
         Ai : IN  std_logic_vector(15 downto 0);
         Bi : IN  std_logic_vector(15 downto 0);
         Ci : IN  std_logic_vector(15 downto 0);
         OPo : OUT  std_logic_vector(7 downto 0);
         Ao : OUT  std_logic_vector(15 downto 0);
         Bo : OUT  std_logic_vector(15 downto 0);
         Co : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Ck : std_logic := '0';
   signal OPi : std_logic_vector(7 downto 0) := (others => '0');
   signal Ai : std_logic_vector(15 downto 0) := (others => '0');
   signal Bi : std_logic_vector(15 downto 0) := (others => '0');
   signal Ci : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal OPo : std_logic_vector(7 downto 0);
   signal Ao : std_logic_vector(15 downto 0);
   signal Bo : std_logic_vector(15 downto 0);
   signal Co : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant Ck_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Pipeline PORT MAP (
          Ck => Ck,
          OPi => OPi,
          Ai => Ai,
          Bi => Bi,
          Ci => Ci,
          OPo => OPo,
          Ao => Ao,
          Bo => Bo,
          Co => Co
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

      -- insert stimulus here 
				
		OPi <= x"01";
		
		wait for 100 ns;
		
		Ai <= x"0002";
		
		wait for 100 ns;
		
		Bi <= x"0003";
		
		wait for 100 ns;
		
		Ci <= x"0004";

      wait;
   end process;

END;
