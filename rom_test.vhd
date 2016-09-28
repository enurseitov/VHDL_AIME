
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY rom_test IS
END rom_test;
 
ARCHITECTURE behavior OF rom_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT rom
    PORT(
         clk : IN  std_logic;
         addr_in : IN  std_logic_vector(3 downto 0);
         data_out : OUT  std_logic_vector(10 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal addr_in : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic_vector(10 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: rom PORT MAP (
          clk => clk,
          addr_in => addr_in,
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
 

   -- Stimulus process
addr_in <= "0000", "0100" after 55 ns, "0110" after 105 ns;

END;
