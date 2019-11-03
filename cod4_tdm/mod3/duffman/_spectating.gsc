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
	addConnectThread(::onPlayerConnect);
}

onPlayerConnect() {
	if(isDefined(self.pers["team"]) && self.pers["team"] == "spectator" && self duffman\_common::hasPermission("spectate_all"))
		self thread duffman\_spectating::StartWhSpectating();
}

cleanup() {
	self endon("disconnect");
	self waittill("joined_team");
	self notify("end_wallhack");
	for(i=0;i<10 && isDefined(self.wallhack);i++)
		if(isDefined(self.wallhack[i]))
			self.wallhack[i] destroy();
	self setClientDvars("waypointIconHeight",13.37,"waypointIconWidth", 13.37);
}

StartWhSpectating() {
	self endon("disconnect");
	self endon("end_wallhack");
	level endon("game_ended");
	self thread cleanup();
	self.wallhack = [];
	for(i=0;i<10;i++)  {
		self.wallhack[i] = NewClientHudElem(self);
		self.wallhack[i] setShader("white", 2, 2);
		self.wallhack[i] setWaypoint(true, "white");
		self.wallhack[i].alpha = 0;
	}
	self setClientDvars("waypointIconHeight",13.37,"waypointIconWidth", 13.37);
	oldplayer = self getSpectatorClient();
	while(!isDefined(oldplayer)) {
		oldplayer = self getSpectatorClient();
		wait .05;
	}
	self setClientDvars("waypointIconHeight",12,"waypointIconWidth", 7);
	while(1) {
		wait .05;
		player = self getSpectatorClient();
		if(!isDefined(player)) {
			if(isDefined(oldplayer) && oldplayer isRealyAlive())
				player = oldplayer;
			else {
				for(i=0;i<10;i++)
					self.wallhack[i].alpha = 0;
				continue;
			}
		}
		else 
			oldplayer = player;

		players = self getBestPlayers(player);
			
		for(i=0;i<10;i++) {
			if(isDefined(players[i])) {
				if(getPlayerVisibility(player,players[i]))
					self.wallhack[i].color = (0,1,0);
				else 
					self.wallhack[i].color = (1,0,0);
				self.wallhack[i].x = players[i].origin[0];
				self.wallhack[i].y = players[i].origin[1];
				if(players[i] GetStance() == "stand")
					self.wallhack[i].z = players[i].origin[2] - 10;
				else if(players[i] GetStance() == "prone")
					self.wallhack[i].z = players[i].origin[2] - 45;
				else		
					self.wallhack[i].z = players[i].origin[2] - 30;		
				self.wallhack[i].alpha = .6;	
			}
			else 
				self.wallhack[i].alpha = 0;
		}
	}
}

getBestPlayers(client) {
	bestplayer = [];
	available = [];
	angle = [];
	players = getAllPlayers();
	for(i=0;i<players.size;i++) {
		if(players[i].health && players[i] != client && (players[i].pers["team"] != client.pers["team"] || !level.teambased) && (!isDefined(players[i].pers["isBot"]) || !players[i].pers["isBot"])) {
			available[available.size] = players[i];
			angle[angle.size] = getAngleDistance(self.angles[0],vectorToAngles((players[i].origin)-(self.origin))[0]);
		}
	}
	for(k=0;k<10&&angle.size>9;k++) {
		for(i=0;i<angle.size-1;i++) {
			if(angle[i] > angle[i+1]) {
				save = angle[i+1];
				save2 = available[i+1];
				angle[i+1] = angle[i];
				angle[i] = save;
				available[i+1] = available[i];
				available[i] = save2;
			}
		}
	}
	for(i=0;i<10 && i<available.size;i++)
		bestplayer[bestplayer.size] = available[i];
	return bestplayer;
}

getSpectatorClient() {
	players = getAllPlayers();
	for(i=0;i<players.size;i++) 
		if(isDefined(players[i]) && players[i] != self && players[i] isRealyAlive() && players[i] getPlayerAngles() == self GetPlayerAngles())
			return players[i];
}