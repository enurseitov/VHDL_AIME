library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datain_delay is
	generic (DATA_WIDTH : integer
		);
	
	port (
		clk : in std_logic;
		rst_n : in std_logic;
		i : in std_logic_vector(DATA_WIDTH - 1 downto 0);
		o : out std_logic_vector(DATA_WIDTH - 1 downto 0)
	);
end entity datain_delay;

architecture RTL of datain_delay is
	signal ff1,ff2 : std_logic_vector(DATA_WIDTH - 1 downto 0);
	
begin
	name : process (clk, rst_n) is
	begin
		if rst_n = '0' then
			o <= (others   =>  '0');		
		elsif rising_edge(clk) then
			ff1  <= i;
			ff2 <= ff1;
			o  <= i;
		end if;
	end process name;
	

end architecture RTL;
