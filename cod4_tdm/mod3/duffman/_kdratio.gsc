/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\¯¯\/////¯¯//||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|__|/////////|__|/////////////|__|/////||
||===================================================================||
||     DO NOT USE, SHARE OR MODIFY THIS FILE WITHOUT PERMISSION      ||
||===================================================================*/

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
				if(isDefined(players[i].mc_headshot))
					players[i].mc_headshot thread FadeOut(1);
				if(isDefined(players[i].mc_streak))
					players[i].mc_streak thread FadeOut(1);
				if(isDefined(players[i].xpbar))
					players[i].xpbar thread FadeOut(1);	
				if(isdefined(players[i].camp)) {
					if(isDefined(players[i].camp.bar))
						players[i].camp.bar thread FadeOut(1);	
					players[i].camp thread FadeOut(1);	
				}
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
	if( IsDefined( self.mc_streak ) )	self.mc_streak Destroy();
	
	self.mc_streak = NewClientHudElem(self);
	self.mc_streak.x = 110;
	self.mc_streak.y = -465;
	self.mc_streak.horzAlign = "left";
	self.mc_streak.vertAlign = "bottom";
	self.mc_streak.alignX = "left";
	self.mc_streak.alignY = "middle";
	self.mc_streak.alpha = 0;
	self.mc_streak.fontScale = 1.4;
	self.mc_streak.hidewheninmenu = true;
	self.mc_streak.label = &"^2Killstreak:^1 &&1";
	self.mc_streak FadeOverTime(.5);
	self.mc_streak.alpha = 1;
	self.mc_streak.glowcolor = (0.3, 0.3, 0.3);
	self.mc_streak.glowalpha = 1;
	
	self.mc_kdratio = NewClientHudElem(self);
	self.mc_kdratio.x = 110;
	self.mc_kdratio.y = -453;
	self.mc_kdratio.horzAlign = "left";
	self.mc_kdratio.vertAlign = "bottom";
	self.mc_kdratio.alignX = "left";
	self.mc_kdratio.alignY = "middle";
	self.mc_kdratio.alpha = 0;
	self.mc_kdratio.fontScale = 1.4;
	self.mc_kdratio.hidewheninmenu = true;
	self.mc_kdratio.label = &"^2K/D Ratio:^1 &&1";
	self.mc_kdratio FadeOverTime(.5);
	self.mc_kdratio.alpha = 1;
	self.mc_kdratio.glowcolor = (0.3, 0.3, 0.3);
	self.mc_kdratio.glowalpha = 1;
	
	self.mc_headshot = NewClientHudElem(self);
	self.mc_headshot.x = 110;
	self.mc_headshot.y = -441;
	self.mc_headshot.horzAlign = "left";
	self.mc_headshot.vertAlign = "bottom";
	self.mc_headshot.alignX = "left";
	self.mc_headshot.alignY = "middle";
	self.mc_headshot.alpha = 0;
	self.mc_headshot.fontScale = 1.4;
	self.mc_headshot.hidewheninmenu = true;
	//self.mc_headshot.label = &"^2Accuracy:^7 &&1";
	self.mc_headshot.label = self getLangString("ACCURACY"); //level.lang["DEU"]["ACCURACY"];
	self.mc_headshot FadeOverTime(.5);
	self.mc_headshot.alpha = 1;
	self.mc_headshot.glowcolor = (0.3, 0.3, 0.3);
	self.mc_headshot.glowalpha = 1;
	
	
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
		self.mc_headshot.color = (2-(acu*4),acu*3,0);
		if(isDefined(acu)) self.mc_headshot SetValue( acu );
		else self.mc_headshot setValue( 0 );
		if(isdefined(self.cur_kill_streak)) self.mc_streak setValue(self.cur_kill_streak);
		else self.mc_streak setValue(0);
		self common_scripts\utility::waittill_any("disconnect","death","weapon_fired","weapon_change","player_killed");
	}
}