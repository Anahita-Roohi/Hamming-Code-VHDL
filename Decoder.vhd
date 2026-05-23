----------------------------------------------------------------------------------
-- Engineer:        Anahita Roohi 
-- Project Name:    Hamming Code Error Detection & Correction (Gate-Level)
-- Module Name:     Decoder - Behavioral 
-- Description:     Receives a 13-bit Hamming code, calculates syndromes to find
--                  errors, corrects single-bit errors, and detects double-bit
--                  errors (pulling the Valid flag low).
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder is
    Port ( DataIn   : in  STD_LOGIC_VECTOR (0 to 12);
           Odd_Mode : in  STD_LOGIC;
           DataOut  : out STD_LOGIC_VECTOR (0 to 7);
           Valid    : out STD_LOGIC);
end Decoder;

architecture Behavioral of Decoder is

    -- Syndrome bits for error localization
    signal C1, C2, C4, C8, P : STD_LOGIC;
    
    -- Extracted data bits
    signal D2, D4, D5, D6, D8, D9, D10, D11 : STD_LOGIC;
    
    -- Error location flags
    signal LOC_D2, LOC_D4, LOC_D5, LOC_D6, LOC_D8, LOC_D9, LOC_D10, LOC_D11 : STD_LOGIC;
    
    -- Correction triggers
    signal Correction_D2,  Correction_D4,  Correction_D5,  Correction_D6  : STD_LOGIC;
    signal Correction_D8,  Correction_D9,  Correction_D10, Correction_D11 : STD_LOGIC;
    
begin

    -- Step 1: Syndrome Calculation
    C1 <= (Odd_Mode) XOR (DataIn(0) XOR DataIn(2) XOR DataIn(4) XOR DataIn(6) XOR DataIn(8) XOR DataIn(10)); 
    C2 <= (Odd_Mode) XOR (DataIn(1) XOR DataIn(2) XOR DataIn(5) XOR DataIn(6) XOR DataIn(9) XOR DataIn(10));
    C4 <= (Odd_Mode) XOR (DataIn(3) XOR DataIn(4) XOR DataIn(5) XOR DataIn(6) XOR DataIn(11));
    C8 <= (Odd_Mode) XOR (DataIn(7) XOR DataIn(8) XOR DataIn(9) XOR DataIn(10) XOR DataIn(11));
    
    -- Overall Parity Verification
    P <= (Odd_Mode) XOR (DataIn(0) XOR DataIn(1) XOR DataIn(2) XOR DataIn(3) XOR DataIn(4) XOR
          DataIn(5) XOR DataIn(6) XOR DataIn(7) XOR DataIn(8) XOR DataIn(9) XOR DataIn(10) XOR
          DataIn(11) XOR DataIn(12));
            
    -- Step 2: Validity Check (Double-Error Detection)
    -- If syndromes indicate an error (C != 0) but overall parity is correct (P = 0), 
    -- it means a double-bit error has occurred. Valid becomes 0.
    Valid <= NOT((C1 OR C2 OR C4 OR C8) AND NOT(P));
    
    -- Step 3: Error Localization based on Syndrome values
    LOC_D2  <= (NOT C8) AND (NOT C4)  AND C2 AND C1;
    LOC_D4  <= (NOT C8) AND C4 AND (NOT C2)  AND C1;
    LOC_D5  <= (NOT C8) AND C4 AND C2 AND (NOT C1);
    LOC_D6  <= (NOT C8) AND C4 AND C2 AND C1;
    LOC_D8  <= C8 AND (NOT C4) AND (NOT C2) AND C1;
    LOC_D9  <= C8 AND (NOT C4) AND C2 AND (NOT C1);
    LOC_D10 <= C8 AND (NOT C4) AND C2 AND C1;
    LOC_D11 <= C8 AND C4 AND (NOT C2) AND (NOT C1);
    
    -- Step 4: Ensure error is a single-bit error (P=1) before applying correction
    Correction_D2  <= LOC_D2  AND P;
    Correction_D4  <= LOC_D4  AND P;
    Correction_D5  <= LOC_D5  AND P;
    Correction_D6  <= LOC_D6  AND P;
    Correction_D8  <= LOC_D8  AND P;
    Correction_D9  <= LOC_D9  AND P;
    Correction_D10 <= LOC_D10 AND P;
    Correction_D11 <= LOC_D11 AND P;

    -- Step 5: Data Correction (Flipping the erroneous bit using XOR)
    D2  <= DataIn(2)  XOR Correction_D2;
    D4  <= DataIn(4)  XOR Correction_D4;
    D5  <= DataIn(5)  XOR Correction_D5;
    D6  <= DataIn(6)  XOR Correction_D6;
    D8  <= DataIn(8)  XOR Correction_D8;
    D9  <= DataIn(9)  XOR Correction_D9;
    D10 <= DataIn(10) XOR Correction_D10;
    D11 <= DataIn(11) XOR Correction_D11;
    
    -- Output Assignments
    DataOut(0) <= D2;
    DataOut(1) <= D4;
    DataOut(2) <= D5;
    DataOut(3) <= D6;
    DataOut(4) <= D8;
    DataOut(5) <= D9;
    DataOut(6) <= D10;
    DataOut(7) <= D11;
    
end Behavioral;