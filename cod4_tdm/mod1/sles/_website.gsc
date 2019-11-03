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

	if(isDefined(level.rulesText))
		level.rulesText destroy();
	level.rulesText = newHudElem();
	level.rulesText.x = 75;
	level.rulesText.y = -67;
	level.rulesText.alignX = "CENTER";
	level.rulesText.alignY = "middle";
	level.rulesText.horzAlign = "left";
	level.rulesText.vertAlign = "bottom";
	level.rulesText.alpha = 1;
	level.rulesText.sort = 10;
	level.rulesText.fontScale = 1.9;
	level.rulesText setText("^8www.ducoder.com");
	

}