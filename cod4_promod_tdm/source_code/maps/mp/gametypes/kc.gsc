#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include hunnia\_utility;

main()
{
	if(getdvar("mapname") == "mp_background")
		return;
		
	if ( !isdefined( game["switchedsides"] ) )
		game["switchedsides"] = false;		
		
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::SetupCallbacks();
	maps\mp\gametypes\_globallogic::SetupCallbacks();

	level.teamBased = true;
	level.overrideTeamScore = true;

	level.onPrecacheGameType = ::onPrecacheGameType;
	level.onStartGameType = ::onStartGameType;
	level.onSpawnPlayer = ::onSpawnPlayer;
    level.onPlayerKilled = ::onPlayerKilled;
	level.onRoundSwitch = ::onRoundSwitch;


	game["dialog"]["gametype"] = "kill_confirmed";

	game["dialog"]["offense_obj"] = "kc_boost";
	game["dialog"]["defense_obj"] = "kc_boost";

}

onPrecacheGameType()
{
	precacheModel( "skull_dogtag" );
	precacheModel( "cross_dogtag" );
	precacheString( &"PL_KILL_CONFIRMED_P" );
	precacheString( &"PL_KILL_DENIED" );
	precacheString( &"PL_GOTTAGS" );   
}

onStartGameType()
{
	setClientNameMode("auto_change");

	maps\mp\gametypes\_globallogic::setObjectiveText( "allies", &"PL_OBJECTIVES_KC" );
	maps\mp\gametypes\_globallogic::setObjectiveText( "axis", &"PL_OBJECTIVES_KC" );
	
	if ( level.splitscreen )
	{
		maps\mp\gametypes\_globallogic::setObjectiveScoreText( "allies", &"PL_OBJECTIVES_KC" );
		maps\mp\gametypes\_globallogic::setObjectiveScoreText( "axis", &"PL_OBJECTIVES_KC" );
	}
	else
	{
		maps\mp\gametypes\_globallogic::setObjectiveScoreText( "allies", &"PL_OBJECTIVES_KC_SCORE" );
		maps\mp\gametypes\_globallogic::setObjectiveScoreText( "axis", &"PL_OBJECTIVES_KC_SCORE" );
	}
	maps\mp\gametypes\_globallogic::setObjectiveHintText( "allies", &"PL_OBJECTIVES_KC_HINT" );
	maps\mp\gametypes\_globallogic::setObjectiveHintText( "axis", &"PL_OBJECTIVES_KC_HINT" );
			
	level.spawnMins = ( 0, 0, 0 );
	level.spawnMaxs = ( 0, 0, 0 );
	maps\mp\gametypes\_spawnlogic::placeSpawnPoints( "mp_tdm_spawn_allies_start" );
	maps\mp\gametypes\_spawnlogic::placeSpawnPoints( "mp_tdm_spawn_axis_start" );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( "allies", "mp_tdm_spawn" );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( "axis", "mp_tdm_spawn" );
	
	level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
	setMapCenter( level.mapCenter );
	
	allowed[0] = level.gametype;
	allowed[1] = "war";
	
	level.displayRoundEndText = false;
	maps\mp\gametypes\_gameobjects::main(allowed);
	
	// elimination style
	if ( level.roundLimit != 1 && level.numLives )
	{
		level.overrideTeamScore = true;
		level.displayRoundEndText = true;
		level.onDeadEvent = ::onDeadEvent;
	}
}

onSpawnPlayer()
{
	// Check which spawn points should be used
	if ( game["switchedsides"] ) {
		spawnTeam = level.otherTeam[ self.pers["team"] ];
	} else {
		spawnTeam =  self.pers["team"];
	}

	self.usingObj = undefined;

	if ( level.inGracePeriod )
	{
		spawnPoints = getentarray("mp_tdm_spawn_" + spawnTeam + "_start", "classname");
		
		if ( !spawnPoints.size )
			spawnPoints = getentarray("mp_sab_spawn_" + spawnTeam + "_start", "classname");
			
		if ( !spawnPoints.size )
		{
			spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints( spawnTeam );
			spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam( spawnPoints );
		}
		else
		{
			spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random( spawnPoints );
		}		
	}
	else
	{
		spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints( spawnTeam );
		spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam( spawnPoints );
	}
	
	self spawn( spawnpoint.origin, spawnpoint.angles );
}


onDeadEvent( team )
{
	// Make sure players on both teams were not eliminated
	if ( team != "all" ) {
		[[level._setTeamScore]]( getOtherTeam(team), [[level._getTeamScore]]( getOtherTeam(team) ) + 1 );
		thread maps\mp\gametypes\_globallogic::endGame( getOtherTeam(team), game["strings"][team + "_eliminated"] );
	} else {
		// We can't determine a winner if everyone died like in S&D so we declare a tie
		thread maps\mp\gametypes\_globallogic::endGame( "tie", game["strings"]["round_draw"] );
	}
}


onRoundSwitch()
{
	// Just change the value for the variable controlling which map assets will be assigned to each team
	level.halftimeType = "halftime";
	game["switchedsides"] = !game["switchedsides"];
}
onPlayerKilled( eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration )
{
	if(isDefined(self) && isDefined(attacker))
		self thread spawnDogTags( attacker );
}        
spawnDogTags(attacker)
{
	if(isDefined(attacker) && self.pers["team"] != "spectator" && attacker != self && attacker.pers["team"] != self.pers["team"] ) 
	{
		basePosition = playerPhysicsTrace( self.origin, self.origin + ( 0, 0, -99999 ) );

		visuals[0] = spawn( "script_model", basePosition + ( 0, 0, 20 ));
		visuals[0] setModel( "skull_dogtag" );
		visuals[1] = spawn( "script_model", basePosition + ( 0, 0, 20 ));
		visuals[1] setModel( "cross_dogtag" );
					
		trigger = spawn( "trigger_radius", basePosition, 0, 20, 50 );
				
		level.dogtags[self.guid] = maps\mp\gametypes\_gameobjects::createDogTag( "any", trigger, visuals, (0,0,16) );
		level.dogtags[self.guid] maps\mp\gametypes\_gameobjects::setUseTime( 0 );
		level.dogtags[self.guid] maps\mp\gametypes\_gameobjects::setUseText("");
		level.dogtags[self.guid].onUse = ::onUseDogTag;
		level.dogtags[self.guid].victim = self;
		level.dogtags[self.guid].team = self.team;
				
		self thread clearOnEvent();
		
		level.dogtags[self.guid] maps\mp\gametypes\_gameobjects::allowUse( "any" );	
				
		level.dogtags[self.guid].visuals[0] thread showToTeam( getOtherTeam( self.pers["team"] ) );
		level.dogtags[self.guid].visuals[1] thread showToTeam( self.pers["team"] );
			
		level.dogtags[self.guid].attacker = attacker;
				
		level.dogtags[self.guid].visuals[0] thread bounce();
		level.dogtags[self.guid].visuals[1] thread bounce();
	}
}  
waittill_any_or_time(x,y,z,time)
{
	level endon("game_ended");

	if(isDefined(x))
		self endon(x);

	if(isDefined(y))
		self endon(y);

	if(isDefined(z))
		self endon(z);

	if(isDefined(time))
		wait time;
}
clearOnEvent()
{	
	guid = self.guid;
	self waittill_any_or_time( "disconnect", "joined_team", "joined_spectators", 20 );
	
	if ( isDefined( level.dogtags[guid] ) )
	{
		level.dogtags[guid] maps\mp\gametypes\_gameobjects::allowUse( "none" );			
		wait( 0.05 );
		
		if ( isDefined( level.dogtags[guid] ) )
		{
			level.dogtags[guid].trigger delete();
			for ( i=0; i<level.dogtags[guid].visuals.size; i++ )
			{
				level.dogtags[guid].visuals[i] notify("deleted");
				level.dogtags[guid].visuals[i] delete();
			}
			level.dogtags[guid] = undefined;		
		}	
	}	
}

onUseDogTag( player )
{  
	for(i = 0; i < self.visuals.size; i++)
	{
		self notify("reset");
		self.visuals[i] hide();
		self.visuals[i] notify("reset");
		self.visuals[i].origin = (0,0,1000);
	}
	
	self.trigger.origin = (0,0,1000);
	
	self maps\mp\gametypes\_gameobjects::allowUse( "none" );	

	if ( player.pers["team"] != self.team )
	{
		player thread givePlayerScore( "kill_confirmed", 50 );
		player thread underScorePopup(&"PL_KILL_CONFIRMED_P");
		[[level._setTeamScore]]( player.pers["team"], [[level._getTeamScore]]( player.pers["team"] ) + 10 );
	}
   
	else if ( player == self.victim ) 
	{
		player thread givePlayerScore( "gottags", 10 );
		player thread underScorePopup(&"PL_GOTTAGS");
	}
		
	else if ( player.pers["team"] == self.team ) 
	{
		player thread givePlayerScore( "kill_denied", 50 );
		player thread underScorePopup(&"PL_KILL_DENIED");
	}
   
	player playSound( "dogtag_kc_pickup" );
}

givePlayerScore( event, score )
{
	self maps\mp\gametypes\_rank::giveRankXP( event );
		
	self.pers["score"] += score;
	self maps\mp\gametypes\_persistence::statAdd( "score", (self.pers["score"] - score) );
	self.score = self.pers["score"];
}

bounce()
{	
	self endon("deleted");
	while( isDefined(self) )
	{
		self rotateYaw( 360, 3, 0.3, 0.3 );

		self moveZ( 20, 1.5, 0.3, 0.3 );
		wait 1.5;
		self moveZ( -20, 1.5, 0.3, 0.3 );
		wait 1.5;	
	}
}
	
showToTeam( showForTeam )
{
	self endon("disconnect");
	self endon("reset");
	
	while( isDefined( self ) )
	{	
		self hide();

		for( i = 0 ; i < level.players.size ; i ++ )
		{
			if ( level.players[i].team == showForTeam )
				self showToPlayer( level.players[i] );
		}
		wait 0.05;
	}
}
