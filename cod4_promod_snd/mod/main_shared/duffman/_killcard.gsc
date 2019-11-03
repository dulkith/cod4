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
	addDesign("default",0,(1,1,1),0.85,"killcard",260,75,"middle",185);
	addDesign("default",1,(1,1,1),0.1,"white",259,30,"middle",163);
	addDesign("default",2,(1,1,1),0.2,"white",93,65,"middle",185);
	
	//-----------------------BLUE--------------------------
	addDesign("blue",0,(1,1,1),0.9,"killcard_sl",260,75,"middle",185);
	addDesign("blue",1,(1,1,1),0.1,"white",259,30,"middle",163);
	addDesign("blue",2,(1,1,1),0.2,"white",93,65,"middle",185);
	
	//-----------------------RED--------------------------
	addDesign("red",0,(1,1,1),0.9,"killcard_yk",260,75,"middle",185);
	addDesign("red",1,(1,1,1),0.1,"white",259,30,"middle",163);
	addDesign("red",2,(1,1,1),0.2,"white",93,65,"middle",185);
	
	//-----------------------GREEN--------------------------
	addDesign("green",0,(1,1,1),0.9,"killcard_in",260,75,"middle",185);
	addDesign("green",1,(1,1,1),0.1,"white",259,30,"middle",163);
	addDesign("green",2,(1,1,1),0.2,"white",93,65,"middle",185);
	
	//-----------------------YELLOW--------------------------
	addDesign("yellow",0,(1,1,1),0.9,"killcard_mw",260,75,"middle",185);
	addDesign("yellow",1,(1,1,1),0.1,"white",259,30,"middle",163);
	addDesign("yellow",2,(1,1,1),0.2,"white",93,65,"middle",185);
	
	//-----------------------BLACK--------------------------
	addDesign("black",0,(1,1,1),0.9,"killcard_ns",260,75,"middle",185);
	addDesign("black",1,(1,1,1),0.1,"white",259,30,"middle",163);
	addDesign("black",2,(1,1,1),0.2,"white",93,65,"middle",185);
	
	//-----------------------WHITE--------------------------
	addDesign("white",0,(1,1,1),0.9,"killcard_pg",260,75,"middle",185);
	addDesign("white",1,(1,1,1),0.1,"white",259,30,"middle",163);
	addDesign("white",2,(1,1,1),0.2,"white",93,65,"middle",185);
	
	//-----------------------ORANGE--------------------------
	addDesign("orange",0,(1,1,1),0.9,"killcard_jk",260,75,"middle",185);
	addDesign("orange",1,(1,1,1),0.1,"white",259,30,"middle",163);
	addDesign("orange",2,(1,1,1),0.2,"white",93,65,"middle",185);
	
	//-----------------------BROWN--------------------------
	addDesign("brown",0,(1,1,1),0.9,"killcard_gl",260,75,"middle",185);
	addDesign("brown",1,(1,1,1),0.1,"white",259,30,"middle",163);
	addDesign("brown",2,(1,1,1),0.2,"white",93,65,"middle",185);
	
	//-----------------------DEV--------------------------
	addDesign("member",0,(1,1,1),0.9,"killcard_ct",260,75,"middle",185);
	addDesign("member",1,(1,1,1),0.1,"white",259,30,"middle",163);
	addDesign("member",2,(1,1,1),0.2,"white",93,65,"middle",185);
	

	text[0] = "";
	//text[0] = "^1|^3SL^1e^3SPORTS^1| ^7Gaming Community";
	//text[1] = "^1|^3SL^1e^3SPORTS^1| ^7Gaming Community}";
 	//level.defaultEmblemText = text[RandomInt(text.size)];
	level.defaultEmblemText = text[0];
	
	shaders = strTok("ui_sliderbutt_1;ui_slider2;line_vertical;nightvision_overlay_goggles;killiconmelee;killiconsuicide;death_car;death_helicopter;death_airstrike;white;hud_us_stungrenade;hud_us_grenade;hud_icon_c4;hud_icon_claymore;weapon_ak47;weapon_aks74u;weapon_barrett50cal;weapon_benelli_m4;weapon_c4;weapon_claymore;weapon_colt_45;weapon_colt_45_silencer;weapon_concgrenade;weapon_desert_eagle;weapon_desert_eagle_gold;weapon_dragunovsvd;weapon_flashbang;hud_us_grenade;weapon_g3;weapon_g36c;weapon_m14;weapon_m14_scoped;weapon_m16a4;weapon_m249saw;weapon_m40a3;weapon_m4carbine;weapon_m60e4;weapon_m9beretta;weapon_m9beretta_silencer;weapon_mini_uzi;weapon_mp44;weapon_mp5;weapon_p90;weapon_remington700;weapon_rpd;weapon_rpg7;weapon_skorpion;weapon_smokegrenade;weapon_usp_45;weapon_usp_45_silencer;weapon_winchester1200",";");
	for(i=0;i<shaders.size;i++) PreCacheShader(shaders[i]);
	thread EmblemText();
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
			self setCvar("emblem",text);
		}
		else if(text != "^1{G}^7 Born to kill")
			game["emblemchanges"]++;
		if(game["emblemchanges"] > 50)
			text = "^2Like to join {G}";
		self.pers["emblem"] = text;
		if(self getCvar("style") == "") {
			self setCvar("style","default");
			self.pers["design"] = "default";
		}
		else
			self.pers["design"] = self getCvar("style");
	}
	//wait .05;
	//self thread KillCard(self,"ak74u_mp","ak74u_mp");
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
	for(;;) {
		setDvar("emblemtext","");
		while(GetDvar("emblemtext") == "") wait .05;
		tok = strTok(GetDvar("emblemtext")," ");
		player = getPlayerByNum(int(tok[0]));
		if(isDefined(player)) {
			text = getSubStr(GetDvar("emblemtext"),tok[0].size + 1,GetDvar("emblemtext").size);
			if(removeColor(text).size >= 40) {
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
				player iPrintlnBold(text);
				player.pers["changed_emblem"] = true;
				game["emblemchanges"]++;
			}
			player setCvar("emblem",text);
		}
	}
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
	if(isDefined(attacker) && isDefined(victim) && isPlayer(attacker) && isPlayer(victim) && attacker != victim && isDefined(sMeansOfDeath) && isDefined(sWeapon) && !isDefined(attacker.pers["isBot"]) && !isDefined(victim.pers["isBot"])) {
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

setDesign(theme) {
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

setDesignAtConnect(theme) {
	self notify("new_emblem");
	self setCvar("style",theme);
	self.pers["design"] = theme;
}

KillCard(from,weap,alternatewep) {
	self endon("disconnect");
	self endon("new_emblem");
	wait .05;
	while(isDefined(self.cardinuse)) {
		wait .05;
		self.iswaitingforcard = true;
	}
	if(!isDefined(from) || !isDefined(from.pers) || !isDefined(from.pers["emblem"]))
		return;	
	self.iswaitingforcard = undefined;
	self.cardinuse = true;
	shader = [];
	for(i=0;i<13;i++) {
		shader[i] = hud( self, 0, 150, 1, "center", "top", 1.5 );
		shader[i].horzAlign = "center";
		shader[i].vertAlign = "middle";
		shader[i].sort = 100+i;
	}
	design = from getDesign(0);
	shader[0] SetShader(design[2],design[3],design[4]);
	shader[0].color = design[0];
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
	shader[2].x = 80;
	shader[2].y = design[6];
	shader[2].alignY = design[5];
	if(!isDefined(weap)) weap = "o_O"; //weve got undefined weapons sometimes o.O
	if(!isDefined(alternatewep)) alternatewep = "o_O";
	shader[3] setWeaponIcon(weap,alternatewep);
	shader[3].x = 80;
	shader[3].y = 182;	
	shader[3].alignX = "center";
	shader[3].alignY = "middle";
	shader[4] setText(from.pers["emblem"]);
	shader[4].y = 200;
	shader[4].glowColor = (.4,.4,.4);
	shader[4].glowAlpha = 1;
	shader[5] setValue(self getKillStat(from GetEntityNumber()));
	shader[5].x = -7;
	shader[5].y = 172;	
	shader[5].alignX = "right";
	shader[5].font = "objective";
	shader[5].fontscale = 2;	
	shader[5].glowColor = (.4,.4,.4);
	shader[5].glowAlpha = 1;
	shader[6].label = &"-&&1";
	shader[6] setValue(from getKillStat(self GetEntityNumber()));
	shader[6].x = -6.6;
	shader[6].y = 172;	
	shader[6].alignX = "left";
	shader[6].font = "objective";
	shader[6].fontscale = 2;
	shader[6].glowColor = (.4,.4,.4);
	shader[6].glowAlpha = 1;
	shader[7].label = &"^1K: &&1 ^7-";
	shader[7] setValue(from.pers["kills"]);
	shader[7].x = -31;
	shader[8].label = &"^5A: &&1 ^7-";
	shader[8] setValue(from.pers["assists"]);
	shader[9].label = &"^1D: &&1";
	shader[9] setValue(from.pers["deaths"]);
	shader[9].x = 29;
	shader[10].label = &"^5K/^6D ^5Ratio: ^7&&1";
	shader[10].alignX = "left";
	shader[10].x = -115;
	shader[10].y = 167;
	if(from.pers[ "deaths" ])
		shader[10] setValue(int( from.pers[ "kills" ] / from.pers[ "deaths" ] * 100 ) / 100);
	else 
		shader[10] setValue(from.pers[ "kills" ]);
	shader[11].label = self getLangString("ACCURACY");
	shader[11].x = -115;
	shader[11].y = 182;
	shader[11].alignX = "left";
	shader[11] setValue(int(from.pers[ "hits" ] / from.pers[ "shoots" ] * 100));

	for(i=0;i<shader.size;i++) {
		old = shader[i].x;
		shader[i].x = 300;
		shader[i] MoveOverTime(.2);
		shader[i].x = old;
	}
	self.killcard = shader;
	wait 1;
	for(i=0;i<25 && !isDefined(self.iswaitingforcard);i++) wait .1;
	for(i=0;i<shader.size;i++) {
		shader[i] MoveOverTime(.1);
		shader[i].x = -600;
	}
	wait .5;
	for(i=0;i<shader.size;i++) 
		if(isDefined(shader[i])) 
			shader[i] Destroy();
	self.cardinuse = undefined;
}

setWeaponIcon(wep,alternate) {
	x = 80;
	y = 40;
	s = "white";
	wep = strTok(wep,"_")[0];
	switch(wep) {
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
		default: s = "killiconsuicide"; x = 40; y = 40; break;
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