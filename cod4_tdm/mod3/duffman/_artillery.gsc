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
	precacheLocationSelector( "map_artillery_selector" );
	preCacheModel("projectile_cbu97_clusterbomb");
	level.nade_fx["nade"]["explode"] = loadfx ("explosions/grenadeexp_default"); 
}

CanUseArtillery() {
	self endon("disconnect");
	self beginLocationSelection( "map_artillery_selector", 400 );
	self.selectingLocation = true;

	self thread endSelectionOn( "cancel_location" );
	self thread endSelectionOn( "death" );
	self thread endSelectionOn( "disconnect" );
	self thread endSelectionOn( "used" );
	self thread endSelectionOnGameEnd();

	self endon( "stop_location_selection" );
	self waittill( "confirm_location", location );

	

	if( isDefined( level.artilleryInProgress ) )
	{
		//self iPrintLnBold( level.hardpointHints["artillery_mp_not_available"] );
		self iPrintBig("ARTILLERY_NOT_AVAILABLE");
		return false;
	}
	self thread Artillery( location );
	return true;
}

Artillery(location) {
	if(isDefined(location) && isDefined(location[0]) && isDefined(location[1]) && isDefined(location[2]) ) {
		self endon("disconnect");
		self endon("joined_spectators");
		level.artilleryInProgress = true;
		level thread endOn(self);
		waittillframeend;
		self thread stopArtilleryLocationSelection( false );
		for(k=0;k<15;k++) {
			pos = location + (RandomIntRange(-100,100),RandomIntRange(-100,100),-1000);
			endpos = bulletTrace(pos+(0,0,2500),pos, false, undefined)["position"];
			if(isDefined(endpos) && isDefined(endpos[0]) && isDefined(endpos[1]) && isDefined(endpos[2]) ) {
				//self setOrigin(endpos);
				level.artillery_bomb = spawn("script_model",endpos+(0,0,3000));
				level.artillery_bomb setModel("projectile_cbu97_clusterbomb");
				level.artillery_bomb.angles = (90,0,0);
				level.artillery_bomb MoveTo(endpos,1);
				level.artillery_bomb.owner = self;
				wait 1.05;
				if(isDefined(level.artillery_bomb))
					level.artillery_bomb delete();
				thread SoundOnOrigin( "grenade_explode_default",endpos);
				playfx(level.nade_fx["nade"]["explode"], endpos);
				players = getAllPlayers();
				for(i=0;i<players.size;i++) {
					if(players[i] isRealyAlive() && players[i] != self && (players[i].pers["team"] != self.pers["team"] || !level.teambased) && distance(players[i].origin,endpos) < 199) {
						players[i] thread [[level.callbackPlayerDamage]](self,self,int(300 - distance(players[i].origin,endpos)),8,"MOD_PROJECTILE_SPLASH","artillery_mp",(0,0,0),(0,0,0),"torso_upper",0);
					}
				}
			}
		}
		self notify("end_artillery");
	}
}

endOn(player) {
	player common_scripts\utility::waittill_any("disconnect","joined_spectators","end_artillery");
	level.artilleryInProgress = undefined;
	if(isDefined(level.artillery_bomb))
		level.artillery_bomb delete();
}

endSelectionOn( waitfor ) {
	self endon( "stop_location_selection" );
	self waittill( waitfor );
	self thread stopArtilleryLocationSelection( (waitfor == "disconnect") );
}

endSelectionOnGameEnd() {
	self endon( "stop_location_selection" );
	level waittill( "game_ended" );
	self thread stopArtilleryLocationSelection( false );
}

stopArtilleryLocationSelection( disconnected ) {
	if ( !disconnected ) {
		self endLocationSelection();
		self.selectingLocation = undefined;
	}
	self notify( "stop_location_selection" );
}