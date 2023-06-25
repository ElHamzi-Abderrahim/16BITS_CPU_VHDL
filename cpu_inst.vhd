library IEEE;
use IEEE.STD_LOGIC_1164.ALL ;
Use IEEE.STD_LOGIC_ARITH.ALL ;
use	IEEE.STD_LOGIC_UNSIGNED.ALL ;

library work ;
use work.fctPack.all ;

entity cpu_inst is 	
	port(
		CLK, nRST	: in std_logic ;
		adr_bus		: out std_logic_vector(11 downto 0);
		data_bus	: out std_logic_vector(15 downto 0);
		M_rw		: out std_logic );
end entity ;
	
	
architecture archi of cpu_inst is 
	
		----------- SIGNALS DECLARATION -----------
	
	signal dt_bus 	: std_logic_vector(15 downto 0) ;
	signal adr_bus 	: std_logic_vector(15 downto 0) ;
	signal muxB_out : std_logic_vector(15 downto 0) ;
	
	signal selB		: std_logic ;
	signal selA		: std_logic ;
	
	signal ALU_FCT	: alu_opr ;
	signal ALU_out	: std_logic_vector(15 downto 0) ;

	signal PC_in	: std_logic_vector(11 downto 0) ;
	signal PC_out	: std_logic_vector(11 downto 0) ;
	signal PC_LAOD	: std_logic ;

	signal IR_in	: std_logic_vector(15 downto 0) ;
	signal IR_out	: std_logic_vector(11 downto 0) ;
	signal op_code	: opcode ;
	signal IR_LAOD	: std_logic ;
	
	signal ACC_in	: std_logic_vector(11 downto 0) ;
	signal ACC_out	: std_logic_vector(11 downto 0) ;
	signal ACC_LAOD	: std_logic ;
	signal ACC_Z	: std_logic ;
	signal ACC_NEG	: std_logic ;
	
	signal ACC_OE	: std_logic ;
	signal TRI_in	: std_logic_vector(15 downto 0) ;
	signal TRI_out	: std_logic_vector(11 downto 0) ;
						-----------
					
			-----------COMPONENTS DECLARATION-----------
		
	component ACC  
		port(
			CLK, nRST 	: in std_logic ;
			load		: in std_logic ;
			input 		: in std_logic_vector(15 downto 0) ;
			output 		: out std_logic_vector(15 downto 0) ;
			acc_Z, acc_neg	: out std_logic );
		end component ;
		
	component ALU 
		generic( lenght := 16) ;
		port(
			fnct				: in alu_opr ;
			input_A, input_B 	: in std_logic_vector(lenght downto 0) ;
			output_res			: out std_logic_vector(lenght downto 0) );
		end component ;
		
	component Tristate
		generic( lenght : integer := 16) ;
		port(
			enable		: in std_logic ;
			data_in 	: in std_logic_vector(lenght downto 0) ;
			data_out	: out std_logic_vector(lenght downto 0) );
			
		end component ;
		
	component PC 
		port(
			CLK, nRST 	: in std_logic ;
			load		: in std_logic );
			data_in 	: in std_logic_vector(11 downto 0) ;
			data_out	: out std_logic_vector(11 downto 0) );	
		end component ;
		
	component MUX
		generic (lenght : integer := 16) ;
		port(
			sel : in std_logic ;
			Input_0, Input_1 : std_logic_vector(lenght-1 downto 0);
			Output	: std_logic_vector(lenght-1 downto 0));
		end component ;
		
	component IR 
		port(
			CLK, nRST 	: in std_logic ;
			data_in 	: in std_logic_vector(15 downto 0) ;
			data_out	: out std_logic_vector(11 downto 0) ;
			load		: in std_logic ;
			decode		: out opcode ) );
		end component ;

	component FSM		
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
		end component ;
			
						-----------
begin
	
	TRI_in 	<=	ACC_out ;
	TRI_out <=	dt_bus	;
	ACC_in 	<=	ALU_out	;
	IR_in 	<=	dt_bus	;
	PC_in 	<=	dt_bus	;
	muxA_out <= adr_bus	;
	
	PC_inst	: 	PC port map (CLK => CLK, nRST => nRST, laod => PC_LAOD, data_in => PC_in , data_out => PC_out) ;
	
	IR_inst	: 	IR port map (CLK => CLK, nRST => nRST, laod => IR_LAOD, data_in => IR_in , data_out => IR_out, decode => op_code) ;
	
	ALU_inst:	ALU port map (input_A => ACC_out, input_B => muxB_out, output_res => ALU_out, fnct => ALU_FCT);
	
	MUX_insB:	MUX port map (sel => selB, Input_0 => "0000" & adr_bus, Input_1 => dt_bus, Output => muxB_out) ;
	MUX_insA:	MUX port map (sel => selA, Input_0 => PC_out, Input_1 => IR_out, Output => PC_out) ;
	
	ACC_inst:	ACC port map (CLK => CLK, nRST => nRST, load => ACC_LAOD, input => ACC_in, 
								output => ACC_out, acc_Z => ACC_Z, acc_neg => ACC_NEG);
	TRI_inst:	TRI port map (enable => ACC_OE, data_in => TRI_in, data_out => TRI_in);
	
	FSM_inst:	FSM port map (CLK => CLK, nRST => nRST,	oper_code => op_code,
								acc_Z => ACC_Z, acc_neg => ACC_NEG, PC_load => PC_LAOD,
								IR_load => IR_LOAD,	ACC_load => ACC_LOAD,
								ACC_out_en => ACC_OE, ALU_fct => ALU_FCT, MEM_RW => M_rw,
								sel_A => selA, sel_B => selA) ;
								
	
								
			
end architecture ;

	