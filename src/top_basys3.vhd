--+----------------------------------------------------------------------------
--| 
--| COPYRIGHT 2018 United States Air Force Academy All rights reserved.
--| 
--| United States Air Force Academy     __  _______ ___    _________ 
--| Dept of Electrical &               / / / / ___//   |  / ____/   |
--| Computer Engineering              / / / /\__ \/ /| | / /_  / /| |
--| 2354 Fairchild Drive Ste 2F6     / /_/ /___/ / ___ |/ __/ / ___ |
--| USAF Academy, CO 80840           \____//____/_/  |_/_/   /_/  |_|
--| 
--| ---------------------------------------------------------------------------
--|
--| FILENAME      : top_basys3.vhd
--| AUTHOR(S)     : Capt Phillip Warner
--| CREATED       : 02/22/2018 Modified: 03/01/2020 by capt Dan Johnson
--| DESCRIPTION   : This file implements the top level module for the solution for Stoplight FSM.
--|
--|					Inputs:  clk 	--> 100 MHz clock from FPGA
--|                          sw(0)  --> car present
--|                          btnL   --> clk divider reset
--|                          btnC   --> FSM reset
--|							 
--|					Outputs: JA(2:0)--> Green, Yellow, Red
--|
--+----------------------------------------------------------------------------
--|
--| REQUIRED FILES : 
--|
--|    Libraries : ieee
--|    Packages  : std_logic_1164, numeric_std
--|    Files     : stoplight.vhd, clock_divider.vhd
--|
--+----------------------------------------------------------------------------
--|
--| NAMING CONVENSIONS :
--|
--|    xb_<port name>           = off-chip bidirectional port ( _pads file )
--|    xi_<port name>           = off-chip input port         ( _pads file )
--|    xo_<port name>           = off-chip output port        ( _pads file )
--|    b_<port name>            = on-chip bidirectional port
--|    i_<port name>            = on-chip input port
--|    o_<port name>            = on-chip output port
--|    c_<signal name>          = combinatorial signal
--|    f_<signal name>          = synchronous signal
--|    ff_<signal name>         = pipeline stage (ff_, fff_, etc.)
--|    <signal name>_n          = active low signal
--|    w_<signal name>          = top level wiring signal
--|    g_<generic name>         = generic
--|    k_<constant name>        = constant
--|    v_<variable name>        = variable
--|    sm_<state machine type>  = state machine type definition
--|    s_<signal name>          = state name
--|
--+----------------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity top_basys3 is
	port(
        clk     :   in std_logic;
        sw  	:   in  std_logic_vector(0 downto 0);
		JA 		:   out std_logic_vector(2 downto 0);
		btnC 	:   in  std_logic;
		btnL	: 	in  std_logic
	);
end top_basys3;

architecture top_basys3_arch of top_basys3 is 

--Declare stoplight component here 

component stoplight_fsm is  
    port(
        i_C      : in std_logic; --car
        i_reset  : in std_logic; --reset
        i_clk    : in std_logic; --clock
        o_R      : out std_logic;
        o_Y      : out std_logic;
        o_G      : out std_logic
       );
    end component stoplight_fsm;


--clock_divider component given 
component clock_divider is
	generic ( constant k_DIV : natural := 2	);
	port ( 	i_clk    : in std_logic;		   -- basys3 clk
			i_reset  : in std_logic;		   -- asynchronous
			o_clk    : out std_logic		   -- divided (slow) clock
	);
end component clock_divider;

	signal w_clk : std_logic;		--this wire provides the connection between o_clk and stoplight clk

begin
	-- PORT MAPS ----------------------------------------
	--Port map stoplight here based on the design provided
	


--Complete the clock_divider portmap below based on the design provided	
	clkdiv_inst : clock_divider 		--instantiation of clock_divider to take 
        generic map ( k_DIV => 50000000 ) -- 1 Hz clock from 100 MHz
        port map (						  
            i_clk   => clk,
            i_reset => btnL,
            o_clk   => w_clk
        );    
	
end top_basys3_arch;
