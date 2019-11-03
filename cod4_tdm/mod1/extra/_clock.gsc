#include maps\mp\_utility;
#include duffman\_common;


init()
{
	level endon("disconnect");
	
	level.clock = true;
	level.clockTime = [];
	
	if( level.clock )
	{
		if(level.instrattime)
		{
			level.clockTime[0] = newHudElem();
			level.clockTime[0].elemType = "font";
			level.clockTime[0].x = -20;
			level.clockTime[0].y = 2;
			level.clockTime[0].alignx = "right";
			level.clockTime[0].horzAlign = "right";
			level.clockTime[0].sort = 1002;
			level.clockTime[0].alpha = 1;
			level.clockTime[0].fontscale = 1.4;
			level.clockTime[0].foreground = false;
			level.clockTime[0].hidewheninmenu = false;
			
			level.clockTime[1] = newHudElem();
			level.clockTime[1].x = 0;
			level.clockTime[1].y = 0;
			level.clockTime[1].alignx = "right";
			level.clockTime[1].horzAlign = "right";
			level.clockTime[1].sort = 1001;
			level.clockTime[1] setShader("gradient", 80, 20);
			level.clockTime[1].alpha = 0.7;
			level.clockTime[1].color = (0.25,0.51,0.68);
			level.clockTime[1].glowAlpha = 0.3;
			level.clockTime[1].foreground = false;
			level.clockTime[1].hidewheninmenu = false;
			
			level thread ClockTimer();
		
			level waittill("clock_over");
			
			for(i=0;i<level.clockTime.size;i++)
			{
				level.clockTime[i] moveOverTime(5);
				level.clockTime[i].x = 300;
			}
			level.clock = false;
			wait 6;
			for(i=0;i<level.clockTime.size;i++)
				level.clockTime[i] destroy();
		}
	}
}

ClockTimer()
{
	level endon("disconnect");
	level endon( "stop_clock" );
	
	while(level.clock)
	{
		time = getRealTime();
		timedisplay = TimeToString(time,0,"%H:%M:%S");
		level.clockTime[0] setText(timedisplay);
		wait 1;			
	}
}