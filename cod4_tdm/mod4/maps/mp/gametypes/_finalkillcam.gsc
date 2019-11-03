/*
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init()
{
    level.killcam_style = 0;
    level.fk = false;
    level.showFinalKillcam = false;
    level.waypoint = false;
    
    level.doFK["axis"] = false;
    level.doFK["allies"] = false;
    
    level.slowmotstart = undefined;
    
    OnPlayerConnect();
}

OnPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread beginFK();
    }
}    
        
beginFK()
{
    self endon("disconnect");
    
    for(;;)
    {
        self waittill("beginFK", winner);
        
        self notify ( "reset_outcome" );
        
        if(level.TeamBased)
        {
            self finalkillcam(level.KillInfo[winner]["attacker"], level.KillInfo[winner]["attackerNumber"], level.KillInfo[winner]["deathTime"], level.KillInfo[winner]["victim"]);
        }
        else
        {
            self finalkillcam(winner.KillInfo["attacker"], winner.KillInfo["attackerNumber"], winner.KillInfo["deathTime"], winner.KillInfo["victim"]);
        }
    }
}

finalkillcam( attacker, attackerNum, deathtime, victim)
{
    self endon("disconnect");
    level endon("end_killcam");
    
    self SetClientDvar("ui_ShowMenuOnly", "none");

    camtime = 5;
    predelay = getTime()/1000 - deathTime;
    postdelay = 2;
    killcamlength = camtime + postdelay;
    killcamoffset = camtime + predelay;
    
    visionSetNaked( getdvar("mapname") );
    
    self notify ( "begin_killcam", getTime() );
    
    self allowSpectateTeam("allies", true);
	self allowSpectateTeam("axis", true);
	self allowSpectateTeam("freelook", true);
	self allowSpectateTeam("none", true);
    
    self.sessionstate = "spectator";
	self.spectatorclient = attackerNum;
	self.killcamentity = -1;
	self.archivetime = killcamoffset;
	self.killcamlength = killcamlength;
	self.psoffsettime = 0;
    
    if(!isDefined(level.slowmostart))
        level.slowmostart = killcamlength - 2.5;
    
    self.killcam = true;
    
    wait 0.05;
    
    if(!isDefined(self.top_fk_shader))
    {
        self CreateFKMenu(victim , attacker);
    }
    else
    {
        self.fk_title.alpha = 1;
        self.fk_title_low.alpha = 1;
        self.top_fk_shader.alpha = 0.5;
        self.bottom_fk_shader.alpha = 0.5;
        self.credits.alpha = 0.2;
    }
    
    self thread WaitEnd(killcamlength);
    
    wait 0.05;
    
    self waittill("end_killcam");
    
    self thread CleanFK();
    
    self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
    
    wait 0.05;
    
    self.sessionstate = "spectator";
	spawnpointname = "mp_global_intermission";
	spawnpoints = getentarray(spawnpointname, "classname");
	assert( spawnpoints.size );
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

	self spawn(spawnpoint.origin, spawnpoint.angles);

    wait 0.05;
    
    self.killcam = undefined;
    self thread maps\mp\gametypes\_spectating::setSpectatePermissions();

    level notify("end_killcam");

    level.fk = false;  
}

CleanFK()
{
    self.fk_title.alpha = 0;
    self.fk_title_low.alpha = 0;
    self.top_fk_shader.alpha = 0;
    self.bottom_fk_shader.alpha = 0;
    
    self SetClientDvar("ui_ShowMenuOnly", "");
    
    visionSetNaked( "mpOutro", 1.0 );
}

WaitEnd( killcamlength )
{
    self endon("disconnect");
	self endon("end_killcam");
    
    wait killcamlength;
    
    self notify("end_killcam");
}

CreateFKMenu( victim , attacker)
{
    self.top_fk_shader = newClientHudElem(self);
    self.top_fk_shader.elemType = "shader";
    self.top_fk_shader.archived = false;
    self.top_fk_shader.horzAlign = "fullscreen";
    self.top_fk_shader.vertAlign = "fullscreen";
    self.top_fk_shader.sort = 0;
    self.top_fk_shader.foreground = true;
    self.top_fk_shader.color	= (.15, .15, .15);
    self.top_fk_shader setShader("white",640,112);
    
    self.bottom_fk_shader = newClientHudElem(self);
    self.bottom_fk_shader.elemType = "shader";
    self.bottom_fk_shader.y = 368;
    self.bottom_fk_shader.archived = false;
    self.bottom_fk_shader.horzAlign = "fullscreen";
    self.bottom_fk_shader.vertAlign = "fullscreen";
    self.bottom_fk_shader.sort = 0; 
    self.bottom_fk_shader.foreground = true;
    self.bottom_fk_shader.color	= (.15, .15, .15);
    self.bottom_fk_shader setShader("white",640,112);
    
    self.fk_title = newClientHudElem(self);
    self.fk_title.archived = false;
    self.fk_title.y = 45;
    self.fk_title.alignX = "center";
    self.fk_title.alignY = "middle";
    self.fk_title.horzAlign = "center";
    self.fk_title.vertAlign = "top";
    self.fk_title.sort = 1; // force to draw after the bars
    self.fk_title.font = "objective";
    self.fk_title.fontscale = 3.5;
    self.fk_title.foreground = true;
    self.fk_title.shadown = 1;
    
    self.fk_title_low = newClientHudElem(self);
    self.fk_title_low.archived = false;
    self.fk_title_low.x = 0;
    self.fk_title_low.y = -85;
    self.fk_title_low.alignX = "center";
    self.fk_title_low.alignY = "bottom";
    self.fk_title_low.horzAlign = "center_safearea";
    self.fk_title_low.vertAlign = "bottom";
    self.fk_title_low.sort = 1; // force to draw after the bars
    self.fk_title_low.font = "objective";
    self.fk_title_low.fontscale = 1.4;
    self.fk_title_low.foreground = true;  
    
	self.fk_title.alpha = 1;
    self.fk_title_low.alpha = 1;
    self.top_fk_shader.alpha = 0.5;
    self.bottom_fk_shader.alpha = 0.5;

    self.fk_title_low setText(attacker.name + " ^1killed ^7" + victim.name);
    
    if( !level.killcam_style )
        self.fk_title setText("^1GAME WINNING KILL");
    else
        self.fk_title setText("^3ROUND WINNING KILL");
}

onPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration)
{
    if(attacker != self)
    {
        level.showFinalKillcam = true;
        
        team = attacker.team;
        
        level.doFK[team] = true;
        
        if(level.teamBased)
        {
            level.KillInfo[team]["attacker"] = attacker;
            level.KillInfo[team]["attackerNumber"] = attacker getEntityNumber();
            level.KillInfo[team]["victim"] = self;
            level.KillInfo[team]["deathTime"] = GetTime()/1000;
        }
        else
        {
            attacker.KillInfo["attacker"] = attacker;
            attacker.KillInfo["attackerNumber"] = attacker getEntityNumber();
            attacker.KillInfo["victim"] = self;
            attacker.KillInfo["deathTime"] = GetTime()/1000;
        }
    }
}

endGame( winner, endReasonText )
{
	// return if already ending via host quit or victory
	if ( game["state"] == "postgame" || level.gameEnded )
		return;

	if ( isDefined( level.onEndGame ) )
		[[level.onEndGame]]( winner );

	visionSetNaked( "mpOutro", 2.0 );
	
	game["state"] = "postgame";
	level.gameEndTime = getTime();
	level.gameEnded = true;
	level.inGracePeriod = false;
	level notify ( "game_ended" );
    
    if ( isdefined( winner ) && level.gametype == "sd" )
		[[level._setTeamScore]]( winner, [[level._getTeamScore]]( winner ) + 1 );
	
	setGameEndTime( 0 ); // stop/hide the timers
	
	if ( level.rankedMatch )
	{
		maps\mp\gametypes\_globallogic::setXenonRanks();
		
		if ( maps\mp\gametypes\_globallogic::hostIdledOut() )
		{
			level.hostForcedEnd = true;
			logString( "host idled out" );
			endLobby();
		}
	}
	
	maps\mp\gametypes\_globallogic::updatePlacement();
	maps\mp\gametypes\_globallogic::updateMatchBonusScores( winner );
	maps\mp\gametypes\_globallogic::updateWinLossStats( winner );
	
	setdvar( "g_deadChat", 1 );
	
	// freeze players
	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		
		player maps\mp\gametypes\_globallogic::freezePlayerForRoundEnd();
		player thread maps\mp\gametypes\_globallogic::roundEndDoF( 4.0 );
		
		player maps\mp\gametypes\_globallogic::freeGameplayHudElems();
		
		player setClientDvars( "cg_everyoneHearsEveryone", 1 );

		if( level.rankedMatch )
		{
			if ( isDefined( player.setPromotion ) )
				player setClientDvar( "ui_lobbypopup", "promotion" );
			else
				player setClientDvar( "ui_lobbypopup", "summary" );
		}
	}

    // end round
    if ( (level.roundLimit > 1 || (!level.roundLimit && level.scoreLimit != 1)) && !level.forcedEnd )
    {
		if ( level.displayRoundEndText )
		{
			players = level.players;
			for ( index = 0; index < players.size; index++ )
			{
				player = players[index];
				
				if ( level.teamBased )
					player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify( winner, true, endReasonText );
				else
					player thread maps\mp\gametypes\_hud_message::outcomeNotify( winner, endReasonText );
		
				player setClientDvars( "ui_hud_hardcore", 1,
									   "cg_drawSpectatorMessages", 0,
									   "g_compassShowEnemies", 0 );
			}

			if ( level.teamBased && !(maps\mp\gametypes\_globallogic::hitRoundLimit() || maps\mp\gametypes\_globallogic::hitScoreLimit()) )
				thread maps\mp\gametypes\_globallogic::announceRoundWinner( winner, level.roundEndDelay / 4 );
			
			if ( maps\mp\gametypes\_globallogic::hitRoundLimit() || maps\mp\gametypes\_globallogic::hitScoreLimit() )
				maps\mp\gametypes\_globallogic::roundEndWait( level.roundEndDelay / 2, false );
			else
				maps\mp\gametypes\_globallogic::roundEndWait( level.roundEndDelay, true );
		}
        
		game["roundsplayed"]++;
		roundSwitching = false;
		if ( !maps\mp\gametypes\_globallogic::hitRoundLimit() && !maps\mp\gametypes\_globallogic::hitScoreLimit() )
			roundSwitching = maps\mp\gametypes\_globallogic::checkRoundSwitch();

		if ( roundSwitching && level.teamBased )
		{
			players = level.players;
			for ( index = 0; index < players.size; index++ )
			{
				player = players[index];
				
				if ( !isDefined( player.pers["team"] ) || player.pers["team"] == "spectator" )
				{
					player [[level.spawnIntermission]]();
					player closeMenu();
					player closeInGameMenu();
					continue;
				}
				
				switchType = level.halftimeType;
				if ( switchType == "halftime" )
				{
					if ( level.roundLimit )
					{
						if ( (game["roundsplayed"] * 2) == level.roundLimit )
							switchType = "halftime";
						else
							switchType = "intermission";
					}
					else if ( level.scoreLimit )
					{
						if ( game["roundsplayed"] == (level.scoreLimit - 1) )
							switchType = "halftime";
						else
							switchType = "intermission";
					}
					else
					{
						switchType = "intermission";
					}
				}
				switch( switchType )
				{
					case "halftime":
						player maps\mp\gametypes\_globallogic::leaderDialogOnPlayer( "halftime" );
						break;
					case "overtime":
						player maps\mp\gametypes\_globallogic::leaderDialogOnPlayer( "overtime" );
						break;
					default:
						player maps\mp\gametypes\_globallogic::leaderDialogOnPlayer( "side_switch" );
						break;
				}
				player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify( switchType, true, level.halftimeSubCaption );
				player setClientDvar( "ui_hud_hardcore", 1 );
			}
			
			maps\mp\gametypes\_globallogic::roundEndWait( level.halftimeRoundEndDelay, false );
		}
		else if ( !maps\mp\gametypes\_globallogic::hitRoundLimit() && !maps\mp\gametypes\_globallogic::hitScoreLimit() && !level.displayRoundEndText && level.teamBased )
		{
			players = level.players;
			for ( index = 0; index < players.size; index++ )
			{
				player = players[index];

				if ( !isDefined( player.pers["team"] ) || player.pers["team"] == "spectator" )
				{
					player [[level.spawnIntermission]]();
					player closeMenu();
					player closeInGameMenu();
					continue;
				}
				
				switchType = level.halftimeType;
				if ( switchType == "halftime" )
				{
					if ( level.roundLimit )
					{
						if ( (game["roundsplayed"] * 2) == level.roundLimit )
							switchType = "halftime";
						else
							switchType = "roundend";
					}
					else if ( level.scoreLimit )
					{
						if ( game["roundsplayed"] == (level.scoreLimit - 1) )
							switchType = "halftime";
						else
							switchTime = "roundend";
					}
				}
				switch( switchType )
				{
					case "halftime":
						player maps\mp\gametypes\_globallogic::leaderDialogOnPlayer( "halftime" );
						break;
					case "overtime":
						player maps\mp\gametypes\_globallogic::leaderDialogOnPlayer( "overtime" );
						break;
				}
				player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify( switchType, true, endReasonText );
				player setClientDvar( "ui_hud_hardcore", 1 );
			}			

			maps\mp\gametypes\_globallogic::roundEndWait( level.halftimeRoundEndDelay, !(maps\mp\gametypes\_globallogic::hitRoundLimit() || maps\mp\gametypes\_globallogic::hitScoreLimit()) );
		}
        
        if(level.players.size > 0 && level.gametype == "sd" && !maps\mp\gametypes\_globallogic::hitScoreLimit())
        {
            level.killcam_style = 1;
            thread startFK( winner );
        }
        
        if(level.fk)
            level waittill("end_killcam");

        if ( !maps\mp\gametypes\_globallogic::hitRoundLimit() && !maps\mp\gametypes\_globallogic::hitScoreLimit() )
        {
        	level notify ( "restarting" );
            game["state"] = "playing";
            map_restart( true );
            return;
        }
        
		if ( maps\mp\gametypes\_globallogic::hitRoundLimit() )
			endReasonText = game["strings"]["round_limit_reached"];
		else if ( maps\mp\gametypes\_globallogic::hitScoreLimit() )
			endReasonText = game["strings"]["score_limit_reached"];
		else
			endReasonText = game["strings"]["time_limit_reached"];
	}
	
	thread maps\mp\gametypes\_missions::roundEnd( winner );
	
	// catching gametype, since DM forceEnd sends winner as player entity, instead of string
	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];

		if ( !isDefined( player.pers["team"] ) || player.pers["team"] == "spectator" )
		{
			player [[level.spawnIntermission]]();
			player closeMenu();
			player closeInGameMenu();
			continue;
		}
		
		if ( level.teamBased )
		{
			player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify( winner, false, endReasonText );
		}
		else
		{
			player thread maps\mp\gametypes\_hud_message::outcomeNotify( winner, endReasonText );
			
			if ( isDefined( winner ) && player == winner )
				player playLocalSound( game["music"]["victory_" + player.pers["team"] ] );
			else if ( !level.splitScreen )
				player playLocalSound( game["music"]["defeat"] );
		}
		
		player setClientDvars( "ui_hud_hardcore", 1,
							   "cg_drawSpectatorMessages", 0,
							   "g_compassShowEnemies", 0 );
	}
	
	if ( level.teamBased )
	{
		thread maps\mp\gametypes\_globallogic::announceGameWinner( winner, level.postRoundTime / 2 );
		
		if ( level.splitscreen )
		{
			if ( winner == "allies" )
				playSoundOnPlayers( game["music"]["victory_allies"], "allies" );
			else if ( winner == "axis" )
				playSoundOnPlayers( game["music"]["victory_axis"], "axis" );
			else
				playSoundOnPlayers( game["music"]["defeat"] );
		}
		else
		{
			if ( winner == "allies" )
			{
				playSoundOnPlayers( game["music"]["victory_allies"], "allies" );
				playSoundOnPlayers( game["music"]["defeat"], "axis" );
			}
			else if ( winner == "axis" )
			{
				playSoundOnPlayers( game["music"]["victory_axis"], "axis" );
				playSoundOnPlayers( game["music"]["defeat"], "allies" );
			}
			else
			{
				playSoundOnPlayers( game["music"]["defeat"] );
			}
		}
	}
    
    wait 9;
    
    if(level.players.size > 0 && level.gametype != "sd")
    {
        level.killcam_style = 0;
        thread startFK( winner );
    }
    
    if(level.gametype == "sd" && maps\mp\gametypes\_globallogic::hitScoreLimit() && level.players.size > 0)
    {
        level.killcam_style = 0;
        thread startFK( winner );
    }
    
    if(level.fk)
        level waittill("end_killcam");
	else
        maps\mp\gametypes\_globallogic::roundEndWait( level.postRoundTime, true );
	
	level.intermission = true;
	
	//regain players array since some might've disconnected during the wait above
	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		
		player closeMenu();
		player closeInGameMenu();
		player notify ( "reset_outcome" );
		player thread maps\mp\gametypes\_globallogic::spawnIntermission();
		player setClientDvar( "ui_hud_hardcore", 0 );
		player setclientdvar( "g_scriptMainMenu", game["menu_eog_main"] );
	}
	
	logString( "game ended" );
	wait getDvarFloat( "scr_show_unlock_wait" );
	
	if( level.console )
	{
		exitLevel( false );
		return;
	}
	
	// popup for game summary
	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		//iPrintLnBold( "opening eog summary!" );
		//player.sessionstate = "dead";
		player openMenu( game["menu_eog_unlock"] );
	}
	
	thread timeLimitClock_Intermission( getDvarFloat( "scr_intermission_time" ) );
	wait getDvarFloat( "scr_intermission_time" );
	
	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		//iPrintLnBold( "closing eog summary!" );
		player closeMenu();
		player closeInGameMenu();
	}
	
	exitLevel( false );
}

timeLimitClock_Intermission( waitTime )
{
	setGameEndTime( getTime() + int(waitTime*1000) );
	clockObject = spawn( "script_origin", (0,0,0) );
	
	if ( waitTime >= 10.0 )
		wait ( waitTime - 10.0 );
		
	for ( ;; )
	{
		clockObject playSound( "ui_mp_timer_countdown" );
		wait ( 1.0 );
	}	
}

startFK( winner )
{
    level endon("end_killcam");
    
    if(!level.showFinalKillcam)
        return;
    
    if(!isPlayer(Winner) && !level.doFK[winner])
        return;
    
    level.fk = true;
    
    for( i = 0; i < level.players.size; i ++)
    {
        player = level.players[i];
        
        player notify("beginFK", winner);
    }
    
    slowMotion();

}

slowMotion()
{
    while(!isDefined(level.slowmostart))
        wait 0.05;
    
    wait level.slowmostart;
    
    SetDvar("timescale", "1");
    for(i=0;i<level.players.size;i++)
        level.players[i] setclientdvar("timescale", "1");
    
    wait 1.7;
    
    SetDvar("timescale", "1");
    for(i=0;i<level.players.size;i++)
        level.players[i] setclientdvar("timescale", "1");
}
*/