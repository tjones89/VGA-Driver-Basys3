library IEEE;
use ieee.std_logic_1164.all;

entity moveable_pixel is

	port(h_pix : in integer range 0 to 640;
		v_pix  : in integer range 0 to 480;
		btnU,btnD,btnL,btnR : in std_logic;
		vgaRed    : out std_logic_vector (3 downto 0));
		
end moveable_pixel;

architecture behavior of moveable_pixel is


	signal hpos : integer range 0 to 640 :=100;
	signal vpos : integer range 0 to 480 :=100;
	signal hsize,vsize : integer;



begin


	vgaRed <= "1111" when vpos>=v_pix and vpos <= v_pix+20 and hpos>=h_pix and hpos<=h_pix+20 else
				"0000";



	moveUp:process(btnU,btnD,btnL,btnR)begin
		if(btnU='1')then
			if(vpos>1)then
				vpos<=vpos-1;
			end if;
		end if;	
		if(btnD='1')then
            if(vpos<480)then
                 vpos<=vpos+1;
             end if;
        end if;
        if(btnL='1')then
            if(hpos>1)then
                  hpos<=hpos-1;
            end if;
        end if;
        if(btnR='1')then
             if(hpos<640)then
                  hpos<=hpos+1;
             end if;
        end if;
   end process;


end behavior;