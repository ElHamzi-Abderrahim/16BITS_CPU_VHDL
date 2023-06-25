library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem is
	port(clk		: in std_logic;
		 M_rw		: in std_logic;
		 addr_bus	: in std_logic_vector(11 downto 0);
		 data_bus	: inout std_logic_vector(15 downto 0));
end mem;


architecture archi of mem is

	type memory_type is array (integer range 0 to 15) of std_logic_vector(15 downto 0);

	signal memory : memory_type := 
	(                     -- ADRESSE -- DONNEE
	  "0000000000000100", --    0    -- LDA 0x4
	  "0010000000000100", --    1    -- ADD 0x4
	  "0001000000000101", --    2    -- STO 0x5 
	  "0111000000000000", --    3    -- STP
	  "0000000000000111", --    4    -- donnée = 7 
	  "0000000000000000", --    5    -- 
	  "0000000000000000", --    6    -- 
	  "0000000000000000",  --   7    -- 
	  "0000000000000000",  --   8    -- 
	  "0000000000000000",  --   9    -- 
	  "0000000000000000",  --   10   -- 
	  "0000000000000000",  --   11   -- 
	  "0000000000000000",  --   12   -- 
	  "0000000000000000",  --   13   -- 
	  "0000000000000000",  --   14   -- 
	  "0000000000000000"   --   15   -- 
	);

begin

	data_bus <= memory(to_integer(unsigned(addr_bus)))  when (RnW = '1') 
				else (others => 'Z');

	process (clk)
	begin
		if rising_edge(clk) then 
		      if (RnW = '0') then
			     memory(to_integer(unsigned(addr_bus))) <= data_bus;
		      end if;
		end if;      
	end process;
end archi;
