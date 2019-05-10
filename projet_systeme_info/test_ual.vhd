--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:58:05 04/19/2019
-- Design Name:   
-- Module Name:   /home/feuillet/projet_systeme_info/test_ual.vhd
-- Project Name:  projet_systeme_info
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ual
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
 
ENTITY test_ual IS
END test_ual;
 
ARCHITECTURE behavior OF test_ual IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ual
    PORT(
         OPE : IN  std_logic_vector(7 downto 0);
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         Sout : OUT  std_logic_vector(15 downto 0);
			N, O, C, Z : out std_logic -- Flags
        );
    END COMPONENT;
    

   --Inputs
   signal OPE : std_logic_vector(7 downto 0) := (others => '0');
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
	signal N : std_logic := '0';
	signal O : std_logic := '0';
	signal C : std_logic := '0';
	signal Z : std_logic := '0';

 	--Outputs
   signal Sout : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   ual_test: ual PORT MAP (
          OPE => OPE,
          A => A,
          B => B,
          Sout => Sout,
			 N => N,
			 O => O,
			 C => C,
			 Z => Z
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 5 ns.
		
		-- Tests de 8105 ns
		
		-- Tests basiques, sans flags
      wait for 5 ns;	
		-- 0025
		A <= x"0012";
		B <= x"0013";
		OPE <= x"01";
      wait for 300 ns;
		-- 0156
		A <= x"0012";
		B <= x"0013";
		OPE <= x"02";	
      wait for 300 ns;
		-- 0009
		A <= x"0010";
		B <= x"0007";
		OPE <= x"03";
		wait for 300 ns;
		-- 0004
		A <= x"0005";
		B <= x"FFFF";
		OPE <= x"01";
		wait for 300 ns;
		-- 0006
		A <= x"0005";
		B <= x"FFFF";
		OPE <= x"03";
		
		-- Tests carry
		-- we are at 1505 ns
		wait for 300 ns;
		-- FFFE, C = '1'
		A <= x"FFFF";
		B <= x"FFFF";
		OPE <= x"01";
		wait for 300 ns;
		-- 0002, C = '0'
		A <= x"0001";
		B <= x"0001";
		OPE <= x"01";
		wait for 300 ns;
		-- 0000, C = '1'
		A <= x"8000";
		B <= x"8000";
		OPE <= x"01";
		wait for 300 ns;
		-- FFFB, C = '0'
		A <= x"FFFB";
		B <= x"0000";
		OPE <= x"01";
		
		-- Tests négatif
		-- We are at 2705 ns
		wait for 300 ns;
		-- 0007, N='0'
		A <= x"0000";
		B <= x"0007";
		OPE <= x"01";
		wait for 300 ns;
		-- FFFE, N = '1'
		A <= x"0000";
		B <= x"0002";
		OPE <= x"03";
		wait for 300 ns;
		-- 000F, ou 15, N='0'
		A <= x"0003";
		B <= x"0005";
		OPE <= x"02";
		wait for 300 ns;
		-- 8000, ou 15, N='0'
		A <= x"0000";
		B <= x"8000";
		OPE <= x"03";
		wait for 300 ns;
		-- FFFa, N='1'
		A <= x"FFFb";
		B <= x"FFFF";
		OPE <= x"01";
		wait for 300 ns;
		-- 0004, N='0'
		A <= x"FFFF";
		B <= x"FFFb";
		OPE <= x"03";
		
		-- Tests zeros
		-- We are 
		wait for 300 ns;
		-- 0000, Z='1'
		A <= x"0000";
		B <= x"0000";
		OPE <= x"01";
		wait for 300 ns;
		-- 0005, Z='0'
		A <= x"0000";
		B <= x"0005";
		OPE <= x"01";
		wait for 300 ns;
		-- 0000, Z='1'
		A <= x"0007";
		B <= x"0007";
		OPE <= x"03";
		wait for 300 ns;
		-- 0007, Z='0'
		A <= x"0007";
		B <= x"0000";
		OPE <= x"03";
		wait for 300 ns;
		-- 0000, Z='1'
		A <= x"0000";
		B <= x"0000";
		OPE <= x"02";
		wait for 300 ns;
		-- 0000, Z='1'
		A <= x"0002";
		B <= x"0000";
		OPE <= x"02";
		wait for 300 ns;
		-- 0009, Z='0'
		A <= x"0003";
		B <= x"0003";
		OPE <= x"02";
		
		-- Tests overflow
		wait for 300 ns;
		-- FFFE, O = '1'
		A <= x"7FFF";
		B <= x"7FFF";
		OPE <= x"01";
		wait for 300 ns;
		-- 0002, O = '0'
		A <= x"0001";
		B <= x"0001";
		OPE <= x"01";
		wait for 300 ns;
		-- 0001, O = '1'
		A <= x"7FFF";
		B <= x"7FFF";
		OPE <= x"02";
		wait for 300 ns;
		-- 0008, O = '0'
		A <= x"0004";
		B <= x"0002";
		OPE <= x"02";
		wait for 300 ns;
		-- 0001, O = '1'
		A <= x"8000";
		B <= x"7FFF";
		OPE <= x"03";
		
      wait;
   end process;

END;
