library IEEE;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;

entity dpram is

generic ( DATA_WIDTH : integer := 12;
	      ADDR_WIDTH : integer := 5);
			
--generic ( DATA_WIDTH : integer;
--	      ADDR_WIDTH : integer);

port (
	addr1, addr2 : in STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
	cs1, cs2 : in STD_LOGIC;
	wr1, wr2 : in STD_LOGIC;
	data_in1, data_in2 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
	data_out1, data_out2  : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
	clk1, clk2 : in STD_LOGIC
	
		
);
end dpram;

architecture Behavioural of dpram is

type reg_array is array ((2**ADDR_WIDTH)-1 downto 0) of std_logic_vector (DATA_WIDTH-1 downto 0) ;
shared variable RAM : reg_array;

begin

process(clk1) 
begin

	if (rising_edge(clk1)) then
		if (cs1 = '1') then
			if (wr1 = '0') then
				data_out1 <= RAM(conv_integer(addr1));
			else
				RAM(conv_integer(addr1)) := data_in1;
				--data_out1  <= (others => '0');
			end if;
		end if;
	end if;
end process;

process(clk2) 
begin

	if (rising_edge(clk2)) then
		if (cs2 = '1') then
			if (wr2 = '0') then
			data_out2 <= RAM(conv_integer(addr2));
			else 
				RAM(conv_integer(addr2)) := data_in2;
			end if;
		end if;
	end if;
end process;

end Behavioural;

