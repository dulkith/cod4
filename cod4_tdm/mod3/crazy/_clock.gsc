//  ________/\\\\\\\\\__________________________________________________________        
//   _____/\\\////////___________________________________________________________       
//    ___/\\\/_________________________________________________________/\\\__/\\\_      
//     __/\\\______________/\\/\\\\\\\___/\\\\\\\\\_____/\\\\\\\\\\\___\//\\\/\\\__     
//      _\/\\\_____________\/\\\/////\\\_\////////\\\___\///////\\\/_____\//\\\\\___    
//       _\//\\\____________\/\\\___\///____/\\\\\\\\\\_______/\\\/________\//\\\____   
//        __\///\\\__________\/\\\__________/\\\/////\\\_____/\\\/_______/\\_/\\\_____  
//         ____\////\\\\\\\\\_\/\\\_________\//\\\\\\\\/\\__/\\\\\\\\\\\_\//\\\\/______ 
//          _______\/////////__\///___________\////////\//__\///////////___\////________
#include maps\mp\_utility;

init()
{
	wait 1;
	if(level.instrattime)
		level thread Clock();
}

Clock()
{
	level.clockTime = [];
	level.clock = true;
	
	level.clockTime[0] = newHudElem();
	level.clockTime[0].elemType = "font";
	level.clockTime[0].x = -20;
	level.clockTime[0].y = 2;
	level.clockTime[0].alignx = "right";
	level.clockTime[0].horzAlign = "right";
	level.clockTime[0].sort = 1002;
	level.clockTime[0].alpha = 1;
	level.clockTime[0].glowalpha = 1;
	level.clockTime[0].color = (0.0, 1.0, 0.0);
	level.clockTime[0].glowcolor = (0.3, 0.3, 0.3);
	level.clockTime[0].fontscale = 1.4;
	level.clockTime[0].foreground = false;
	level.clockTime[0].hidewheninmenu = false;
	
	level.clockTime[1] = newHudElem();
	level.clockTime[1].x = 0;
	level.clockTime[1].y = 1;
	level.clockTime[1].alignx = "right";
	level.clockTime[1].horzAlign = "right";
	level.clockTime[1].sort = 1001;
	level.clockTime[1] setShader("gradient", 100, 20);
	level.clockTime[1].alpha = 0.5;
	level.clockTime[1].glowAlpha = 0.3;
	level.clockTime[1].color = (0.25,0.51,0.68);
	level.clockTime[1].foreground = false;
	level.clockTime[1].hidewheninmenu = false;
	
	level thread ClockTimer();
	
	if(level.instrattime)
		level waittill("clock_over");
	else
		wait 8;
	
	for(i=0;i<level.clockTime.size;i++)
	{
		level.clockTime[i] moveOverTime(3);
		level.clockTime[i].x = 300;
	}
	level.clock = false;
	wait 4;
	for(i=0;i<level.clockTime.size;i++)
		level.clockTime[i] destroy();
		
	level notify("stoptime");
}

ClockTimer()
{
	level endon("stoptime");
	
	while(level.clock)
	{
		timedisplay = TimeToString(getRealTime(),1, "%r");
		level.clockTime[0] setText(timedisplay);
		wait 1;			
	}
}