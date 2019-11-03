/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\¯¯\/////¯¯//||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|__|/////////|__|/////////////|__|/////||
||===================================================================||
||     DO NOT USE, SHARE OR MODIFY THIS FILE WITHOUT PERMISSION      ||
||===================================================================*/

#include duffman\_common;
init()
{
	level.byduff1 = false;
	level.byduff2 = false;
	level.callbackMsg1 = ::madebyduff;
	level.callbackMsg2 = ::madebyduff2;
	setDvar("iprintln","");
	setDvar("iprintlnbold","");

	while(1)
	{
		wait .5;
		if(getDvar("iprintln") != "")
		{
			iPrintln(getDvar("iprintln"));
			setDvar("iprintln","");
		}
		if(getDvar("iprintlnbold") != "")
		{
			iPrintlnBold(getDvar("iprintlnbold"));			
			setDvar("iprintlnbold","");
		}		
	}
}

streakMsg(text) {
	while(level.streakmsginuse) 
		wait .05;
	level.streakmsginuse = true;
	msg = addTextHud( level, 750, 470, 1, "left", "middle", undefined, undefined, 1.6, 888 );
	msg SetText(text);
	msg MoveHud(10,-1300);
	wait 2.5;
	level.streakmsginuse = false;
	wait 8.55;
	msg destroy();
}

madebyduff( start_offset, movetime, mult, text )
{
	while(level.byduff1)
		wait .05;
	waittillframeend;
	level.byduff1 = true;
	start_offset *= mult;
	hud = schnitzel( "center", 0.1, start_offset, -130 );
	hud setText( text );
	hud moveOverTime( movetime );
	hud.x = 0;
	wait( movetime );
	wait( 3 );
	level.byduff1 = false;
	hud moveOverTime( movetime );
	hud.x = start_offset * -1;
	wait movetime;
	hud destroy();
}

madebyduff2( start_offset, movetime, mult, text )
{
	if(level.byduff2 && !level.byduff1)
	{
		thread madebyduff( start_offset, movetime, mult, text );
		return;
	}
	else if(level.byduff2 && level.byduff1)
		while(level.byduff2)
			wait .05;
	waittillframeend;
	level.byduff2 = true;	
	start_offset *= mult;
	hud = schnitzel( "center", 0.1, start_offset, -105 );
	hud setText( text );
	hud moveOverTime( movetime );
	hud.x = 0;
	wait( movetime );
	wait( 3 );
	level.byduff2 = false;
	hud moveOverTime( movetime );
	hud.x = start_offset * -1;
	wait movetime;
	hud destroy();
}

schnitzel( align, fade_in_time, x_off, y_off )
{
	hud = newHudElem();
    hud.foreground = true;
	hud.x = x_off;
	hud.y = y_off;
	hud.alignX = align;
	hud.alignY = "middle";
	hud.horzAlign = align;
	hud.vertAlign = "middle";
 	hud.fontScale = 2;
	hud.color = (1, 1, 1);
	hud.font = "objective";
	hud.glowColor = level.randomcolour;
	hud.glowAlpha = 1;
	hud.alpha = 1;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
}