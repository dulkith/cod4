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
	level.streakmsginuse = false;
	level.callbackMsg1 = ::madebyduff;
	level.callbackMsg2 = ::madebyduff2;
	setDvar("pl_iprintln","");
	setDvar("pl_iprintlnbold","");
	setDvar("iprintln","");
	setDvar("iprintlnbold","");
	setDvar("iprintmessage","");
	setDvar("iprintstreak","");
	switch(randomInt(20))
	{
		case 0:level.randomcolour = (1, 0, 0);break;
		case 1:level.randomcolour = (0.3, 0.6, 0.3);break;
		case 2:level.randomcolour = (0.602, 0, 0.563);break;
		case 3:level.randomcolour = (0.055, 0.746, 1);break;
		case 4:level.randomcolour = (0, 1, 0);break;
		case 5:level.randomcolour = (0.043, 0.203, 1);break;
		case 6:level.randomcolour = (0.5, 0.0, 0.8);break;
		case 7:level.randomcolour = (1.0, 0.0, 0.0);break;
		case 8:level.randomcolour = (0.9, 1.0, 0.0);break;
		case 9:level.randomcolour = (1.0, 0.0, 0.0);break;			
		case 10:level.randomcolour = (1.0, 0.0, 0.4);break;
		case 11:level.randomcolour = (1.0, 0.5, 0.0);break;
		case 12:level.randomcolour = (0.0, 0.5, 1.0);break;
		case 13:level.randomcolour = (0.5, 0.0, 0.8);break;
		case 14:level.randomcolour = (1.0, 0.0, 0.4);break;
		case 15:level.randomcolour = (0.0, 0.5, 1.0);break;
		case 16:level.randomcolour = (0.3, 0.0, 0.3);break;
		case 17:level.randomcolour = (0.0, 0.5, 1.0);break;	
		case 18:level.randomcolour = (0.5, 0.0, 0.2);break;
		case 19:level.randomcolour = (0.0, 1.0, 1.0);break;
		case 20:level.randomcolour = (0.0, 0.0, 1.0);break;
		case 21:level.randomcolour = (0.0, 1.0, 1.0);break;
		default: level.randomcolour = (0.0, 0.0, 1.0);break;
		//0.5, 0.0, 0.8 - Sexxy purple
		//1.0, 0.0, 0.0 - Epic Red
		//1.0, 0.0, 0.4 - Preppy Pink
		//0.0, 0.8, 0.0 - Epic Green
		//0.9, 1.0, 0.0 - Banana Yellow
		//1.0, 0.5, 0.0 - Burnt Orange
		//0.0, 0.5, 1.0 - Turquoise
		//0.0, 0.0, 1.0 - Deep Blue
		//0.3, 0.0, 0.3 - Deep Purple
		//0.0, 1.0, 0.0 - Light Green
		//0.5, 0.0, 0.2 - Maroon
		//0.0, 0.0, 0.0 - Black
		//1.0, 1.0, 1.0 - White
		//0.0, 1.0, 1.0 - Cyan
	}

	while(1) {
		wait .5;
		if(getDvar("pl_iprintln") != "") {
			thread pl_iPrintln(getDvar("pl_iprintln"));
			setDvar("pl_iprintln","");
		}
		if(getDvar("pl_iprintlnbold") != "") {
			thread pl_iPrintlnBold(getDvar("pl_iprintlnbold"));
			setDvar("pl_iprintlnbold","");
		}
		if(getDvar("iprintln") != "") {
			iPrintln(getDvar("iprintln"));
			setDvar("iprintln","");
		}
		if(getDvar("iprintlnbold") != "") {
			iPrintlnBold(getDvar("iprintlnbold"));			
			setDvar("iprintlnbold","");
		}
		dvar = getDvar("iprintmessage");
		if(dvar != "" && !isSubStr(dvar,"3xP-Stats")) {
			msg(dvar);
			setDvar("iprintmessage","");
		}	
		if(getDvar("iprintstreak") != "") {
			thread streakMsg(getDvar("iprintstreak"));			
			setDvar("iprintstreak","");
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

pl_iPrintln(arg) {
	tok = StrTok(arg,"$");
	player = getPlayerByNum(tok[0]);
	if(isDefined(player)) {
		if(isDefined(tok[3])) 
			player iPrintln(tok[1] + "$" + tok[2] + "$" + tok[3]);
		else if(isDefined(tok[2])) 
			player iPrintln(tok[1] + "$" + tok[2]);
		else if(isDefined(tok[1])) 
			player iPrintln(tok[1]);
	}
}

pl_iPrintlnBold(arg) {
	tok = StrTok(arg,"$");
	player = getPlayerByNum(tok[0]);
	if(isDefined(player)) {
		if(isDefined(tok[3])) 
			player iPrintlnBold(tok[1] + "$" + tok[2] + "$" + tok[3]);
		else if(isDefined(tok[2])) 
			player iPrintlnBold(tok[1] + "$" + tok[2]);
		else if(isDefined(tok[1])) 
			player iPrintlnBold(tok[1]);
	}
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