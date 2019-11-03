#include code\utility;
init()
{
	players = getPlayers();
	sLoc = getLoc();
	sAng = getAng();
	
	waittillframeend;
	
	if( level.leiizko_dvars[ "end_music" ] )
		musicPlay( "end_game_1" );
	
	wait .75;
	
	for( i = 0; i < players.size; i++ )
	{
		player = players[i];
		
		player spawnSpec( sLoc, sAng );
		player freezeControls( true );
		waittillframeend;
	}
	
	waittillframeend;

	//level thread maps\mp\gametypes\_endroundmusic::playSoundOnAllPlayersX( "HGW_Gameshell_v10" );
	getBestPlayers();
	thread credits();
	thread showPlayers();
	
	// 4+2+14
	
	wait 15;
	
	for( i=0; i<10; i++ )
	{
		if( isDefined( level.player[i] ) )
			level.player[i] destroy();
	}
	/*
	for( i=0; i<5; i++ )
	{
		if( isDefined( level.credit[i] ) )
			level.credit[i] destroy();
	}*/
}

setUp()
{
	thread code\events::addConnectEvent( ::onPlayerConnect );
	thread code\events::addDeathEvent( ::onPlayerKilled );
}

onPlayerConnect()
{
	if( !isDefined( self.pers["knifekills"] ) )
		self.pers["knifekills"] = 0;
		
	if( !isDefined( self.pers["nadekills"] ) )
		self.pers["nadekills"] = 0;
		
	if( !isDefined( self.pers["playersuicides"] ) )
		self.pers["playersuicides"] = 0;
		
	if( !isDefined( self.pers["playerHS"] ) )
		self.pers["playerHS"] = 0;
		
	if( !isDefined( self.pers["defuses"] ) )
		self.pers["defuses"] = 0;
		
	if( !isDefined( self.pers["plants"] ) )
		self.pers["plants"] = 0;
}

onPlayerKilled( eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration )
{
	if( sMeansOfDeath == "MOD_MELEE" )
		self.pers["knifekills"]++;
	
	else if( sMeansOfDeath == "MOD_HEAD_SHOT" )
		self.pers["playerHS"]++;
		
	else if( sMeansOfDeath == "MOD_SUICIDE" || attacker == self )
		self.pers["playersuicides"]++;
		
	else if( sMeansOfDeath == "MOD_GRENADE" || sMeansOfDeath == "MOD_GRENADE_SPLASH" || sMeansOfDeath == "MOD_EXPLOSIVE" )
		self.pers["nadekills"]++;
}

showPlayers()
{
	// Kills //
	level.player[0] = newHudElem();
	level.player[0].alpha = 0;
	level.player[0].glowalpha = 0;
	level.player[0].glowColor = (0.5,0.1,0.8);
	level.player[0].archived = false;
	level.player[0].alignX = "center";
	level.player[0].alignY = "middle";
	level.player[0].x = 110+35;
	level.player[0].y = 210;
	level.player[0].fontscale = 1.4;
	
	if( level.playerskills > 0 )
		level.player[0] setText( "^7" + level.playerskills_ent.name );
	else
		level.player[0] setText( "^1- - -" );
	//  //
	
	// Score //
	level.player[1] = newHudElem();
	level.player[1].alpha = 0;
	level.player[1].glowalpha = 0;
	level.player[1].glowColor = (0.5,0.1,0.8);
	level.player[1].archived = false;
	level.player[1].alignX = "center";
	level.player[1].alignY = "middle";
	level.player[1].x = 200+35;
	level.player[1].y = 210;
	level.player[1].fontscale = 1.4;
	if( level.playerscore > 0 )
		level.player[1] setText( "^7" + level.playerscore_ent.name );
	else
		level.player[1] setText( "^1- - -" );
	//  //
	
	// Deaths //
	level.player[2] = newHudElem();
	level.player[2].alpha = 0;
	level.player[2].glowalpha = 0;
	level.player[2].glowColor = (0.5,0.1,0.8);
	level.player[2].archived = false;
	level.player[2].alignX = "center";
	level.player[2].alignY = "middle";
	level.player[2].x = 290+35;
	level.player[2].y = 210;
	level.player[2].fontscale = 1.4;
	if( level.playerdeaths > 0 )
		level.player[2] setText( "^7" + level.playerdeaths_ent.name );
	else
		level.player[2] setText( "^1- - -" );
	//  //
	
	// Assists //
	level.player[3] = newHudElem();
	level.player[3].alpha = 0;
	level.player[3].glowalpha = 0;
	level.player[3].glowColor = (0.5,0.1,0.8);
	level.player[3].archived = false;
	level.player[3].alignX = "center";
	level.player[3].alignY = "middle";
	level.player[3].x = 380+35;
	level.player[3].y = 210;
	level.player[3].fontscale = 1.4;
	if( level.assists > 0 )
		level.player[3] setText( "^7" + level.assists_ent.name );
	else
		level.player[3] setText( "^1- - -" );
	//  //
	
	// Suicides //
	level.player[4] = newHudElem();
	level.player[4].alpha = 0;
	level.player[4].glowalpha = 0;
	level.player[4].glowColor = (0.5,0.1,0.8);
	level.player[4].archived = false;
	level.player[4].alignX = "center";
	level.player[4].alignY = "middle";
	level.player[4].x = 470+35;
	level.player[4].y = 210;
	level.player[4].fontscale = 1.4;
	if( level.playersuicides > 0 )
		level.player[4] setText( "^7" + level.playersuicides_ent.name );
	else
		level.player[4] setText( "^1- - -" );
	//  //
	
	// HeadShots //
	level.player[5] = newHudElem();
	level.player[5].alpha = 0;
	level.player[5].glowalpha = 0;
	level.player[5].glowColor = (0.5,0.1,0.8);
	level.player[5].archived = false;
	level.player[5].alignX = "center";
	level.player[5].alignY = "middle";
	level.player[5].x = 110+35;
	level.player[5].y = 320;
	level.player[5].fontscale = 1.4;
	if( level.playerHS > 0 )
		level.player[5] setText( "^7" + level.playerHS_ent.name );
	else
		level.player[5] setText( "^1- - -" );
	//  //

	// knife kills //
	level.player[6] = newHudElem();
	level.player[6].alpha = 0;
	level.player[6].glowalpha = 0;
	level.player[6].glowColor = (0.5,0.1,0.8);
	level.player[6].archived = false;
	level.player[6].alignX = "center";
	level.player[6].alignY = "middle";
	level.player[6].x = 200+35;
	level.player[6].y = 320;
	level.player[6].fontscale = 1.4;
	if( level.knifekills > 0 )
		level.player[6] setText( "^7" + level.knifekills_ent.name );
	else
		level.player[6] setText( "^1- - -" );
	//  //
	
	// nade kills //
	level.player[7] = newHudElem();
	level.player[7].alpha = 0;
	level.player[7].glowalpha = 0;
	level.player[7].glowColor = (0.5,0.1,0.8);
	level.player[7].archived = false;
	level.player[7].alignX = "center";
	level.player[7].alignY = "middle";
	level.player[7].x = 290+35;
	level.player[7].y = 320;
	level.player[7].fontscale = 1.4;
	if( level.nadekills > 0 )
		level.player[7] setText( "^7" + level.nadekills_ent.name );
	else
		level.player[7] setText( "^1- - -" );
	//  //
	
	// plants //
	level.player[8] = newHudElem();
	level.player[8].alpha = 0;
	level.player[8].glowalpha = 0;
	level.player[8].glowColor = (0.5,0.1,0.8);
	level.player[8].archived = false;
	level.player[8].alignX = "center";
	level.player[8].alignY = "middle";
	level.player[8].x = 380+35;
	level.player[8].y = 320;
	level.player[8].fontscale = 1.4;
	if( level.plants > 0 )
		level.player[8] setText( "^7" + level.plants_ent.name );
	else
		level.player[8] setText( "^1- - -" );
	//  //
	
	// defuses //
	level.player[9] = newHudElem();
	level.player[9].alpha = 0;
	level.player[9].glowalpha = 0;
	level.player[9].glowColor = (0.5,0.1,0.8);
	level.player[9].archived = false;
	level.player[9].alignX = "center";
	level.player[9].alignY = "middle";
	level.player[9].x = 470+35;
	level.player[9].y = 320;
	level.player[9].fontscale = 1.4;
	if( level.defuses > 0 )
		level.player[9] setText( "^7" + level.defuses_ent.name );
	else
		level.player[9] setText( "^1- - -" );
	//  //
	
	for( i=0; i<10; i++ )
	{
		level.player[i] fadeOverTime( 1 );
		level.player[i].alpha = 1;
		
		wait .8;
	}
}

credits() // 640x480 
{
	addY = 60;//60;
	hudElems = [];
	info = [];
	info2 = [];

	hudElems[hudElems.size] = addTextHud( level, 320, 0+addY, 1, "center", "middle", 3.5 );
	hudElems[hudElems.size-1] setText( "^0||||||||||||||||||||||||||||||||||||||||||||||||||  ^1BEST PLAYERS  OF  THIS  MAP  ^0||||||||||||||||||||||||||||||||||||||||||||||||||" );
	hudElems[hudElems.size-1].alpha = 1;
	hudElems[hudElems.size-1].glowAlpha = 1;
	hudElems[hudElems.size-1].glowColor = (0.5,0.1,0.8);
	
	addY = 100;
	
	//showBestStatsx();
	
	// ORDER - 3 2 4 1 5
	
	info[0]["hud"] = addIconHud( level, 290, 40+addY, 0, "sles_hud_medals_deaths", 70, 70 );
	info[0]["hud"].sort = -1;
	info[1]["hud"] = addIconHud( level, 290, 40+addY, 0, "sles_hud_medals_score", 70, 70 );
	info[1]["hud"].sort = -1;
	info[2]["hud"] = addIconHud( level, 290, 40+addY, 0, "sles_hud_medals_assists", 70, 70 );
	info[2]["hud"].sort = -1;
	info[3]["hud"] = addIconHud( level, 290, 40+addY, 0, "sles_hud_medals_kills", 70, 70 );
	info[3]["hud"].sort = -1;
	info[4]["hud"] = addIconHud( level, 290, 40+addY, 0, "sles_hud_medals_suicides", 70, 70 );
	info[4]["hud"].sort = -1;
	
	info[5]["hud"] = addIconHud( level, 290, 150+addY, 0, "sles_hud_medals_nade_killer", 70, 70 );
	info[5]["hud"].sort = -1;
	info[6]["hud"] = addIconHud( level, 290, 150+addY, 0, "sles_hud_medals_knife_killer", 70, 70 );
	info[6]["hud"].sort = -1;
	info[7]["hud"] = addIconHud( level, 290, 150+addY, 0, "sles_hud_medals_plants", 70, 70 );
	info[7]["hud"].sort = -1;
	info[8]["hud"] = addIconHud( level, 290, 150+addY, 0, "sles_hud_medals_headshots", 70, 70 );
	info[8]["hud"].sort = -1;
	info[9]["hud"] = addIconHud( level, 290, 150+addY, 0, "sles_hud_medals_defuses", 70, 70 );
	info[9]["hud"].sort = -1;
	
	/////////////////////////////////////////////

	for( i = 10; i < 20; i++ )
	{
		info[i]["hud"] = newHudElem();
		info[i]["hud"].alpha = 0;
		info[i]["hud"].glowAlpha = 1;
		info[i]["hud"].color = (1,0.9,0);
		info[i]["hud"].sort = 1;
		info[i]["hud"].glowAlpha = 1;
		info[i]["hud"].glowColor = (0.1,0.1,0.7);
		info[i]["hud"].archived = false;
		info[i]["hud"].alignX = "center";
		info[i]["hud"].alignY = "middle";
		info[i]["hud"].x = 220;
		if(i>=15){
			info[i]["hud"].y = 32+addY;
		}else{
			info[i]["hud"].y = 142+addY;
		}
		info[i]["hud"].fontscale = 1.4;
	}
	info[15]["hud"] setText("NOOB^0:^1" + level.playerdeaths);
	info[16]["hud"] setText("KING^0:^1" + level.playerscore);
	info[17]["hud"] setText("ASSIST^0:^1" + level.assists);
	info[18]["hud"] setText("KILLER^0:^1" + level.playerskills);
	info[19]["hud"] setText("SUICIDER^0:^1" + level.playersuicides);
	
	info[10]["hud"] setText("NADER^0:^1" + level.nadekills);
	info[11]["hud"] setText("NINJA^0:^1" + level.knifekills);
	info[12]["hud"] setText("PLANTER^0:^1" + level.plants);
	info[13]["hud"] setText("HEADSHOT^0:^1" + level.playerHS);
	info[14]["hud"] setText("DEFUSER^0:^1" + level.defuses);

		
	//////////////////////////////////////////////////////////////////////////////
	

	info2[10]["hud"] = addIconHud( level, 290, 25+addY, 0, "nightvision_overlay_goggles", 72, 15 );
	info2[10]["hud"].color = (0, 0 ,0);
	info2[10]["hud"].sort = -1;
	
	info2[11]["hud"] = addIconHud( level, 290, 25+addY, 0, "nightvision_overlay_goggles", 72, 15 );
	info2[11]["hud"].color = (0, 0 ,0);
	info2[11]["hud"].sort = -1;

	info2[12]["hud"] = addIconHud( level, 290, 25+addY, 0, "nightvision_overlay_goggles", 72, 15 );
	info2[12]["hud"].color = (0, 0 ,0);
	info2[12]["hud"].sort = -1;

	info2[13]["hud"] = addIconHud( level, 290, 25+addY, 0, "nightvision_overlay_goggles", 72, 15 );
	info2[13]["hud"].color = (0, 0 ,0);
	info2[13]["hud"].sort = -1;

	info2[14]["hud"] = addIconHud( level, 290, 25+addY, 0, "nightvision_overlay_goggles", 72, 15 );
	info2[14]["hud"].color = (0, 0 ,0);
	info2[14]["hud"].sort = -1;
	
	info2[15]["hud"] = addIconHud( level, 290, 135+addY, 0, "nightvision_overlay_goggles", 72, 15 );
	info2[15]["hud"].color = (0, 0 ,0);
	info2[15]["hud"].sort = -1;

	info2[16]["hud"] = addIconHud( level, 290, 135+addY, 0, "nightvision_overlay_goggles", 72, 15 );
	info2[16]["hud"].color = (0, 0 ,0);
	info2[16]["hud"].sort = -1;

	info2[17]["hud"] = addIconHud( level, 290, 135+addY, 0, "nightvision_overlay_goggles", 72, 15 );
	info2[17]["hud"].color = (0, 0 ,0);
	info2[17]["hud"].sort = -1;

	info2[18]["hud"] = addIconHud( level, 290, 135+addY, 0, "nightvision_overlay_goggles", 72, 15 );
	info2[18]["hud"].color = (0, 0 ,0);
	info2[18]["hud"].sort = -1;

	info2[19]["hud"] = addIconHud( level, 290, 135+addY, 0, "nightvision_overlay_goggles", 72, 15 );
	info2[19]["hud"].color = (0, 0 ,0);
	info2[19]["hud"].sort = -1;
	
	/////////////////////////////////////////////
	
	
	
	///////////////////////////////////////////////////////

	pos[0] = 290; //left1
	pos[1] = 200; //center
	pos[2] = 380; //right1
	pos[3] = 110; //left2
	pos[4] = 470; //right2
	
	pos[5] = 290; //left1
	pos[6] = 200; //center
	pos[7] = 380; //right1
	pos[8] = 110; //left2
	pos[9] = 470; //right2
	

	currPos = 0;
	for( i = 0; i < 20; i++ )
	{
		if(i<10){
			showHud( info[i]["hud"], pos[currPos], 1, 3, 2.6 );
			//showHud( info2[i]["hud"], pos[currPos]+35, 1, 3, 2.6 );
		}else{
			showHud( info[i]["hud"], pos[currPos]+35, 1, 3, 2.6 );
			showHud( info2[i]["hud"], pos[currPos], 1, 3, 2.6 );
		}
		currPos++;
		if(i==9){
			currPos = 0;
		}
	}

	wait 14;
	
	for( i = 0; i < info.size; i++ )
	{
		info[i]["hud"] thread destroyHudAfterTime( 2 );
	}
	for( i = 10; i < info2.size+10; i++ )
	{
		info2[i]["hud"] thread destroyHudAfterTime( 2 );
	}
	for( i = 0; i < hudElems.size; i++ )
	{
		hudElems[i] thread destroyHudAfterTime( 2.2 );
	}
}

/////////////////////////////////////////


getBestPlayers()
{
	level.playerscore = 0;
	level.playerHS = 0;
	level.knifekills = 0;
	level.playerdeaths = 0;
	level.playerskills = 0;
	level.plants = 0;
	level.defuses = 0;
	level.playersuicides = 0;
	level.nadekills = 0;
	level.assists = 0;

	players = getEntarray( "player", "classname" );
	for( i=0; i<players.size; i++ )
	{
		player = players[i];
		
		if( !isDefined( player ) || !isPlayer( player ) )
			continue;
		
		if( player.pers[ "plants" ] > level.plants )
		{
			level.plants = player.pers[ "plants" ];
			level.plants_ent = player;
		}
		
		if( player.pers[ "defuses" ] > level.defuses )
		{
			level.defuses = player.pers[ "defuses" ];
			level.defuses_ent = player;
		}
		
		if( player.pers[ "kills" ] > level.playerskills )
		{
			level.playerskills = player.pers[ "kills" ];
			level.playerskills_ent = player;
		}
		
		if( player.pers[ "deaths" ] > level.playerdeaths )
		{
			level.playerdeaths = player.pers[ "deaths" ];
			level.playerdeaths_ent = player;
		}
		
		if( player.pers[ "assists" ] > level.assists )
		{
			level.assists = player.pers[ "assists" ];
			level.assists_ent = player;
		}
		
		if( player.pers[ "score" ] > level.playerscore )
		{
			level.playerscore = player.pers[ "score" ];
			level.playerscore_ent = player;
		}
		
		if( player.pers[ "knifekills" ] > level.knifekills )
		{
			level.knifekills = player.pers[ "knifekills" ];
			level.knifekills_ent = player;
		}
		
		if( player.pers[ "nadekills" ] > level.nadekills )
		{
			level.nadekills = player.pers[ "nadekills" ];
			level.nadekills_ent = player;
		}
		
		if( player.pers[ "playersuicides" ] > level.playersuicides )
		{
			level.playersuicides = player.pers[ "playersuicides" ];
			level.playersuicides_ent = player;
		}
		
		if( player.pers[ "playerHS" ] > level.playerHS )
		{
			level.playerHS = player.pers[ "playerHS" ];
			level.playerHS_ent = player;
		}
		
		waittillframeend;
	}
}

showBestStatsx()
{
	level.hud_best_players = newHudElem();
	level.hud_best_players.x = 320;
	level.hud_best_players.y = 105;
	level.hud_best_players.alignX = "center";
	level.hud_best_players.alignY = "middle";
	level.hud_best_players.alpha = 0;
	level.hud_best_players.sort = 10;

	wait 1;

	
	if( true )
	{
		cleanScreen();
		level.hud_best_players thread changeImage( "killiconsuicide" ); //<CHANGE THIS
		iPrintlnBold( "^2 is ^1THE BEST PLAYER ^2with ^2 score." );
		wait 2.6;
	}

	
	if(true )
	{
		cleanScreen();
		level.hud_best_players thread changeImage( "killiconsuicide" );
		iPrintlnBold( "^2 is ^1THE BEST KILLER ^2with ^2 kills total." );
		wait 2.6;
	}

	
	if(true )
	{
		cleanScreen();
		level.hud_best_players thread changeImage( "killiconsuicide" );
		iPrintlnBold( "^2 is ^1NINJA ^2with ^2 melee kills." );
		wait 2.6;
	}

	
	if( true )
	{
		cleanScreen();
		level.hud_best_players thread changeImage( "killiconsuicide" );
		iPrintlnBold( "^2 is ^2HEAD HUNTER ^2with ^2 head shot kills." );
		wait 2.6;
	}

	cleanScreen();
	level.hud_best_players destroy();

	wait 0.5;
}



/////////////////////////////////////////


changeImage( image )
{
	self.alpha = 0;
	self setShader( image, 64, 64 );
	self fadeOverTime( 0.4 );
	self.alpha = 1;
	wait 2.2;
	self fadeOverTime( 0.4 );
	self.alpha = 0;
}

destroyHudAfterTime( time )
{
	self fadeOverTime( time );
	self.alpha = 0;
	wait time;
	self destroy();
}

showHud( hud, X, alpha, movetime, fadetime )
{
	hud moveOverTime( movetime );
	hud.x = x;

	hud fadeOverTime( fadetime );
	hud.alpha = alpha;
}


addIconHud( who, x, y, alpha, shader, scalex, scaley )
{
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud setShader( shader, scalex, scaley );

	return hud;
}

//"center", "middle"
addTextHud( who, x, y, alpha, alignX, alignY, fontScale )
{
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.alignX = alignX;
	hud.alignY = alignY;
	hud.fontScale = fontScale;
	return hud;
}

cleanScreen()
{
	for( i = 0; i < 6; i++ )
	{
		iPrintlnBold( " " );
		iPrintln( " " );
	}
}
