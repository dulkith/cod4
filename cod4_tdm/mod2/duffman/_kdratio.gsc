#include duffman\_common;


init() {

	addConnectThread(::initStats,"once");
	addConnectThread(::ShowKDRatio);
	
	wait .05;
	for(;;wait 1) {
		if( game["state"] == "playing") continue;
		players = getAllPlayers();
		for(i=0;i<players.size;i++) {
			if(isDefined(players[i])) {
				if(isDefined(players[i].mc_kdratio))
					players[i].mc_kdratio thread FadeOut(1);
				if(isDefined(players[i].hp))
					players[i].hp thread FadeOut(1);
				if(isDefined(players[i].mc_headshot))
					players[i].mc_headshot thread FadeOut(1);
				if(isDefined(players[i].mc_kills))
					players[i].mc_kills thread FadeOut(1);	
				if(isDefined(players[i].mc_deaths))
					players[i].mc_deaths thread FadeOut(1);	
				if(isDefined(players[i].mc_headshots))
					players[i].mc_headshots thread FadeOut(1);
			}
		}				
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
	if( IsDefined( self.mc_kills ) )	self.mc_kills Destroy();
	if( IsDefined( self.mc_deaths ) )	self.mc_deaths Destroy();
	if( IsDefined( self.mc_headshots ) )	self.mc_headshots Destroy();
	
	self.mc_kdratio = NewClientHudElem(self);
	self.mc_kdratio.x = 110;
	self.mc_kdratio.y = -465;
	self.mc_kdratio.horzAlign = "left";
	self.mc_kdratio.vertAlign = "bottom";
	self.mc_kdratio.alignX = "left";
	self.mc_kdratio.alignY = "middle";
	self.mc_kdratio.alpha = 0;
	self.mc_kdratio.fontScale = 1.4;
	self.mc_kdratio.hidewheninmenu = true;
	self.mc_kdratio.label = &"^3K/D Ratio^3:^1 &&1";
	self.mc_kdratio FadeOverTime(.5);
	self.mc_kdratio.alpha = 0.8;
   self.mc_kdratio.glowColor = (0, 0, 1);
   self.mc_kdratio.glowAlpha = 0;
	
	self.mc_headshot = NewClientHudElem(self);
	self.mc_headshot.x = 110;
	self.mc_headshot.y = -453;
	self.mc_headshot.horzAlign = "left";
	self.mc_headshot.vertAlign = "bottom";
	self.mc_headshot.alignX = "left";
	self.mc_headshot.alignY = "middle";
	self.mc_headshot.alpha = 0;
	self.mc_headshot.fontScale = 1.4;
	self.mc_headshot.hidewheninmenu = true;
	self.mc_headshot.label = &"^3Accuracy^3:^1 &&1";
	self.mc_headshot FadeOverTime(.5);
	self.mc_headshot.alpha = 0.8;
	
	self.mc_headshots = NewClientHudElem(self);
	self.mc_headshots.x = 110;
	self.mc_headshots.y = -441;
	self.mc_headshots.horzAlign = "left";
	self.mc_headshots.vertAlign = "bottom";
	self.mc_headshots.alignX = "left";
	self.mc_headshots.alignY = "middle";
	self.mc_headshots.alpha = 0;
	self.mc_headshots.fontScale = 1.4;
	self.mc_headshots.hidewheninmenu = true;
	self.mc_headshots.label = &"^3HeadShots^3:^1 &&1";
	self.mc_headshots FadeOverTime(.5);
	self.mc_headshots.alpha = 0.8;
	
	self.mc_kills = NewClientHudElem(self);
	self.mc_kills.x = 110;
	self.mc_kills.y = -417;
	self.mc_kills.horzAlign = "left";
	self.mc_kills.vertAlign = "bottom";
	self.mc_kills.alignX = "left";
	self.mc_kills.alignY = "middle";
	self.mc_kills.alpha = 0;
	self.mc_kills.font="objective";
	self.mc_kills.fontScale = 1.4;
	self.mc_kills.hidewheninmenu = true;
	self.mc_kills.label = &"^2Kills^3:^1 &&1";
	self.mc_kills FadeOverTime(.5);
	self.mc_kills.alpha = 0.9;
	self.mc_kills.color = ( 1.00, 0.52, 0.00 );
	
	self.mc_deaths = NewClientHudElem(self);
	self.mc_deaths.x = 110;
	self.mc_deaths.y = -402;
	self.mc_deaths.horzAlign = "left";
	self.mc_deaths.vertAlign = "bottom";
	self.mc_deaths.alignX = "left";
	self.mc_deaths.alignY = "middle";
	self.mc_deaths.alpha = 0;
	self.mc_deaths.font="objective";
	self.mc_deaths.fontScale = 1.4;
	self.mc_deaths.hidewheninmenu = true;
	self.mc_deaths.label = &"^2Deaths^3:^1 &&1";
	self.mc_deaths FadeOverTime(.5);
	self.mc_deaths.alpha = 0.9;
	self.mc_deaths.color = ( 1.00, 0.52, 0.00 );
	
	color = (0,0,0);
	first = true;
	for(;;) {
		if(first)
			first = 0;
		else 
			wait .5;//** let the code time till he MAY kill someone	
		if(!isDefined(self) || !isDefined(self.pers) || !isDefined(self.pers[ "hits" ]) || !isDefined(self.pers[ "kills" ]) || !isDefined(self.pers[ "deaths" ]) || !isDefined(self.pers[ "shoots" ]) || !isDefined(self.mc_kdratio) || !isDefined(self.mc_headshot))
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
		
		if(isDefined(acu)) self.mc_headshot SetValue( acu );
		else self.mc_headshot setValue( 0 );
		
		if(isdefined( self.pers["kills"]))
			
			self.mc_kills setValue(self.pers["kills"]);
		else self.mc_kills setValue(0);

		if(isdefined( self.pers["deaths"]))
			self.mc_deaths setValue(self.pers["deaths"]);
		else
			self.mc_deaths setValue(0);	
			
		if(isdefined(self.headshots)) 
			self.mc_headshots setValue(self.headshots);
		else 
			self.mc_headshots setValue(0);
		
		self common_scripts\utility::waittill_any("disconnect","death","weapon_fired","weapon_change","player_killed");
	}
}