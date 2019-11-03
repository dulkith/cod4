#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include duffman\_common;
// Rallypoints should be destroyed on leaving your team/getting killed
// Compass icons need to be looked at
// Doesn't seem to be setting angle on spawn so that you are facing your rallypoint

/*
	Search and Destroy
	Attackers objective: Bomb one of 2 positions
	Defenders objective: Defend these 2 positions / Defuse planted bombs
	Round ends:	When one team is eliminated, bomb explodes, bomb is defused, or roundlength time is reached
	Map ends:	When one team reaches the score limit, or time limit or round limit is reached
	Respawning:	Players remain dead for the round and will respawn at the beginning of the next round

	Level requirements
	------------------
		Allied Spawnpoints:
			classname		mp_sd_spawn_attacker
			Allied players spawn from these. Place at least 16 of these relatively close together.

		Axis Spawnpoints:
			classname		mp_sd_spawn_defender
			Axis players spawn from these. Place at least 16 of these relatively close together.

		Spectator Spawnpoints:
			classname		mp_global_intermission
			Spectators spawn from these and intermission is viewed from these positions.
			Atleast one is required, any more and they are randomly chosen between.

		Bombzones:
			classname					trigger_multiple
			targetname					bombzone
			script_gameobjectname		bombzone
			script_bombmode_original	<if defined this bombzone will be used in the original bomb mode>
			script_bombmode_single		<if defined this bombzone will be used in the single bomb mode>
			script_bombmode_dual		<if defined this bombzone will be used in the dual bomb mode>
			script_team					Set to allies or axis. This is used to set which team a bombzone is used by in dual bomb mode.
			script_label				Set to A or B. This sets the letter shown on the compass in original mode.
			This is a volume of space in which the bomb can planted. Must contain an origin brush.

		Bomb:
			classname				trigger_lookat
			targetname				bombtrigger
			script_gameobjectname	bombzone
			This should be a 16x16 unit trigger with an origin brush placed so that it's center lies on the bottom plane of the trigger.
			Must be in the level somewhere. This is the trigger that is used when defusing a bomb.
			It gets moved to the position of the planted bomb model.

	Level script requirements
	-------------------------
		Team Definitions:
			game["allies"] = "marines";
			game["axis"] = "opfor";
			This sets the nationalities of the teams. Allies can be american, british, or russian. Axis can be german.

			game["attackers"] = "allies";
			game["defenders"] = "axis";
			This sets which team is attacking and which team is defending. Attackers plant the bombs. Defenders protect the targets.

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

		Exploder Effects:
			Setting script_noteworthy on a bombzone trigger to an exploder group can be used to trigger additional effects.
*/

/*QUAKED mp_sd_spawn_attacker (0.0 1.0 0.0) (-16 -16 0) (16 16 72)
Attacking players spawn randomly at one of these positions at the beginning of a round.*/

/*QUAKED mp_sd_spawn_defender (1.0 0.0 0.0) (-16 -16 0) (16 16 72)
Defending players spawn randomly at one of these positions at the beginning of a round.*/

main()
{
	if(getdvar("mapname") == "mp_background")
		return;

	level.fire_fx=loadfx("fire/tank_fire_engine");	
	level.fx_airstrike_afterburner = loadfx ("fire/jet_afterburner"); 

	PreCacheModel("tag_origin");
	
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::SetupCallbacks();
	maps\mp\gametypes\_globallogic::SetupCallbacks();
	
	maps\mp\gametypes\_globallogic::registerRoundSwitchDvar( level.gameType, 3, 0, 9 );
	maps\mp\gametypes\_globallogic::registerTimeLimitDvar( level.gameType, 2.5, 0, 1440 );
	maps\mp\gametypes\_globallogic::registerScoreLimitDvar( level.gameType, 4, 0, 500 );
	maps\mp\gametypes\_globallogic::registerRoundLimitDvar( level.gameType, 0, 0, 12 );
	maps\mp\gametypes\_globallogic::registerNumLivesDvar( level.gameType, 1, 0, 10 );
	
	level.teamBased = true;
	level.overrideTeamScore = true;
	level.onPrecacheGameType = ::onPrecacheGameType;
	level.onStartGameType = ::onStartGameType;
	level.onSpawnPlayer = ::onSpawnPlayer;
	level.onPlayerKilled = ::onPlayerKilled;
	level.onDeadEvent = ::onDeadEvent;
	level.onOneLeftEvent = ::onOneLeftEvent;
	level.onTimeLimit = ::onTimeLimit;
	level.onRoundSwitch = ::onRoundSwitch;
	
	level.endGameOnScoreLimit = false;
	
	game["dialog"]["gametype"] = "searchdestroy";
	game["dialog"]["offense_obj"] = "obj_destroy";
	game["dialog"]["defense_obj"] = "obj_defend";

	waittillframeend;

	thread setupSpawnPoints();
	thread checkAreaEnter();
/*	if(1) {
		wait 5;
		thread addBotClient("axis");
		thread addBotClient("axis");
		thread addBotClient("axis");
		thread addBotClient("axis");
		thread addBotClient("axis");

		thread addBotClient("allies");
		thread addBotClient("allies");
		thread addBotClient("allies");
		thread addBotClient("allies");
		thread addBotClient("allies");
	}
	else
		thread Record();*/
}

onPrecacheGameType()
{
	game["bombmodelname"] = "mil_tntbomb_mp";
	game["bombmodelnameobj"] = "mil_tntbomb_mp";
	game["bomb_dropped_sound"] = "mp_war_objective_lost";
	game["bomb_recovered_sound"] = "mp_war_objective_taken";
	precacheModel(game["bombmodelname"]);
	precacheModel(game["bombmodelnameobj"]);

	precacheShader("waypoint_bomb");
	precacheShader("hud_suitcase_bomb");
	precacheShader("waypoint_target");
	precacheShader("waypoint_target_a");
	precacheShader("waypoint_target_b");
	precacheShader("waypoint_defend");
	precacheShader("waypoint_defend_a");
	precacheShader("waypoint_defend_b");
	precacheShader("waypoint_defuse");
	precacheShader("waypoint_defuse_a");
	precacheShader("waypoint_defuse_b");
	precacheShader("compass_waypoint_target");
	precacheShader("compass_waypoint_target_a");
	precacheShader("compass_waypoint_target_b");
	precacheShader("compass_waypoint_defend");
	precacheShader("compass_waypoint_defend_a");
	precacheShader("compass_waypoint_defend_b");
	precacheShader("compass_waypoint_defuse");
	precacheShader("compass_waypoint_defuse_a");
	precacheShader("compass_waypoint_defuse_b");
}

onRoundSwitch()
{
	if ( !isdefined( game["switchedsides"] ) )
		game["switchedsides"] = false;
	
	if ( game["teamScores"]["allies"] == level.scorelimit - 1 && game["teamScores"]["axis"] == level.scorelimit - 1 )
	{
		// overtime! team that's ahead in kills gets to defend.
		aheadTeam = getBetterTeam();
		if ( aheadTeam != game["defenders"] )
		{
			game["switchedsides"] = !game["switchedsides"];
		}
		else
		{
			level.halftimeSubCaption = "";
		}
		level.halftimeType = "overtime";
	}
	else
	{
		level.halftimeType = "halftime";
		game["switchedsides"] = !game["switchedsides"];
	}
}

getBetterTeam()
{
	kills["allies"] = 0;
	kills["axis"] = 0;
	deaths["allies"] = 0;
	deaths["axis"] = 0;
	
	for ( i = 0; i < level.players.size; i++ )
	{
		player = level.players[i];
		team = player.pers["team"];
		if ( isDefined( team ) && (team == "allies" || team == "axis") )
		{
			kills[ team ] += player.kills;
			deaths[ team ] += player.deaths;
		}
	}
	
	if ( kills["allies"] > kills["axis"] )
		return "allies";
	else if ( kills["axis"] > kills["allies"] )
		return "axis";
	
	// same number of kills

	if ( deaths["allies"] < deaths["axis"] )
		return "allies";
	else if ( deaths["axis"] < deaths["allies"] )
		return "axis";
	
	// same number of deaths
	
	if ( randomint(2) == 0 )
		return "allies";
	return "axis";
}

onStartGameType()
{
	if ( !isDefined( game["switchedsides"] ) )
		game["switchedsides"] = false;
	
	if ( game["switchedsides"] )
	{
		oldAttackers = game["attackers"];
		oldDefenders = game["defenders"];
		game["attackers"] = oldDefenders;
		game["defenders"] = oldAttackers;
	}
	
	setClientNameMode( "manual_change" );
	
	game["strings"]["target_destroyed"] = &"MP_TARGET_DESTROYED";
	game["strings"]["bomb_defused"] = &"MP_BOMB_DEFUSED";
	
	precacheString( game["strings"]["target_destroyed"] );
	precacheString( game["strings"]["bomb_defused"] );

	level._effect["bombexplosion"] = loadfx("explosions/tanker_explosion");
	
	maps\mp\gametypes\_globallogic::setObjectiveText( game["attackers"], &"OBJECTIVES_SD_ATTACKER" );
	maps\mp\gametypes\_globallogic::setObjectiveText( game["defenders"], &"OBJECTIVES_SD_DEFENDER" );

	if ( level.splitscreen )
	{
		maps\mp\gametypes\_globallogic::setObjectiveScoreText( game["attackers"], &"OBJECTIVES_SD_ATTACKER" );
		maps\mp\gametypes\_globallogic::setObjectiveScoreText( game["defenders"], &"OBJECTIVES_SD_DEFENDER" );
	}
	else
	{
		maps\mp\gametypes\_globallogic::setObjectiveScoreText( game["attackers"], &"OBJECTIVES_SD_ATTACKER_SCORE" );
		maps\mp\gametypes\_globallogic::setObjectiveScoreText( game["defenders"], &"OBJECTIVES_SD_DEFENDER_SCORE" );
	}
	maps\mp\gametypes\_globallogic::setObjectiveHintText( game["attackers"], &"OBJECTIVES_SD_ATTACKER_HINT" );
	maps\mp\gametypes\_globallogic::setObjectiveHintText( game["defenders"], &"OBJECTIVES_SD_DEFENDER_HINT" );

	level.spawnMins = ( 0, 0, 0 );
	level.spawnMaxs = ( 0, 0, 0 );	
	maps\mp\gametypes\_spawnlogic::placeSpawnPoints( "mp_sd_spawn_attacker" );
	maps\mp\gametypes\_spawnlogic::placeSpawnPoints( "mp_sd_spawn_defender" );
	
	level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
	setMapCenter( level.mapCenter );
	
	allowed[0] = "sd";
	allowed[1] = "bombzone";
	allowed[2] = "blocker";
	maps\mp\gametypes\_gameobjects::main(allowed);
	
	maps\mp\gametypes\_rank::registerScoreInfo( "win", 2 );
	maps\mp\gametypes\_rank::registerScoreInfo( "loss", 1 );
	maps\mp\gametypes\_rank::registerScoreInfo( "tie", 1.5 );
	
	maps\mp\gametypes\_rank::registerScoreInfo( "kill", 5 );
	maps\mp\gametypes\_rank::registerScoreInfo( "headshot", 5 );
	maps\mp\gametypes\_rank::registerScoreInfo( "assist", 2 );
	maps\mp\gametypes\_rank::registerScoreInfo( "plant", 10 );
	maps\mp\gametypes\_rank::registerScoreInfo( "defuse", 10 );
	
	thread updateGametypeDvars();
	
	thread bombs();
}


onSpawnPlayer()
{
	self.isPlanting = false;
	self.isDefusing = false;
	self.isBombCarrier = false;

	if(self.pers["team"] == game["attackers"])
		spawnPointName = "mp_sd_spawn_attacker";
	else
		spawnPointName = "mp_sd_spawn_defender";

	if ( level.multiBomb && !isDefined( self.carryIcon ) && self.pers["team"] == game["attackers"] && !level.bombPlanted )
	{
		if ( level.splitscreen )
		{
			self.carryIcon = createIcon( "hud_suitcase_bomb", 35, 35 );
			self.carryIcon setPoint( "BOTTOM RIGHT", "BOTTOM RIGHT", -10, -50 );
			self.carryIcon.alpha = 0.75;
		}
		else
		{
			self.carryIcon = createIcon( "hud_suitcase_bomb", 50, 50 );
			self.carryIcon setPoint( "CENTER", "CENTER", 220, 140 );
			self.carryIcon.alpha = 0.75;
		}
	}

	spawnPoints = getEntArray( spawnPointName, "classname" );
	assert( spawnPoints.size );
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random( spawnPoints );

	wait .05;

	if(level.trainingArea && self.inTrainingArea) {
		spawn = randomint(level.trainingAreaSpawns[self.pers["team"]].size);
		spawnpoint.origin = level.trainingAreaSpawns[self.pers["team"]][spawn]["origin"];
		spawnpoint.angles = level.trainingAreaSpawns[self.pers["team"]][spawn]["angles"];
		self thread WatchWeaponUsage();
	}

	self spawn( spawnpoint.origin, spawnpoint.angles );

	level notify ( "spawned_player" );
}

WatchWeaponUsage() {
	self endon("disconnect");
	self notify("newer_wwu_thread");
	self endon("newer_wwu_thread");
	while(game["state"] == "playing") {
		wait 1;
		if(self GetCurrentWeapon() != "desert_eagle_mp" && self.inTrainingArea) {
			self.statusicon = "hud_status_dead";
			self Giveweapon("deserteaglegold_mp");
			self SetWeaponAmmoClip("deserteaglegold_mp",0);
			self SetWeaponAmmoStock("deserteaglegold_mp",0);
			self thread s2w("deserteaglegold_mp");
			self setperk( "specialty_quieter" );
			self setperk( "specialty_gpsjammer" );
			self setperk( "specialty_longersprint" );
			self SetActionSlot( 1, "nightvision" );
			if(!isDefined(self.pers["primaryWeapon"]) || !isDefined(self.class)) {
				self maps\mp\gametypes\_class::setClass( "assault");
				self maps\mp\gametypes\_teams::playerModelForWeapon( "ak47_mp" );
			}
			else {
				self maps\mp\gametypes\_class::setClass( self.class );
				self maps\mp\gametypes\_teams::playerModelForWeapon( self.pers["primaryWeapon"] );
			}	
		}
	}
}


onPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
	thread checkAllowSpectating();
	if(!level.trainingArea) return;
	if(!self.inTrainingArea) {
		self thread JoinTrainingAreaMessage((attacker != self));
	}
	else {
		// ** Disable XP, Kills, Deaths and Killstreaks
		if(isDefined(attacker.pers) && isDefined(attacker.pers["kills"]) && isDefined(attacker.pers["score"])) {
			attacker.pers["kills"]--;	
			attacker.pers["score"] -= level.scoreInfo["kill"]["value"];
			attacker.score = attacker.pers["score"];
			attacker.kills = attacker.pers["kills"];
		}	
		if(isDefined(self.deaths)) {
			self.pers["deaths"]--;
			self.deaths = self.pers["deaths"];
		}			
		self thread Respawn(1);				
	}
}

checkAllowSpectating()
{
	wait ( 0.05 );
	
	update = false;
	if ( !level.aliveCount[ game["attackers"] ] )
	{
		level.spectateOverride[game["attackers"]].allowEnemySpectate = 1;
		update = true;
	}
	if ( !level.aliveCount[ game["defenders"] ] )
	{
		level.spectateOverride[game["defenders"]].allowEnemySpectate = 1;
		update = true;
	}
	if ( update )
		maps\mp\gametypes\_spectating::updateSpectateSettings();
}


sd_endGame( winningTeam, endReasonText )
{
	if ( isdefined( winningTeam ) )
		[[level._setTeamScore]]( winningTeam, [[level._getTeamScore]]( winningTeam ) + 1 );
	
	thread maps\mp\gametypes\_globallogic::endGame( winningTeam, endReasonText );
}


onDeadEvent( team )
{
	if ( level.bombExploded || level.bombDefused )
		return;
	
	if ( team == "all" )
	{
		if ( level.bombPlanted )
			sd_endGame( game["attackers"], game["strings"][game["defenders"]+"_eliminated"] );
		else
			sd_endGame( game["defenders"], game["strings"][game["attackers"]+"_eliminated"] );
	}
	else if ( team == game["attackers"] )
	{
		if ( level.bombPlanted )
			return;
		
		sd_endGame( game["defenders"], game["strings"][game["attackers"]+"_eliminated"] );
	}
	else if ( team == game["defenders"] )
	{
		sd_endGame( game["attackers"], game["strings"][game["defenders"]+"_eliminated"] );
	}
}


onOneLeftEvent( team )
{
	if ( level.bombExploded || level.bombDefused )
		return;
	
	//if ( team == game["attackers"] )
	warnLastPlayer( team );
}


onTimeLimit()
{
	if ( level.teamBased )
		sd_endGame( game["defenders"], game["strings"]["time_limit_reached"] );
	else
		sd_endGame( undefined, game["strings"]["time_limit_reached"] );
}


warnLastPlayer( team )
{
	if ( !isdefined( level.warnedLastPlayer ) )
		level.warnedLastPlayer = [];
	
	if ( isDefined( level.warnedLastPlayer[team] ) )
		return;
		
	level.warnedLastPlayer[team] = true;

	players = level.players;
	for ( i = 0; i < players.size; i++ )
	{
		player = players[i];

		if ( isDefined( player.pers["team"] ) && player.pers["team"] == team && isdefined( player.pers["class"] ) )
		{
			if ( player.sessionstate == "playing" && !player.afk && !player.inTrainingArea )
				break;
		}
	}
	
	if ( i == players.size )
		return;
	
	players[i] thread giveLastAttackerWarning();
}


giveLastAttackerWarning()
{
	self endon("death");
	self endon("disconnect");
	
	fullHealthTime = 0;
	interval = .05;
	
	while(1)
	{
		if ( self.health != self.maxhealth )
			fullHealthTime = 0;
		else
			fullHealthTime += interval;
		
		wait interval;
		
		if (self.health == self.maxhealth && fullHealthTime >= 3)
			break;
	}
	
	//self iprintlnbold(&"MP_YOU_ARE_THE_ONLY_REMAINING_PLAYER");
	self maps\mp\gametypes\_globallogic::leaderDialogOnPlayer( "last_alive" );
	
	self maps\mp\gametypes\_missions::lastManSD();

	level.pausebot = true;
}


updateGametypeDvars()
{
	level.plantTime = dvarFloatValue( "planttime", 5, 0, 20 );
	level.defuseTime = dvarFloatValue( "defusetime", 5, 0, 20 );
	level.bombTimer = dvarFloatValue( "bombtimer", 45, 1, 300 );
	level.multiBomb = dvarIntValue( "multibomb", 0, 0, 1 );
}


bombs()
{
	level.bombPlanted = false;
	level.bombDefused = false;
	level.bombExploded = false;

	
	duffman\_common::devPrint(game["attackers"]);
	duffman\_common::devPrint(game["defenders"]);

	trigger = getEnt( "sd_bomb_pickup_trig", "targetname" );
	if ( !isDefined( trigger ) )
	{
		maps\mp\_utility::error("No sd_bomb_pickup_trig trigger found in map.");
		return;
	}
	
	visuals[0] = getEnt( "sd_bomb", "targetname" );
	if ( !isDefined( visuals[0] ) )
	{
		maps\mp\_utility::error("No sd_bomb script_model found in map.");
		return;
	}

	precacheModel( "prop_suitcase_bomb" );	
	visuals[0] setModel( "prop_suitcase_bomb" );
	
	if ( !level.multiBomb )
	{
		level.sdBomb = maps\mp\gametypes\_gameobjects::createCarryObject( game["attackers"], trigger, visuals, (0,0,32) );
		level.sdBomb maps\mp\gametypes\_gameobjects::allowCarry( "friendly" );
		level.sdBomb maps\mp\gametypes\_gameobjects::set2DIcon( "friendly", "compass_waypoint_bomb" );
		level.sdBomb maps\mp\gametypes\_gameobjects::set3DIcon( "friendly", "waypoint_bomb" );
		level.sdBomb maps\mp\gametypes\_gameobjects::setVisibleTeam( "friendly" );
		level.sdBomb maps\mp\gametypes\_gameobjects::setCarryIcon( "hud_suitcase_bomb" );
		level.sdBomb.allowWeapons = true;
		level.sdBomb.onPickup = ::onPickup;
		level.sdBomb.onDrop = ::onDrop;
	}
	else
	{
		trigger delete();
		visuals[0] delete();
	}
	
	
	level.bombZones = [];
	
	bombZones = getEntArray( "bombzone", "targetname" );
	
	for ( index = 0; index < bombZones.size; index++ )
	{
		trigger = bombZones[index];
		visuals = getEntArray( bombZones[index].target, "targetname" );
		
		bombZone = maps\mp\gametypes\_gameobjects::createUseObject( game["defenders"], trigger, visuals, (0,0,64) );
		bombZone maps\mp\gametypes\_gameobjects::allowUse( "enemy" );
		bombZone maps\mp\gametypes\_gameobjects::setUseTime( level.plantTime );
		bombZone maps\mp\gametypes\_gameobjects::setUseText( &"MP_PLANTING_EXPLOSIVE" );
		bombZone maps\mp\gametypes\_gameobjects::setUseHintText( &"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES" );
		if ( !level.multiBomb )
			bombZone maps\mp\gametypes\_gameobjects::setKeyObject( level.sdBomb );
		label = bombZone maps\mp\gametypes\_gameobjects::getLabel();
		bombZone.label = label;
		bombZone maps\mp\gametypes\_gameobjects::set2DIcon( "friendly", "compass_waypoint_defend" + label );
		bombZone maps\mp\gametypes\_gameobjects::set3DIcon( "friendly", "waypoint_defend" + label );
		bombZone maps\mp\gametypes\_gameobjects::set2DIcon( "enemy", "compass_waypoint_target" + label );
		bombZone maps\mp\gametypes\_gameobjects::set3DIcon( "enemy", "waypoint_target" + label );
		bombZone maps\mp\gametypes\_gameobjects::setVisibleTeam( "any" );
		bombZone.onBeginUse = ::onBeginUse;
		bombZone.onEndUse = ::onEndUse;
		bombZone.onUse = ::onUsePlantObject;
		bombZone.onCantUse = ::onCantUse;
		bombZone.useWeapon = "briefcase_bomb_mp";
		
		for ( i = 0; i < visuals.size; i++ )
		{
			if ( isDefined( visuals[i].script_exploder ) )
			{
				bombZone.exploderIndex = visuals[i].script_exploder;
				break;
			}
		}
		
		level.bombZones[level.bombZones.size] = bombZone;
		
		bombZone.bombDefuseTrig = getent( visuals[0].target, "targetname" );
		assert( isdefined( bombZone.bombDefuseTrig ) );
		bombZone.bombDefuseTrig.origin += (0,0,-10000);
		bombZone.bombDefuseTrig.label = label;
	}
	
	for ( index = 0; index < level.bombZones.size; index++ )
	{
		array = [];
		for ( otherindex = 0; otherindex < level.bombZones.size; otherindex++ )
		{
			if ( otherindex != index )
				array[ array.size ] = level.bombZones[otherindex];
		}
		level.bombZones[index].otherBombZones = array;
	}
}

onBeginUse( player )
{
	if ( self maps\mp\gametypes\_gameobjects::isFriendlyTeam( player.pers["team"] ) )
	{
		player playSound( "mp_bomb_defuse" );
		player.isDefusing = true;
		
		if ( isDefined( level.sdBombModel ) )
			level.sdBombModel hide();
	}
	else
	{
		player.isPlanting = true;

		if ( level.multibomb )
		{
			for ( i = 0; i < self.otherBombZones.size; i++ )
			{
				self.otherBombZones[i] maps\mp\gametypes\_gameobjects::disableObject();
			}
		}
	}
}

onEndUse( team, player, result )
{
	if ( !isAlive( player ) )
		return;
		
	player.isDefusing = false;
	player.isPlanting = false;

	if ( self maps\mp\gametypes\_gameobjects::isFriendlyTeam( player.pers["team"] ) )
	{
		if ( isDefined( level.sdBombModel ) && !result )
		{
			level.sdBombModel show();
		}
	}
	else
	{
		if ( level.multibomb && !result )
		{
			for ( i = 0; i < self.otherBombZones.size; i++ )
			{
				self.otherBombZones[i] maps\mp\gametypes\_gameobjects::enableObject();
			}
		}
	}
}

onCantUse( player )
{
	player iPrintLnBold( &"MP_CANT_PLANT_WITHOUT_BOMB" );
}

onUsePlantObject( player )
{
	// planted the bomb
	if ( !self maps\mp\gametypes\_gameobjects::isFriendlyTeam( player.pers["team"] ) )
	{
		level thread bombPlanted( self, player );
		player logString( "bomb planted: " + self.label );
		
		// disable all bomb zones except this one
		for ( index = 0; index < level.bombZones.size; index++ )
		{
			if ( level.bombZones[index] == self )
				continue;
				
			level.bombZones[index] maps\mp\gametypes\_gameobjects::disableObject();
		}
		
		player playSound( "mp_bomb_plant" );
		player notify ( "bomb_planted" );
		if ( !level.hardcoreMode )
			iPrintLn( &"MP_EXPLOSIVES_PLANTED_BY", player );
		maps\mp\gametypes\_globallogic::leaderDialog( "bomb_planted" );

		maps\mp\gametypes\_globallogic::givePlayerScore( "plant", player );
		player thread [[level.onXPEvent]]( "plant" );
	}
}

onUseDefuseObject( player )
{
	wait .05;
	
	player notify ( "bomb_defused" );
	player logString( "bomb defused: " + self.label );
	level thread bombDefused();
	
	// disable this bomb zone
	self maps\mp\gametypes\_gameobjects::disableObject();
	
	if ( !level.hardcoreMode )
		iPrintLn( &"MP_EXPLOSIVES_DEFUSED_BY", player );
	maps\mp\gametypes\_globallogic::leaderDialog( "bomb_defused" );

	maps\mp\gametypes\_globallogic::givePlayerScore( "defuse", player );
	player thread [[level.onXPEvent]]( "defuse" );
}


onDrop( player )
{
	if ( !level.bombPlanted )
	{
		if ( isDefined( player ) && isDefined( player.name ) )
			printOnTeamArg( &"MP_EXPLOSIVES_DROPPED_BY", game["attackers"], player );

//		maps\mp\gametypes\_globallogic::leaderDialog( "bomb_lost", player.pers["team"] );
		if ( isDefined( player ) )
		 	player logString( "bomb dropped" );
		 else
		 	logString( "bomb dropped" );
	}

	self maps\mp\gametypes\_gameobjects::set3DIcon( "friendly", "waypoint_bomb" );
	
	maps\mp\_utility::playSoundOnPlayers( game["bomb_dropped_sound"], game["attackers"] );
}


onPickup( player )
{
	player.isBombCarrier = true;

	self maps\mp\gametypes\_gameobjects::set3DIcon( "friendly", "waypoint_defend" );

	if ( !level.bombDefused )
	{
		if ( isDefined( player ) && isDefined( player.name ) )
			printOnTeamArg( &"MP_EXPLOSIVES_RECOVERED_BY", game["attackers"], player );
			
		maps\mp\gametypes\_globallogic::leaderDialog( "bomb_taken", player.pers["team"] );
		player logString( "bomb taken" );
	}		
	maps\mp\_utility::playSoundOnPlayers( game["bomb_recovered_sound"], game["attackers"] );
}


onReset()
{
}


bombPlanted( destroyedObj, player )
{
	maps\mp\gametypes\_globallogic::pauseTimer();
	level.bombPlanted = true;
	
	destroyedObj.visuals[0] thread maps\mp\gametypes\_globallogic::playTickingSound();
	level.tickingObject = destroyedObj.visuals[0];

	level.timeLimitOverride = true;
	setGameEndTime( int( gettime() + (level.bombTimer * 1000) ) );
	setDvar( "ui_bomb_timer", 1 );
	
	if ( !level.multiBomb )
	{
		level.sdBomb maps\mp\gametypes\_gameobjects::allowCarry( "none" );
		level.sdBomb maps\mp\gametypes\_gameobjects::setVisibleTeam( "none" );
		level.sdBomb maps\mp\gametypes\_gameobjects::setDropped();
		level.sdBombModel = level.sdBomb.visuals[0];
	}
	else
	{
		
		for ( index = 0; index < level.players.size; index++ )
		{
			if ( isDefined( level.players[index].carryIcon ) )
				level.players[index].carryIcon destroyElem();
		}

		trace = bulletTrace( player.origin + (0,0,20), player.origin - (0,0,2000), false, player );
		
		tempAngle = randomfloat( 360 );
		forward = (cos( tempAngle ), sin( tempAngle ), 0);
		forward = vectornormalize( forward - vector_scale( trace["normal"], vectordot( forward, trace["normal"] ) ) );
		dropAngles = vectortoangles( forward );
		
		level.sdBombModel = spawn( "script_model", trace["position"] );
		level.sdBombModel.angles = dropAngles;
		level.sdBombModel setModel( "prop_suitcase_bomb" );
	}
	destroyedObj maps\mp\gametypes\_gameobjects::allowUse( "none" );
	destroyedObj maps\mp\gametypes\_gameobjects::setVisibleTeam( "none" );
	/*
	destroyedObj maps\mp\gametypes\_gameobjects::set2DIcon( "friendly", undefined );
	destroyedObj maps\mp\gametypes\_gameobjects::set2DIcon( "enemy", undefined );
	destroyedObj maps\mp\gametypes\_gameobjects::set3DIcon( "friendly", undefined );
	destroyedObj maps\mp\gametypes\_gameobjects::set3DIcon( "enemy", undefined );
	*/
	label = destroyedObj maps\mp\gametypes\_gameobjects::getLabel();
	
	// create a new object to defuse with.
	trigger = destroyedObj.bombDefuseTrig;
	trigger.origin = level.sdBombModel.origin;
	visuals = [];
	defuseObject = maps\mp\gametypes\_gameobjects::createUseObject( game["defenders"], trigger, visuals, (0,0,32) );
	defuseObject maps\mp\gametypes\_gameobjects::allowUse( "friendly" );
	defuseObject maps\mp\gametypes\_gameobjects::setUseTime( level.defuseTime );
	defuseObject maps\mp\gametypes\_gameobjects::setUseText( &"MP_DEFUSING_EXPLOSIVE" );
	defuseObject maps\mp\gametypes\_gameobjects::setUseHintText( &"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES" );
	defuseObject maps\mp\gametypes\_gameobjects::setVisibleTeam( "any" );
	defuseObject maps\mp\gametypes\_gameobjects::set2DIcon( "friendly", "compass_waypoint_defuse" + label );
	defuseObject maps\mp\gametypes\_gameobjects::set2DIcon( "enemy", "compass_waypoint_defend" + label );
	defuseObject maps\mp\gametypes\_gameobjects::set3DIcon( "friendly", "waypoint_defuse" + label );
	defuseObject maps\mp\gametypes\_gameobjects::set3DIcon( "enemy", "waypoint_defend" + label );
	defuseObject.label = label;
	defuseObject.onBeginUse = ::onBeginUse;
	defuseObject.onEndUse = ::onEndUse;
	defuseObject.onUse = ::onUseDefuseObject;
	defuseObject.useWeapon = "briefcase_bomb_defuse_mp";
	
	BombTimerWait();
	setDvar( "ui_bomb_timer", 0 );
	
	destroyedObj.visuals[0] maps\mp\gametypes\_globallogic::stopTickingSound();
	
	if ( level.gameEnded || level.bombDefused )
		return;
	
	level.bombExploded = true;
	
	explosionOrigin = level.sdBombModel.origin;
	level.sdBombModel hide();
	
	if ( isdefined( player ) )
		destroyedObj.visuals[0] radiusDamage( explosionOrigin, 512, 200, 20, player );
	else
		destroyedObj.visuals[0] radiusDamage( explosionOrigin, 512, 200, 20 );
	
	rot = randomfloat(360);
	explosionEffect = spawnFx( level._effect["bombexplosion"], explosionOrigin + (0,0,50), (0,0,1), (cos(rot),sin(rot),0) );
	triggerFx( explosionEffect );
	
	thread playSoundinSpace( "exp_suitcase_bomb_main", explosionOrigin );
	
	if ( isDefined( destroyedObj.exploderIndex ) )
		exploder( destroyedObj.exploderIndex );
	
	for ( index = 0; index < level.bombZones.size; index++ )
		level.bombZones[index] maps\mp\gametypes\_gameobjects::disableObject();
	defuseObject maps\mp\gametypes\_gameobjects::disableObject();
	
	setGameEndTime( 0 );
	
	wait 3;
	
	sd_endGame( game["attackers"], game["strings"]["target_destroyed"] );
}

BombTimerWait()
{
	level endon("game_ended");
	level endon("bomb_defused");
	wait level.bombTimer;
}

playSoundinSpace( alias, origin )
{
	org = spawn( "script_origin", origin );
	org.origin = origin;
	org playSound( alias  );
	wait 10; // MP doesn't have "sounddone" notifies =(
	org delete();
}

bombDefused()
{
	level.tickingObject maps\mp\gametypes\_globallogic::stopTickingSound();
	level.bombDefused = true;
	setDvar( "ui_bomb_timer", 0 );
	
	level notify("bomb_defused");
	
	wait 1.5;
	
	setGameEndTime( 0 );
	
	sd_endGame( game["defenders"], game["strings"]["bomb_defused"] );
}


setupSpawnPoints() {
	level.trainingAreaSpawns["axis"] = [];
	level.trainingAreaSpawns["allies"] = [];
	level.boxsize = [];
	level.trainingAreaFire = [];
	level.trainingArea = (getDvar("training_area") != "0" && level.gametype == "sd");

	if(level.script == "mp_crash"||level.script == "mp_crash_snow") {
		i=0;
 		level.trainingAreaSpawns["axis"][i]["origin"] = (-717.844, 49.1098, 252.374); 
 		level.trainingAreaSpawns["axis"][i]["angles"] = (2.90039, -74.3536, 0);
 		i++;
 		level.trainingAreaSpawns["axis"][i]["origin"] = (-604.486, 8.76953, 226.254); 
 		level.trainingAreaSpawns["axis"][i]["angles"] = (0.653687, -86.5979, 0);
 		i++;
 		level.trainingAreaSpawns["axis"][i]["origin"] = (-488.396, -2.23524, 218.92); 
 		level.trainingAreaSpawns["axis"][i]["angles"] = (-0.648185, -95.5792, 0);
		i++;
 		level.trainingAreaSpawns["axis"][i]["origin"] = (-482.235, -116.929, 213.424); 
 		level.trainingAreaSpawns["axis"][i]["angles"] = (-0.357047, -96.0187, 0);
 		i++;
 		level.trainingAreaSpawns["axis"][i]["origin"] = (-589.133, -135.531, 229.855); 
 		level.trainingAreaSpawns["axis"][i]["angles"] = (0.576782, -87.0319, 0);
 		i++;
 		level.trainingAreaSpawns["axis"][i]["origin"] = (-698.398, -176.046, 279.288); 
 		level.trainingAreaSpawns["axis"][i]["angles"] = (1.52161, -84.4226, 0);
 		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (-668.183, -135.644, 262.813); 
 		level.trainingAreaSpawns["axis"][i]["angles"] = (0.505371, -86.4551, 0);

		i=0;
 		level.trainingAreaSpawns["allies"][i]["origin"] = (-699.919, -1526.33, 224.192); 
 		level.trainingAreaSpawns["allies"][i]["angles"] = (4.77905, 86.5357, 0);
 		i++;
 		level.trainingAreaSpawns["allies"][i]["origin"] = (-698.091, -1443.61, 236.602); 
 		level.trainingAreaSpawns["allies"][i]["angles"] = (4.77905, 86.5357, 0);
 		i++;
 		level.trainingAreaSpawns["allies"][i]["origin"] = (-628.942, -1442.84, 217.35); 
 		level.trainingAreaSpawns["allies"][i]["angles"] = (2.90039, 92.0453, 0);
		i++;
 		level.trainingAreaSpawns["allies"][i]["origin"] = (-553.925, -1452.55, 214.531); 
 		level.trainingAreaSpawns["allies"][i]["angles"] = (3.11462, 91.1005, 0);
 		i++;
 		level.trainingAreaSpawns["allies"][i]["origin"] = (-500.066, -1341.75, 216.617); 
 		level.trainingAreaSpawns["allies"][i]["angles"] = (3.11462, 91.1005, 0);
 		i++;
 		level.trainingAreaSpawns["allies"][i]["origin"] = (-564.14, -1310.67, 224.129); 
 		level.trainingAreaSpawns["allies"][i]["angles"] = (3.11462, 91.1005, 0);
 		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-617.691, -1278.92, 230.143); 
 		level.trainingAreaSpawns["allies"][i]["angles"] = (3.11462, 91.1005, 0);

		level.trainingAreaFire[level.trainingAreaFire.size] = (-753.188, 86.5576, 336);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-753.188, -1639.07, 336);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-742.188, -1639.07, 222);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-455.425, -1452.03, 222);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-456.261, -928.275, 222);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-420.754, -514.615, 222);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-423.726, -115.728, 222);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-457.221, 83.8369, 222);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-753.188, 86.5576, 336);
	}
	else if(level.script == "mp_strike") {
		i=0;
		level.trainingAreaSpawns["axis"][i]["origin"] = (83.2152, -754.643, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (4.05945, -179.247, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (83.1993, -721.296, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (4.05945, -179.247, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (83.1861, -688.592, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (4.05945, -179.247, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (83.1704, -650.437, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (4.05945, -179.247, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (83.1558, -617.13, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (4.05945, -179.247, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (83.142, -583.917, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (4.05945, -179.247, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (83.1263, -542.693, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (4.05945, -179.247, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (83.9449, -522.013, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (13.1122, 173.941, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (29.3069, -517.534, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (13.1122, 173.941, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (27.4591, -546.73, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (13.1122, 173.941, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (25.9838, -597.251, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (13.1122, 173.941, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (24.4961, -648.207, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (13.1122, 173.941, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (23.0208, -698.728, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (13.1122, 173.941, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (20.9076, -771.108, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (13.1122, 173.941, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (-60.5087, -784.297, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (13.1122, 173.941, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (-58.3476, -713.367, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (13.1122, 173.941, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (-56.8721, -662.846, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (13.1122, 173.941, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (-55.604, -619.418, 456.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (13.1122, 173.941, 0);
		//Recorder Mode: allies
		i=0;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-730.414, -528.199, 456.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (16.2268, -1.29638, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-730.442, -567.147, 456.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (13.1836, -2.37853, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-730.481, -593.418, 456.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (13.1836, -2.37853, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-730.529, -629.301, 456.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (13.1836, -2.37853, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-730.575, -665.064, 456.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (13.1836, -2.37853, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-730.62, -703.248, 456.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (13.1836, -2.37853, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-730.669, -744.263, 456.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (13.1836, -2.37853, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-695.268, -746.833, 456.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (13.1836, -2.37853, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-680.93, -714.132, 456.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (13.1836, -2.37853, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-677.245, -678.299, 456.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (13.1836, -2.37853, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-672.05, -627.789, 456.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (13.1836, -2.37853, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-666.885, -577.565, 456.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (13.1836, -2.37853, 0);

 		level.trainingAreaFire[level.trainingAreaFire.size] = (-924.919, -870.76, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (268.677, -870.849, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (268.78, -657.592, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (224.372, -657.503, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (224.429, -502.276, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (268.374, -502.313, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (269.056, -356.958, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (86.7796, -357.577, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (87.7316, -402.047, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-40.1744, -401.935, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-40.093, -357.857, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-220.824, -357.391, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-220.81, -529.561, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-438.16, -529.094, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-435.994, -357.225, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-616.1, -357.344, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-615.744, -401.945, 456.125);
 		level.trainingAreaFire[level.trainingAreaFire.size] = (-743.42, -401.897, 456.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-743.647, -357.563, 456.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-925.108, -357.541, 456.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-924.5, -503.143, 456.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-879.884, -502.253, 456.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-870.584, -657.612, 456.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-924.253, -657.575, 456.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-923.731, -870.471, 456.125);
	}
	else if(level.script == "mp_backlot") {
		level.trainingAreaFire[level.trainingAreaFire.size] = (155.74, 1699.7, 592.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (644.819, 1700.22, 592.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (644.302, 2572.46, 592.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (154.927, 2573.49, 587.183);
		level.trainingAreaFire[level.trainingAreaFire.size] = (155.74, 1699.7, 592.125);
		i=0;
		level.trainingAreaSpawns["axis"][i]["origin"] = (545.009, 1807.03, 592.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.22925, 91.4227, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (480.952, 1806.98, 592.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.22925, 91.4227, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (408.732, 1806.93, 592.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.22925, 91.4227, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (329.435, 1806.88, 592.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.22925, 91.4227, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (264.292, 1806.84, 592.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.22925, 91.4227, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (262.002, 1860.75, 592.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.22925, 91.4227, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (323.444, 1887.79, 592.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.22925, 91.4227, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (373.678, 1894.99, 592.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.22925, 91.4227, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (431.271, 1903.2, 592.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.15784, 90.9833, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (517.757, 1914.96, 592.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.08643, 90.7691, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (508.496, 1965.47, 592.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.08643, 90.7691, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (400.114, 1981.65, 592.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.08643, 90.7691, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (334.889, 1988.7, 592.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.08643, 90.7691, 0);
		//Recorder Mode: allies
		i=0;
		level.trainingAreaSpawns["allies"][i]["origin"] = (277.261, 2468.37, 592.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (4.56482, -89.5056, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (332.303, 2468.38, 592.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (4.56482, -89.6484, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (382.699, 2468.39, 592.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (4.56482, -89.6484, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (455.189, 2468.4, 592.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (4.56482, -89.6484, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (504.271, 2468.4, 592.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (4.56482, -89.6484, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (532.874, 2440.87, 592.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (4.56482, -89.6484, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (532.977, 2403.32, 592.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (4.56482, -89.6484, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (453.92, 2386.19, 592.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (4.63623, -89.7199, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (404.008, 2384.12, 592.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (4.78455, -89.6484, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (346.825, 2384.12, 592.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (4.78455, -89.6484, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (302.679, 2384.12, 592.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (4.78455, -89.6484, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (313.172, 2312.75, 592.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (4.78455, -89.6484, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (377.814, 2297.41, 592.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (4.78455, -89.6484, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (464.938, 2289.41, 592.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (4.78455, -89.6484, 0);
	}
	else if(level.script == "mp_crossfire") {
		level.trainingAreaFire[level.trainingAreaFire.size] = (6423.87, -153.669, 368.087);
		level.trainingAreaFire[level.trainingAreaFire.size] = (6038.08, 1655.04, 368.018);
		level.trainingAreaFire[level.trainingAreaFire.size] = (6059.51, 1658.95, 338.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (6711.65, 1793.65, 334.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (6732.06, 1797.37, 367.882);
		level.trainingAreaFire[level.trainingAreaFire.size] = (7117.39, -8.02759, 367.73);
		level.trainingAreaFire[level.trainingAreaFire.size] = (7095.64, -12.8608, 334.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (6443.98, -149.87, 338.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (6421.94, -155.798, 367.623);
		i=0;
		level.trainingAreaSpawns["axis"][i]["origin"] = (6473.65, -28.0496, 334.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (15.9619, 90.8179, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (6511.56, 147.456, 334.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (15.9619, 90.8179, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (6616.01, 244.661, 334.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (14.2975, 112.043, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (6778.35, 259.272, 334.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (8.86475, 100.887, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (6707.26, 60.1999, 334.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (5.96985, 100.524, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (6935.37, 42.4658, 334.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (-0.336304, 106.611, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (6928.06, 244.288, 334.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (2.05322, 102.771, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (6866.23, 382.312, 334.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (2.13013, 102.914, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (6700.51, 353.783, 334.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.83777, 105.957, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (6513.46, 339.951, 334.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (4.29993, 94.0039, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (6402.32, 347.874, 334.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (0.531616, 92.4109, 0);
		i=0;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6165.03, 1563.82, 334.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (0.653687, -76.6302, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6283.39, 1589.69, 334.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (0.43396, -80.47, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6468.28, 1650.49, 334.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (1.01624, -83.1506, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6595.76, 1678.96, 334.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (1.23047, -84.8865, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6694.97, 1609.15, 334.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (1.08765, -87.0618, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6647.98, 1543.8, 334.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (1.23047, -85.4687, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6530.32, 1522.15, 334.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (1.37878, -82.9309, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6428.73, 1508.39, 334.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (1.37878, -82.4969, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6316.12, 1500.13, 334.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (1.37878, -82.4969, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6197.24, 1489.23, 334.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (1.23047, -77.8607, 0);
	}
	else if(level.script == "mp_convoy") {
		i=0;
		level.trainingAreaSpawns["axis"][i]["origin"] = (-3164.26, -708.943, -56.8286);
		level.trainingAreaSpawns["axis"][i]["angles"] = (2.39502, 93.6752, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (-3223.89, -709.031, -45.0726);
		level.trainingAreaSpawns["axis"][i]["angles"] = (3.19153, 90.3463, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (-3308.7, -709.019, -28.5283);
		level.trainingAreaSpawns["axis"][i]["angles"] = (3.48267, 89.4015, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (-3334.34, -628.761, -32.4198);
		level.trainingAreaSpawns["axis"][i]["angles"] = (3.48267, 89.4015, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (-3291.48, -621.912, -43.6585);
		level.trainingAreaSpawns["axis"][i]["angles"] = (3.48267, 89.4015, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (-3236.5, -621.928, -46.5037);
		level.trainingAreaSpawns["axis"][i]["angles"] = (3.48267, 89.4015, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (-3173.34, -621.944, -59.2882);
		level.trainingAreaSpawns["axis"][i]["angles"] = (3.48267, 89.4015, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (-3169.84, -555.57, -63.4575);
		level.trainingAreaSpawns["axis"][i]["angles"] = (3.48267, 89.4015, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (-3225.14, -540.742, -52.3551);
		level.trainingAreaSpawns["axis"][i]["angles"] = (3.48267, 89.4015, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (-3311.22, -530.956, -47.3124);
		level.trainingAreaSpawns["axis"][i]["angles"] = (3.48267, 89.4015, 0);
		//Recorder Mode: allies
		i=0;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-3334.32, 721.784, -71.875);
		level.trainingAreaSpawns["allies"][i]["angles"] = (2.2522, -89.5987, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-3273.27, 721.734, -71.875);
		level.trainingAreaSpawns["allies"][i]["angles"] = (2.90588, -91.5598, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-3194.25, 721.672, -71.875);
		level.trainingAreaSpawns["allies"][i]["angles"] = (2.90588, -91.774, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-3128.8, 721.624, -71.875);
		level.trainingAreaSpawns["allies"][i]["angles"] = (2.90588, -91.774, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-3101.43, 647.88, -71.875);
		level.trainingAreaSpawns["allies"][i]["angles"] = (3.41126, -92.3563, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-3156.94, 633.633, -71.875);
		level.trainingAreaSpawns["allies"][i]["angles"] = (3.41126, -92.3563, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-3235.75, 633.302, -71.875);
		level.trainingAreaSpawns["allies"][i]["angles"] = (3.48267, -92.4991, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-3319.77, 633.389, -71.875);
		level.trainingAreaSpawns["allies"][i]["angles"] = (3.48267, -92.4991, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-3346.04, 565.53, -71.875);
		level.trainingAreaSpawns["allies"][i]["angles"] = (3.48267, -92.4991, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-3278.4, 547.221, -71.875);
		level.trainingAreaSpawns["allies"][i]["angles"] = (3.48267, -92.4991, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (-3213.41, 536.094, -71.5404);
		level.trainingAreaSpawns["allies"][i]["angles"] = (3.48267, -92.4991, 0);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3369.37, 843.742, 32.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3465.88, 843.77, 32.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3466.27, 737.265, 32.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3446.85, 657.008, -157.488);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3456.72, 935.053, -164.286);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3464.06, 352.875, 64.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3465.52, 61.4458, 64.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3465.5, 32.4846, 77.8924);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3394.99, 33.784, 80.0339);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3402.11, -342.648, 79.947);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3402.14, -387.976, 63.9368);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3395.5, -750.888, 63.8903);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3062.45, -761.999, 62.3673);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3074.48, -903.262, -264.393);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3026.16, -233.176, -62.5693);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3025.66, -213.137, -7.78918);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3030.49, -10.8946, -7.78918);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3044.68, -46.6946, -274.508);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-2669.78, 510.332, -161.724);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-2661.37, 523.691, -49.4723);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-2655.55, 872.975, -41.4101);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-2817.31, 932.26, -30.0557);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-2883.07, 846.356, 27.1028);
		level.trainingAreaFire[level.trainingAreaFire.size] = (-3383.12, 842.152, 32.125);
	}
	else if(level.script == "mp_citystreets") {
		level.trainingAreaFire[level.trainingAreaFire.size] = (6589.22, -2567.47, 624.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (5696.15, -2564.98, 624.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (5694.97, -1762.54, 624.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (5890.71, -1570.58, 624.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (6595.5, -1562.87, 624.125);
		level.trainingAreaFire[level.trainingAreaFire.size] = (6591.63, -2568.42, 624.125);
		//Recorder Mode: axis
		i=0;
		level.trainingAreaSpawns["axis"][i]["origin"] = (5817.51, -2464.98, 624.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (8.43079, 34.9863, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (5927.37, -2449.99, 624.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (7.7771, 46.2858, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (5927.62, -2342.73, 624.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.54663, 55.778, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (5858.79, -2272.88, 624.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (6.3269, 46.2144, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (5930.62, -2332.96, 624.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (5.82153, 36.2168, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (6054.59, -2419.95, 624.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (4.8053, 55.344, 0);
		i++;
		level.trainingAreaSpawns["axis"][i]["origin"] = (6102.53, -2362.9, 624.125);
		level.trainingAreaSpawns["axis"][i]["angles"] = (4.37134, 46.7911, 0);
		//Recorder Mode: allies
		i=0;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6542.39, -1807.69, 624.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (11.474, -141.888, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6444.58, -1818.45, 624.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (11.6882, -139.713, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6426.07, -1905.9, 624.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (11.6882, -133.775, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6495.55, -2014.56, 624.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (10.3864, -138.702, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6378.5, -1936.27, 624.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (8.86475, -129.572, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6271.02, -1829.78, 624.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (6.68945, -130.226, 0);
		i++;
		level.trainingAreaSpawns["allies"][i]["origin"] = (6301.92, -1661.88, 624.125);
		level.trainingAreaSpawns["allies"][i]["angles"] = (8.35388, -134.28, 0);
	}	
	else
		level.trainingArea = false;

	if(level.trainingArea && isDefined(level.trainingAreaFire[0])) {
		for(i=1;i<level.trainingAreaFire.size;i++) {
			thread AddBlockerWall(level.trainingAreaFire[i-1],level.trainingAreaFire[i]);
		}
		thread PlayFireCircle(level.trainingAreaFire);
		dist = 0;
		for(i=1;i<level.trainingAreaFire.size;i++)
			dist += distance(level.trainingAreaFire[i],level.trainingAreaFire[i-1])/500;
		wait dist/2;
		thread PlayFireCircle(level.trainingAreaFire);
	}		
}

PlayFireCircle(array) {
	link = spawn("script_model",array[0]); 
	link setModel("tag_origin");
	persec = 10;
	while(1) {
		for(i=1;i<array.size;i++) {
			speed = distance(array[i],array[i-1])/500;
			link moveTo(array[i],speed);
			for(k=0;k<speed*persec;k++) {
				PlayFx( level.fire_fx, link.origin );
				wait 1/persec;
			}
			wait 1/persec;
		}
	}
}

AddBlockerWall(a,b) {
	speed = distance(a,b)/700;
	link = spawn("script_origin",a);
	link MoveTo(b,speed);
	for(k=0;k<speed*20;k++) {
		AddBlocker(link.origin,25,100);
		wait .05;
	}
	link delete();
}

checkAreaEnter() {
	if(!level.trainingArea) return;
	//wait 8; //check for new players that cant spawn this round - no dead 
	for(;;) {
		level waittill("connected",player);
		player thread SpawnIfWeaponSelected();
	}
}

SpawnIfWeaponSelected() {
	level endon ( "game_ended" );
	self endon("disconnect");
	//self endon("spawned_player");
	for(;;) {
		self waittill("menuresponse", menu, response);
		if( (menu == game["menu_changeclass"] || menu == game["menu_changeclass_offline"]) && !self isRealyAlive()) {
			wait .05; //waitill other lower messages done
			self thread JoinTrainingAreaMessage(0);
		}
	}
}

Respawn(dowait) {
	level endon ( "game_ended" );
	self endon("disconnect");
	spawndelay = 3;
	if(dowait) {
		self thread SkipKillcam();
		wait 2;
		time = getTime() / 1000;
		self common_scripts\utility::waittill_any("disconnect","end_killcam","skipped_killcam");
		spawndelay = spawndelay - (getTime()/1000)-time;
	} 
	//if(dowait) for(i=0;i<180 && !self useButtonPressed() && (!isDefined(self.cancelKillcam) || !self.cancelKillcam);i++) wait .05;	//wait for killcam skip
	self clearLowerMessage();
	if(spawndelay > 0) {
		self thread timer(spawndelay);
		wait spawndelay;
	}
	while(self AttackButtonPressed()) wait .05;	
	self thread SpawnPlayer();
}

timer(time) {
	self endon("disconnect");	
	text = addTextHud( self, 0, 100, 1, "center", "middle", "center", "middle", 1.4, 1001 );
	text.label = duffman\_common::getLangString("RESPAWN_IN");
	text SetTenthsTimer(time);
	wait time;
	text destroy();
}

SkipKillcam() {
	level endon ( "game_ended" );
	self endon("disconnect");
	self endon("end_killcam");
	wait 2;
	while(!self UseButtonPressed() && (!isDefined(self.cancelKillcam) || !self.cancelKillcam)) wait .05;
	self notify("skipped_killcam");
}

SpawnPlayer() {
	self endon("disconnect");
	if(self.pers["team"] == "spectator")
		return;
	self.inTrainingArea = true;
	self thread [[level.spawnPlayer]]();
	self waittill("spawned_player");
	self.statusicon = "hud_status_dead";
   	self clearLowerMessage();
}

JoinTrainingAreaMessage(dowait) {
	level endon ( "game_ended" );
	self endon("disconnect");
	self endon("spawned_player");
	if(dowait) {
		wait 2;
		for(i=0;i<180 && !self useButtonPressed() && (!isDefined(self.cancelKillcam) || !self.cancelKillcam);i++) wait .05;	//wait for killcam skip
	}
	wait .05;
	while(self useButtonPressed()) wait .05;
	self thread lmsg(self getLangString("TRAINING_AREA"));
	while(!self useButtonPressed() || self AttackButtonPressed()) wait .05;
	self thread timer(2);
	wait 2;
	while(self AttackButtonPressed()) wait .05;
	self thread SpawnPlayer();
}

lmsg(msg) {
	self endon("disconnect");
	self setLowerMessage(msg);
	wait 2;
	self clearLowerMessage(2);	
}

Record() {
	for(;;) {
		level waittill("connected",player);
		player thread Recorder();
	}
}

Recorder() {
	self endon("disconnect");
	mode = "axis";
	wtf = duffman\_common::read("wtf");
	start = "i=0;";
	ifstart = true;
	for(;;) {
		while(!self UseButtonPressed() && !self MeleeButtonPressed() && !self SecondaryOffhandButtonPressed() && !self FragButtonPressed()) wait .05;
		if(self UseButtonPressed()) {
			iPrintLnBold("origin saved");
			if(ifstart) {
				duffman\_common::log("locations_"+level.script+".log","else if(level.script == "+wtf+""+getDvar("mapname")+""+wtf+") {","append");
				ifstart = false;				
			}
			if(mode == "axis")
				duffman\_common::log("locations_"+level.script+".log","	" +start+"\n	level.trainingAreaSpawns["+wtf+"axis"+wtf+"][i]["+wtf+"origin"+wtf+"] = "+self.origin+";\n	level.trainingAreaSpawns["+wtf+"axis"+wtf+"][i]["+wtf+"angles"+wtf+"] = "+self GetPlayerAngles()+";","append");
			else if(mode == "allies")
				duffman\_common::log("locations_"+level.script+".log","	" +start+"\n	level.trainingAreaSpawns["+wtf+"allies"+wtf+"][i]["+wtf+"origin"+wtf+"] = "+self.origin+";\n	level.trainingAreaSpawns["+wtf+"allies"+wtf+"][i]["+wtf+"angles"+wtf+"] = "+self GetPlayerAngles()+";","append");
			else if(mode == "fire")
				duffman\_common::log("locations_"+level.script+".log","	level.trainingAreaFire[level.trainingAreaFire.size] = "+self.origin+";","append");
			start = "i++;";
		}
		else if(self MeleeButtonPressed()) {
			iPrintLnBold("New sector");
			duffman\_common::log("locations_"+level.script+".log","	//--------------------------------","append");
		}
		else if(self SecondaryOffhandButtonPressed()) {
			if(mode == "axis")
				mode = "allies";
			else if(mode == "allies")
				mode = "fire";
			else if(mode == "fire")
				mode = "axis";
			iPrintlnbold("Switched to mode: " +mode);
			duffman\_common::log("locations_"+level.script+".log","	//Recorder Mode: " +mode,"append");
			start = "i=0;";
		}
		else if(self FragButtonPressed() && !ifstart) {
			duffman\_common::log("locations_"+level.script+".log","}","append");
			ifstart = true;
			iPrintLnBold("finished record");
		}
		while(self UseButtonPressed() || self MeleeButtonPressed() || self SecondaryOffhandButtonPressed() || self FragButtonPressed()) wait .05;
	}
}