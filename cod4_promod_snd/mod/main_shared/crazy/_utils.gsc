#include maps\mp\_utility;
#include common_scripts\utility;

precache()
{
	precachemodel("projectile_hellfire_missile");
	precacheShader("waypoint_kill");
	precacheShader("white");
	precacheShellShock( "radiation_high" );
	precacheLocationSelector( "map_artillery_selector" );
}

varcache()
{
	level.hardcoreMode = getDvarInt( "scr_hardcore" );
	level.oldschool = getDvarInt( "scr_oldschool" );
	if ( level.hardcoreMode )
		level.prevHP = 30;
	else if ( level.oldschool )
		level.prevHP = 200;
	else
		level.prevHP = 100;

	level.predatorLaunchTime = 10;
	level.predatorFlyTime = 10;
	level.reaperLaunchTime = 30;
	level.ac130Time = 30;
	level.rounds = 20;  // Arty
	level.missilesLeft = 6; // Predator drone
	level.missileFlyTime = 1.0;  //heli guided missile
	
	level.reaper = false;
	level.predator = false;
	level.ac130 = false;
	level.arty = false;
	level.nuke = false;
	
    if(getDvar("scr_game_finalkillcam") == "")
        setDvar("scr_game_finalkillcam", 1);
    
    level.showingfinalkillcam = false;
    level.killcam_style = 0;
    level.Winner = undefined;
    level.InEndGame = false;
	
	level.finalkillcam = getDvarInt("scr_game_finalkillcam" );
	
	level._105mm_ = loadfx ("explosions/tanker_explosion");
	level._25mm_ = loadfx("impacts/large_mud");
	level._40mm_ = loadfx("explosions/artilleryExp_dirt_brown");
	level.smoke = loadfx("smoke/smoke_geotrail_hellfire");
}

pow(number, times)
{
	result = number;
	
	for(i=0;i<times;i++)
	{
		result *= number;
	}
	
	return result;
}

getPlayers()
{
	return getEntarray( "player", "classname" );
}

isReallyAlive(player)
{
	if(isAlive(player) && player.sessionstate == "playing")
		return true;
	else
		return false;
}

clearNotify()
{
	if(level.nuke)
		return;

	players = getPlayers();
	for( i = 0; i < players.size; i++ )
	{
		if(isDefined(players[i].doingNotify) && players[i].doingNotify)
			players[i] thread maps\mp\gametypes\_hud_message::resetNotify();

	}
}

notifyTeam(string, glow, duration)
{
	players = getPlayers();
	for( i = 0; i < players.size; i++ )
	{
		player = players[i];
		//Dont need notification for himself
		if(player == self)
			continue;
		if(player.pers["team"] == self.pers["team"])
			player thread maps\mp\gametypes\_hud_message::oldNotifyMessage(undefined, "FRIENDLY " + string, undefined, glow, undefined, duration);
		else
			player thread maps\mp\gametypes\_hud_message::oldNotifyMessage(undefined, "ENEMY " + string, undefined, glow, undefined, duration);
	}
}

notifyTeamBig(string, glow, duration)
{
	players = getPlayers();
	for( i = 0; i < players.size; i++ )
	{
		player = players[i];
		if(player.pers["team"] == self.pers["team"])
			player thread maps\mp\gametypes\_hud_message::oldNotifyMessage("FRIENDLY " + string, undefined, undefined, glow, undefined, duration);
		else
			player thread maps\mp\gametypes\_hud_message::oldNotifyMessage("ENEMY " + string, undefined, undefined, glow, undefined, duration);
	}
}

cleanScreen()
{
	for( i = 0; i < 6; i++ )
	{
		iPrintlnBold( " " );
		iPrintln( " " );
	}
}

monotone(str)
{
	if(!isDefined(str) || (str == "")) return ("");

	_s = "";

	_colorCheck = false;
	for(i = 0; i < str.size; i++)
	{
		ch = str[i];
		if ( _colorCheck )
		{
			_colorCheck = false;

			switch(ch)
			{
			  case "0":	// black
			  case "1":	// red
			  case "2":	// green
			  case "3":	// yellow
			  case "4":	// blue
			  case "5":	// cyan
			  case "6":	// pink
			  case "7":	// white
			  case "8":	// Olive
			  case "9":	// Grey
			  	break;
			  default:
			  	_s += ("^" + ch);
			  	break;
			}
		}
		else if(ch == "^")
			_colorCheck = true;
		else
			_s += ch;
	}
	return ( _s );
}

TargetMarkers()
{
	wait .1;

	self setClientDvar("waypointiconheight", 15);
	self setClientDvar("waypointiconwidth", 15);

	j=0;
	
	players = getEntArray("player", "classname");
	for(i=0;i<players.size;i++)
	{
		//he doesn't need an icon to know his own position
		if(players[i] == self)
			continue;
			
		if(players[i].pers["team"] == self.pers["team"] || players[i].pers["team"] == "spectator")
			continue;

		self.TargetMarker[j] = newClientHudElem(self);
		self.TargetMarker[j].x = players[i].origin[0];
		self.TargetMarker[j].y = players[i].origin[1];
		self.TargetMarker[j].z = players[i].origin[2];
		self.TargetMarker[j].baseAlpha = 1;
		self.TargetMarker[j].alpha = 1;
		self.TargetMarker[j].isFlashing = false;
		self.TargetMarker[j].isShown = true;
		self.TargetMarker[j] setShader("waypoint_kill", 15, 15);
		self.TargetMarker[j] setWayPoint(true, "waypoint_kill");
		self.TargetMarker[j] setTargetEnt(players[i]);
		
		players[i] thread TargetMarkerEvent(self, j);
			
		j++;
	}
}

TargetMarkerEvent(owner, j)
{
	class = undefined;
	
	if(isDefined(level.predator) && level.predator && isDefined(owner.predator))
		class = "predator";

	if(isDefined(level.ac130) && level.ac130 && isDefined(owner.ac130))
		class = "ac130";

	if(isDefined(level.reaper) && level.reaper && isDefined(owner.reaper))
		class = "reaper";

	while(isDefined(owner) && isReallyAlive(owner) && isDefined(class) )
	{
		self waittill_any("joined_spectators", "joined_team", "death", "spawned_player", "endSpawn");

		if(class == "predator" && !isDefined(owner.predator) || !level.predator)
			break;
			
		else if(class == "ac130" && !isDefined(owner.ac130) || !level.ac130)
			break;
			
		else if(class == "reaper" && !isDefined(owner.reaper) || !level.reaper)
			break;
		
		if(!isDefined(owner.TargetMarker) || !isDefined(owner.TargetMarker[j]) )
			break;

		if(!isReallyAlive(self) || self.pers["team"] == owner.pers["team"] || self.pers["team"] == "spectator" || isDefined(self.spawnprotected))
		{
			owner.TargetMarker[j].alpha = 0;
			owner.TargetMarker[j].baseAlpha = 0;
		}
		else
		{
			owner.TargetMarker[j].alpha = 1;
			owner.TargetMarker[j].baseAlpha = 1;
		}
	}
	if(isDefined(owner.TargetMarker[j]))
		owner.TargetMarker[j] destroy();
}

playSoundinSpace( alias, origin )
{
	org = spawn( "script_origin", origin );
	org.origin = origin;
	org playSound( alias  );
	wait 10; 
	org delete();
}

spawnSpec(loc, angle)
{
	self thread maps\mp\gametypes\_globallogic::spawnSpectator(loc, angle);
}

isMap(map)
{
	if(map == getDvar("mapname"))
		return true;
		
	return false;
}

health(end)
{
	self endon("disconnect");
	self endon(end);
	level endon("game_ended");
	
	self.maxhealth = 999999999;
	self.health = 999999999;

	self thread endHealth(end);
}

endHealth(end)
{
	self endon("disconnect");
	level endon("game_ended");
	
	self waittill(end);
	
	wait .1;    // give the player a bit of breathing room when terminating protection to avoid random radiusdamage
	
	self.maxhealth = level.prevHP;
	self.health = level.prevHP;
}

/*
	Some of this positions and angles are a bit off
	Depending on CoD switch vs if statements performance adjust below code accordingly
	missing: Killhouse, shipment, chinatown
*/

getLoc()
{
	loc = level.spawn["spectator"].origin;
	
	map = getDvar("mapname");
	
	switch(map)
	{
		case "mp_backlot":
			loc = (656.731, 1853.1, 64.125);
			break;
		case "mp_bloc":
			loc = (-655.601, -1547.25, 571.784);
			break;
		case "mp_bog":
			loc = (-4415.65, -15.6626, 52.552);
			break;
		case "mp_cargoship":
			loc = (1838.28, 349.865, 165.437);
			break;
		case "mp_citystreets":
			loc = (5257.22, -151.651, 281.967);
			break;
		case "mp_convoy":
			loc = (4521.64, 3391.34, 109.336);
			break;
		case "mp_countdown":
			loc = (6619.84, -4082.8, 1109.13);
			break;
		case "mp_crash":
		case "mp_crash_snow":
			loc = (2179.16, 29.1966, 95.4196);
			break;
		case "mp_crossfire":
			loc = (3255.58, 305.262, -25.875);
			break;
		case "mp_downpour":
			loc = (-1463.01, -2571.35, 161.825);
			break;
		case "mp_overgrown":
			loc = (-2078.23, -5482.13, -139.344);
			break;
		case "mp_pipeline":
			loc = (2715.33, 3153.56, 291.236);
			break;
		case "mp_showdown":
			loc = (11.0894, 2090.79, -1.875);
			break;
		case "mp_strike":
			loc = (-2894.76, 1397.75, 1.63746);
			break;
		case "mp_vacant":
			loc = (2583.85, -136.047, -91.875);
			break;
		default:
			loc = loc;
			break;
	}
	
	return loc;
}

getAng()
{
	ang = level.spawn["spectator"].angles;
	
	map = getDvar("mapname");
	
	switch(map)
	{
		case "mp_backlot":
			ang = (0, 34.8267, 0);
			break;
		case "mp_bloc":
			ang = (0, -72.9053, 0);
			break;
		case "mp_bog":
			ang = (0, -144.456, 0);
			break;
		case "mp_cargoship":
			ang = (0, -22.8978, 0);
			break;
		case "mp_citystreets":
			ang = (0, -133.577, 0);
			break;
		case "mp_convoy":
			ang = (0, -127.947, 0);
			break;
		case "mp_countdown":
			ang = (0, 144.69, 0);
			break;
		case "mp_crash":
		case "mp_crash_snow":
			ang = (0, -1.57104, 0);
			break;
		case "mp_crossfire":
			ang = (0, 90.3735, 0);
			break;
		case "mp_downpour":
			ang = (0, -145.764, 0);
			break;
		case "mp_overgrown":
			ang = (0, -79.0173, 0);
			break;
		case "mp_pipeline":
			ang = (0, 55.7287, 0);
			break;
		case "mp_showdown":
			ang = (0, 90.4779, 0);
			break;
		case "mp_strike":
			ang = (0, -1.1261, 0);
			break;
		case "mp_vacant":
			ang = (0, 179.654, 0);
			break;
		default:
			ang = ang;
			break;
	}
	
	return ang;
}

getPosition()
{
	location = (0,0,2100);
	if(isMap("mp_bloc"))
		location = (1100,-5836,2500);
	else if(isMap("mp_crossfire"))
		location = (4566,-3162,2300);
	else if(isMap("mp_citystreets"))
		location = (4384,-469,2100);
	else if(isMap("mp_creek"))
		location = (-1595,6528,2500);
	else if(isMap("mp_bog"))
		location = (3767,1332,2300);
	else if(isMap("mp_overgrown"))
		location = (267,-2799,2600);
		
	return location;
}

removeStuff()
{
	self endon("disconnect");
	level endon("game_ended");

	if(self hasPerk("specialty_armorvest"))
	{
		self unsetPerk("specialty_armorvest");
		self setperk("specialty_bulletdamage");
	}
		
	self endon("spawned");
}


// This should be used for SD only
makeSpeed()
{
	switch ( weaponClass( self.pers["primaryWeapon"] ) )
	{
		case "rifle":
			self setMoveSpeedScale( 0.95 );
			break;
		case "pistol":
			self setMoveSpeedScale( 1.0 );
			break;
		case "mg":
			self setMoveSpeedScale( 0.875 );
			break;
		case "smg":
			self setMoveSpeedScale( 1.0 );
			break;
		case "spread":
			self setMoveSpeedScale( 1.0 );
			break;
		default:
			self setMoveSpeedScale( 1.0 );
			break;
	}
}

checkGL()
{
	self endon("disconnect");
	self endon("death");
	   
	curWeapon = self GetCurrentWeapon();
		  
	if(isSubStr(curWeapon,"_gl"))
	{
		self TakeWeapon(curWeapon);
				 
		prefix = StrTok(curWeapon,"_");
		newWeapon = prefix[0] + "_mp";

		self GiveWeapon(newWeapon);
		self GiveStartAmmo(newWeapon);

		wait 0.5;

		self SwitchToWeapon( newWeapon );
	}
}
