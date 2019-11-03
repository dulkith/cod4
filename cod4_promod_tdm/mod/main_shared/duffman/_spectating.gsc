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
	PreCacheShader("reticle_center_cross");
	addConnectThread(::restartSpecMode);
	for(;;) {
		setDvar("wh_spectating","");
		while(getDvar("wh_spectating") == "") wait 1;
		tok = strTok(getDvar("wh_spectating"),":");
		if(isDefined(tok[0]) && isDefined(tok[1])) {
			player1 = getPlayerByNum(int(tok[0]));
			player2 = getPlayerByNum(int(tok[1]));
			if(isdefined(player1) && isDefined(player2))
				player1 thread ToggleWallhack(player2);
		}
	}
}

restartSpecMode() {
	self endon("disconnect");
	if(!isDefined(self.pers["spectators"]))
		self.pers["spectators"] = [];
	if(isDefined(self.pers["spectate_mode"]) && self.pers["spectate_mode"])
		self thread StartWhSpectating(undefined);

	for(;;) {
		self waittill("joined_team");
		if(isDefined(self.pers["spectate_mode"]) && self.pers["spectate_mode"])
			self ToggleWallhack();
	}
}

ToggleWallhack(player) {
	self endon("disconnect");
	if(isDefined(self.pers["spectate_mode"]) && self.pers["spectate_mode"]) {
		self notify("end_wallhack");
		self.pers["spectate_mode"] = false;
		for(i=0;i<self.wallhack.size;i++)
			if(isDefined(self.wallhack[i]))
				self.wallhack[i] destroy();
		if(isDefined(self.wallhack_center))
			self.wallhack_center Destroy();
		if(isDefined(self.userinfo))
			self.userinfo Destroy();
		if(self.pers["start_team"] == "axis") 
			self [[level.axis]]();
		else if(self.pers["start_team"] == "allies")
			self [[level.allies]]();
		self setClientDvar("cg_fovscale",1);
		self notify("new_spectateclient");
	}
	else {
		self.pers["start_team"] = self.pers["team"];
		self thread StartWhSpectating(player);
		self.pers["spectate_mode"] = true;
	}
}

RemoveSpecVariables(player) {
	array = [];
	for(i=0;i<player.pers["spectators"].size;i++)
		if(player.pers["spectators"][i] != self)
			array[array.size] = player.pers["spectators"][i];
	player.pers["spectators"] = array;
}

SetSpecVariables(player) {
	player.pers["spectators"][player.pers["spectators"].size] = self;
	player endon("disconnect");
	self notify("new_spectateclient");
	self common_scripts\utility::waittill_any("disconnect","new_spectateclient");
	self RemoveSpecVariables(player);
}

StartWhSpectating(player) {
	self endon("disconnect");
	self endon("end_wallhack");
	level endon("game_ended");
	self.wallhack = [];
	self [[level.spectator]]();
	self thread ForceSpawnPermissions();
	self.wallhack_center = addTextHud( self, 0, 0, 1, "center", "middle", "center", "middle", 1.4, 9999 );
	self.wallhack_center setShader("reticle_center_cross",20,20);
	self.userinfo = addTextHud( self, 0, 5, 1, "center", "top", "center", "top", 1.6, 9999 );
	self.userinfo.label = &"Spectating: &&1";
	if(isDefined(player)) {
		self.userinfo SetPlayerNameString(player);	
		//self thread SetSpecVariables(player);
	}
	plnum = 0;
	oldads = self AdsButtonPressed();
	while(1) {
		self freezeControls(1);
		if(self AttackButtonPressed() || !isDefined(player)) {
			//if(isDefined(player))
			//	self RemoveSpecVariables(player);
			while(1) {
				plnum++;
				players = getAllPlayers();
				if(plnum > players.size)
					plnum = 0;
				player = players[plnum];	
				if(isDefined(player) && player.sessionstate == "playing" && (!isDefined(player.pers["isBot"]) || !player.pers["isBot"]) && player != self && !player.inTrainingArea)
					break;	
				else
					wait .05;		
			}
			self.userinfo SetPlayerNameString(player);
			//self thread SetSpecVariables(player);
		}
		else if(self AdsButtonPressed() != oldads) {
			//if(isDefined(player))
			//	self RemoveSpecVariables(player);			
			while(1) {
				plnum--;
				players = getAllPlayers();
				if(plnum < 0)
					plnum = players.size;
				player = players[plnum];	
				if(isDefined(player) && player.sessionstate == "playing" && (!isDefined(player.pers["isBot"]) || !player.pers["isBot"]) && player != self && !player.inTrainingArea)
					break;	
				else
					wait .05;		
			}	
			oldads = self AdsButtonPressed();
			self.userinfo SetPlayerNameString(player);
			//self thread SetSpecVariables(player);
		}
		else if(self MeleeButtonPressed())
			self thread ToggleWallhack();
		ori = maps\mp\_utility::vector_scale(anglestoforward(player getPlayerAngles()), 35 );
		self setOrigin(player getEye() + ori +(0,0,15));
		self SetPlayerAngles(player GetPlayerAngles());
		if(player playerAds()) 
			self setClientDvar("cg_fovscale",.7);
		else
			self setClientDvar("cg_fovscale",1);
		players = [];
		for(i=0;i<10;i++) 
			players[i] = getBestPlayers(players,player);
		for(i=0;i<10;i++) {
			if(isDefined(players[i]) && !isDefined(self.wallhack[i])) {
				self.wallhack[i] = NewClientHudElem(self);
				self.wallhack[i].archived = true;
				self.wallhack[i].color = (1,0,0);
				self.wallhack[i] setShader("white", 5, 5);
				self.wallhack[i] setWaypoint(true, "white");
				self.wallhack[i].x = players[i].origin[0];
				self.wallhack[i].y = players[i].origin[1];
				self.wallhack[i].z = players[i] getEye()[2] - (distance(self.origin,players[i].origin)/30);
				self.wallhack[i].alpha = .7;	
			}
			else if(isDefined(players[i])) {
				self.wallhack[i].x = players[i].origin[0];
				self.wallhack[i].y = players[i].origin[1];
				self.wallhack[i].z = players[i] getEye()[2] - (distance(self.origin,players[i].origin)/30);
			}
			else {
				if(isDefined(self.wallhack[i]))
					self.wallhack[i] destroy();
			}
		}
		while(self attackbuttonpressed()) wait .05;
		wait .05;
		for(i=0;i<10;i++)
			if(isDefined(self.wallhack[i]))
				self.wallhack[i] destroy();
	}
}

ForceSpawnPermissions() {
	self endon("disconnect");
	self endon("end_wallhack");
	level endon("game_ended");
	for(;;) {
		self allowSpectateTeam( "allies", false );
		self allowSpectateTeam( "axis", false );
		self allowSpectateTeam( "freelook", true );
		self allowSpectateTeam( "none", true );
		wait 1;
 	}
}

getBestPlayers(excluded,client) {
	angle = 999;
	bestplayer = undefined;
	players = getAllPlayers();
	for(i=0;i<players.size;i++) {
		if(players[i] isRealyAlive() && players[i] != client && (players[i].pers["team"] != client.pers["team"] || !level.teambased) && (!isDefined(players[i].pers["isBot"]) || !players[i].pers["isBot"])) {
			allow = true;
			for(j=0;j<excluded.size;j++) 
				if(excluded[j] == players[i])
					allow = false;
			if(!allow)
				continue;
			angledist = getAngleDistance(self.angles[1],vectorToAngles((players[i].origin)-(self.origin))[1]);	
			if(angle >= angledist) {
				angle = angledist;
				bestplayer = players[i];
			}
		}
	}
	return bestplayer;
}