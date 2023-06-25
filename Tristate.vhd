	library IEEE;
use IEEE.STD_LOGIC_1164.ALL ;
Use IEEE.STD_LOGIC_ARITH.ALL ;
use	IEEE.STD_LOGIC_UNSIGNED.ALL ;

library work ;
use work.fctPack.all ;

entity Tristate is 
	generic( lenght : integer := 16) ;
	port(
		enable		: in std_logic ;
		data_in 	: in std_logic_vector(lenght downto 0) ;
		data_out	: out std_logic_vector(lenght downto 0) );
		
end entity ;
	
	
architecture archi of Tristate is 
begin
	
	data_out <= data_in when enable = '1' else (others => 'Z') ;
	
end architecture ;

	
	
	