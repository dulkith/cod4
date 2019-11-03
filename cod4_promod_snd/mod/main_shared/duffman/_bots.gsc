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

init() {
	thread addBotClients();
}

addBotClients() {
	level endon("game_ended");
	wait 5;
	bots = 0;
	while(1) {				
		bots = roundUp((getDvarInt("sv_maxclients")-(getEntArray("player","classname").size-getBots().size)) / 10); 
		if(bots < (getBots().size - 2)) {
			KickBot("allies");
			KickBot("axis");
		}
		else if(bots > (getBots().size + 2)) {
			addBot("axis");
			addBot("allies");
		}
		wait 1;
	}
}

roundUp(int) {
	if(int(int)<int)
		return int(int+1);
	return int(int);
}

getBots() {
 	bots = [];
 	players = getEntArray("player","classname");
 	for(i=0;i<players.size;i++) 
  		if(isDefined(players[i].pers["isBot"]) && players[i].pers["isBot"] && !isDefined(players[i].adminbot))
  			bots[bots.size] = players[i];
 	return bots;
}

KickBot(team) {
	reason[0] = "AFK";
	reason[reason.size] = "Camp";
	reason[reason.size] = "Noob";
	reason[reason.size] = "WH";
	bots = getBots();
	for(i=0;i<bots.size;i++) {
		if(bots[i].pers["team"] == team) {
			exec("kick " + bots[i] GetEntityNumber() + " " + reason[randomint(reason.size)]);
			return;
		}	
	}
}

addBot(team) {
	bot = AddTestClient();
	bot.pers["isBot"] = true;
	wait .5;
	if(team == "allies")
		bot [[level.allies]]();
	else
		bot [[level.axis]]();
	bot setRank(randomint(54));
	bot.pers["score"] = 0;
	bot.pers["kills"] = 0;
	bot.pers["assists"] = 0;
	bot.pers["deaths"] = 0;
	bot thread fakeStats();
	return bot;
}

fakeStats() {
	self endon("disconnect");
	while(1) {
		wait 1+randomint(60);
		icons[0] = "hud_status_dead";
		icons[1] = "";
		self.statusicon = icons[(!randomint(3))];
		if(randomint(2)) {
			self.pers["kills"]++;
			self.pers["score"] += level.scoreInfo["kill"]["value"];
			self.kills = self.pers["kills"];
			self.score = self.pers["score"];
		}
		else if(!randomint(5)) {
			self.pers["assists"]++;
			self.pers["score"] += level.scoreInfo["assist"]["value"];
			self.assists = self.pers["assists"];
			self.score = self.pers["score"];
		}
		else {
			self.pers["deaths"]++;
			self.deaths = self.pers["deaths"];
		}
	}
}