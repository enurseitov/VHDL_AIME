library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity accumulator is
	generic(DATA_WIDTH     : integer := 12;
		    ADDR_WIDTH     : integer := 5;
		    ROM_DATA_WIDTH : integer := 11;
		    ROM_ADDR_WIDTH : integer := 4
	);

	Port(clk      : in  STD_LOGIC;
		 rst_n    : in  STD_LOGIC;
		 data_in  : in  STD_LOGIC_VECTOR(DATA_WIDTH + ROM_DATA_WIDTH - 1 downto 0);
		 mode_in  : in  STD_LOGIC;
		 data_out : out STD_LOGIC_VECTOR(DATA_WIDTH + ROM_DATA_WIDTH + ADDR_WIDTH - 1 downto 0);
		 data_val : out STD_LOGIC);
end accumulator;

architecture arch of accumulator is
	signal sum   : unsigned(DATA_WIDTH + ROM_DATA_WIDTH + ADDR_WIDTH -1 downto 0) := (others => '0');
	signal count : unsigned (4 downto 0) :=  (others => '0');
	signal ff1,ff2 : std_logic;

begin
	process(clk, rst_n)
	begin
		if rst_n = '0' then
			sum <= (others => '0');

		elsif (clk'event and clk = '1') then
			ff1  <=  mode_in;
			ff2 <= ff1;
			if ff2 = '1' then       -- memory filling mode, output is 0
				sum <= (others => '0');
				data_val <= '0';
				count <= (others  => '0');

			else                        --accumulation mode, summarize inputs during 32 clicks and put it to output, then constant output till ram filling stage
				
				if count < 31 then
					sum   <= sum + unsigned(data_in);
					count <= count + 1;
				end if;
				
				if count = 31 then
					data_val <= '1';
				end if;
				

			end if;

		end if;

	end process;        
	
	data_out <= std_logic_vector(sum);                -- clk


end arch;

