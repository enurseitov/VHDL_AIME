
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY sequencer_test IS
END sequencer_test;
 
ARCHITECTURE behavior OF sequencer_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sequencer
    PORT(
         en : IN  std_logic;
         clk : IN  std_logic;
         rst_n : IN  std_logic;
         addr : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal en : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst_n : std_logic := '0';

 	--Outputs
   signal addr : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sequencer PORT MAP (
          en => en,
          clk => clk,
          rst_n => rst_n,
          addr => addr
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
rst_n <= '0', '1' after 205 ns;
en <= '1' after 100 ns, '0' after 1 ms, '1' after 2 ms;

END;
