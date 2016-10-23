
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
	
	rst_n <= '0', '1' after 100 ns;
--datain_i <= "000000000010";
enable <= '1', '0' after 1000 ns, '1' after 2000 ns, '0' after 3000 ns, '1' after 4000 ns;
 
   -- Stimulus process
   stim_proc: process 
   begin		
		datain_i <= "000000000000";
		wait for 2000 ns;
		datain_i <= std_logic_vector(to_unsigned(1,12));
		wait for 20 ns;
		datain_i <= std_logic_vector(to_unsigned(2,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(3,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(4,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(5,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(6,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(7,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(8,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(9,12));
		wait for 20 ns;
		datain_i <= std_logic_vector(to_unsigned(10,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(11,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(12,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(13,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(14,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(15,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(16,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(17,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(18,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(19,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(20,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(11,12));
		wait for 20 ns;
		datain_i <= std_logic_vector(to_unsigned(22,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(23,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(24,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(25,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(26,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(27,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(28,12));
		wait for clk_period;
		datain_i <= std_logic_vector(to_unsigned(29,12));
		wait for 20 ns;
		datain_i <= std_logic_vector(to_unsigned(30,12));
		wait for 20 ns;
		datain_i <= std_logic_vector(to_unsigned(31,12));
		wait for 20 ns;
		datain_i <= std_logic_vector(to_unsigned(32,12));
		wait for 20 ns;
		datain_i <= std_logic_vector(to_unsigned(0,12));		
		wait for 20 ns;

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




END;
