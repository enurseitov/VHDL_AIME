
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY TOP_test IS
END TOP_test;
 
ARCHITECTURE behavior OF TOP_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TOP
    PORT(
         clk : IN  std_logic;
         rst_n : IN  std_logic;
         enable : IN  std_logic;
         datain_i : IN  std_logic_vector(11 downto 0);
         dataout : OUT  std_logic_vector(27 downto 0);
         dataval : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst_n : std_logic := '0';
   signal enable : std_logic := '0';
   signal datain_i : std_logic_vector(11 downto 0) := (others => '0');

 	--Outputs
   signal dataout : std_logic_vector(27 downto 0);
   signal dataval : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TOP PORT MAP (
          clk => clk,
          rst_n => rst_n,
          enable => enable,
          datain_i => datain_i,
          dataout => dataout,
          dataval => dataval
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
--   stim_proc: process
--   begin		
--      -- hold reset state for 100 ns.
--      wait for 100 ns;	
--
--      wait for clk_period*10;
--
--      -- insert stimulus here 
--
--      wait;
--   end process;

rst_n <= '0', '1' after 100 ns;
datain_i <= "000000000010";
enable <= '1', '0' after 1 ms, '1' after 2 ms, '0' after 3ms, '1' after 4ms;


END;
