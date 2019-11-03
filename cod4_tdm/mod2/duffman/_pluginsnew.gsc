#include duffman\_common;

init( modVersion )
{
	////add new precachestrings here when you change the text/////
	precachestring( &"" );
	precachestring( &"" );
	//precacheshader("white")
	
	level.advLine[0] = newHudElem();
	level.advLine[0].x = 5;
	level.advLine[0].y = 460;
	level.advLine[0].alignx = "right";
	level.advLine[0].horzAlign = "right";
	level.advLine[0].sort = 1001;
	level.advLine[0] setShader("white", 850, 20);
	level.advLine[0].alpha = 0.2;
	level.advLine[0].glowAlpha = 0.5;
	level.advLine[0].color = (0,0,0.5);
	level.advLine[0].foreground = false;
	level.advLine[0].hidewheninmenu = false;
 
	if(isDefined(level.rulesText))
		level.rulesText destroy();
 
	level.rulesText = newHudElem();
	level.rulesText.x = 5;
	level.rulesText.y = 410;            //470 
	level.rulesText.alignX = "left";
	level.rulesText.alignY = "Middle";
	level.rulesText.horzAlign = "left";
	level.rulesText.vertAlign = "TOP";
	level.rulesText.alpha = 5;
	level.rulesText.glowAlpha = 0.6;
	level.rulesText.glowColor = (0,0,0.3);
	level.rulesText.sort = 10;
	level.rulesText.fontScale = 1.4;
	level.rulesText setShader("gradient", 100, 20);
	

	
	for(;;)
	{       
		level.rulesText setText("^7Mod Version [^22.1V^7]");
		wait 10;
		level.rulesText setText("^7Server Owners [ ^2Duka ^7]");
		wait 10;
		level.rulesText setText("^7Mod Created by [ ^2Duka ^7]");
		wait 10;
		level.rulesText setText("^7Head Admins [ ^2Duka^7 ^7]");
		wait 10;
		level.rulesText setText("^7Mod Modified by [ ^2SLeS Gaming Community ^7]");
		wait 10;

	}
}