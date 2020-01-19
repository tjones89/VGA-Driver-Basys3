library IEEE;
use ieee.std_logic_1164.all;

entity testImage is
	port(clk: in std_logic;
	    h_pix : in integer range 0 to 640;
		v_pix  : in integer range 0 to 480;
		red    : out std_logic_vector (3 downto 0);
		green  : out std_logic_vector (3 downto 0);
		blue   : out std_logic_vector (3 downto 0));
		
end testImage;


Architecture behavior of testImage is

signal counter: integer := 0;
signal clk60: std_logic;
signal hpos,hdir,vdir,vpos: integer :=1;
signal bhpos : integer :=150;
signal bvpos : integer := 375;
signal bhdir : integer := 2;


begin

--red <= "1111" when 
red<= "1111" when ((v_pix=240 or v_pix=241) and (h_pix>=311 and h_pix<= 330)) 
                or ((h_pix=320 or h_pix=321) and (v_pix>=231 and v_pix<=250))
                or (h_pix >= hpos and h_pix <= hpos+20 and v_pix >= vpos and v_pix <= vpos+20)
                else  
		"0000";
		
--green <= "1111" when h_pix >= 250 and h_pix <= 350 and v_pix >= 250 and v_pix <= 350 else
		--"0000";
green <= "1111" when (((v_pix=1 or v_pix=2)or(v_pix=479 or v_pix=480)) 
                        and ((h_pix>=1 and h_pix<=10) or (h_pix>=631 and h_pix<=640))) else
         "0000";
		
blue <= "1111" when h_pix >= bhpos and h_pix <= bhpos+100 and v_pix >= bvpos and v_pix <= bvpos+100 else
		"0000";
		
clk60_proc:process(clk)begin
    if(rising_edge(clk))then
        counter<=counter+1;
        if(counter=416666)then
            counter<=1;           
            clk60<= not clk60;
        end if;
     end if;
end process;
            
    process(clk60)begin
    if(rising_edge(clk60))then
       bhpos<=bhpos+bhdir; 
       hpos<=hpos+hdir;
       vpos<=vpos+vdir;
            if(hpos<=1 or ((hpos<=bhpos+100 and hpos>=bhpos+98)  and (vpos+20>=375 and vpos<=475)))then--collision on left
                hpos<=hpos+2;
                hdir<=2;
            elsif(hpos+20>=640 or ((hpos+20>=bhpos and hpos+20<=bhpos+3) and (vpos+20>=375 and vpos<=475)))then--collision on right
                hpos<=hpos-2;
                hdir<=-2;
            end if;
            if(vpos<=1)then--collision on top
                vpos<=2;
                vdir<=2;
            elsif(vpos+20>=480 or ((vpos+20>=375 and vpos+20<=377) and (hpos+20>=bhpos and hpos<=bhpos+100)))then--collision on bottom
                vpos<=vpos-2;
                vdir<=-2;
            end if;
            
            if(bhpos<=1)then
                bhpos<=bhpos+2;
                bhdir<=2;
            elsif(bhpos+100>=640)then
                bhpos<=bhpos-2;
                bhdir<=-2;
            end if;
            
    end if;
  end process;    

end behavior;