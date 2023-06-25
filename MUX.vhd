library IEEE;
use IEEE.STD_LOGIC_1164.ALL ;


entity MUX is 
	generic (lenght : integer := 16) ;
	port(
		sel : in std_logic ;
		Input_0, Input_1 : std_logic_vector(lenght-1 downto 0);
		Output	: std_logic_vector(lenght-1 downto 0));
end entity ;
	
	
architecture archi of MUX is 
	
begin
	with sel select 
		Output <= 	Input_0 when '0' ,
					Input_1 when '1' ,
					(others => '0') when others ;
	
end architecture;
		
		