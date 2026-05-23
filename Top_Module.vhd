----------------------------------------------------------------------------------
-- Engineer:        Anahita Roohi 
-- Project Name:    Hamming Code Error Detection & Correction (Gate-Level)
-- Module Name:     Top_Module - Structural
-- Description:     Top level module integrating the Encoder and Decoder. 
--                  It includes an error injection mechanism (XOR with 'Error' vector)
--                  to simulate transmission channel noise.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_Module is
    Port ( Data     : in  STD_LOGIC_VECTOR (0 to 7);
           Odd_Mode : in  STD_LOGIC;
           Error    : in  STD_LOGIC_VECTOR (0 to 12);
           DataOut  : out STD_LOGIC_VECTOR (0 to 7);
           Valid    : out STD_LOGIC);
end Top_Module;

architecture Structural of Top_Module is
    
    -- Internal signals for connecting modules and simulating channel
    signal DataOut_S : STD_LOGIC_VECTOR(0 to 12);
    signal XOR_RES   : STD_LOGIC_VECTOR(0 to 12);
    
    -- Decoder Component Declaration
    COMPONENT Decoder
    PORT(
        DataIn   : IN std_logic_vector(0 to 12);
        Odd_Mode : IN std_logic;          
        DataOut  : OUT std_logic_vector(0 to 7);
        Valid    : OUT std_logic
        );
    END COMPONENT;
    
    -- Encoder Component Declaration
    COMPONENT Encoder
    PORT(
        Data     : IN std_logic_vector(0 to 7);
        Odd_Mode : IN std_logic;          
        DataOut  : OUT std_logic_vector(0 to 12)
        );
    END COMPONENT;
    
begin

    -- Instantiate the Encoder
    Inst_Encoder: Encoder PORT MAP(
        Data     => Data,
        Odd_Mode => Odd_Mode,
        DataOut  => DataOut_S
    );
    
    -- Simulate a noisy transmission channel by injecting errors
    -- The 'Error' input dictates which bits get flipped
    XOR_RES <= DataOut_S XOR Error;
    
    -- Instantiate the Decoder
    Inst_Decoder: Decoder PORT MAP(
        DataIn   => XOR_RES,
        Odd_Mode => Odd_Mode,
        DataOut  => DataOut,
        Valid    => Valid
    );

end Structural;