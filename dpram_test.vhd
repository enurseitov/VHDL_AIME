library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dpram_test is
	generic(
			DATA_WIDTH : integer := 12;
			ADDR_WIDTH : integer := 5
		);
end entity dpram_test;

architecture RTL of dpram_test is
	
	
	component dpram
		generic(
			DATA_WIDTH : integer := 12;
			ADDR_WIDTH : integer := 5
		);
		port(
			addr1, addr2         : in  STD_LOGIC_VECTOR(ADDR_WIDTH - 1 downto 0);
			cs1, cs2             : in  STD_LOGIC;
			wr1, wr2             : in  STD_LOGIC;
			data_in1, data_in2   : in  STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
			data_out1, data_out2 : out STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
			clk1, clk2           : in  STD_LOGIC
		);
	end component dpram;
	signal addr1 : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 downto 0);
	signal addr2 : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 downto 0);
	signal cs1 : STD_LOGIC;
	signal cs2 : STD_LOGIC;
	signal wr1 : STD_LOGIC;
	signal wr2 : STD_LOGIC;
	signal data_in1 : STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
	signal data_in2 : STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
	signal data_out1 : STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
	signal data_out2 : STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
	signal clk1 : STD_LOGIC;
	signal clk2 : STD_LOGIC    := '0';
	signal addint: unsigned (ADDR_WIDTH - 1 downto 0) := (others => '0');
	
	constant period : time := 20 ns;
	
begin
	
	DP:component dpram
		generic map(
			DATA_WIDTH => DATA_WIDTH,
			ADDR_WIDTH => ADDR_WIDTH
		)
		port map(
			addr1     => addr1,
			addr2     => addr2,
			cs1       => cs1,
			cs2       => cs2,
			wr1       => wr1,
			wr2       => wr2,
			data_in1  => data_in1,
			data_in2  => data_in2,
			data_out1 => data_out1,
			data_out2 => data_out2,
			clk1      => clk1,
			clk2      => clk2
		);
clock_driver : process
	
begin
	clk1  <=  '0';
addr1 <= std_logic_vector(addint);
addint  <=  addint + 1;
wait for period/2;
clk1  <=  '1';
wait for period/2;
end process clock_driver;

cs1   <=  '1';
wr1  <=  '0', '1' after 100 ns,  '0' after 500 ns;
data_in1  <=  "000000000010";



end architecture RTL;
