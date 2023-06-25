library IEEE;
use IEEE.STD_LOGIC_1164.ALL ;
Use IEEE.STD_LOGIC_ARITH.ALL ;
use	IEEE.STD_LOGIC_UNSIGNED.ALL ;

library work ;
use work.fctPack.all ;

entity ALU is 
	generic( lenght : integer := 16) ;
	port(
		fnct				: in alu_opr ;
		input_A, input_B 	: in std_logic_vector(lenght downto 0) ;
		output_res			: out std_logic_vector(lenght downto 0) );
		
end entity ;
	
	
architecture archi of ALU is 
begin
	--  ALU_B, ALU_ADD, ALU_SUB, ALU_AND, ALU_XOR, ALU_OR, ALU_B_INC, ALU_NOT_B --
	with fnct select 
			output_res <= input_A + input_B		when fnct = ALU_ADD ,
			output_res <= input_A - input_B		when fnct = ALU_SUB ,
			output_res <= input_A and input_B	when fnct = ALU_AND ,
			output_res <= input_B				when fnct = ALU_B 	,
			output_res <= input_A xor input_B	when fnct = ALU_XOR ,
			output_res <= input_A OR input_B	when fnct = ALU_OR 	,
			output_res <= input_B + 1			when fnct = ALU_B_INC,
			output_res <= not(input_B)			when fnct = ALU_NOT_B,
			output_res <= (others => '0')		when others 		;
			
end architecture ;

	
	
	