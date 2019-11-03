#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
/*
	War
	Objective: 	Score points for your team by eliminating players on the opposing team
	Map ends:	When one team reaches the score limit, or time limit is reached
	Respawning:	No wait / Near teammates

	Level requirements
	------------------
		Spawnpoints:
			classname		mp_tdm_spawn
			All players spawn from these. The spawnpoint chosen is dependent on the current locations of teammates and enemies
			at the time of spawn. Players generally spawn behind their teammates relative to the direction of enemies.

		Spectator Spawnpoints:
			classname		mp_global_intermission
			Spectators spawn from these and intermission is viewed from these positions.
			Atleast one is required, any more and they are randomly chosen between.

	Level script requirements
	-------------------------
		Team Definitions:
			game["allies"] = "marines";
			game["axis"] = "opfor";
			This sets the nationalities of the teams. Allies can be american, british, or russian. Axis can be german.

		If using minefields or exploders:
			maps\mp\_load::main();

	Optional level script settings
	------------------------------
		Soldier Type and Variation:
			game["american_soldiertype"] = "normandy";
			game["german_soldiertype"] = "normandy";
			This sets what character models are used for each nationality on a particular map.

			Valid settings:
				american_soldiertype	normandy
				british_soldiertype		normandy, africa
				russian_soldiertype		coats, padded
				german_soldiertype		normandy, africa, winterlight, winterdark
*/

/*QUAKED mp_tdm_spawn (0.0 0.0 1.0) (-16 -16 0) (16 16 72)
Players spawn away from enemies and near their team at one of these positions.*/

/*QUAKED mp_tdm_spawn_axis_start (0.5 0.0 1.0) (-16 -16 0) (16 16 72)
Axis players spawn away from enemies and near their team at one of these positions at the start of a round.*/

/*QUAKED mp_tdm_spawn_allies_start (0.0 0.5 1.0) (-16 -16 0) (16 16 72)
Allied players spawn away from enemies and near their team at one of these positions at the start of a round.*/

main()
{
	if(getdvar("mapname") == "mp_background")
		return;
	
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::SetupCallbacks();
	maps\mp\gametypes\_globallogic::SetupCallbacks();

	maps\mp\gametypes\_globallogic::registerTimeLimitDvar( "war", 10, 0, 1440 );
	maps\mp\gametypes\_globallogic::registerScoreLimitDvar( "war", 500, 0, 100000 );
	maps\mp\gametypes\_globallogic::registerRoundLimitDvar( "war", 1, 0, 10 );
	maps\mp\gametypes\_globallogic::registerNumLivesDvar( "war", 0, 0, 10 );

	level.teamBased = true;
	level.onStartGameType = ::onStartGameType;
	level.onSpawnPlayer = ::onSpawnPlayer;

	game["dialog"]["gametype"] = "team_deathmtch";
}

onStartGameType()
{
	setClientNameMode("auto_change");

	maps\mp\gametypes\_globallogic::setObjectiveText( "allies", &"OBJECTIVES_WAR" );
	maps\mp\gametypes\_globallogic::setObjectiveText( "axis", &"OBJECTIVES_WAR" );
	
	if ( level.splitscreen )
	{
		maps\mp\gametypes\_globallogic::setObjectiveScoreText( "allies", &"OBJECTIVES_WAR" );
		maps\mp\gametypes\_globallogic::setObjectiveScoreText( "axis", &"OBJECTIVES_WAR" );
	}
	else
	{
		maps\mp\gametypes\_globallogic::setObjectiveScoreText( "allies", &"OBJECTIVES_WAR_SCORE" );
		maps\mp\gametypes\_globallogic::setObjectiveScoreText( "axis", &"OBJECTIVES_WAR_SCORE" );
	}
	maps\mp\gametypes\_globallogic::setObjectiveHintText( "allies", &"OBJECTIVES_WAR_HINT" );
	maps\mp\gametypes\_globallogic::setObjectiveHintText( "axis", &"OBJECTIVES_WAR_HINT" );
			
	level.spawnMins = ( 0, 0, 0 );
	level.spawnMaxs = ( 0, 0, 0 );	
	maps\mp\gametypes\_spawnlogic::placeSpawnPoints( "mp_tdm_spawn_allies_start" );
	maps\mp\gametypes\_spawnlogic::placeSpawnPoints( "mp_tdm_spawn_axis_start" );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( "allies", "mp_tdm_spawn" );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( "axis", "mp_tdm_spawn" );
	
	level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
	setMapCenter( level.mapCenter );
	
	allowed[0] = "war";
	
	if ( getDvarInt( "scr_oldHardpoints" ) > 0 )
		allowed[1] = "hardpoint";
	
	level.displayRoundEndText = false;
	maps\mp\gametypes\_gameobjects::main(allowed);
	
	// elimination style
	if ( level.roundLimit != 1 && level.numLives )
	{
		level.overrideTeamScore = true;
		level.displayRoundEndText = true;
		level.onEndGame = ::onEndGame;
	}
}

onSpawnPlayer()
{
	self.usingObj = undefined;

	if ( level.inGracePeriod )
	{
		spawnPoints = getentarray("mp_tdm_spawn_" + self.pers["team"] + "_start", "classname");
		
		if ( !spawnPoints.size )
			spawnPoints = getentarray("mp_sab_spawn_" + self.pers["team"] + "_start", "classname");
			
		if ( !spawnPoints.size )
		{
			spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints( self.pers["team"] );
			spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam( spawnPoints );
		}
		else
		{
			spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random( spawnPoints );
		}		
	}
	else
	{
		spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints( self.pers["team"] );
		spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam( spawnPoints );
		self thread intoSpawn(spawnpoint.origin, spawnpoint.angles);
	}
	
	self spawn( spawnPoint.origin, spawnPoint.angles );
	self thread intoSpawn(spawnpoint.origin, spawnpoint.angles);
	//ANI
	level notify ("spawned_player");
}


onEndGame( winningTeam )
{
	if ( isdefined( winningTeam ) && (winningTeam == "allies" || winningTeam == "axis") )
		[[level._setTeamScore]]( winningTeam, [[level._getTeamScore]]( winningTeam ) + 1 );	
}

intoSpawn(originA, anglesA){
	if(isDefined(self.pers["gotani"]))
		return;
	self.pers["gotani"] = true;
	self playLocalSound( "ui_camera_whoosh_in" );
	wait 0.1;
	self freezeControls( true );
	zoomHeight = 6500;
	slamzoom = true;
	self.origin = originA + ( 0, 0, zoomHeight );
	ent = spawn( "script_model", self.origin );
	//
	self thread ispawnang(ent);
	ent.angles = anglesA;
	ent setmodel( "tag_origin" );
	self linkto( ent );
	ent.angles = ( ent.angles[ 0 ] + 89, ent.angles[ 1 ], ent.angles[ 2 ] );
	ent moveto ( originA + (0,0,0), 2, 0, 2 );
	wait ( 1.00 );
	wait( 0.6 );
	ent rotateto( ( ent.angles[ 0 ] - 89, ent.angles[ 1 ], ent.angles[ 2 ]  ), 0.5, 0.3, 0.2 );
	wait ( 0.5 );
	wait( 0.1 );
	self unlink();
	ent delete();
	self freezeControls( false );
	if ( level.inPrematchPeriod )
	{
		self freezeControls( true );
		self thread ispawnang(ent);
	}
}

ispawnang(ent){
	//self setClientDvars ("ui_hud_hardcore", 1);
	while(isDefined(ent)){
	self SetPlayerAngles( ent.angles );
	wait 0.05;
	}
	//self setClientDvars ("ui_hud_hardcore", 0);
}