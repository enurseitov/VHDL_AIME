library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom is

generic (ROM_DATA_WIDTH : integer :=11;
	ROM_ADDR_WIDTH : integer := 4
	);

port (
	clk : in std_logic;
	addr_in : in std_logic_vector((ROM_ADDR_WIDTH - 1) downto 0);
	data_out : out std_logic_vector ((ROM_DATA_WIDTH) - 1 downto 0)

	) ;
end entity ; -- rom

architecture arch of rom is

type rom_type is array (0 to 15) of std_logic_vector (ROM_DATA_WIDTH-1 downto 0);
constant ROM: rom_type:= (
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(2,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(3,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(4,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(5,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(6,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(7,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(8,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(9,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(10,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(11,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(12,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(13,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(14,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(15,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(16,ROM_DATA_WIDTH))
	--others => '0'
	);
	
begin

process( clk )
begin

if (clk'event and clk = '1') then
	data_out <= ROM(to_integer(unsigned(addr_in)));	
end if ;
	
end process ; -- 

end architecture ; -- arch