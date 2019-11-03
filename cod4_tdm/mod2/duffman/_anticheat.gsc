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
	level.avg_recoil["default"] = 0.8;
	level.avg_recoil["m4_acog_mp"] = 0.8;
	level.avg_recoil["m4_gl_mp"] = 0.8;
	level.avg_recoil["m4_mp"] = 0.8;
	level.avg_recoil["m60e4_grip_mp"] = 0.8;
	level.avg_recoil["m60e4_reflex_mp"] = 0.8;
	level.avg_recoil["mp5_mp"] = 0.8;
	level.avg_recoil["mp5_reflex_mp"] = 0.8;
	level.avg_recoil["mp5_silencer_mp"] = 0.8;
	level.avg_recoil["p90_mp"] = 0.8;
	level.avg_recoil["p90_reflex_mp"] = 0.8;
	level.avg_recoil["p90_silencer_mp"] = 0.8;
	level.avg_recoil["remington700_acog_mp"] = 0.8;
	level.avg_recoil["remington700_mp"] = 0.8;
	level.avg_recoil["rpd_acog_mp"] = 0.8;
	level.avg_recoil["rpd_grip_mp"] = 0.8;
	level.avg_recoil["rpd_mp"] = 0.8;
	level.avg_recoil["rpd_reflex_mp"] = 0.8;
	level.avg_recoil["saw_acog_mp"] = 0.8;
	level.avg_recoil["saw_mp"] = 0.8;
	level.avg_recoil["saw_reflex_mp"] = 0.8;
	level.avg_recoil["skorpion_mp"] = 0.8;
	level.avg_recoil["uzi_mp"] = 0.8;
	level.avg_recoil["uzi_reflex_mp"] = 0.8;
	level.avg_recoil["uzi_silencer_mp"] = 0.8;
	level.avg_recoil["winchester1200_grip_mp"] = 0.8;
	level.avg_recoil["winchester1200_mp"] = 0.8;
	level.avg_recoil["ak47_acog_mp"] = 0.8;
	level.avg_recoil["ak47_gl_mp"] = 0.8;
	level.avg_recoil["ak47_mp"] = 0.8;
	level.avg_recoil["ak47_reflex_mp"] = 0.8;
	level.avg_recoil["ak47_silencer_mp"] = 0.8;
	level.avg_recoil["ak74u_mp"] = 0.8;
	level.avg_recoil["ak74u_reflex_mp"] = 0.8;
	level.avg_recoil["ak74u_silencer_mp"] = 0.8;
	level.avg_recoil["barrett_acog_mp"] = 0.8;
	level.avg_recoil["barrett_mp"] = 0.8;
	level.avg_recoil["deserteagle_mp"] = 0.8;
	level.avg_recoil["deserteaglegold_mp"] = 0.8;
	level.avg_recoil["g36c_acog_mp"] = 0.8;
	level.avg_recoil["g36c_gl_mp"] = 0.8;
	level.avg_recoil["g36c_mp"] = 0.8;
	level.avg_recoil["g36c_reflex_mp"] = 0.8;
	level.avg_recoil["m16_reflex_mp"] = 0.8;
	level.avg_recoil["m14_reflex_mp"] = 0.8;
	level.avg_recoil["m14_acog_mp"] = 0.8;
	addConnectThread(::initStats);
	wait 5;
	if(level.gametype != "dm") // we only need one bot in ffa
		level thread addAimbotClient("axis");
	level thread addAimbotClient("allies");	
}


addAimbotClient(team) {
	if(!isDefined(level.aimbots)) {
		level.aimbots = [];
		level.botlinks = [];
	}
	size = level.aimbots.size;
	level.botlinks[size][team] = spawn("script_origin",(0,0,-20000));
	level.aimbots[size][team] = AddTestClient();
	bot = level.aimbots[size][team];
	link = level.botlinks[size][team];
	bot.inTrainingArea = true; // ** hack to go arround endgame freeze
	bot.pers["isBot"] = true;
	bot.pers["player_welcomed"] = true;
	wait .5;
	if(team == "allies")
		bot [[level.allies]]();
	else
		bot [[level.axis]]();
	wait .5;
	bot notify("menuresponse", "changeclass", "specops_mp,0");
	bot waittill("spawned_player");
	bot TakeAllWeapons();
	bot setOrigin(link.origin);
	bot LinkTo(link);	
	bot hide();
	bot.sessionstate = "dead";
	bot.statusicon = "hud_status_dead";
	bot setperk( "specialty_gpsjammer" );	
	player = undefined;
	bot notify("disconnect");
	bot endon("disconnect");
	bot thread ShowAverageScoreOfTeam(team);
	while(game["state"] == "playing")  {
		wait .1;
		while(isDefined(level.pausebot) && game["state"] == "playing") wait 1;
		players = getEntArray("player","classname");
		player = players[RandomInt(players.size)];
		if(!isDefined(player) || player.pers["team"] == "spectator" || (player.pers["team"] == team && level.teambased) || player isLagging() || (isDefined(player.pers["isBot"]) && player.pers["isBot"]) || player.health <= 0 || player.pers["hasAimbot"] < -1.5 )
			continue;
		angle = player GetPlayerAngles()[1];
		if(angle < 0)
			angle += 180;
		else
			angle -= 180;
		botspawn = player.origin + maps\mp\_utility::vector_scale(anglestoforward((0,angle,0)), 70);
		if(bullettracepassed(player.origin,botspawn,false,player)) {
			//player iPrintLnBold("spawn");
			ping = player getPing();
			if(!isDefined(ping) || ping < 50)
			 	ping = 50;
			time = ping / 1000 + .1;
			bot thread TestOrigin(botspawn,link,player,time);
			wait time;
			if(!isDefined(player) || !player isRealyAlive())
				continue;
			trace = bullettrace(player geteye()+(0,0,20),player geteye()+(0,0,20)+maps\mp\_utility::vector_scale(anglestoforward(player getplayerangles()),99999),true,player);
            if(trace["fraction"] != 1 && isDefined(trace["entity"]) && isPlayer(trace["entity"]) && trace["entity"] == bot) {
            	player.pers["hasAimbot"] += 1;
            	if(player.pers["hasAimbot"] > 2.9) {
            		player thread dropPlayer("kick","Aimbot (Autokick)");
            	}
            }
            else
            	player.pers["hasAimbot"] -= .1;
		}
	}
	level thread RemoveBots();
}

RemoveBots() {
	removeAllTestClients();
	CleanScreen();
}

TestOrigin(ori,link,player,time) {
	self endon("disconnect");
	self.sessionstate = "playing";
	self TakeAllWeapons();
	self setperk( "specialty_gpsjammer" );	
	self hide();
	self ShowToPlayer(player);
	self Unlink();
	self setOrigin(ori);
	self LinkTo(link);	
	self.maxhealth = 9999;
	self.health = 9999;
	wait time + .05;
	if(isDefined(self)) {
		self show();
		self hide();
		self.sessionstate = "dead";
		self Unlink();
		self setOrigin(link.origin);
		self LinkTo(link);	
	}
}

ShowAverageScoreOfTeam(team) {
	self endon("disconnect");
	rank = 0;
	while(1) {
		wait 1;
		self.pers["score"] = getAverageStat(team,"score"); 
		self.pers["kills"] = getAverageStat(team,"kills");;
		self.pers["assists"] = getAverageStat(team,"assists");;
		self.pers["deaths"] = getAverageStat(team,"deaths");;
		self.score = self.pers["score"];
		self.kills = self.pers["kills"];
		self.assists = self.pers["assists"];
		self.deaths = self.pers["deaths"];
		if(getAverageStat(team,"rank") != rank) {
			rank = getAverageStat(team,"rank");
			self setRank(rank);
		}
	}
}

getAverageStat(team,stat) {
	avg = [];
	players = getAllPlayers();
	for(i=0;i<players.size;i++)
		if(isDefined(players[i]) && players[i].pers["team"] == team && (!isDefined(players[i].pers["isBot"]) || !players[i].pers["isBot"]) && isDefined(players[i].pers[stat]))
			avg[avg.size] = players[i].pers[stat];
	if(avg.size<1) return 0;
	return int(getAverageValue(avg));
}

initStats() {
	if(!isDefined(self.pers["hasAimbot"]))
		self.pers["hasAimbot"] = 0;
	self thread pingCheck();
	self thread RecoilCheck();
	self thread NameCheck();
}

isNameUsed(name) {
	used = 0;
	players = getEntArray("player","classname");
	for(i=0;i<players.size;i++)
		if(players[i] != self && removeExtras(name) == removeExtras(players[i].name))
			used++;
	return used;
}

NameCheck() {
	self endon("disconnect");
	self endon("end_cheat_detection");
	namechanges = 0;
	while(1) {
		oldname = self.name;
		wait 5;
		if(oldname != self.name) 
			self setCvar("name",self.name);
		if(oldname != self.name && self isNameUsed(self.name)) {
			namechanges += 1;
		}
		else
			namechanges -= 0.1;
		if(namechanges<0)
			namechanges = 0;			
		if(namechanges > 3) 
			self thread dropPlayer("kick","Namechanger (Autokick)");
	}
}

RecoilCheck() {
	self endon("disconnect");
	self endon("end_cheat_detection");
	if(!isDefined(self.pers["recoil"]))
		self.pers["recoil"] = 0;
	w = "none";
	while(1) {
		self waittill("weapon_fired");
		w = self getCurrentWeapon();
		if(self isInEarthquake() || (!isSubStr(w,self.pers["primaryWeapon"]) && !isDefined(level.avg_recoil[w])) || self isLagging()) continue;
		if(!self isAngleChanging()) 
			self.pers["recoil"]++;
		else 
			self.pers["recoil"] = 0;
		if(self.pers["recoil"] && 1-exponent(1-getWeaponRecoil(w),self.pers["recoil"]) >= 1) {
			self thread dropPlayer("kick","No Recoil Hack("+strTok(w,"_")[0]+") (Autokick)");
			return;	
		}
	}
}

getWeaponRecoil(w) {
	if(isDefined(level.avg_recoil[w])) 
		return level.avg_recoil[w];
	else 
		return level.avg_recoil["default"];
}

pingCheck() {
	self endon("disconnect");
	if(!isDefined(self.pers["avg_ping"]))
		for(i=0;i<10;i++)
			self.pers["avg_ping"][i] = 200;
	while(1) {
		wait 5;
		for(i=0;i<9;i++)
			self.pers["avg_ping"][i] = self.pers["avg_ping"][i+1];
		self.pers["avg_ping"][9] = self getPing(); 
	}
}

isLagging() {
	return (!isDefined(self.pers["avg_ping"]) || getAverageValue(self.pers["avg_ping"])*1.2<self getPing() || self getCountedFPS() <= 20);
}

isAngleChanging() {
	for(i=0;i<10;i++) {
		if(self.currentframe[2]) 
			return true;
		wait .05;
	}
	return false;
}

PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
}

PlayerKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
}