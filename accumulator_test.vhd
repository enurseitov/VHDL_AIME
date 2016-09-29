
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY accumulator_test IS
END accumulator_test;
 
ARCHITECTURE behavior OF accumulator_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT accumulator
    PORT(
         clk : IN  std_logic;
         rst_n : IN  std_logic;
         data_in : IN  std_logic_vector(22 downto 0);
         mode_in : IN  std_logic;
         data_out : OUT  std_logic_vector(27 downto 0);
         data_val : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst_n : std_logic := '0';
   signal data_in : std_logic_vector(22 downto 0) := (others => '0');
   signal mode_in : std_logic := '0';

 	--Outputs
   signal data_out : std_logic_vector(27 downto 0);
   signal data_val : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: accumulator PORT MAP (
          clk => clk,
          rst_n => rst_n,
          data_in => data_in,
          mode_in => mode_in,
          data_out => data_out,
          data_val => data_val
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
	mode_in <= '1', '0' after 300 ns, '1' after 1000 ns;
	data_in <= std_logic_vector(to_unsigned(2, 23));
	
 



END;
