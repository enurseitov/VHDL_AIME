library IEEE;
	use ieee.std_logic_1164.all;
	--use ieee.std_logic_unsigned.all;
	use ieee.numeric_std.all;

entity sequencer is

--generic ( DATA_WIDTH : integer;
--	      ADDR_WIDTH : integer);

generic (ADDR_WIDTH : integer := 5);


port (
	en, clk, rst_n: in STD_LOGIC;   
	addr : out STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
	mode: out STD_LOGIC
	
);
end sequencer;

architecture Behavioural of sequencer is

TYPE state_machine IS (init, load_ram, calc);
SIGNAL present_state, future_state: state_machine;
--signal temp_out : STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0) := (others => '0');
signal count : unsigned (ADDR_WIDTH -1 downto 0) := (others => '0');
--signal temp : std_logic;
signal ff1, ff2 : std_logic;



begin

M: process (rst_n, clk)
	begin
	if (rst_n = '0') then
		present_state <= init;
	elsif (clk'event and clk='1') then
		present_state <= future_state;
		ff1  <= en;
		ff2  <= ff1;
	end if;

end process;

F: process (present_state, ff1, ff2, count)
	begin
	case present_state is 
		when init =>
			if (ff1 = '1' and ff2 =  '0') then 
				future_state <= load_ram;
				
			else 
				future_state <=init;				
			end if;
		when load_ram =>
			mode  <= '1';
			if (count = 31) then 
				future_state <= calc;
				
			else future_state <=load_ram;
			end if;
		when calc =>
			mode  <= '0';
			if (count = 31) then 
			future_state <= init;
			else future_state <=calc;
			end if;
	end case;
end process;

G: process (clk) is
begin
	if clk'event and clk = '1' then
		case present_state is 
		when init =>
			count <= (others =>  '0');
		when load_ram =>			
			count  <= count + 1;
			if count = 31 then
				count  <= (others  => '0');
			end if;
			
		when calc =>
			count  <= count + 1;
			if count = 31 then
				count  <= (others  => '0');
			end if;
	end case;
	end if;
	
	
end process;
	
	addr   <= std_logic_vector(count);
--	update : process (clk, rst_n) is
--	begin
--		if rst_n = '0' then
--			count <= (others => '0');			
--			
--		elsif rising_edge(clk) then
--			temp <= en;			
--			if temp /= en then -- edge detected
--				count <= (others => '0');
--			else 
--				count <= count + 1;
--			end if;					
--		end if;
--	end process update;
--	
--addr <= std_logic_vector(count);

--process (rst_n, clk, en, present_state) 
--begin
--
--	if (rst_n = '0') then
--		present_state <= init;
--		temp_out <= (others => '0');
--		
--	elsif (rising_edge(clk)) then
--		present_state <= future_state;
--		
--	end if;
--
--	case present_state is
--    
--		when init =>
--			if (en = '1') then
--				future_state <= active_HIGH;
--			else
--				future_state <= init;
--			end if;
--		
--		when active_HIGH =>
--			  if (en = '1') then 
--					if (clk'event and clk='1') then
--						future_state <= active_HIGH;
--						temp_out <= temp_out + 1;
--					end if;
--			  else
--					future_state <= active_LOW;
--					temp_out <= (others => '0');
--			  end if;
--		
--		when active_LOW =>
--			  if (en = '1') then 
--					temp_out <= (others => '0');
--					future_state <= active_HIGH;
--			  else
--					if (clk'event and clk='1') then
--						temp_out <= temp_out + 1;
--						future_state <= active_LOW;
--					end if;
--			  end if;
--		
--	end case;
--end process;
--
--addr <= temp_out;
	
end Behavioural;

