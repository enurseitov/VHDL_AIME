
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity  TOP is
    Port ( clk : in  STD_LOGIC;
           rst_n : in  STD_LOGIC;
			  enable : in  STD_LOGIC;
           datain_i : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);           
           dataout : out  STD_LOGIC_VECTOR (31 downto 0); --????
           dataval : out  STD_LOGIC);
end TOP;

architecture Behavioral of TOP is

begin


end Behavioral;

