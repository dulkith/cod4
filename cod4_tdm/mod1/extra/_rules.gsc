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
	level.rulesText.x = 10;
	level.rulesText.y = 470;            //470 
	level.rulesText.alignX = "CENTER";
	level.rulesText.alignY = "Middle";
	level.rulesText.horzAlign = "CENTER";
	level.rulesText.vertAlign = "TOP";
	level.rulesText.alpha = 1;
	level.rulesText.sort = 10;
	level.rulesText.fontScale = 1.5;
 
	if(isDefined(level.rulesTitle))
		level.rulesTitle destroy();
 
	level.rulesTitle = newHudElem();
	level.rulesTitle.x = 10;
	level.rulesTitle.y = 110;          //110
	level.rulesTitle.alignX = "CENTER";
	level.rulesTitle.alignY = "Middle";
	level.rulesTitle.horzAlign = "CENTER";
	level.rulesTitle.vertAlign = "TOP";
	level.rulesTitle.alpha = 1;
	level.rulesTitle.sort = 10;
    level.rulesTitle.fontScale = 1.4;
	level.rulesTitle setText("");
	for(;;)
	{
                                level.rulesText setText("^2 Welcome All");
                                wait 5;
		level.rulesText setText("^2 -={cool.GUGO.clan}=-");
		wait 10;
		level.rulesText setText("");
		wait 10;
		level.rulesText setText("^1TS3 ^7voice.freets3.ovh:4366");
		wait 10;
		level.rulesText setText("");
		wait 10;
		level.rulesText setText("");
		wait 10;
	}
}