library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplier is


--generic (DATA_WIDTH : integer;
--		ADDR_WIDTH : integer;
--		ROM_DATA_WIDTH : integer;
--		ROM_ADDR_WIDTH : integer
--		);
		
generic (DATA_WIDTH : integer := 12;
		ADDR_WIDTH : integer := 5;
		ROM_DATA_WIDTH : integer :=11;
		ROM_ADDR_WIDTH : integer :=4
		);

  port (
  	clk, rst_n : in std_logic;
	data_in_A : in std_logic_vector (DATA_WIDTH-1 downto 0);
	data_in_B : in std_logic_vector (ROM_DATA_WIDTH-1 downto 0);
	data_out : out std_logic_vector ((DATA_WIDTH + ROM_DATA_WIDTH) - 1 downto 0)

  ) ;
end entity ; -- multiplie

architecture arch of multiplier is
begin
process( clk, rst_n )
begin
	if rst_n = '0' then
		data_out <= (others => '0');
	elsif clk'event and clk = '1' then
			data_out <= std_logic_vector(unsigned(data_in_A)*unsigned(data_in_B));			
		
	end if ;
end process ; -- 



end architecture ; -- arch