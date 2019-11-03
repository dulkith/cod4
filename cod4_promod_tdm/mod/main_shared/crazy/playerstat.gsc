/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\  \/////  //||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|  |/////////|  |/////////////|  |/////||
||===================================================================*/

playerstat()
{
	self endon( "disconnect" );
	self endon( "endstats" );
	//self endon( "spawned_player" );
	
	if(isdefined(self.hud_stattext))
		self.hud_stattext destroy();
  
	if(isdefined(self.hudscore))
		self.hudscore destroy();
 
	if(isdefined(self.hudkills))
		self.hudkills destroy();
  
	if(isdefined(self.huddeaths))
		self.huddeaths destroy();
	
	if(isdefined(self.hudtime))
		self.hudtime destroy(); 
		
	if(isdefined(self.hudtime2))
		self.hudtime2 destroy(); 		
		
	self thread destroyonEnd();
  
	self.hud_stattext = newClientHudElem(self);
    self.hud_stattext.foreground = true;
	self.hud_stattext.alignX = "right";
	self.hud_stattext.alignY = "top";
	self.hud_stattext.horzAlign = "right";
    self.hud_stattext.vertAlign = "top";
    self.hud_stattext.x = 200;
    self.hud_stattext.y = 145;
    self.hud_stattext.sort = 0;
  	self.hud_stattext.fontScale = 1.4;
	self.hud_stattext.color = (0.8, 1.0, 0.8);
	self.hud_stattext.font = "objective";
	self.hud_stattext.glowColor = level.randomcolour;
	self.hud_stattext.glowAlpha = 1;
 	self.hud_stattext.hidewheninmenu = false;	
	
	self.hudscore = newClientHudElem(self);
    self.hudscore.foreground = true;
	self.hudscore.alignX = "right";
	self.hudscore.alignY = "top";
	self.hudscore.horzAlign = "right";
    self.hudscore.vertAlign = "top";
    self.hudscore.x = 200;
    self.hudscore.y = 165;
    self.hudscore.sort = 0;
  	self.hudscore.fontScale = 1.4;
	self.hudscore.color = (0.8, 1.0, 0.8);
	self.hudscore.font = "objective";
	self.hudscore.glowColor = level.randomcolour;
	self.hudscore.glowAlpha = 1;
 	self.hudscore.hidewheninmenu = false;	
	
	self.hudkills = newClientHudElem(self);
    self.hudkills.foreground = true;
	self.hudkills.alignX = "right";
	self.hudkills.alignY = "top";
	self.hudkills.horzAlign = "right";
    self.hudkills.vertAlign = "top";
    self.hudkills.x = 200;
    self.hudkills.y = 185;
    self.hudkills.sort = 0;
  	self.hudkills.fontScale = 1.4;
	self.hudkills.color = (0.8, 1.0, 0.8);
	self.hudkills.font = "objective";
	self.hudkills.glowColor = level.randomcolour;
	self.hudkills.glowAlpha = 1;
 	self.hudkills.hidewheninmenu = false;	
	
	self.huddeaths = newClientHudElem(self);
    self.huddeaths.foreground = true;
	self.huddeaths.alignX = "right";
	self.huddeaths.alignY = "top";
	self.huddeaths.horzAlign = "right";
    self.huddeaths.vertAlign = "top";
    self.huddeaths.x = 200;
    self.huddeaths.y = 205;
    self.huddeaths.sort = 0;
  	self.huddeaths.fontScale = 1.4;
	self.huddeaths.color = (0.8, 1.0, 0.8);
	self.huddeaths.font = "objective";
	self.huddeaths.glowColor = level.randomcolour;
	self.huddeaths.glowAlpha = 1;
 	self.huddeaths.hidewheninmenu = false;	
	
	self.hudtime = newClientHudElem(self);
    self.hudtime.foreground = true;
	self.hudtime.alignX = "right";
	self.hudtime.alignY = "top";
	self.hudtime.horzAlign = "right";
    self.hudtime.vertAlign = "top";
    self.hudtime.x = 200;
    self.hudtime.y = 245;
    self.hudtime.sort = 0;
  	self.hudtime.fontScale = 1.4;
	self.hudtime.color = (0.8, 1.0, 0.8);
	self.hudtime.font = "objective";
	self.hudtime.glowColor = level.randomcolour;
	self.hudtime.glowAlpha = 1;
 	self.hudtime.hidewheninmenu = false;
	
	self.hudtime2 = newClientHudElem(self);
    self.hudtime2.foreground = true;
	self.hudtime2.alignX = "right";
	self.hudtime2.alignY = "top";
	self.hudtime2.horzAlign = "right";
    self.hudtime2.vertAlign = "top";
    self.hudtime2.x = 200;
    self.hudtime2.y = 225;
    self.hudtime2.sort = 0;
  	self.hudtime2.fontScale = 1.4;
	self.hudtime2.color = (0.8, 1.0, 0.8);
	self.hudtime2.font = "objective";
	self.hudtime2.glowColor = level.randomcolour;
	self.hudtime2.glowAlpha = 1;
 	self.hudtime2.hidewheninmenu = false;	
	
	self.hud_stattext setText( "Your Stats" );
	self.hudscore.label = &"Score: &&1";
	//self.hudscore SetClockUp( 5, 60, "hudStopwatch", 64, 64 ); 
	self.hudkills.label = &"Kills: &&1";
	self.huddeaths.label = &"Deaths: &&1";
	self.hudtime2.label = &"Time: &&1";
	
	self.hudscore setValue( self.pers["score"] );
	self.hudkills setValue( self.pers["kills"] );
	self.huddeaths setValue( self.pers["deaths"] );
	self.hudtime2 setValue( 0 );
	if(self.pers["time"] == 0 )
	{
		self.hudtime.label = &"Record: &&1";
		self.hudtime setValue( 0 );
	}
	else
	{
		self.hudtime.label = &"Record: &&1";
		self.hudtime setValue( self.pers["time"] );
	}
	
	self.hud_stattext MoveTo(1.5,-10);
	self.hudscore MoveTo(1.5,-10);
	self.hudkills MoveTo(1.5,-10);
	self.huddeaths MoveTo(1.5,-10);
	self.hudtime MoveTo(1.5,-10);
	self.hudtime2 MoveTo(1.5,-10);
	
	while(1)
	{
		/*
		self.hud_stattext fadeOverTime(1);
		self.hud_stattext.alpha = 1;	
		self.hud_stat fadeOverTime(1);
		self.hud_stat.alpha = 1;	
		self.hud_stats fadeOverTime(1);
		self.hud_stats.alpha = 1;	
		self.hud_status fadeOverTime(1);
		self.hud_status.alpha = 1;
		*/					
			
		oldscore = self.pers["score"];	
		oldkills = self.pers["kills"];
		olddeaths = self.pers["deaths"];
		oldtime = self.pers["time"];
		oldyourtime = self.yourtime;
		
		while(oldscore == self.pers["score"] && oldkills == self.pers["kills"] && olddeaths == self.pers["deaths"] && oldtime == self.pers["time"] )
			wait .05;
	
		if(oldscore != self.pers["score"])
		{
			self.hudscore thread fader(self.pers["score"]);
		}
		if(oldkills != self.pers["kills"])	
		{
			self.hudkills thread fader(self.pers["kills"]);	
		}
		if(olddeaths != self.pers["deaths"])	
		{
			self.huddeaths thread fader(self.pers["deaths"]);		
		}
		if(oldtime != self.pers["time"])
		{
			self.hudtime thread fader(self.pers["time"]);
		}		
	}
}

fader(value)
{
	self fadeOverTime(.2);
	self.alpha = 0;
	wait .25;
	self setValue( value );
	self fadeOverTime(.6);
	self.alpha = 1;		
}

destroyonEnd()
{
	w8 = 2;
	
	if( game["roundsplayed"] != level.dvar["round_limit"] )
		w8 = 8;
		
	self endon("disconnect");
	level waittill("endround");
	
	wait w8;
	
/*	self.hud_stattext thread killhud();
	self.hudscore thread killhud();	
	self.hudkills thread killhud();
	self.huddeaths thread killhud();
	self.hudtime thread killhud();
	self.hudtime2 thread killhud();*/
	self.hud_stattext MoveTo(1.5,200);
	self.hudscore MoveTo(1.5,200);
	self.hudkills MoveTo(1.5,200);
	self.huddeaths MoveTo(1.5,200);
	self.hudtime MoveTo(1.5,200);
	self.hudtime2 MoveTo(1.5,200);
}

MoveTo(time,x,y)
{
	self moveOverTime(time);
	if(isDefined(x))
		self.x = x;
		
	if(isDefined(y))
		self.y = y;
}

killhud()
{
	self fadeOverTime(1);
	self.alpha = 0;
	wait 1;
	self destroy();
}

fasterfader(value)
{
	self fadeOverTime(.05);
	self.alpha = 0;
	wait .05;
	self setValue( value );
	self fadeOverTime(.05);
	self.alpha = 1;		
}