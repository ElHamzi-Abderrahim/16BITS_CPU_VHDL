library IEEE;
use IEEE.STD_LOGIC_1164.ALL ;
use IEEE.STD_LOGIC_ARITH.ALL ;

package fctPack is 
	
	Type alu_opr is ( ALU_B, ALU_ADD, ALU_SUB, ALU_AND, ALU_XOR, ALU_OR, ALU_B_INC, ALU_NOT_B) ;	
	-- ALU_B 	==> 000
	-- ALU_ADD	==> 001
	-- ALU_SUB	==> 010
	-- ALU_AND	==> ...
	-- ALU_XOR 	==> ...
	-- ...
	
	Type opcode is (load, store, add, not_Opp, and_Opp, or_Opp, xor_Opp, inc, sub, branch, br_ntg, br_eq, stp, unknown);
	
end package fctPack ;
	
	
package body fctPack is 
	
	
end package body fctPack ;