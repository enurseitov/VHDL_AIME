
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
ENTITY multiplier_test IS
END multiplier_test;
 
ARCHITECTURE behavior OF multiplier_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT multiplier
    PORT(
         clk : IN  std_logic;
         rst_n : IN  std_logic;
         data_in_A : IN  std_logic_vector(11 downto 0);
         data_in_B : IN  std_logic_vector(10 downto 0);
         data_out : OUT  std_logic_vector(22 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst_n : std_logic := '0';
   signal data_in_A : std_logic_vector(11 downto 0) := (others => '0');
   signal data_in_B : std_logic_vector(10 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic_vector(22 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: multiplier PORT MAP (
          clk => clk,
          rst_n => rst_n,
          data_in_A => data_in_A,
          data_in_B => data_in_B,
          data_out => data_out
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

data_in_A <= std_logic_vector(to_unsigned (5, 12));
data_in_B <= std_logic_vector(to_unsigned (6, 11));

END;
