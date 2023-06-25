library IEEE;
use IEEE.STD_LOGIC_1164.ALL ;
Use IEEE.STD_LOGIC_ARITH.ALL ;
use	IEEE.STD_LOGIC_UNSIGNED.ALL ;

library work ;
use work.fctPack.all ;

entity FSM is 		-- FINITE STATE MACHINE FOR CONTROLLING THE CPU
	port(
		CLK, nRST		: in std_logic ;
		oper_code		: in opcode ;
		acc_Z, acc_neg	: in std_logic ;
		PC_load			: out std_logic ;
		IR_load			: out std_logic ;
		ACC_load		: out std_logic ;
		ACC_out_en		: out std_logic ;
		ALU_fct			: out alu_opr	;
		MEM_RW			: out std_logic ;
		sel_A, sel_B	: out std_logic );
		
end entity ;
	
	
architecture archi of FSM is 
	type state is ( init, fetch, execute, stop) ;
	curr_state, next_state : state ;
begin
	
	process(CLK, nRST)
	begin
		if nRST = '0' then 
			curr_state <= init ;
		elsif rising_edge(CLK) then 
			curr_state <= next_state ;
	end process;
	
	process(curr_state, opcode, acc_neg, acc_Z)
    begin
		nRST 		<= '0' ;
		sel_A 		<= '0' ;
		sel_B 		<= '0' ;
		ACC_out_en 	<= '0' ;
		ACC_load 	<= '0' ;
		IR_load 	<= '0' ;
		PC_load 	<= '0' ;
		MEM_RW  	<= '1' ; -- READING MEM

		case curr_state is 
			when init =>
					next_state <= fetch ;
					nRST <= '1' ;
			when fetch =>
					next_state <= execute ;
					IR_load <= '1' ;
					ALU_fct <= ALU_B_INC ;
					PC_load <= '1' ;
			when execute =>
					-- load, store, add, not_Opp, and_Opp, or_Opp, 
					-- xor_Opp , sub, branch, br_not_neg, br_eq, stp
					case opcode is
						when load =>
								sel_A <= '1' ;
								sel_B <= '1' ;
								ALU_fct <= ALU_B ;
								ACC_laod <= '1' ;
								next_state <= fetch ;
						when store => 
								sel_A <= '1' ;
								MEM_RW <= '0' ;
								ACC_out_en <= '1' ;
								next_state <= fetch ;
						when add =>
								sel_A <= '1' ;
								sel_B <= '1' ;
								ALU_fct <= ALU_ADD ;
								ACC_load <= '1' ;
								next_state <= fetch ;
						when and_Opp => 
								sel_A <= '1' ;
								sel_B <= '1' ;
								ALU_fct <= ALU_AND ;
								ACC_load <= '1' ;
								next_state <= fetch ;
						when or_Opp =>
								sel_A <= '1' ;
								sel_B <= '1' ;
								ALU_fct <= ALU_OR ;
								ACC_load <= '1' ;
								next_state <= fetch ;
						when xor_Opp =>
								sel_A <= '1' ;
								sel_B <= '1' ;
								ALU_fct <= ALU_XOR ;
								ACC_load <= '1' ;
								next_state <= fetch ;
						when not_Opp => 
								sel_A <= '1' ;
								sel_B <= '1' ;
								ALU_fct <= ALU_NOT_B ;
								ACC_load <= '1' ;
								next_state <= fetch ;
						when inc   => 
								sel_A <= '1' ;
								sel_B <= '1' ;
								ALU_fct <= ALU_B_INC ;
								ACC_load <= '1' ;
								next_state <= fetch ;
						when sub   => 
								sel_A <= '1' ;
								sel_B <= '1' ;
								ALU_fct <= ALU_SUB ;
								ACC_load <= '1' ;
								next_state <= fetch ;
						when branch   => 		-- the address in IR[mem] to the PC  
								sel_A <= '1' ;
								sel_B <= '0' ;
								ALU_fct <= ALU_B ;
								PC_load <= '1' ;
								next_state <= fetch ;
						when br_not_neg   =>
							if acc_neg = '0' then  -- the address in IR[mem] to the PC if the result in the ACC >= 0 
									sel_A <= '1' ;
									sel_B <= '0' ;
									ALU_fct <= ALU_B ;
									PC_load <= '1' ;	
							end if ;
								next_state <= fetch ;
						when br_eq   =>
							if acc_Z = '0' then  -- the address in IR[mem] to the PC if the result in the ACC == 0
									sel_A <= '1' ;
									sel_B <= '0' ;
									ALU_fct <= ALU_B ;
									PC_load <= '1' ;	
							end if ;
								next_state <= fetch ;
						when others =>
							next_state <= stp ;
					end case ;
			when stp => 
					next_state <= stp ;
		end case;
			
	end process ;
						
								
			
end architecture ;

	
	
	