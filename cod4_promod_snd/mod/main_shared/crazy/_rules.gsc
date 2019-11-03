/*
 
^1 = red
^2 = green
^3 = yellow
^4 = blue
^5 = cyan(light blue)
^6 = pink
^7 = white
^8 = Axis killfeed colour
^9 = Allies killfeed colour
^0 = Black
 
*/
 
 
 
init( modVersion )
{
	////add new precachestrings here when you change the text/////
	precachestring( &"" );
	precachestring( &"" );
 
 
 
	if(isDefined(level.rulesText))
		level.rulesText destroy();
 
	level.rulesText = newHudElem();
	level.rulesText.x = 150;
	level.rulesText.y = 20;            //470 
	level.rulesText.alignX = "CENTER";
	level.rulesText.alignY = "Middle";
	level.rulesText.horzAlign = "CENTER";
	level.rulesText.vertAlign = "TOP";
	level.rulesText.alpha = 5;
	level.rulesText.sort = 10;
	level.rulesText.fontScale = 1.4;
 
	if(isDefined(level.rulesTitle))
		level.rulesTitle destroy();
 
	level.rulesTitle = newHudElem();
	level.rulesTitle.x = 130;
	level.rulesTitle.y = 10;          //110
	level.rulesTitle.alignX = "CENTER";
	level.rulesTitle.alignY = "Middle";
	level.rulesTitle.horzAlign = "CENTER";
	level.rulesTitle.vertAlign = "TOP";
	level.rulesTitle.alpha = 10;
	level.rulesTitle.sort = 10;
    level.rulesTitle.fontScale = 1.4;
	level.rulesTitle setText("");
	for(;;)
	{       
		level.rulesText setText("^7We are ^2^3[SL^2e^3SPORT]");
		//level.rulesText setText("^1Happy wesak festival for Sri Lankans.^2^3[SL^2e^3SPORT] ^7Team.");
		wait 20;
		level.rulesText setText(" ");
		wait 2;
		level.rulesText setText("^1Press 8 ^3On/Off ^2FPS");
		wait 10;
		level.rulesText setText(" ");
		wait 2;
		level.rulesText setText("^1Press 9 ^3change ^2FOV");
		wait 2;
		level.rulesText setText(" ");
		wait 2;
		level.rulesText setText("^1TeamSpeak3 IP ^3209.58.178.174");
		wait 2;       
		//level.rulesText setText("^7We are ^2^3[SL^2e^3SPORT] ^0- ^3Sri Lanka");
		//wait 10;
		//level.rulesText setText(" ");
		//wait 10;
		level.rulesText setText("^7Type ^1!register ^7& use more ^3features.");
		wait 2;
		level.rulesText setText(" ");
		wait 2;
		level.rulesText setText("^7Type ^1!help ^7to view your ^3commands.");
		wait 2;
		level.rulesText setText(" ");
		wait 5;
		level.rulesText setText("^7Type ^1!xlrstats ^7& view your ^3stats .");
		wait 2;
		level.rulesText setText(" ");
		wait 2;
		level.rulesText setText("^7Now server admins can take ^1player's screenshots. ");
		wait 2;
		level.rulesText setText(" ");
		wait 2;
		level.rulesText setText("^4FB ^2Group ^0: ^3www.fb.com/groups/callofdoggy/");
		wait 2;
		level.rulesText setText(" ");
		wait 2;
		level.rulesText setText("^3Rule #: ^1Respect ^3All Players");
		wait 2;
		level.rulesText setText(" ");
		wait 2;
		level.rulesText setText("^3Rule #: ^1No ^3arguing with admins");
		wait 2;
		level.rulesText setText(" ");
		wait 2;
		level.rulesText setText("^3Using ^1cheats ^3and ^1scripts ^3will get an instant ^1ban");
		wait 2;
		level.rulesText setText(" ");
		wait 2;
		level.rulesText setText("^7SL^1e^7S ^1TDM ^0: ^3209.58.178.174:28960 ");
		wait 2;
		level.rulesText setText(" ");
		wait 2;
	}
}