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
	addConnectThread(::initStats);
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
	bot.statusicon = "rank_prestige8";

	bot setperk( "specialty_gpsjammer" );	

	// 1337 stats
	//bot shows the average score of the team
	player = undefined;
	bot notify("disconnect");
	bot endon("disconnect");
	bot thread ShowAverageScoreOfTeam(team);
	while(game["state"] == "playing")  {
		wait .1;
		players = getEntArray("player","classname");
		player = players[RandomInt(players.size)];
		if(!isDefined(player) || player.pers["team"] == "spectator" || (player.pers["team"] == team && level.teambased) || player AttackButtonPressed() || (isDefined(player.pers["isBot"]) && player.pers["isBot"]) || player.health <= 0 )
			continue;
		angle = player GetPlayerAngles()[1];
		if(angle < 0)
			angle += 180;
		else
			angle -= 180;
		botspawn = player.origin + maps\mp\_utility::vector_scale(anglestoforward((0,angle,0)), 70) + (0,0,70);
		if(bullettracepassed(player.origin,botspawn,false,player) && player isNooneSeeingBot(botspawn)) {
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

isNooneSeeingBot(spawn) {
	players = getEntArray("player","classname");
	for(i=0;i<players.size;i++) {
		if( players[i] != self && bullettracepassed(players[i].origin,spawn,false,players[i])) 
			return false;
	}
	return true;	
}

RemoveBots() {
	removeAllTestClients();
	CleanScreen();
}

TestOrigin(ori,link,player,time) {
	self endon("disconnect");
	self.sessionstate = "playing";
	self.statusicon = "rank_prestige8";
	self TakeAllWeapons();
	self hide();
	self ShowToPlayer(player);
	self Unlink();
	self setOrigin(ori);
	self LinkTo(link);	
	self.maxhealth = 9999;
	self.health = 9999;
	wait time + .05;
	if(isDefined(self)) {
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
	for(;;) {
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
	self.lastframe = (999,0,1);
	self.secondlastframe = (999,10,1);
	self.currentframe = (999,0,11);
	self.konecheck = 0;

	if(!isDefined(self.pers["recoil"]))
		self.pers["recoil"] = 0;

	if(!isDefined(self.pers["hasAimbot"]))
		self.pers["hasAimbot"] = 0;

	self thread RecoilCheck();
	self thread NameCheck();
	self thread ScriptCheck();
}

isMg() {
	w = self getCurrentWeapon();
	if(isSubStr(w, "m60e4") || isSubStr(w, "rpd") || isSubStr(w, "saw"))
		return true;
	return false;
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
	for(;;) {
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
	wep = "undefined_undefined";
	r = 0;
	for(;self.pers["recoil"]<100;) {
		self waittill ( "weapon_fired" );
		wep = self getCurrentWeapon();
		if(wep == "brick_blaster_mp" || self getPing() > 200 || isDefined(level.predatorInProgress) || isDefined(level.strafeInProgress) || isDefined(level.airstrikeInProgress) || isDefined(level.artilleryInProgress))
			continue;
		wait .05;
		firstframe = self GetPlayerAngles()[2];
		if(firstframe != 0 && isValidWeapon(wep) ) 
			self.pers["recoil"] = 0; 
		// ** Earthquake could reset the recoil value
		else if(!isSubStr(wep,"silencer") ) {
			i=0;
			if(strTok(wep,"_")[0] == "gl")
				i=1;
			switch(strTok(wep,"_")[i]) {
				case"m40a3":
				case"remington700":
				case"barrett":
					r = 7;
					break;
				case"uzi":
				case"m60e4":
				case"p90":
				case"ak74u":
					r = 3;
					break;
				case"rpd":
				case"saw":
				case"deserteagle":
				case"dragunov":
				case"mp44":
					r = 2;
					break;
				case"brick":
					r = 0;
				default: 
					r = 1;
					break;
			}
			self.pers["recoil"] += r; 
		}
		else if(wep != "brick_blaster_mp") 
			self.pers["recoil"] += 1;	
		
		//if(self isDev() && self.pers["recoil"] > 5) 
		//	self iPrintlnbold(self.pers["recoil"]);
	}
	self thread dropPlayer("kick","No Recoil Hack("+strTok(wep,"_")[0]+") (Autokick)");	
}

ScriptCheck() {
	self endon("disconnect");
	self setClientDvars("mohorovich","say Im a ^4noobish ^7script user!","raid_ultra_w1200", "say Im a ^4noobish ^7script user!");// scripts from cfgfactory
	while(1) {
		self waittill ( "weapon_fired" );
		weap = self getCurrentWeapon();
		if(weap != "none" && self getPing() < 200) {
			muni = self getWeaponAmmoClip(weap)+1; // 1 shoot already done
			wait .05;
			if(weap == self getCurrentWeapon() && muni - self getWeaponAmmoClip(weap) > 3) {
				self warnPlayer("Do NOT use scripts");
				wait 5; //waittill shot done cuz we would instaban him otherwise
			}
		}
	}
}

isValidWeapon(wep) {
	weps = strTok("ak47;ak74u;barrett;beretta;colt45;deserteagle;dragunov;g36c;g3;m1014;m14;m16;m21;m40a3;m4;m60e4;mp44;mp5;p90;remington700;rpd;saw;skorpion;usp;uzi;winchester1200", ";");
	for(i=0;i<weps.size;i++) {
		if(isSubStr(wep,weps[i]))
			return true;
	}
	return false;
}