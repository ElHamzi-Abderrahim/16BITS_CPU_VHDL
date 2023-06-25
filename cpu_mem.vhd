library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work ;
use work.all ;

entity cpu_mem is
	port(CLK, nRST	: in std_logic;
		 addr_bus	: in std_logic_vector(11 downto 0);
		 data_bus	: inout std_logic_vector(15 downto 0));
end mem;


architecture archi of cpu_mem is
	signal MEM_RW : std_logic ;
	
	component mem
		port(CLK		: in std_logic;
			 M_rw		: in std_logic;
			 addr_bus	: in std_logic_vector(11 downto 0);
			 data_bus	: inout std_logic_vector(15 downto 0));
		end mem;
		
	component cpu_inst
		port(
			CLK, nRST	: in std_logic ;
			add_bus		: out std_logic_vector(11 downto 0);
			data_bus	: out std_logic_vector(15 downto 0);
			M_rw		: out std_logic );
		end cpu_inst ;

begin
	
	cpu : cpu_inst	port map (CLK => CLK, nRST => nRST, adr_bus => addr_bus, data_bus => data_bus, M_rw => MEM_RW);
	memr: mem		port map (CLK => CLK, M_rw => MEM_RW, addr_bus => addr_bus, data_bus => data_bus);
	
	
	
end archi;
