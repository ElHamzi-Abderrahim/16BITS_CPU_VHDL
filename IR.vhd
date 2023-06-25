library IEEE;
use IEEE.STD_LOGIC_VECTOR.ALL ;
Use IEEE.STD_LOGIC_ARITH.ALL ;

library work ;
use work.fctPack.all ;

entity IR is 
	port(
		CLK, nRST 	: in std_logic ;
		data_in 	: in std_logic_vector(15 downto 0) ;
		data_out	: out std_logic_vector(11 downto 0) ;
		load		: in std_logic ;
		decode		: out opcode ) );
end entity ;
	
	
architecture archi of IR is 
	signal opcode_inst : std_logic_vector(3 downto 0) ;
begin
	
	decode <= 	load 	when opcode_inst = "0000" else
				store 	when opcode_inst = "0001" else 
				add 	when opcode_inst = "0010" else 
				not_Opp	when opcode_inst = "0011" else
				and_Opp when opcode_inst = "0100" else
				or_Opp	when opcode_inst = "0101" else
				xor_Opp when opcode_inst = "0110" else
				inc		when opcode_inst = "0111" else
				sub		when opcode_inst = "1000" else
				brance	when opcode_inst = "1001" else
				unknown_OP ;
					
	process(CLK, nRST)					
	begin
		if nRST = '0' then
			data_out <= (others => '0') ;
		elsif rising_edge(CLK) then
			opcode_inst <= data_in(15 downto 12);
			data_out 	<= data_in(11 downto 0);
		end if;
	end process;
				

end architecture ;

	
	
	