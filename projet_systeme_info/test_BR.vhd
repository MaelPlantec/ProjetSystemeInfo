--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:40:14 05/13/2019
-- Design Name:   
-- Module Name:   /home/feuillet/Bureau/4A/S2/Projet info/projet_systeme_info/test_BR.vhd
-- Project Name:  projet_systeme_info
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BR
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
 
ENTITY test_BR IS
END test_BR;
 
ARCHITECTURE behavior OF test_BR IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BR
    PORT(
			Ck : IN std_logic;
         RST : IN  std_logic;
         addrA : IN  std_logic_vector(15 downto 0);
         addrB : IN  std_logic_vector(15 downto 0);
         QA : OUT  std_logic_vector(15 downto 0);
         QB : OUT  std_logic_vector(15 downto 0);
         addrW : IN  std_logic_vector(15 downto 0);
         W : IN  std_logic;
         DATA : IN  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
	signal Ck : std_logic := '0';
   signal RST : std_logic := '0';
   signal addrA : std_logic_vector(15 downto 0) := (others => '0');
   signal addrB : std_logic_vector(15 downto 0) := (others => '0');
   signal addrW : std_logic_vector(15 downto 0) := (others => '0');
   signal W : std_logic := '0';
   signal DATA : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal QA : std_logic_vector(15 downto 0);
   signal QB : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	
	constant Ck_period : time := 10 ns;
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BR PORT MAP (
			 Ck => Ck,
          RST => RST,
          addrA => addrA,
          addrB => addrB,
          QA => QA,
          QB => QB,
          addrW => addrW,
          W => W,
          DATA => DATA
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
		
		RST <= '1';
		
		wait for 100 ns;
		
		-- QA = 0000
		addrA <= x"0001";
		-- QB = 0000
		addrB <= x"0002";
		
		wait for 100 ns;
		
		-- Rien
		W <= '1';
		addrA <= x"0000";
		addrW <= x"0001";
		DATA <= x"1111";
		
		wait for 100 ns;
		
		-- QA = x"1111"
		W <= '0';
		addrA <= x"0001";
		
		wait for 100 ns;
		
		-- QB = 3333
		W <= '1';
		addrA <= x"0000";
		addrW <= x"0002";
		addrB <= x"0002";
		DATA <= x"3333";
		
		wait for 100 ns;
		
		RST <= '0';
		-- QA = 0000
		-- QB = 0000

      wait;
   end process;

END;
