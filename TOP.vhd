
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity  TOP is
	generic (DATA_WIDTH : integer := 12;
		ADDR_WIDTH : integer := 5;
		ROM_DATA_WIDTH : integer :=11;
		ROM_ADDR_WIDTH : integer :=4
		);
	
    Port ( clk : in  STD_LOGIC;
           rst_n : in  STD_LOGIC;
			  enable : in  STD_LOGIC;
           datain_i : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);           
           dataout : out  STD_LOGIC_VECTOR (DATA_WIDTH + ROM_DATA_WIDTH + ADDR_WIDTH - 1 downto 0); --????
           dataval : out  STD_LOGIC);
end TOP;

architecture Behavioral of TOP is
	
	component sequencer
		
		port(
			en, clk, rst_n : in  STD_LOGIC;
			addr           : out STD_LOGIC_VECTOR(ADDR_WIDTH - 1 downto 0);
			mode           : out STD_LOGIC
		);
	end component sequencer;
	
	component dpram
		generic(
			DATA_WIDTH : integer;
			ADDR_WIDTH : integer
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
	
	component rom
		generic(
			ROM_DATA_WIDTH : integer;
			ROM_ADDR_WIDTH : integer
		);
		port(
			clk      : in  std_logic;
			addr_in  : in  std_logic_vector((ROM_ADDR_WIDTH - 1) downto 0);
			data_out : out std_logic_vector((ROM_DATA_WIDTH - 1) downto 0)
		);
	end component rom;
	
	component multiplier
		generic(
			DATA_WIDTH     : integer;
			--ADDR_WIDTH     : integer;
			ROM_DATA_WIDTH : integer
			--ROM_ADDR_WIDTH : integer
		);
		port(
			clk, rst_n : in  std_logic;
			data_in_A  : in  std_logic_vector(DATA_WIDTH - 1 downto 0);
			data_in_B  : in  std_logic_vector(ROM_DATA_WIDTH - 1 downto 0);
			data_out   : out std_logic_vector((DATA_WIDTH + ROM_DATA_WIDTH) - 1 downto 0)
		);
	end component multiplier;
	
	component accumulator
		generic(
			DATA_WIDTH     : integer ;
			ADDR_WIDTH     : integer ;
			ROM_DATA_WIDTH : integer ;
			ROM_ADDR_WIDTH : integer 
		);
		port(
			clk      : in  STD_LOGIC;
			rst_n    : in  STD_LOGIC;
			data_in  : in  STD_LOGIC_VECTOR(DATA_WIDTH + ROM_DATA_WIDTH - 1 downto 0);
			mode_in  : in  STD_LOGIC;
			data_out : out STD_LOGIC_VECTOR(DATA_WIDTH + ROM_DATA_WIDTH + ADDR_WIDTH - 1 downto 0);
			data_val : out STD_LOGIC
		);
	end component accumulator;
	
	signal addr_internal : std_logic_vector (ADDR_WIDTH - 1 downto 0);
	signal high : std_logic := '1';
	signal low : std_logic := '1';
	signal dpram_data_internal : std_logic_vector (DATA_WIDTH - 1 downto 0);
	signal rom_data_internal : std_logic_vector (ROM_DATA_WIDTH - 1 downto 0);
	signal mult_output : std_logic_vector ((DATA_WIDTH + ROM_DATA_WIDTH) - 1 downto 0);
	signal mode : std_logic;
	
	    

begin

SEQ:sequencer
	port map(
		en    => enable,
		clk   => clk,
		rst_n => rst_n,
		addr  => addr_internal,
		mode  => mode
		
	); 
	
DPRM:dpram
	generic map(
		DATA_WIDTH => DATA_WIDTH,
		ADDR_WIDTH => ADDR_WIDTH
	)
	port map(
		addr1     => addr_internal,
		addr2     => (addr_internal'range => '0'),
		cs1       => high,
		cs2       => low,
		wr1       => mode,
		wr2       => low,
		data_in1  => datain_i,
		data_in2  => (datain_i'range => '0'),
		data_out1 => dpram_data_internal,
	--	data_out2 => (others => '0'),
		clk1      => clk,
		clk2      => clk
	);
	
ROMM:rom
	generic map(
		ROM_DATA_WIDTH => ROM_DATA_WIDTH,
		ROM_ADDR_WIDTH => ROM_ADDR_WIDTH
	)
	port map(
		clk      => clk,
		addr_in  => addr_internal(3 downto 0),
		data_out => rom_data_internal
	);
	
MUL:multiplier
	generic map(
		DATA_WIDTH     => DATA_WIDTH,
		--ADDR_WIDTH     => ADDR_WIDTH,
		ROM_DATA_WIDTH => ROM_DATA_WIDTH
		--ROM_ADDR_WIDTH => ROM_ADDR_WIDTH
	)
	port map(
		clk       => clk,
		rst_n     => rst_n,
		data_in_A => dpram_data_internal,
		data_in_B => rom_data_internal,
		data_out  => mult_output
	);
	
ACCU:accumulator
	generic map(
		DATA_WIDTH     => DATA_WIDTH,
		ADDR_WIDTH     => ADDR_WIDTH,
		ROM_DATA_WIDTH => ROM_DATA_WIDTH,
		ROM_ADDR_WIDTH => ROM_ADDR_WIDTH
	)
	port map(
		clk      => clk,
		rst_n    => rst_n,
		data_in  => mult_output,
		mode_in  => mode,
		data_out => dataout,
		data_val => dataval
	);

end Behavioral;

