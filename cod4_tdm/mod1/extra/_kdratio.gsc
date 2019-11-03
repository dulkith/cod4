#include maps\mp\gametypes\_common;

init() 
{

	addConnectThread(::initStats,"once");
	addConnectThread(::ShowKDRatio);
	wait .05;
	for(;;wait 1) {
		if( game["state"] == "playing") continue;
		players = getAllPlayers();
		for(i=0;i<players.size;i++) 
	}
}

initStats() {
	self.pers["shoots"] = 1;
	self.pers["hits"] = 1;	
}

ShowKDRatio()
{
	self notify( "new_KDRRatio" );
	self endon( "new_KDRRatio" );
	self endon( "disconnect" );
	wait 1;
	if( IsDefined( self.mc_kdratio ) )	self.mc_kdratio Destroy();
	if( IsDefined( self.mc_headshot ) )	self.mc_headshot Destroy();
	if( IsDefined( self.mc_streak ) )	self.mc_streak Destroy();
	
	self.mc_kdratio = NewClientHudElem(self);
	self.mc_kdratio.x = 6;
	self.mc_kdratio.y = -34;
	self.mc_kdratio.horzAlign = "left";
	self.mc_kdratio.vertAlign = "bottom";
	self.mc_kdratio.alignX = "left";
	self.mc_kdratio.alignY = "middle";
	self.mc_kdratio.alpha = 0;
	self.mc_kdratio.fontScale = 1.4;
	self.mc_kdratio.hidewheninmenu = true;
	self.mc_kdratio.label = &"^7K^5/^1D ^2Ratio: ^7&&1";
	self.mc_kdratio FadeOverTime(.5);
	self.mc_kdratio.alpha = 1;
	
	self.mc_headshot = NewClientHudElem(self);
	self.mc_headshot.x = 6;
	self.mc_headshot.y = -22;
	self.mc_headshot.horzAlign = "left";
	self.mc_headshot.vertAlign = "bottom";
	self.mc_headshot.alignX = "left";
	self.mc_headshot.alignY = "middle";
	self.mc_headshot.alpha = 0;
	self.mc_headshot.fontScale = 1.4;
	self.mc_headshot.hidewheninmenu = true;
	self.mc_headshot.label = &"^1A^2ccuracy: ^7&&1";
	self.mc_headshot FadeOverTime(.5);
	self.mc_headshot.alpha = 1;
	
	self.mc_streak = NewClientHudElem(self);
	self.mc_streak.x = 6;
	self.mc_streak.y = -10;
	self.mc_streak.horzAlign = "left";
	self.mc_streak.vertAlign = "bottom";
	self.mc_streak.alignX = "left";
	self.mc_streak.alignY = "middle";
	self.mc_streak.alpha = 0;
	self.mc_streak.fontScale = 1.4;
	self.mc_streak.hidewheninmenu = true;
	self.mc_streak.label = &"^1K^2illstreak: ^7&&1";
	self.mc_streak FadeOverTime(.5);
	self.mc_streak.alpha = 1;

	
	color = (0,0,0);
	first = true;
	for(;;) {
		if(first)
			first = 0;
		else 
			wait .5;//** let the code time till he MAY kill someone	
		if(!isDefined(self) || !isDefined(self.pers) || !isDefined(self.pers[ "hits" ]) || !isDefined(self.pers[ "kills" ]) || !isDefined(self.pers[ "deaths" ]) || !isDefined(self.pers[ "shoots" ]) || !isDefined(self.mc_kdratio) || !isDefined(self.mc_headshot) || !isDefined(self.mc_streak))
			return;	
		if( IsDefined( self.pers[ "kills" ] ) && IsDefined( self.pers[ "deaths" ] ) ) {
			if( self.pers[ "deaths" ] < 1 ) ratio = self.pers[ "kills" ];
			else ratio = int( self.pers[ "kills" ] / self.pers[ "deaths" ] * 100 ) / 100;
			if(ratio < 1) color = (1,ratio / 2,0);
			else if(ratio > 1) color = (1.7 - ratio,1,0);
			else color = (1,1,0);				
			self.mc_kdratio FadeOverTime(.5);
			self.mc_kdratio.color = color;
			self.mc_kdratio setValue(ratio);
		}
		
		acu = int(self.pers[ "hits" ] / self.pers[ "shoots" ] * 10000)/100;
		
		self.mc_headshot FadeOverTime(.5);
			if(isDefined(acu)) self.mc_headshot SetValue( acu );
		else self.mc_headshot setValue( 0 );
		if(isdefined(self.cur_kill_streak)) self.mc_streak setValue(self.cur_kill_streak);
		else self.mc_streak setValue(0);
		self common_scripts\utility::waittill_any("disconnect","death","weapon_fired","weapon_change","player_killed");
	}
}