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
	addr : out STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0)
	
);
end sequencer;

architecture Behavioural of sequencer is

--TYPE state_machine IS (init, active_HIGH, active_LOW);
--SIGNAL present_state, future_state: state_machine;
--signal temp_out : STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0) := (others => '0');
signal count : unsigned (ADDR_WIDTH -1 downto 0) := (others => '0');
signal temp : std_logic;



begin
	
	update : process (clk, rst_n) is
	begin
		if rst_n = '0' then
			count <= (others => '0');			
			
		elsif rising_edge(clk) then
			temp <= en;			
			if temp /= en then -- edge detected
				count <= (others => '0');
			else 
				count <= count + 1;
			end if;					
		end if;
	end process update;
	
addr <= std_logic_vector(count);

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

