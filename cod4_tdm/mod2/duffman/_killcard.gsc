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
	//----------------------DEFAULT-------------------------
	//    |DESIGNNAME|INDEX|   COLOR  |ALPHA|SHADER|W  |H| ALIGNY | Y
	addDesign("default",0,(0,0,0),0.6,"ui_camoskin_bshdwl",252,72,"middle",185);
	addDesign("default",1,(1,1,1),0.8,"nightvision_overlay_goggles",250,70,"middle",185);
	addDesign("default",2,(1,1,1),0.1,"white",250,30,"middle",165);
	//-----------------------BLUE--------------------------
	addDesign("blue",0,(0.3,0.3,0.8),0.6,"ui_camoskin_bshdwl",252,72,"middle",185);
	addDesign("blue",1,(1, 0, 1),0.8,"nightvision_overlay_goggles",250,70,"middle",185);
	addDesign("blue",2,(0,0,1),0.1,"white",250,30,"middle",165);
	//-----------------------RED--------------------------
	addDesign("red",0,(0.8,0.3,0.3),0.6,"ui_camoskin_bshdwl",252,72,"middle",185);
	addDesign("red",1,(1, 0, 0),0.8,"nightvision_overlay_goggles",250,70,"middle",185);
	addDesign("red",2,(1,0,0),0.1,"white",250,30,"middle",165);	
	//-----------------------GREEN--------------------------
	addDesign("green",0,(0.3,0.8,0.3),0.6,"ui_camoskin_bshdwl",252,72,"middle",185);
	addDesign("green",1,(0, 1, 0),0.8,"nightvision_overlay_goggles",250,70,"middle",185);
	addDesign("green",2,(0,1,0),0.1,"white",250,30,"middle",165);	
	//-----------------------YELLOW--------------------------
	addDesign("yellow",0,(1,0.8, 0),0.75,"ui_camoskin_bshdwl",252,72,"middle",185);
	addDesign("yellow",1,(1, 1, 0),0.75,"nightvision_overlay_goggles",250,70,"middle",185);
	addDesign("yellow",2,(1, 1, 0),0.375,"white",250,30,"middle",165);
	//-----------------------DEV--------------------------
	addDesign("admin",0,(0.8, 0.333333, 0),1,"ui_camoskin_bshdwl",252,72,"middle",185);
	addDesign("admin",1,(0.8, 0.333333, 0),1,"nightvision_overlay_goggles",250,70,"middle",185);
	addDesign("admin",2,(0.8, 0.333333, 0),0.5,"white",250,30,"middle",165);
	shaders = strTok("ui_camoskin_bshdwl;gradient_fadein;gradient;ui_sliderbutt_1;ui_slider2;line_vertical;nightvision_overlay_goggles;killiconmelee;killiconsuicide;death_car;death_helicopter;death_airstrike;white;hud_us_stungrenade;hud_us_grenade;hud_icon_c4;hud_icon_claymore;weapon_ak47;weapon_aks74u;weapon_barrett50cal;weapon_benelli_m4;weapon_c4;weapon_claymore;weapon_colt_45;weapon_colt_45_silencer;weapon_concgrenade;weapon_desert_eagle;weapon_desert_eagle_gold;weapon_dragunovsvd;weapon_flashbang;hud_us_grenade;weapon_g3;weapon_g36c;weapon_m14;weapon_m14_scoped;weapon_m16a4;weapon_m249saw;weapon_m40a3;weapon_m4carbine;weapon_m60e4;weapon_m9beretta;weapon_m9beretta_silencer;weapon_mini_uzi;weapon_mp44;weapon_mp5;weapon_p90;weapon_remington700;weapon_rpd;weapon_rpg7;weapon_skorpion;weapon_smokegrenade;weapon_usp_45;weapon_usp_45_silencer;weapon_winchester1200;hud_icon_benelli_m4",";");
	text[0] = "^7| ^3www.sles.com^7 |";
	text[1] = "^7| ^3www.sles.com^7 |";
 	level.defaultEmblemText = text[RandomInt(text.size)];

	for(i=0;i<shaders.size;i++) PreCacheShader(shaders[i]);
	thread EmblemText();
	level.vartexts = array("self.name","self.score","self.deaths","self.kills","self.headshots","self.assists","self.killstreak","self.team");
	if(!isDefined(game["emblemchanges"])) game["emblemchanges"] = 0;
	for(;;) {
		level waittill("connected",player);
		level thread onPlayerDisconnect(player);
		player thread Connected();
	}
}

Connected() {
	if(!isDefined(self.pers["killstats"])) {
		self.pers["killstats"] = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0";
		text = self getCvar("emblem");
		if(!isDefined(text) || text == "") {
			text = level.defaultEmblemText;
		}
		else if(text != level.defaultEmblemText)
			game["emblemchanges"]++;
		if(game["emblemchanges"] > 40)
			text = level.defaultEmblemText;
		self.pers["emblem"] = text;
		if(self getCvar("style") == "") {
			self setCvar("style","default");
			self.pers["design"] = "default";
		}
		else
			self.pers["design"] = self getCvar("style");
	}
}

setKillStat(pid,stat) {
	stats = strTok(self.pers["killstats"],".");
	stats[pid] = stat;
	string = "";
	for(i=0;i<63;i++)
		string += stats[i] + ".";
	self.pers["killstats"] = string;
}

getKillStat(pid) {
	return int(strTok(self.pers["killstats"],".")[pid]);
}

EmblemText() {
	while(1) {
		setDvar("emblemtext","");
		while(GetDvar("emblemtext") == "") wait .05;
		tok = strTok(GetDvar("emblemtext")," ");
		player = getPlayerByNum(int(tok[0]));
		if(isDefined(player)) {
			text = getSubStr(GetDvar("emblemtext"),tok[0].size + 1,GetDvar("emblemtext").size);
			if( removeVarNameSize(text) >= 40) {
				player iPrintlnbold("^5Emblemtext must be ^7shorter than 40^5 chars");
				continue;
			}
			else if(removeColor(text).size < 4) {
				player IPrintLnBold("^5Emblemtext must be ^7longer than 3^5 chars");
				continue;
			}
			if(isDefined(player.pers["changed_emblem"])) {
				player iPrintlnbold("^5Your ^7emblemtext will changed ^5after a maprotate!");
			}
			else {
				player.pers["emblem"] = text;
				player iPrintlnbold("Emblemtext Successfully changed to:");
				player iPrintlnBold(player getEmblemText(player));
				player.pers["changed_emblem"] = true;
				game["emblemchanges"]++;
			}
			player setCvar("emblem",text);
		}
	}
}

removeVarNameSize(text) {
	size = removeColor(text).size;
	for(i=0;i<level.vartexts.size;i++)
		if(isSubStr(text,level.vartexts[i]))
			size -= level.vartexts[i].size;
	return size;
}

onPlayerDisconnect(player) {
	entity = player getEntityNumber();
	player waittill("disconnect");
	wait .05;
	players = GetEntArray("player","classname");
	for(i=0;i<players.size;i++) 
		if(isDefined(players[i]))
			players[i] setKillStat(entity,0);
}

ShowKillCard(attacker,victim,sMeansOfDeath,sWeapon,sHitLoc) {
	if(isDefined(attacker) && isDefined(victim) && isPlayer(attacker) && isPlayer(victim) && attacker != victim && isDefined(sMeansOfDeath) && isDefined(sWeapon)) {
		if(sMeansOfDeath == "MOD_MELEE")
			sWeapon = "knife_mp";
		attacker setKillStat(victim GetEntityNumber(),attacker getKillStat(victim GetEntityNumber()) + 1);
		if(!isDefined(attacker GetCurrentWeapon())) 
			return;
		victim thread KillCard(attacker,sWeapon,attacker GetCurrentWeapon());
		attacker thread KillCard(victim,sWeapon,attacker GetCurrentWeapon());
	}
 }

 addDesign(name,index,color,alpha,shader,width,height,al,y) {
 	level.designs[name][index][0] = color;
 	level.designs[name][index][1] = alpha;
 	level.designs[name][index][2] = shader;
 	level.designs[name][index][3] = width;
 	level.designs[name][index][4] = height;
 	level.designs[name][index][5] = al;
 	level.designs[name][index][6] = y;
 	precacheShader(shader);
 }

 getDesign(index) {
 	name = self.pers["design"];
 	if(isDefined(level.designs[name]) && isDefined(level.designs[name][index]) && isDefined(level.designs[name][index]))
 		return level.designs[name][index];
 	else
 		return level.designs["default"][index];
}

setDesign(theme)
{
	if(self getStat(634) >= 1)
	{
		self notify("new_emblem");
		self setCvar("style",theme);
		self.pers["design"] = theme;	
		if(isDefined(self.killcard))
			for(i=0;i<self.killcard.size;i++)
				if(isDefined(self.killcard[i]))
					self.killcard[i] Destroy();
		self.iswaitingforcard = undefined;
		self.cardinuse = undefined;
		self thread KillCard(self,"ak74u_mp","ak74u_mp");
	}
	else
		self iPrintBig("PRESTIGE_UNLOCK","LEVEL",2,"FEATURE","EMBLEM");
}

getEmblemText(enemy) {
	text = self.pers["emblem"];

	text = ReplaceStats(text,"self.name",self.name);
	text = ReplaceStats(text,"self.score",self.score);
	text = ReplaceStats(text,"self.deaths",self.deaths);
	text = ReplaceStats(text,"self.kills",self.kills);
	text = ReplaceStats(text,"self.headshots",self.headshots);
	text = ReplaceStats(text,"self.assists",self.assists);
	text = ReplaceStats(text,"self.killstreak",self.cur_kill_streak);
	text = ReplaceStats(text,"self.team",self.team);

	text = ReplaceStats(text,"enemy.name",enemy.name);
	text = ReplaceStats(text,"enemy.score",enemy.score);
	text = ReplaceStats(text,"enemy.deaths",enemy.deaths);
	text = ReplaceStats(text,"enemy.kills",enemy.kills);
	text = ReplaceStats(text,"enemy.headshots",enemy.headshots);
	text = ReplaceStats(text,"enemy.assists",enemy.assists);
	text = ReplaceStats(text,"enemy.killstreak",enemy.cur_kill_streak);
	text = ReplaceStats(text,"enemy.killstreak",enemy.cur_kill_streak);
	text = ReplaceStats(text,"enemy.team",enemy.team);

	return text;
}

ReplaceStats(text,string,var) {
	for(i=0;isSubStr(text,string) && i<3;i++)
		text = StrReplace(text,string,var);	
	return text;
}

KillCard(from,weap,alternatewep) {
	self endon("disconnect");
	self endon("new_emblem");
	while(isDefined(self.cardinuse)) {
		wait .05;
		self.iswaitingforcard = true;
	}
	if(!isDefined(from) || !isDefined(from.pers) || !isDefined(from.pers["emblem"]))
		return;	
	self.iswaitingforcard = undefined;
	self.cardinuse = true;
	shader = [];
	for(i=0;i<12;i++) {
		shader[i] = hud( self, 0, 150, 1, "center", "top", 1.4 );
		shader[i].horzAlign = "center";
		shader[i].vertAlign = "middle";
		shader[i].sort = 100+i;
	}
	design = from getDesign(0);
	shader[0] SetShader(design[2],design[3],design[4]);
	//shader[0].color = design[0];
	shader[0].y = design[6];
	shader[0].alignY = design[5];
	shader[0].alpha = design[1];
	design = from getDesign(1);
	shader[1] SetShader(design[2],design[3],design[4]);
	shader[1].color = design[0];
	shader[1].alpha = design[1];
	shader[1].y = design[6];
	shader[1].alignY = design[5];	
	design = from getDesign(2);
	shader[2] SetShader(design[2],design[3],design[4]);
	shader[2].alpha = design[1];
	shader[2].color = design[0];
	shader[2].y = design[6];
	shader[2].alignY = design[5];
	rankicon = maps\mp\gametypes\_rank::getRankInfoIcon( from.pers["rank"], 0 );
	rank = from.pers["rank"];
	if(from.pers["rank"] == 54 && from getStat(634) != 0) {
		rankicon = from duffman\_prestige::getPrestigeIcon();
		rank = int(from getStat(635)/255*54);
	}
	shader[3] SetShader(rankicon,35,35);
	shader[3].x = -98;
	shader[3].y = 168;
	if(from hasPermission("RS-Owner"))
		shader[4].label = &"^1Owner\n            Lv: &&1";
	else if(from hasPermission("RS-Leader"))
		shader[4].label = &"^1Leader\n            Lv: &&1";
	else if(from hasPermission("RS-headadmin"))
		shader[4].label = &"^1Head admin\n            Lv: &&1";
	else if(from hasPermission("RS-FullAdmin"))
		shader[4].label = &"^1Full Admin\n            Lv: &&1";
	else if(from hasPermission("RS-Rookie"))
		shader[4].label = &"^1Rookie\n            Lv: &&1";
	else if(from hasPermission("RS-Member"))
		shader[4].label = &"^1Member\n            Lv: &&1";
	else
		shader[4].label = &"Lv: &&1";
	shader[4] setValue(rank+1);
	shader[4].x = -75;
	shader[4].y = 152;	
	if(!isDefined(weap)) weap = "o_O"; //weve got undefined weapons sometimes o.O
	if(!isDefined(alternatewep)) alternatewep = "o_O";
	shader[5] setWeaponIcon(weap,alternatewep);
	shader[5].x = 80;
	shader[5].y = 185;	
	shader[5].alignX = "center";
	shader[5].alignY = "middle";
	shader[5].alignY = "middle";
	shader[6] setText(from getEmblemText(self));
	shader[6].y = 200;
	shader[6].glowColor = (.4,.4,.4);
	shader[6].glowAlpha = 1;
	shader[7] setValue(self getKillStat(from GetEntityNumber()));
	shader[7].x = -7;
	shader[7].y = 175;	
	shader[7].alignX = "right";
	shader[7].font = "objective";
	shader[7].fontscale = 2;	
	shader[7].glowColor = (.4,.4,.4);
	shader[7].glowAlpha = 1;
	shader[8].label = &"-&&1";
	shader[8] setValue(from getKillStat(self GetEntityNumber()));
	shader[8].x = -6.6;
	shader[8].y = 175;	
	shader[8].alignX = "left";
	shader[8].font = "objective";
	shader[8].fontscale = 2;
	shader[8].glowColor = (.4,.4,.4);
	shader[8].glowAlpha = 1;
	perks = maps\mp\gametypes\_globallogic::getPerks( from );
	if(isDefined(perks[0]) && isDefined(level.perkIcons[perks[0]]))
		shader[9] SetShader(level.perkIcons[perks[0]],20,20);
	shader[9].y = 155;	
	shader[9].x = -25;
	if(isDefined(perks[1]) && isDefined(level.perkIcons[perks[1]]))
		shader[10] SetShader(level.perkIcons[perks[1]],20,20);
	shader[10].y = 155;	
	if(isDefined(perks[2]) && isDefined(level.perkIcons[perks[2]]))
		shader[11] SetShader(level.perkIcons[perks[2]],20,20);
	shader[11].y = 155;	
	shader[11].x = 25;
	for(i=0;i<shader.size;i++) {
		old = shader[i].y;
		shader[i].y = 300;
		shader[i] MoveOverTime(.3);
		shader[i].y = old;
	}
	self.killcard = shader;
	wait 2;
	for(i=0;i<25 && !isDefined(self.iswaitingforcard);i++) wait .1;
	for(i=0;i<shader.size;i++) {
		shader[i] MoveOverTime(.3);
		shader[i].y = 300;
	}
	wait .5;
	for(i=0;i<shader.size;i++) 
		if(isDefined(shader[i])) 
			shader[i] Destroy();
	self.cardinuse = undefined;
}

setWeaponIcon(wep,alternate) {
	weap[0] = strTok(wep,"_")[0];
	if(weap[0] == "gl" && isDefined(strTok(wep,"_")[1])) weap[0] = strTok(wep,"_")[1];
	weap[1] = strTok(alternate,"_")[0];
	if(weap[1] == "gl" && isDefined(strTok(alternate,"_")[1])) weap[1] = strTok(alternate,"_")[1];	
	x = 80;
	y = 40;
	s = "white";
	for(i=0;i<2;i++) {
		switch(weap[i]) {
			case"artillery": s = "death_airstrike"; x = 90; y = 22; break;
			case"destructible": s = "death_car"; x = 40; break;
			case"cobra": s = "death_helicopter";  x = 90; y = 22; break;
			case"ak47": s = "weapon_ak47";  break;
			case"ak74u": s = "weapon_aks74u";  break;
			case"m1014": s = "hud_icon_benelli_m4";  break;
			case"barrett": s = "weapon_barrett50cal";  break;
			case"c4": s = "hud_icon_c4"; x = 40; break;
			case"claymore": s = "weapon_claymore"; x = 40; break;
			case"colt45": s = "weapon_colt_45";  x = 60; y = 60;; break;
			case"deserteagle": s = "weapon_desert_eagle"; x = 60; y = 60; break;
			case"deserteaglegold": s = "weapon_desert_eagle_gold"; x = 60; y = 60; break;
			case"dragunov": s = "weapon_dragunovsvd";  break;
			case"g3": s = "weapon_g3";  break;
			case"g36c": s = "weapon_g36c"; break;
			case"m14": s = "weapon_m14"; break;
			case"m21": s = "weapon_m14_scoped"; break;
			case"m16": s = "weapon_m16a4";  break;
			case"saw": s = "weapon_m249saw";  break;
			case"m40a3": s = "weapon_m40a3";  break;
			case"m4": s = "weapon_m4carbine";  break;
			case"m60e4": s = "weapon_m60e4";  break;
			case"beretta": s = "weapon_m9beretta"; x = 60; y = 60; break;
			case"uzi": s = "weapon_mini_uzi"; break;
			case"mp44": s = "weapon_mp44"; break;
			case"mp5": s = "weapon_mp5"; break;
			case"p90": s = "weapon_p90"; break;
			case"remington700": s = "weapon_remington700"; break;
			case"rpd": s = "weapon_rpd"; break;
			case"rpg": s = "weapon_rpg7"; break;
			case"skorpion": s = "weapon_skorpion"; break;
			case"usp": s = "weapon_usp_45"; x = 60; y = 60; break;
			case"winchester1200": s = "weapon_winchester1200"; break;
			case"frag": s = "hud_us_grenade"; x = 50; y = 50; break; 
			case"stun": s = "hud_us_stungrenade"; x = 40; break;
			case"flash": s = "weapon_concgrenade"; x = 40; break;
			case"knife": s = "killiconmelee"; x = 40; break;
		}
		if(s != "white")
			break;
	}
	if(s == "white") {
		s = "killiconsuicide";
		x = 40;
		y = 40;
	}
	self setShader(s,int(x),int(y));
}

hud( who, x, y, alpha, alignX, alignY, fontScale ) {
	if( isPlayer( who ) ) hud = newClientHudElem( who );
	else hud = newHudElem();
	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.alignX = alignX;
	hud.alignY = alignY;
	hud.fontScale = fontScale;
	return hud;
}