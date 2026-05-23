--------------------------------------------------------------------------------
-- Engineer:   Anahita Roohi
-- Create Date:   10:59:28 05/15/2025
-- Design Name:   Test Bench for the Top Module
-- Module Name:   C:/ISE/HW1/Hamming/Top_Module_Test_Bench.vhd
-- Project Name:  Error detection and correction by using hammig code 
-- Description:   In this part of the code, we test whether the code works as 
--                we want by giving different values ??to the inputs of the main module.
-- VHDL Test Bench Created by ISE for module: Top_Module
-- Revision:
-- Revision 0.01 - File Created
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Top_Module_Test_Bench IS
END Top_Module_Test_Bench;
 
ARCHITECTURE behavior OF Top_Module_Test_Bench IS
 
	-- In this part of the code, Top_Module has been made a Component,
	-- so that we can see the outputs for different inputs using different signals:
   COMPONENT Top_Module
   PORT(
		Data : IN  std_logic_vector(7 downto 0);
		Odd_Mode : IN  std_logic;
		Error : IN  std_logic_vector(12 downto 0);
		DataOut : OUT  std_logic_vector(7 downto 0);
		Valid : OUT  std_logic
      );
	END COMPONENT;
	
	-- Defining signals for module inputs:	
   signal Data_S : std_logic_vector(7 downto 0) := (others => '0');
   signal Odd_Mode_S : std_logic := '0';
   signal Error_S : std_logic_vector(12 downto 0) := (others => '0');

	-- Defining signals for module outputs:
   signal DataOut_S : std_logic_vector(7 downto 0);
   signal Valid_S : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Top_Module PORT MAP (
          Data => Data_S,
          Odd_Mode => Odd_Mode_S,
          Error => Error_S,
          DataOut => DataOut_S,
          Valid => Valid_S
        );

   -- Clock process definitions
   Stimulators :process
   begin
		
		--wait for 1000 ns;
		
		-- Test 1: Odd_Mode -> ON, P2 -> Error bit:
		Data_S <= "11010110";
		Odd_Mode_S <= '1';
		Error_S <= "0100000000000";
		wait for 1000 ns;
		
		-- Test 2: Odd_Mode -> OFF, Data(3) -> Error bit:
		Data_S <= "00100101";
		Odd_Mode_S<= '0';
		Error_S <= "0000001000000";
		wait for 1000 ns;
		
		-- Test 3: Odd_Mode -> ON, Data(1) & Data(5) -> Error bits:
		Data_S <= "00111001";
		Odd_Mode_S <= '1';
		Error_S <= "0000100001000";
		wait for 1000 ns;
		
		-- Test 4: Odd_Mode -> OFF, P8 & Data(3) -> Error bits:
		Data_S <= "11100001";
		Odd_Mode_S <= '0';
		Error_S <= "0000010100000";
		wait for 1000 ns;
		
		-- Test 5: Odd_Mode -> ON, P13 -> Error bit:
		Data_S <= "00111111";
		Odd_Mode_S <= '1';
		Error_S <= "0000000000001";
		wait for 1000 ns;
		
		-- Test 6: Odd_Mode -> OFF, P1 & P2 -> Error bit:
		Data_S <= "10101010";
		Odd_Mode_S <= '0';
		Error_S <= "1100000000000";
		wait for 1000 ns;
   end process;
 

   -- Stimulus process
--   stim_proc: process
--   begin		
--      -- hold reset state for 100 ns.
--      wait for 100 ns;	
--
--      wait for <clock>_period*10;
--
--      -- insert stimulus here 
--
--      wait;
--   end process;

END;
