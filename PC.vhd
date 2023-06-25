library IEEE;
use IEEE.STD_LOGIC_1164.ALL ;
Use IEEE.STD_LOGIC_ARITH.ALL ;
use	IEEE.STD_LOGIC_UNSIGNED.ALL ;

library work ;
use work.fctPack.all ;

entity PC is 
	port(
		CLK, nRST 	: in std_logic ;
		load		: in std_logic );
		data_in 	: in std_logic_vector(11 downto 0) ;
		data_out	: out std_logic_vector(11 downto 0) );
		
end entity ;
	
	
architecture archi of PC is 
	signal counter : unsigned(11 downto 0) ;
begin
	
	data_out <= conv_std_logic_vector( counter, 12 ) ;
	
	process(CLK, nRST)					
	begin
		if nRST = '0' then
			counter <= (others => '0') ;
		elsif rising_edge(CLK) then
			if load = '1' then
				counter <= conv_unsigned( data_in, 12) ;
			else 
				counter <= counter + 1 ;
			end if ;
		end if;
	end process;
				

end architecture ;

	
	
	