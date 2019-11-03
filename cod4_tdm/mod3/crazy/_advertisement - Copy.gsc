#include duffman\_common;

init()
{
	level.delay = 20;
	level thread advertisement();
}

advertisement()
{	
	while(1)
	{
	
		level hudmsg("^0Have lags visit our Fruum  coolgugo.fr");
	
		wait level.delay;
		
		level hudmsg("Welcome in ^1our server");
	
		wait level.delay;
	
		level hudmsg("^8Add in FAV our server CoD4^7 109.23.106.55:28960");
	
		wait level.delay;
		
		level hudmsg("^5TeamSpeak3:^7 109.23.106.55:9987");
		
		wait level.delay;
		
		level hudmsg("^3Recruitment Open!");
		
		wait level.delay;
		
		level hudmsg("^2-={cool.GUGO.clan}=-");
		
		wait level.delay;
	}
}

hudmsg(text) 
{
	msg = addTextHud( level, 750, 470, 1, "left", "middle", undefined, undefined, 1.6, 888 );
	msg SetText(text);
	msg.sort = 102;
	msg.foreground = 1;
	msg.archived = true;
	msg.alpha = 1;
	msg.fontScale = 1.5;
	msg.color = level.randomcolour;
	msg MoveHud(30,-1300);
	wait 20;
	msg destroy();
}