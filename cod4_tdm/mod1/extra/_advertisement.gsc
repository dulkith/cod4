#include duffman\_common;

init()
{
	level.delay = 25;
	level thread advertisement();
}

advertisement()
{	
	while(1)
	{
	
		level hudmsg("Welcome All");
	
		wait level.delay;
	
		level hudmsg("");
	
		wait level.delay;
	
		level hudmsg("");
		
		wait level.delay;
		
		level hudmsg("");
		
		wait level.delay;
		
		level hudmsg("");
		
		wait level.delay;
		
		level hudmsg("");
		
		wait level.delay;
		
		level hudmsg("");
		
		wait level.delay;
		
		level hudmsg("");
		
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