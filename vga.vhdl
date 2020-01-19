library ieee;
use ieee.std_logic_1164.all;


entity vga is

	port(clk,btnU,btnD,btnL,btnR : in std_logic;
		Hsync	 : out std_logic;
		Vsync   : out std_logic;
		vgaRed  : out std_logic_vector (3 downto 0);
		vgaGreen  : out std_logic_vector (3 downto 0);
		vgaBlue  : out std_logic_vector (3 downto 0));
		
end vga;


architecture behavior of vga is

component clk_25M is
	
	port(clk : in std_logic;
		clk_25 : out std_logic);
		
end component clk_25M;

component horizontalSync is

	port(clk_25	: in std_logic;
		h_pixel: out integer range 0 to 640;		
		  HS	: out std_logic);
		  
end component horizontalSync;

component verticalSync is

	port(HS	: in std_logic;
		 v_pixel : out integer range 0 to 480;
		 VS	: out std_logic);
		  
end component verticalSync;

component testImage is
	port(clk : in std_logic;
	    h_pix : in integer range 0 to 640;
		v_pix  : in integer range 0 to 480;
		red    : out std_logic_vector (3 downto 0);
		green  : out std_logic_vector (3 downto 0);
		blue   : out std_logic_vector (3 downto 0));
		
end component testImage;

--component moveable_pixel is

--	port(h_pix : in integer range 0 to 640;
--		v_pix  : in integer range 0 to 480;
--		btnU,btnD,btnL,btnR : in std_logic;
--		vgaRed    : out std_logic_vector (3 downto 0));
		
--end component moveable_pixel;

signal clock25 : std_logic;
signal h_pix : integer range 0 to 640;
signal v_pix : integer range 0 to 480;
signal hs_internal : std_logic;

begin

clk25:clk_25M port map (clk=>clk,clk_25=>clock25);
HS: horizontalSync port map ( clk_25=>clock25,h_pixel=>h_pix,HS=>hs_internal);
VS: verticalSync port map (HS=>hs_internal,v_pixel=>v_pix,VS=>Vsync);
test: testImage port map(clk=>clk,h_pix=>h_pix,v_pix=>v_pix,red=>vgaRed,green=>vgaGreen,blue=>vgaBlue);
--mp: moveable_pixel port map(h_pix=>h_pix,v_pix=>v_pix,btnU=>btnU,btnD=>btnD,btnL=>btnL,btnR=>btnR,
                            --vgaRed=>vgaRed);

Hsync<=hs_internal;
end behavior;

