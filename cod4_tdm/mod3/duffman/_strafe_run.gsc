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
#include maps\mp\_helicopter;

StrafeRun() {
	level.strafeInProgress = true;
	self endon("disconnect");

	level thread EndonOnDc(self);

	center = getMapCenter();

	angle = randomint(360);

	vector1 = anglesToForward((0,angle - 180,0));
	vector2 = anglesToForward((0,angle,0));
	vector3 = anglesToForward((0,angle-90,0));
	vector4 = anglesToForward((0,angle-270,0));

	start[0] = center+(vector1[0]*10600,vector1[1]*10600,0)+(vector3[0]*1800,vector3[1]*1800,0);
	end[0] = center+(vector2[0]*10600,vector2[1]*10600,0)+(vector3[0]*1800,vector3[1]*1800,0);

	start[1] = center+(vector1[0]*10300,vector1[1]*10300,0)+(vector3[0]*900,vector3[1]*900,0);
	end[1] = center+(vector2[0]*10300,vector2[1]*10300,0)+(vector3[0]*900,vector3[1]*900,0);

	start[2] = center+(vector1[0]*10000,vector1[1]*10000,0);
	end[2] = center+(vector2[0]*10000,vector2[1]*10000,0);

	start[3] = center+(vector1[0]*10300,vector1[1]*10300,0)+(vector4[0]*900,vector4[1]*900,0);
	end[3] = center+(vector2[0]*10300,vector2[1]*10300,0)+(vector4[0]*900,vector4[1]*900,0);

	start[4] = center+(vector1[0]*10600,vector1[1]*10600,0)+(vector4[0]*1800,vector4[1]*1800,0);
	end[4] = center+(vector2[0]*10600,vector2[1]*10600,0)+(vector4[0]*1800,vector4[1]*1800,0);

	chopper = undefined;

	model = "vehicle_cobra_helicopter_fly";
	sound = "mp_cobra_helicopter";
	/*
	model = "vehicle_mi24p_hind_desert";
	sound = "mp_hind_helicopter";
	if ( self.pers["team"] == "allies" ) {
		model = "vehicle_cobra_helicopter_fly";
		sound = "mp_cobra_helicopter";
	}
	** delete cuz they look ugly
	*/
	for(i=0;i<5;i++) {	
		chopper[i] = spawnHelicopter( self, start[i], (0,angle,0), "cobra_mp", model );
		level.strafe_chopper[i] = chopper[i];
		chopper[i] playLoopSound( sound );
		chopper[i] SetDamageStage(3);
		chopper[i] setCanDamage(true);
		chopper[i] clearTargetYaw();
		chopper[i] clearGoalYaw();
		chopper[i] setspeed( 30, 25 );	
		chopper[i] setyawspeed( 75, 45, 45 );
		chopper[i] setmaxpitchroll( 15, 15 );
		chopper[i] setneargoalnotifydist( 200 );
		chopper[i] setturningability( 0.9 );
		chopper[i] setvehgoalpos( end[i], 0 );
		chopper[i] setVehWeapon( "cobra_20mm_mp" );
		chopper[i].owner = self;
		chopper[i].team = self.pers["team"];
		chopper[i].pers["team"] = self.pers["team"];
	}

	while(distance(center,chopper[2].origin) >= 5000) wait .05;
	for(k=0;distance(center,chopper[2].origin) <= 5000;k++) {
		players = getAllPlayers();
		allowed = [];
		for(j=0;j<players.size;j++) {
			if(isDefined(players[j]) && players[j].health > 0 && players[j].sessionteam != "spectator" && (players[j].pers["team"] != self.pers["team"] || !level.teambased) && self != players[j] && BulletTracePassed(chopper[2].origin,players[j].origin+(0,0,100),true,chopper[2])) {
				allowed[allowed.size] = players[j];
			}
		}
		if(allowed.size > 0 && k%(randomint(20) + 20) != 0) {
			player = allowed[randomint(allowed.size)];
			for(i=0;i<5;i++) {
				chopper[i] setTurretTargetEnt( player, ( 0, 0, 40 ) );
				chopper[i] setturrettargetvec( player.origin );
				chopper[i] fireWeapon( "tag_flash",player);
			}
			luck = 80 - (GetTeamPlayersAlive(player.pers["team"]) * 2);
			if(!randomint(luck)) 
				player thread [[level.callbackPlayerDamage]](chopper[randomint(chopper.size)],self,120,false,"MOD_PISTOL_BULLET","cobra_20mm_mp",(0,0,0),(0,0,0),"torso_upper",0);
		}
		else
			wait 1;
		wait .05;
	}
	wait 6;
	for(i=0;i<5;i++) 
		chopper[i] delete();
	self notify("heli_deleted");
	level.strafeInProgress = undefined;
}

getMapCenter() {
	players = getAllPlayers();
	x = [];
	y = [];
	for(i=0;i<players.size;i++) {
		if(isDefined(players[i]) && players[i].health > 0 && players[i].sessionteam != "spectator") {
			x[x.size] = players[i].origin[0];
			y[y.size] = players[i].origin[1];
		}
	}
	location = 2000;
	if(getDvar("mapname") == "mp_bloc") location = 2400;
	else if(getDvar("mapname") == "mp_crossfire") location = 2200;
	else if(getDvar("mapname") == "mp_citystreets") location = 2000;
	else if(getDvar("mapname") == "mp_creek") location = 2100;
	else if(getDvar("mapname") == "mp_bog") location = 2200;
	else if(getDvar("mapname") == "mp_overgrown") location = 2500;	
	else if(getDvar("mapname") == "mp_nuketown") location = 1700;
	else if(getDvar("mapname") == "mp_strike") location = 2100;	
	else if(getDvar("mapname") == "mp_crash") location = 2100;	
	return (getAverageValue(x),getAverageValue(y),location);
}

EndonOnDc(player) {
	player endon("heli_deleted");
	player waittill("disconnect");
	for(i=0;i<5;i++) 
		if(isDefined(level.strafe_chopper[i]))
			level.strafe_chopper[i] delete();
	level.strafeInProgress = undefined;
}