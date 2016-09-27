library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom is

generic (ROM_DATA_WIDTH : integer :=11;
	ROM_ADDR_WIDTH : integer := 16
	);

port (
	clk : in std_logic;
	addr_in : in std_logic_vector((ROM_ADDR_WIDTH - 1) downto 0);
	data_out : out std_logic_vector ((ROM_DATA_WIDTH) - 1 downto 0)

	) ;
end entity ; -- rom

architecture arch of rom is

type rom_type is array (0 to ROM_ADDR_WIDTH) of std_logic_vector (ROM_DATA_WIDTH-1 downto 0);
constant ROM: rom_type:= (
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH)),
	std_logic_vector(to_unsigned(1,ROM_DATA_WIDTH))
	--others => '0'
	);
	
begin

process( clk )
begin

if (clk'event and clk = '1') then
	data_out <= ROM(conv_integer(addr_in));	
end if ;
	
end process ; -- 

end architecture ; -- arch