#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;


init()
{
	if(!isDefined(self.pers["introduce"]))
	{
		self thread IntroduceThisServer();
		self.pers["introduce"] = true;
		self freezeControls( true );
		self allowSpectateTeam("freelook", false);
	}
	else if( isDefined(self.pers["introduce"]) )
	{
		self freezeControls( false );
		self allowSpectateTeam("freelook", true);
	}
}


IntroduceThisServer()
{
	if(self getStat(752) == 0)
	{
		self setStat(752,1);
		self endon("disconnect");
		for(k=0;k<3;k++)
		{
			self closeMenu();
			self closeInGameMenu();
			wait .05;
		}
		shader = [];
		for(i=0;i<10;i++)
		{
			shader[i] = createHud( self, 0, 0, .6, "center", "middle", "center",1.6, 9999 + i );	
		  	shader[i].vertAlign = "middle";
		  	shader[i] thread FadeIn1(.5);
		}
		
		self freezeControls( true );
		
		shader[0] SetShader("white",400,250);
		shader[0].alpha = 0.4;
		shader[0].color = (0,.5,1);
		
		shader[1] SetShader("black",402,252);
		shader[1].alpha = 0.7;
		
		shader[2].alignX = "centre";
		shader[2].y = -118;
		shader[2].x = 0;
		shader[2].alpha = 0.7;
		shader[2] setText( "^1 Rules" );
		
		shader[3].alignX = "centre";
		shader[3].y = -100;
		shader[3].x = 0;
		shader[3].alpha = 0.7;
		shader[3] setText( "^5Dont Be Asking For Admin It Can Get you permban" );
		
		shader[4].alignX = "centre";
		shader[4].y = -60;
		shader[4].x = 0;
		shader[4].alpha = 0.7;
		shader[4] setText( "^5Roccat/Aimbot/Cheating Will Get you Permban" );
		
		shader[5].alignX = "centre";
		shader[5].y = -20;
		shader[5].x = 0;
		shader[5].alpha = 0.7;
		shader[5] setText( "^5Glitching/elevators Will Get You a Tempban" );
		
		shader[6].alignX = "centre";
		shader[6].y = 20;
		shader[6].x = 10;
		shader[6].alpha = 0.7;
		shader[6] setText( "^5No Bad language Or Racism Towards Others" );
		
		shader[7].alignX = "centre";
		shader[7].y = 60;
		shader[7].x = -0;
		shader[7].alpha = 0.7;
		shader[7] setText( "^5Respect RS Members And All players" );
		
		shader[8].alignX = "centre";
		shader[8].y = 100;
		shader[8].x = -0;
		shader[8].alpha = 0.7;
		shader[8] setText( "^5Enjoy Your Stay In Our Server" );
		
		shader[9].x = 180;
		shader[9].y = 110;
		shader[9].alpha = 0.7;
		shader[9] SetTenthsTimer(20);
		shader[9].alignX = "right";
		
		wait 20;
		
		shader[9].label = &"&&1";
		shader[9] setText( "[{+activate}] To Exit" );
		while(!self UseButtonPressed()) wait .05;
		for(i=0;i<10;i++)
			shader[i] thread FadeOut1(1,true,"left");
		self thread init();
	}
}

FadeOut1(time,slide,dir)
{	
	if(!isDefined(self)) return;
	if(isdefined(slide) && slide)
	{
		self MoveOverTime(0.2);
		if(isDefined(dir) && dir == "right") self.x+=600;
		else self.x-=600;
	}
	self fadeovertime(time);
	self.alpha = 0;
	wait time;
	if(isDefined(self)) self destroy();
}
FadeIn1(time,slide,dir)
{
	if(!isDefined(self)) return;
	if(isdefined(slide) && slide)
	{
		if(isDefined(dir) && dir == "right") self.x+=600;
		else self.x-=600;	
		self moveOverTime( .2 );
		if(isDefined(dir) && dir == "right") self.x-=600;
		else self.x+=600;
	}
	alpha = self.alpha;
	self.alpha = 0;
	self fadeovertime(time);
	self.alpha = alpha;
}
createHud( who, x, y, alpha, alignX, alignY, vert, fontScale, sort )
{
	if( isPlayer( who ) ) hud = newClientHudElem( who );
	else hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.alignX = alignX;
	hud.alignY = alignY;
	if(isdefined(vert))
		hud.horzAlign = vert;
	if(fontScale != 0)
		hud.fontScale = fontScale;
	return hud;
}