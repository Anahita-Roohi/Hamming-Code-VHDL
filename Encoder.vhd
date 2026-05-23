----------------------------------------------------------------------------------
-- Engineer:        Anahita Roohi 
-- Project Name:    Hamming Code Error Detection & Correction (Gate-Level)
-- Module Name:     Encoder - Behavioral 
-- Description:     Encodes an 8-bit input into a 13-bit Hamming sequence.
--                  Generates 4 standard parity bits and 1 overall parity bit.
--                  Supports both Odd and Even parity modes.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Encoder is
    Port ( Data     : in  STD_LOGIC_VECTOR (0 to 7);
           Odd_Mode : in  STD_LOGIC;
           DataOut  : out STD_LOGIC_VECTOR (0 to 12));
end Encoder;

architecture Behavioral of Encoder is
    
    -- Internal signals for Parity Bits
    signal P1  : STD_LOGIC;
    signal P2  : STD_LOGIC;
    signal P4  : STD_LOGIC;
    signal P8  : STD_LOGIC;
    signal P13 : STD_LOGIC; -- Overall parity bit
    
begin

    -- Parity Bit Calculations based on Hamming logic (Gate-level XORs)
    P1 <= Data(0) XOR Data(1) XOR Data(3) XOR Data(4) XOR Data(6);
    P2 <= Data(0) XOR Data(2) XOR Data(3) XOR Data(5) XOR Data(6);
    P4 <= Data(1) XOR Data(2) XOR Data(3) XOR Data(7);
    P8 <= Data(4) XOR Data(5) XOR Data(6) XOR Data(7);
    
    -- Overall Parity Calculation for Double-Error Detection
    P13 <= Data(0) XOR Data(1) XOR Data(2) XOR Data(3) XOR Data(4) XOR Data(5)
           XOR Data(6) XOR Data(7) XOR P1 XOR P2 XOR P4 XOR P8;
           
    -- Mapping Data and Parity bits to the output vector
    -- Odd_Mode acts as a toggle to switch between Even and Odd parity logic
    DataOut(0)  <= Odd_Mode XOR P1;
    DataOut(1)  <= Odd_Mode XOR P2;
    DataOut(2)  <= Data(0);
    DataOut(3)  <= Odd_Mode XOR P4;
    DataOut(4)  <= Data(1);
    DataOut(5)  <= Data(2);
    DataOut(6)  <= Data(3);
    DataOut(7)  <= Odd_Mode XOR P8;
    DataOut(8)  <= Data(4);
    DataOut(9)  <= Data(5);
    DataOut(10) <= Data(6);
    DataOut(11) <= Data(7);
    DataOut(12) <= Odd_Mode XOR P13; -- Position 13 for overall parity
    
end Behavioral;