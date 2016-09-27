library IEEE;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.numeric_std.all;

entity sequencer is

generic ( DATA_WIDTH : integer;
	      ADDR_WIDTH : integer);

port (
	en: in STD_LOGIC;
	clk: in STD_LOGIC;
	rst_n : in STD_LOGIC;
	addr : out STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
	wr : in STD_LOGIC
	
);
end sequencer;

architecture Behavioural of sequencer is

TYPE state_machine IS (init, execute, read1, write1);
SIGNAL present_state, future_state: state_machine;
signal temp_out : STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
--signal count : integer;
--signal temp : integer;

begin

process (rst_n, clk, en, wr, present_state) 
begin

	if (rst_n = '0') then
		future_state <= init;
		temp_out <= (others => '0');
		
	elsif rising_edge(clk) then
		present_state <= future_state;
	end if;

	case present_state is
    
		when init =>
			if (en = '1') then
				future_state <= execute;
			else
				future_state <= init;
				temp_out <= (others => '0');

			end if;
		 
		when execute =>
			  if (en = '1' and wr = '1') then 
				future_state <= write1;
			  elsif (en = '1' and wr = '0') then
				future_state <= read1;
			  else
				future_state <= init;
				temp_out <= (others => '0');

			  end if;
		
		when write1 =>
			  if (en = '1' and wr = '0') then 
				future_state <= read1;
			  elsif (en = '1' and wr = '1') then
				future_state <= write1;
				temp_out <= temp_out + 1;
			  else
				future_state <= init;
				temp_out <= (others => '0');

			  end if;
		
		when read1 =>
			  if (en = '1' and wr = '1') then 
				future_state <= write1;
			  elsif (en = '1' and wr = '0') then
				future_state <= read1;
				temp_out <= temp_out;
			  else
				future_state <= init;
				temp_out <= (others => '0');

			  end if; 
	end case;
end process;

addr <= temp_out;
	
end Behavioural;

