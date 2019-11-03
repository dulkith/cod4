#include duffman\_common;

init()
{
	level.delay = 3;
	level thread advertisement();
}

advertisement()
{	
	while(1)
	{
		
		level hudmsg("^7Type ^2!register ^7to register & get access for more ^3b3_commands");
		
		wait level.delay;
		
		level hudmsg("^7If You have any ^3Complaints and Suggestions ^7contact ^2.:: sL Asi ::.");
		
		wait level.delay;
		
		level hudmsg("^7You Can ^2Donate^7 us Via contacting an ^3Superadmin for AdminPowers");
		
		wait level.delay;
		
		level hudmsg("^7Using ^3wall-hacks , Weponbinds & any other types of hacks^7 are ^2prohibited ^7in this server");
		
		wait level.delay;
		
		level hudmsg("^7Like Facebook fanpage : ^2facebook.com/sles.hosting");
		
		wait level.delay;
		
		level hudmsg("^7Contact our hosting Provider via mail :^5mmallawa3062@gmail.com");
		
		wait level.delay;
		
		level hudmsg("^7Daily Visitors will get ^3Promoted.");
		
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
	msg.alpha = 0.8;
	msg.fontScale = 1.4;
	msg.glowColor = ( 0.3,0.3,0.8 );
	msg MoveHud(30,-1300);
	wait 20;
	msg destroy();
}
