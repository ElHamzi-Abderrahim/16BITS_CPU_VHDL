library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL ;


entity ACC is 
	port(
		CLK, nRST 	: in std_logic ;
		load		: in std_logic ;
		input 		: in std_logic_vector(15 downto 0) ;
		output 		: out std_logic_vector(15 downto 0) ;
		acc_Z, acc_neg	: out std_logic );
end entity ;

	
	
architecture archi of ACC is
	signal Int_reg : std_logic_vector(15 downto 0) ;
begin
	
	acc_Z <= '1' when Int_reg = (others => '0') else '0' ;
	
	acc_neg <= input(15) ;
	
	process(CLK, nRST)
	begin
		if nRST = '0' then
			output <= (others => '0') ;
		elsif rising_edge(CLK) then
			if load = '1' then
				Int_reg <= input ;
			end if ;
		end if ;
			
	end process;

end architecture ;
	
	
	