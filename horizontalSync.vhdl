library IEEE;
use ieee.std_logic_1164.all;

entity horizontalSync is

	port(clk_25	: in std_logic;
	      h_pixel: out integer range 0 to 640;
		  HS	: out std_logic);
		  
end horizontalSync;

Architecture behavior of horizontalSync is

	signal counter : integer range 0 to 799 :=752;
    signal h_pixel_temp : integer range 0 to 640;
begin	
	
	h_pixel<=h_pixel_temp;
                
	
	process(clk_25)begin

		if(rising_edge(clk_25))then
			counter<=counter+1;
			if(counter >= 96)then
			    if(counter >= 112 and counter <= 751)then
			             if(h_pixel_temp = 640)then
			                    h_pixel_temp<=1;
			             else
			                    h_pixel_temp<=h_pixel_temp+1;
			             end if;     
			    else
			        h_pixel_temp<=0;
			    end if;     
				HS <= '1';
				if(counter = 799)then
					counter<=0;
				end if;			
			else
				HS <= '0';
			end if;
		end if;
	end process;
			
end Architecture behavior;			