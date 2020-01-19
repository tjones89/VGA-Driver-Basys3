library IEEE;
use ieee.std_logic_1164.all;

entity clk_25M is
	
	port(clk : in std_logic;
		clk_25 : out std_logic);
		
end clk_25M;

Architecture behavior of clk_25M is

signal counter : integer;

begin

clk_gen:process(clk)begin
	
	if(rising_edge(clk))then
	
		counter<=counter + 1;
		if(counter=0 or counter =1)then
			clk_25<='0';
		elsif(counter=2 or counter= 3)then
			if(counter=3)then
				counter<=0;
			end if;
			clk_25<='1';
		end if;
		
	end if;
end process clk_gen;

end Architecture behavior;
		