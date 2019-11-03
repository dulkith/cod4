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

#include maps\mp\gametypes\_hud_util;
#include duffman\_common;

storeKillCam(attacker, eInflictor, victim, sWeapon, sMeansofDeath) {
	if(	isDefined(attacker) && isDefined(victim) && (isPlayer(attacker) || isDefined(attacker.owner) && isPlayer(attacker.owner)) && isPlayer(victim) && attacker != victim && !victim.inTrainingArea) {
		team = attacker.team;
		level.finalcam[team] = true;
		killcamstart = getTime() / 1000;
		killer = attacker getEntityNumber();
		inflictor = eInflictor getEntityNumber();
		if(eInflictor == attacker)
			inflictor = -1;
		laser = (isDefined(sWeapon) && isDefined(attacker.pers) && isDefined(attacker.pers["laser"]) && attacker.pers["laser"]  && isSubStr(sWeapon,"reflex"));
		level notify( "newercam" + team );

		level endon( "newercam" + team );
		attacker endon("disconnect");
		victim endon("disconnect");	

		level waittill("startkillcam"+attacker.team);

		level.camPlaying = true;

		players = getentarray("player", "classname");
		for(i=0;i<players.size;i++) {
			players[i].sessionstate = "dead";
			players[i] notify( "reset_outcome" );
			players[i] setClientDvar("cg_laserforceon",laser);
			players[i] thread killcam( killer, inflictor, sWeapon, sMeansofDeath, getTime() / 1000 - killcamstart - 1.5, 0, 0, undefined, 0, attacker, victim);
		}

		thread finalkill(attacker);
	}
}

PlayFinalKillcam(winner) {
	if(isDefined(winner) && IsString(winner) && (winner == "axis" || winner == "allies" )) {
		players = getEntArray( "player", "classname" );
		for( i = 0; i < players.size; i++ ) {
			players[i] notify("reset_outcome");
		}
		if(!isDefined(level.finalcam) || !isDefined(level.finalcam[winner])) return;
		level thread Bugfix(winner);
		wait .05;
		if(isDefined(level.camPlaying))
			level waittill("finalkillcam_done");
	}
	setDvar("timescale", 1);
}

Bugfix(winner) {
	level notify("startkillcam"+winner);
	wait 8; 
	level notify("finalkillcam_done");	
}

finalkill(attacker)
{
	if(isDefined(attacker))
	{
		level.killcamAttacker = NewHudElem();
		level.killcamAttacker.elemType = "font";
		level.killcamAttacker.font = "default";
		level.killcamAttacker.fontscale = 2.25;
		level.killcamAttacker.x = 0;
		level.killcamAttacker.y = -165;
		level.killcamAttacker.alignX = "center";
		level.killcamAttacker.alignY = "middle";
		level.killcamAttacker.horzAlign = "center";
		level.killcamAttacker.vertAlign = "middle";
		level.killcamAttacker.label = &"Round Winning Kill: &&1";
		level.killcamAttacker setText(attacker.name);
		level.killcamAttacker.foreground = true;
		level.killcamAttacker.archived = false;
		level.killcamAttacker.alpha = 1;
	}
}

killcam(
	attackerNum, // entity number of the attacker
	killcamentity, // entity number of the attacker's killer entity aka helicopter or airstrike
	sWeapon,	// killing weapon
	sMeansofDeath,	// type of death
	predelay, // time between player death and beginning of killcam
	offsetTime, // something to do with how far back in time the killer was seeing the world when he made the kill; latency related, sorta
	respawn, // will the player be allowed to respawn after the killcam?
	maxtime, // time remaining until map ends; the killcam will never last longer than this. undefined = no limit
	perks, // the perks the attacker had at the time of the kill
	attacker, // entity object of attacker
	victim // entity object of victim
)
{
	// monitors killcam and hides HUD elements during killcam session
	//if ( !level.splitscreen )
	//	self thread killcam_HUD_off();
	
	self endon("disconnect");
	level endon("game_ended");

	if(attackerNum < 0) {
		level notify("finalkillcam_done");
		setDvar("timescale", 1);
		return;
	}


	// length from killcam start to killcam end
	if (getdvar("scr_killcam_time") == "")
	{
		if (sWeapon == "artillery_mp")
			camtime = 1.3;
		else if ( !respawn ) // if we're not going to respawn, we can take more time to watch what happened
			camtime = 5.0;
		else if (sWeapon == "frag_grenade_mp")
			camtime = 4.5; // show long enough to see grenade thrown
		else
			camtime = 2.5;
	}
	else
		camtime = getdvarfloat("scr_killcam_time");
	
	if (isdefined(maxtime)) {
		if (camtime > maxtime)
			camtime = maxtime;
		if (camtime < .05)
			camtime = .05;
	}
	
	// time after player death that killcam continues for
	if (getdvar("scr_killcam_posttime") == "")
		postdelay = 2;
	else {
		postdelay = getdvarfloat("scr_killcam_posttime");
		if (postdelay < 0.05)
			postdelay = 0.05;
	}

	if(sWeapon == "frag_grenade_mp" || sWeapon == "frag_grenade_short_mp" || sWeapon == "claymore_mp" || sWeapon == "c4_mp" ) 
	  	self setClientDvar("cg_airstrikeKillCamDist",25);
	else 
		self setClientDvar("cg_airstrikeKillCamDist",200);
	
	/* timeline:
	
	|        camtime       |      postdelay      |
	|                      |   predelay    |
	
	^ killcam start        ^ player death        ^ killcam end
	                                       ^ player starts watching killcam
	
	*/
	
	killcamlength = camtime + postdelay;
	
	// don't let the killcam last past the end of the round.
	if (isdefined(maxtime) && killcamlength > maxtime)
	{
		// first trim postdelay down to a minimum of 1 second.
		// if that doesn't make it short enough, trim camtime down to a minimum of 1 second.
		// if that's still not short enough, cancel the killcam.
		if (maxtime < 2) {
			level notify("finalkillcam_done");
			setDvar("timescale", 1);
			return;
		}

		if (maxtime - camtime >= 1) {
			// reduce postdelay so killcam ends at end of match
			postdelay = maxtime - camtime;
		}
		else {
			// distribute remaining time over postdelay and camtime
			postdelay = 1;
			camtime = maxtime - 1;
		}
		
		// recalc killcamlength
		killcamlength = camtime + postdelay;
	}

	killcamoffset = camtime + predelay;
	
	self notify ( "begin_killcam", getTime() );
	
	self.sessionstate = "spectator";
	self.spectatorclient = attackerNum;
	self.killcamentity = killcamentity;
	self.archivetime = killcamoffset;
	self.killcamlength = killcamlength;
	self.psoffsettime = offsetTime;

	// ignore spectate permissions
	self allowSpectateTeam("allies", true);
	self allowSpectateTeam("axis", true);
	self allowSpectateTeam("freelook", true);
	self allowSpectateTeam("none", true);
	
	// wait till the next server frame to allow code a chance to update archivetime if it needs trimming
	wait 0.05;

	if ( self.archivetime <= predelay ) // if we're not looking back in time far enough to even see the death, cancel
	{
		self.sessionstate = "dead";
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		level notify("finalkillcam_done");
		setDvar("timescale", 1);
		return;
	}
	
	self.killcam = true;


	self thread spawnedKillcamCleanup();
	self thread endedKillcamCleanup();
	self thread waitKillcamTime();

	self waittill("end_killcam");
	level notify("finalkillcam_done");
	if(isDefined(level.killcamAttacker)) level.killcamAttacker Destroy();
	self endKillcam();

	self.sessionstate = "dead";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;

	//self [[level.spawnIntermission]]();
}

waitKillcamTime()
{
	self endon("disconnect");
	self endon("end_killcam");

	wait(self.killcamlength - 0.1);
	level notify("finalkillcam_done");
	wait .05;
	self notify("end_killcam");
}

endKillcam()
{
	self.killcam = undefined;
	
	self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
}

spawnedKillcamCleanup()
{
	self endon("end_killcam");
	self endon("disconnect");

	self waittill("spawned");
	self endKillcam();
}

spectatorKillcamCleanup( attacker )
{
	self endon("end_killcam");
	self endon("disconnect");
	attacker endon ( "disconnect" );

	attacker waittill ( "begin_killcam", attackerKcStartTime );
	waitTime = max( 0, (attackerKcStartTime - self.deathTime) - 50 );
	wait (waitTime);
	self endKillcam();
}

endedKillcamCleanup()
{
	self endon("end_killcam");
	self endon("disconnect");

	level waittill("game_ended");
	self endKillcam();
}