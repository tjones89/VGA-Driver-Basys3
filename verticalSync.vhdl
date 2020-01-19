library IEEE;
use ieee.std_logic_1164.all;

entity verticalSync is

	port(HS	: in std_logic;
		 v_pixel : out integer range 0 to 480;
		 VS	: out std_logic);
		  
end verticalSync;


Architecture behavior of verticalSync is

	signal counter: integer range 0 to 524 :=493;
	
begin

	v_pixel <= counter - 12 when counter >= 13 and counter <= 492 else
				0;

	process(HS)begin
		if(rising_edge(HS))then
			counter <= counter+1;
			if(counter >= 2)then
				if(counter = 524)then
					counter <= 0;
				end if;
				VS <= '1';
			else
				VS <='0';
			end if;
		end if;
		
	end process;

end Architecture behavior;