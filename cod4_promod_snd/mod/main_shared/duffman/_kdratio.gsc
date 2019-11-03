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


init()
{

	addConnectThread(::initStats,"once");
	addConnectThread(::ShowKDRatio);
	wait .05;
	for(;;wait 1)
	{
		if( game["state"] == "playing") continue;
		players = getAllPlayers();
		for(i=0;i<players.size;i++)
		{
			if(isDefined(players[i]))
			{
				if(isDefined(players[i].mc_kdratio))
					players[i].mc_kdratio thread FadeOut(1);
				if(isDefined(players[i].mc_accuracy))
					players[i].mc_accuracy thread FadeOut(1);
				if(isDefined(players[i].mc_streak))
					players[i].mc_streak thread FadeOut(1);
				if(isDefined(players[i].hudkills))
					players[i].hudkills thread FadeOut(1);
				if(isDefined(players[i].huddeaths))
					players[i].huddeaths thread FadeOut(1);
				if(isDefined(players[i].hudscore))
					players[i].hudscore thread FadeOut(1);
				if(isDefined(players[i].hudheadshots))
					players[i].hudheadshots thread FadeOut(1);
				if(isDefined(players[i].countedFPS))
					players[i].countedFPS thread FadeOut(1);
				
			}
		}				
	}
}

initStats() {
	self.pers["shoots"] = 1;
	self.pers["hits"] = 1;
	if(!isDefined(self.pers["gottags"]))
		self.pers["gottags"] = 0;
}

ShowKDRatio()
{
	self notify( "new_KDRRatio" );
	self endon( "new_KDRRatio" );
	self endon( "disconnect" );
	
	wait 1;
	if( IsDefined( self.mc_kdratio ) )	self.mc_kdratio Destroy();
	if( IsDefined( self.mc_accuracy ) )	self.mc_accuracy Destroy();
	if( IsDefined( self.mc_streak ) )	self.mc_streak Destroy();
	if( IsDefined( self.mc_kc ) )	self.mc_kc Destroy();
	if( IsDefined( self.hudkills ) )	self.hudkills Destroy();
	if( IsDefined( self.huddeaths ) )	self.huddeaths Destroy();
	if( IsDefined( self.hudscore ) )	self.hudscore Destroy();
	if( IsDefined( self.hudheadshots ) )	self.hudheadshots Destroy();
	if( IsDefined( self.countedFPS ) )	self.countedFPS Destroy();
	
	//if( IsDefined( self.detailsBackground ) )	self.detailsBackground Destroy();
	
	/*
	self.detailsBackground = [];
	self.detailsBackground[1] = newclientHudElem(self);
	self.detailsBackground[1].x = 110;
	self.detailsBackground[1].y = 8;
	self.detailsBackground[1].alignx = "left";
	self.detailsBackground[1].horzAlign = "left";
	self.detailsBackground[1].sort = 901;
	self.detailsBackground[1] setShader("white", 95, 110);
	self.detailsBackground[1].alpha = 0.2;
	self.detailsBackground[1].glowAlpha = 0.4;
	self.detailsBackground[1].color = (0,0,0);
	self.detailsBackground[1].foreground = false;
	self.detailsBackground[1].hidewheninmenu = true;
	self.detailsBackground[1].archived = false;
	*/
	
	self.mc_streak = NewClientHudElem(self);
	self.mc_streak.x = 115;
	self.mc_streak.y = -459;
	self.mc_streak.horzAlign = "left";
	self.mc_streak.vertAlign = "bottom";
	self.mc_streak.alignX = "left";
	self.mc_streak.alignY = "middle";
	self.mc_streak.alpha = 0;
	self.mc_streak.fontScale = 1.4;
	self.mc_streak.hidewheninmenu = true;
	self.mc_streak.label = &"Killstreak:^7 &&1";
	self.mc_streak FadeOverTime(.5);
	self.mc_streak.alpha = 0.8;
	self.mc_streak.color = (0.1,1,0.6);
	//self.mc_streak.glowcolor = (0.1,1,0.6);
	self.mc_streak.glowalpha = 0.5;
	self.mc_streak.foreground = 1;
	
	/////////////////
	self.hudkills = NewClientHudElem(self);
	self.hudkills.x = 120;
	self.hudkills.y = -407;
	self.hudkills.horzAlign = "left";
	self.hudkills.vertAlign = "bottom";
	self.hudkills.alignX = "left";
	self.hudkills.alignY = "middle";
	self.hudkills.alpha = 0;
	self.hudkills.fontScale = 1.8;
	self.hudkills.hidewheninmenu = true;
	self.hudkills.label = &"Kills^7: &&1";
	self.hudkills FadeOverTime(.5);
	self.hudkills.alpha = 0.9;
	self.hudkills.color = (0.2,0.6,1);
	self.hudkills.glowcolor = (0.2,0.6,1);
	self.hudkills.glowalpha = 1;
	self.hudkills.foreground = 1;
	
	self.huddeaths = NewClientHudElem(self);
	self.huddeaths.x = 120;
	self.huddeaths.y = -393;
	self.huddeaths.horzAlign = "left";
	self.huddeaths.vertAlign = "bottom";
	self.huddeaths.alignX = "left";
	self.huddeaths.alignY = "middle";
	self.huddeaths.alpha = 0;
	self.huddeaths.fontScale = 1.8;
	self.huddeaths.hidewheninmenu = true;
	self.huddeaths.label = &"Deaths^7: &&1";
	self.huddeaths FadeOverTime(.5);
	self.huddeaths.alpha = 0.9;
	self.huddeaths.color = (0.9,0.1,0.2);
	self.huddeaths.glowcolor = (0.9,0.1,0.2);
	self.huddeaths.glowalpha = 1;
	self.huddeaths.foreground = 1;
	
	self.hudheadshots = NewClientHudElem(self);
	self.hudheadshots.x = 115;
	self.hudheadshots.y = -423;
	self.hudheadshots.horzAlign = "left";
	self.hudheadshots.vertAlign = "bottom";
	self.hudheadshots.alignX = "left";
	self.hudheadshots.alignY = "middle";
	self.hudheadshots.alpha = 0;
	self.hudheadshots.fontScale = 1.4;
	self.hudheadshots.hidewheninmenu = true;
	self.hudheadshots.label = &"Headshots:^7 &&1";
	self.hudheadshots FadeOverTime(.5);
	self.hudheadshots.alpha = 0.8;
	self.hudheadshots.color = (0.1,1,0.6);
	//self.hudheadshots.glowcolor = (0.1,1,0.6);
	self.hudheadshots.glowalpha = 0.5;
	self.hudheadshots.foreground = 1;
	
	self.hudscore = NewClientHudElem(self);
	self.hudscore.x = 120;
	self.hudscore.y = -377;
	self.hudscore.horzAlign = "left";
	self.hudscore.vertAlign = "bottom";
	self.hudscore.alignX = "left";
	self.hudscore.alignY = "middle";
	self.hudscore.alpha = 0;
	self.hudscore.fontScale = 1.8;
	self.hudscore.hidewheninmenu = true;
	self.hudscore.label = &"Score: &&1";	
	self.hudscore FadeOverTime(.5);
	self.hudscore.alpha = 0.9;
	self.hudscore.glowcolor = (0.8, 0.8, 0.8);
	self.hudscore.glowalpha = 1;
	self.hudscore.foreground = 1;
	////////////////////
	
	self.mc_kdratio = NewClientHudElem(self);
	self.mc_kdratio.x = 115;
	self.mc_kdratio.y = -447;
	self.mc_kdratio.horzAlign = "left";
	self.mc_kdratio.vertAlign = "bottom";
	self.mc_kdratio.alignX = "left";
	self.mc_kdratio.alignY = "middle";
	self.mc_kdratio.alpha = 0;
	self.mc_kdratio.fontScale = 1.4;
	self.mc_kdratio.hidewheninmenu = true;
	self.mc_kdratio.label = &"K/D Ratio: ^7&&1";
	self.mc_kdratio FadeOverTime(.5);
	self.mc_kdratio.alpha = 0.8;
	self.mc_kdratio.color = (0.1,1,0.6);
	//self.mc_kdratio.glowcolor = (0.1,1,0.6);
	self.mc_kdratio.glowalpha = 0.5;
	self.mc_kdratio.foreground = 1;

	self.mc_accuracy = NewClientHudElem(self);
	self.mc_accuracy.x = 115;
	self.mc_accuracy.y = -435;
	self.mc_accuracy.horzAlign = "left";
	self.mc_accuracy.vertAlign = "bottom";
	self.mc_accuracy.alignX = "left";
	self.mc_accuracy.alignY = "middle";
	self.mc_accuracy.alpha = 0;
	self.mc_accuracy.fontScale = 1.4;
	self.mc_accuracy.hidewheninmenu = true;
	self.mc_accuracy.label = &"Accuracy:^7 &&1";
	//self.mc_accuracy.label = self getLangString("ACCURACY"); //level.lang["DEU"]["ACCURACY"];
	self.mc_accuracy FadeOverTime(.5);
	self.mc_accuracy.alpha = 0.8;
	self.mc_accuracy.color = (0.1,1,0.6);;
	//self.mc_accuracy.glowcolor = (0.1,1,0.6);
	self.mc_accuracy.glowalpha = 0.5;
	self.mc_accuracy.foreground = 1;
	
	self.countedFPS = NewClientHudElem(self);
	self.countedFPS.x = -9;
	self.countedFPS.y = -139;
	self.countedFPS.horzAlign = "right";
	self.countedFPS.vertAlign = "bottom";
	self.countedFPS.alignX = "right";
	self.countedFPS.alignY = "bottom";
	self.countedFPS.alpha = 0;
	self.countedFPS.fontScale = 1.4;
	self.countedFPS.hidewheninmenu = false;
	self.countedFPS.label = &"FPS: &&1";	
	self.countedFPS FadeOverTime(.5);
	self.countedFPS.alpha = 0.9;
	//self.countedFPS.glowcolor = (0.8, 0.8, 0.8);
	self.countedFPS.glowalpha = 1;
	self.countedFPS.foreground = 1;
	
	if(level.gametype == "kc")
	{
		self.mc_kc = NewClientHudElem(self);
		self.mc_kc.x = 112;
		self.mc_kc.y = -428;
		self.mc_kc.horzAlign = "left";
		self.mc_kc.vertAlign = "bottom";
		self.mc_kc.alignX = "left";
		self.mc_kc.alignY = "middle";
		self.mc_kc.alpha = 0;
		self.mc_kc.fontScale = 1.4;
		self.mc_kc.hidewheninmenu = true;
		self.mc_kc.label = &"^2Kill confirms:^1 &&1";
		self.mc_kc FadeOverTime(.5);
		self.mc_kc.alpha = 1;
		self.mc_kc.glowcolor = (0.3, 0.3, 0.3);
		self.mc_kc.glowalpha = 1;
	}
	
	color = (0,0,0);
	first = true;
	for(;;)
	{
		h = self.pers[ "headshots" ];
		k = self.pers[ "kills" ];
		d = self.pers[ "deaths" ];
		s = self.pers[ "score" ];
		f = self getCountedFPS();
		
		if(first)
			first = 0;
		else 
			wait .5;//** let the code time till he MAY kill someone	
		if(!isDefined(self) || !isDefined(self.pers) || !isDefined(self.pers[ "hits" ]) || !isDefined(self.pers[ "kills" ]) || !isDefined(self.pers[ "deaths" ]) || !isDefined(self.pers[ "shoots" ]) || !isDefined(self.mc_kdratio) || !isDefined(self.mc_accuracy) || !isDefined(self.mc_streak))
			return;	
		if( IsDefined( self.pers[ "kills" ] ) && IsDefined( self.pers[ "deaths" ] ) )
		{
			if( self.pers[ "deaths" ] < 1 ) ratio = self.pers[ "kills" ];
			else ratio = int( self.pers[ "kills" ] / self.pers[ "deaths" ] * 100 ) / 100;
			if(ratio < 1) color = (1,ratio / 2,0);
			else if(ratio > 1) color = (1.7 - ratio,1,0);
			else color = (1,1,0);				
			self.mc_kdratio FadeOverTime(.5);
			//self.mc_kdratio.color = color;
			self.mc_kdratio setValue(ratio);
		}
		acu = int(self.pers[ "hits" ] / self.pers[ "shoots" ] * 10000)/100;
		self.mc_accuracy FadeOverTime(.5);
		if(acu < 10.00) color1 = (0.9, 0.3, 0.0);
			else color1 = (0, 1.0, 0);
		//self.mc_accuracy.color = color1;
		if(isDefined(acu)) self.mc_accuracy SetValue( acu );
		else self.mc_accuracy setValue( 100 );
		self.hudkills SetValue( k );
		self.huddeaths SetValue( d );
		self.hudscore SetValue( s );
		self.hudheadshots SetValue( h );
		self.countedFPS SetValue( f );
		if(isdefined(self.cur_kill_streak)) self.mc_streak setValue(self.cur_kill_streak);
		else self.mc_streak setValue(0);
		if(level.gametype == "kc")
			self.mc_kc setValue( self.pers["gottags"] );
		self common_scripts\utility::waittill_any("disconnect","death","weapon_fired","weapon_change","player_killed");
	}
}