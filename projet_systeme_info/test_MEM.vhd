--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:34:15 05/28/2019
-- Design Name:   
-- Module Name:   /home/feuillet/Bureau/4A/S2/Projet info/projet_systeme_info/test_MEM.vhd
-- Project Name:  projet_systeme_info
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memoireDonnees
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
 
ENTITY test_MEM IS
END test_MEM;
 
ARCHITECTURE behavior OF test_MEM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memoireDonnees
    PORT(
         data_out : IN  std_logic_vector(15 downto 0);
         data_addr : IN  std_logic_vector(15 downto 0);
         data_write : IN  std_logic;
         data_in : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal data_out : std_logic_vector(15 downto 0) := (others => '0');
   signal data_addr : std_logic_vector(15 downto 0) := (others => '0');
   signal data_write : std_logic := '0';

 	--Outputs
   signal data_in : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memoireDonnees PORT MAP (
          data_out => data_out,
          data_addr => data_addr,
          data_write => data_write,
          data_in => data_in
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		-- On écrit "0005" à l'addr "0001"
		data_write <= '1';
		data_out <= x"0005";
		data_addr <= x"0001";

		wait for 100ns;
		data_out <= x"0006";
		data_addr <= x"0002";
		
		wait for 100ns;
		-- On doit voir dans data_in "0006"
		data_out <= x"0007";
		data_write <= '0';
		data_addr <= x"0002";
		
		wait for 100ns;
		-- On doit voir dans data_in "0005"
		data_out <= x"0008";
		data_addr <= x"0001";
		
      wait;
   end process;

END;
