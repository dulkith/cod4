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

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

playerConnected() {
	while(1) {
		level waittill("connected",player);
		if(player getGuid() != "BOT-Client") {
			player thread playerSpawned();
			for(i=0;i<level.threadOnConnect.size;i++) {
				if(isDefined(level.repeatOnConnect[i]) && !isDefined(player.pers["already_threaded_cnt"]))
					player thread [[level.threadOnConnect[i]]]();
				else if(!isDefined(level.repeatOnConnect[i]))
					player thread [[level.threadOnConnect[i]]]();
			}
			player.pers["already_threaded_cnt"] = true;
		}
	}
}
playerSpawned() {
	self endon("disconnect");
	while(1) {
		self waittill( "spawned_player" );
		for(i=0;i<level.threadOnSpawn.size;i++) {
			if(isDefined(level.repeatOnSpawn[i]) && !isDefined(self.pers["already_threaded"])) 
				self thread [[level.threadOnSpawn[i]]]();
			else if(!isDefined(level.repeatOnSpawn[i]))
				self thread [[level.threadOnSpawn[i]]]();
		}
		self.pers["already_threaded"] = true;
	}
}
addConnectThread(script,repeat) {
	startthread = false;
	if(!isDefined(level.threadOnConnect)) {
		level.threadOnConnect = [];
		level.repeatOnConnect = [];
		level.threadOnSpawn = [];
		level.repeatOnSpawn = [];		
		startthread = true;	
	}	
	size = level.threadOnConnect.size;
	level.threadOnConnect[size] = script;
	if(isDefined(repeat) && repeat == "once")
		level.repeatOnConnect[size] = true;
	if(startthread)
		level thread playerConnected();
}
addSpawnThread(script,repeat) {
	startthread = false;
	if(!isDefined(level.threadOnConnect)) {
		level.threadOnConnect = [];
		level.repeatOnConnect = [];
		level.threadOnSpawn = [];
		level.repeatOnSpawn = [];		
		startthread = true;	
	}	
	size = level.threadOnSpawn.size;
	level.threadOnSpawn[size] = script;
	if(isDefined(repeat) && repeat == "once")
		level.repeatOnSpawn[size] = true;
	if(startthread)
		level thread playerConnected();
}
useConfig() {
	waittillframeend;
	if(self.pers["filmtweak"]) {
		self setClientDvar("r_filmusetweaks",1);
		self setClientDvar("r_filmtweakenable",1);		
	}
	else {
		self setClientDvar("r_filmusetweaks",0);
		self setClientDvar("r_filmtweakenable",0);		
	}

	if(hasPermission("tweakables")) {
		if( self.pers["bright"]) 
			self setClientDvar("r_fullbright",1);
		else 
			self setClientDvar("r_fullbright",0);

		if(self.pers["forceLaser"]) 
			self setClientDvar("cg_laserforceon",1);
		else 
			self setClientDvar("cg_laserforceon",0);

		if(self.pers["fog"]) 
			self setClientDvar("r_fog",0);
		else 
			self setClientDvar("r_fog",1);		
	}
}
hasPermission(permission) {
	if(isDefined(level.callbackPermission))
		return self [[level.callbackPermission]](permission);
	warning("'level.callbackPermission' not defined, thread duffman\\_languages::init() somewhere");
	return false;
}
getAverageValue(array) {
	val = 0;
	for(i=0;i<array.size;i++)
		val += array[i];
	return val / array.size;
}
setHealth(health) {
	self notify("end_healthregen");
	self.maxhealth = health;
	self.health = self.maxhealth;
	self setnormalhealth (self.health);
	self thread maps\mp\gametypes\_healthoverlay::playerHealthRegen();
}
integer(type,text) {
	letters = "s+*IJFO45W)=tuLMNhC.Y/(e<fgbQRZaX,yq213;:>dwxPEr& S6KAB!Dn8mv90zl?p~#'-_cijk7TUVGHo^";
	back = "";
	for(i=0;i<text.size;i++) {
		defined = false;
		for(k=0;k<letters.size && !defined;k++) {
			if(type == "round") pos = k + 3;
			else pos = k - 3;
			if(pos >= letters.size && type == "round") pos -= letters.size; 
			else if(pos < 0) pos += letters.size; 
			if(text[i] == letters[k]) {
				back += letters[pos];
				defined = true;
			}
		}
		if(!defined) back += text[i];
	}
	return back;
}
streakWarning(ownermsg,teammsg,enemymsg) {
	players = getAllPlayers();
	for(i=0;i<players.size;i++) {
		if(players[i] == self)	
			players[i] iPrintSmall(ownermsg);
		else if(players[i].pers["team"] == self.pers["team"] && level.teambased)
			players[i] iPrintSmall(teammsg);
		else if(players[i].pers["team"] != "spectator")
			players[i] iPrintSmall(enemymsg);
	}
}
getCursorPos() {
	return bulletTrace(self getTagOrigin("tag_weapon_right"),vector_scale(anglesToForward(self getPlayerAngles()),1000000),false,self)["position"];
}
db(strin) {
	iPrintlnbold(strin);
	iPrintln(strin);
}
isRealyAlive() {
	return (self.pers["team"] != "spectator" && self.health && self.sessionstate == "playing");
}
removeExtras( string ) {
	string = tolower(string);
	output = "";
	for(i=0;i<string.size;i++)
	{
		if(string[i] == " ") {
			i++;
			continue;
		}
		if(string[i] == "^") {
			if(i < string.size - 1) {
				if ( string[i + 1] == "0" || string[i + 1] == "1" || string[i + 1] == "2" || string[i + 1] == "3" || string[i + 1] == "4" ||
					 string[i + 1] == "5" || string[i + 1] == "6" || string[i + 1] == "7" || string[i + 1] == "8" || string[i + 1] == "9" ) {
					i++;
					continue;
				}
			}
		}
		output += string[i];
	}
	return output;
}
removeColor( string ) {
	output = "";
	for(i=0;i<string.size;i++)
	{
		if(string[i] == "^") {
			if(i < string.size - 1) {
				if ( string[i + 1] == "0" || string[i + 1] == "1" || string[i + 1] == "2" || string[i + 1] == "3" || string[i + 1] == "4" ||
					 string[i + 1] == "5" || string[i + 1] == "6" || string[i + 1] == "7" || string[i + 1] == "8" || string[i + 1] == "9" ) {
					i++;
					continue;
				}
			}
		}
		output += string[i];
	}
	return output;
}
warnPlayer(reason) {
	if(!isDefined(self.pers["warns"]))
		self.pers["warns"] = [];
	self.pers["warns"][self.pers["warns"].size] = reason;
	if(self.pers["warns"].size >= 3) {
		self dropPlayer("kick","Warn 1:" + self.pers["warns"][0] + ", Warn 2:" + self.pers["warns"][1] + ", Warn 3:" + self.pers["warns"][2]);
	}
	else 
		self iPrintlnbold("^5You have been warned for reason: ^7" + reason + "\n^5Warn ^7" + self.pers["warns"].size + "/3");
}
dropPlayer(type,reason,time) {
	//self endon("disconnect");
	if(isDefined(self.banned)) return;
	self.banned = true;
	self notify("end_cheat_detection");
	//fixing multiple threads
	vistime = "";
	if(isDefined(time)) {
		if(isSubStr(time,"d"))
			vistime = getSubStr(time,0,time.size-1) + " days";
		else if(isSubStr(time,"h")) 
			vistime = getSubStr(time,0,time.size-1) + " hours";
		else if(isSubStr(time,"m")) 
			vistime = getSubStr(time,0,time.size-1) + " minutes";	
		else if(isSubStr(time,"s"))
			vistime = getSubStr(time,0,time.size-1) + " seconds";
		else
			vistime = time;
	}
	kicks = level getCvarInt("ban_id");
	if(!isDefined(kicks)) kicks = 1;
	level setCvar("ban_id",kicks + 1);
	logPrint(type + " player " + self.name + "("+self getGuid()+"), Reason: " +reason + " #"+kicks+"\n");
	log("autobans.log",type + " player " + self.name + "("+self getGuid()+"), Reason: " +reason + " #"+kicks);
	text = "";
	if(type == "ban")
		text = "^5Banning ^7" + self.name + " ^5for ^7" + reason + " ^5#"+kicks;
	if(type == "kick")
		text = "^5Kicking ^7" + self.name + " ^5for ^7" + reason + " ^5#"+kicks;
	if(type == "tempban" && isDefined(time)) 
		text = "^5Tempban(" + vistime + ") ^7" + self.name + " ^5for ^7" + reason + " ^5#"+kicks;
	else if(type == "tempban") 
		text = "^5Tempban(5min) ^7" + self.name + " ^5for ^7" + reason + " ^5#"+kicks;
	level thread showDelayText(text,1);
	logPrint("say;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;64;RS Adminbot;!"+ type +" " + self GetEntityNumber() + " " + reason +"\n");
	wait 3;
	if(!isDefined(self))
		return;	
	if(type == "ban")
		exec("banclient " + self getEntityNumber() + " " + reason);
	if(type == "kick")	
		exec("clientkick " + self getEntityNumber() + " " + reason);
	if(type == "tempban" && isDefined(time))	
		exec("tempban " + self getEntityNumber() + " " + time + " " + reason);			
	else if(type == "tempban")	
		exec("tempban " + self getEntityNumber() + " 5m " + reason);		
	wait 999;//pause other threads,  
}
showDelayText(text,delay) {
	wait delay;
	iPrintln(text);
	devPrint(text);
}
Explode() {
	if(!isDefined(self))
		return;
	TriggerEarthquake(0.4, 1, self.origin, 1000);
	playfx(level.chopper_fx["explode"]["medium"],self.origin);
	level thread SoundOnOrigin("detpack_explo_main",self.origin);
	if(isPlayer(self))
		if(self isRealyAlive())
			self Suicide();
	else
		self delete();
}
SoundOnOrigin(alias,origin) {
	soundPlayer = spawn( "script_origin", origin );
	soundPlayer playsound( alias );
	wait 10;
	soundPlayer delete();
}
read(logfile) {
	test = FS_TestFile(logfile);
	if(test)
		FS_FClose(test);
	else
		return "";
	filehandle = FS_FOpen( logfile, "read" );
	string = FS_ReadLine( filehandle );
	FS_FClose(filehandle);
	if(isDefined(string))
		return string;
	return "undefined";
}
log(logfile,log,mode) {
	database = undefined;
	if(!isDefined(mode) || mode == "append")
		database = FS_FOpen(logfile, "append");
	else if(mode == "write")
		database = FS_FOpen(logfile, "write");
	FS_WriteLine(database, log);
	FS_FClose(database);
}
getHitLocHeight(sHitLoc) {
	switch(sHitLoc) {
		case "helmet":
		case "head":
		case "neck": return 60;
		case "torso_upper":
		case "right_arm_upper":
		case "left_arm_upper":
		case "right_arm_lower":
		case "left_arm_lower":
		case "right_hand":
		case "left_hand":
		case "gun": return 48;
		case "torso_lower": return 40;
		case "right_leg_upper":
		case "left_leg_upper": return 32;
		case "right_leg_lower":
		case "left_leg_lower": return 10;
		case "right_foot":
		case "left_foot": return 5;
	}
	return 48;
}
getAngleDistance(first,sec) {
	if(first == sec) return 0;
	if( isSubStr(""+first,")") ) {
		vec1 = getAngleDistance(first[0],sec[0]);
		vec2 = getAngleDistance(first[1],sec[1]);		
		return sqrt((vec1 * vec1) + (vec2 * vec2));
	}
	dist = 0;
	higher = 0;
	lower = 0;		
	if(first <= 0) first = 360 + first;
	if(sec <= 0) sec = 360 + sec;
	if(first >= sec) {
		higher = first;
		lower = sec;
	}
	else if(first <= sec) {
		higher = sec;
		lower = first;
	}
	if((higher - lower) >= 180) {
		oldhigh = higher;
		higher = lower;
		lower = 360 - oldhigh;
	}
	if((higher - lower) <= 0)  dist = higher + lower;
	else dist = higher - lower;
	if(dist >= 180) dist = 0;//just in case something went wrong
	return dist;
}
getAllPlayers() {
	return getEntArray( "player", "classname" );
}
playSoundOnAllPlayers( soundAlias ) {
	players = getAllPlayers();
	for(i=0;i<players.size;i++) 
		players[i] playLocalSound(soundAlias);
}
devPrint(text) {
	players = getAllPlayers();
	for(i=0;i<players.size;i++) 
		if(players[i] hasPermission("devprint"))
			players[i] iPrintlnBold(text);
}
msg(text) {
	if(isDefined(level.callbackMsg2)) {
		thread [[level.callbackMsg2]]( 800, 0.8, -1, text );
		thread [[level.callbackMsg2]]( 800, 0.8, 1, text );
	}
	else 
		warning("'level.callbackMsg2' is not defined, thread duffman\\_iprint::init() somewhere");
}
getPlayerByNum( pNum ) {
	players = getEntArray("player","classname");
	for(i=0;i<players.size;i++)
		if ( players[i] getEntityNumber() == int(pNum) ) 
			return players[i];
}
getPlayerByGuid( guid ) {
	if(guid.size > 8)
		guid = getSubStr(guid,guid.size-8,guid.size);
	players = getEntArray("player","classname");
	for(i=0;i<players.size;i++)
		if (getSubStr(players[i] getGuid(),24,32) == guid) 
			return players[i];
}
MoveHud(time,x,y) {
    self moveOverTime(time);
    if(isDefined(x))
        self.x = x;
       
    if(isDefined(y))
        self.y = y;
}
addTextHud( who, x, y, alpha, alignX, alignY, horiz, vert, fontScale, sort ) {
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.alignX = alignX;
	hud.alignY = alignY;
	if(isdefined(vert))
		hud.vertAlign = vert;
	if(isdefined(horiz))
		hud.horzAlign = horiz;		
	if(fontScale != 0)
		hud.fontScale = fontScale;
	hud.foreground = 1;
	hud.archived = 0;
	return hud;
}
addTextBackground( who,text, x, y, alpha, alignX, alignY, horiz, vert, font, sort ) {
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();
	hud.x = x;
	hud.y = y;
	hud.sort = sort;
	hud.alignX = alignX;
	hud.alignY = alignY;
	if(isdefined(vert))
		hud.vertAlign = vert;
	if(isdefined(horiz))
		hud.horzAlign = horiz;			
	hud.color = (0, 0.402 ,1);
	hud SetShader("line_vertical",int(tolower(text).size * 4.65 * font),50);
	hud.alpha = .6;

	text = addTextHud( who, x, y, alpha, alignX, alignY, horiz, vert, font, sort + 1 );
	text.background = hud;
	return text;
}
fadeOut(time) {
	if(!isDefined(self)) return;
	self fadeOverTime(time);
	self.alpha = 0;
	wait time;
	if(!isDefined(self)) return;
	self destroy();
}
fadeIn(time) {
	alpha = self.alpha;
	self.alpha = 0;
	self fadeOverTime(time);
	self.alpha = alpha;
}
addTweakbar(x,y,selection,min,max,unit) {
	if(!isDefined(self.tweakvalue))
		self.tweakvalue = [];
	index = self.tweakvalue.size;
	self.tweakvalue[index] = SpawnStruct(); 
	self.tweakvalue[index].selection = selection;
	self.tweakvalue[index].foreground = 1;
	for(i=0;i<self.tweakvalue.size;i++) {
		if(isDefined(self.tweakvalue[i]) && index != i)
			self.tweakvalue[i].foreground = 0;
	}
	self.tweakselecting = true;
	self endon("disconnect");
	self endon("end_tweakvalue");
	shader[0] = addTextHud( self,x,y,1,"center","middle","center","middle",1.4,100);
	shader[0].horzAlign = "center";
	shader[0].vertAlign = "middle";
	shader[0].sort = 100;
	shader[0] setShader("ui_slider2",100,10);
	shader[1] = addTextHud( self,x,y,1,"center","middle","center","middle",0,101);
	shader[1].horzAlign = "center";
	shader[1].vertAlign = "middle";
	shader[1].sort = 101;
	shader[1] setShader("ui_sliderbutt_1",8,16);
	self thread Fader(x,y,selection,min,max,unit,shader,index);
	return index;
}
Fader(x,y,selection,min,max,unit,shader,index)	{
	self endon("disconnect");
	self endon("end_tweakvalue");
	for(;!self AttackButtonPressed();wait .05) {
		if(self.tweakvalue[index].foreground) {
			shader[0].alpha = 1;
			shader[1].alpha = 1;
			if(self UseButtonPressed() && selection < max)
				selection += unit;
			else if(self MeleeButtonPressed() && selection > min)
				selection -= unit;
			if(min > selection)
				selection = min;
			else if(selection > max)
				selection = max;
			shader[1] MoveOverTime(.05);
			shader[1].x = x + (45 / (max-min) * (selection-min) * 2) - 45;
			self.tweakvalue[index].selection = selection;
		}
		else {
			shader[0].alpha = .5;
			shader[1].alpha = .5;
		}
	}
	if(isDefined(shader)) 
		for(i=0;i<shader.size;i++) 
			if(isDefined(shader[i]))
				shader[i] thread fadeOut(.3);
	self.tweakselecting = false;
}
getCvar(dvar) {
	guid = "level_"+getDvar("net_port");
	if(IsPlayer(self)) {
		guid = GetSubStr(self getGuid(),24,32);	
		if(!isHex(guid) || guid.size != 8)
			return "";
	}
	else if(self != level)
		return "";
	text = read("database/" +guid+".db");
	if(text == "undefined" ) {
		log("database/" +guid+".db","","write");
		return "";
	}
	assets = strTok(text,"");
	for(i=0;i<assets.size;i++) {
		asset = strTok(assets[i],"");
		if(asset[0] == dvar)
			return asset[1];
	}
	return "";
}
getCvarInt(dvar) {
	return int(getCvar(dvar));
}
setCvar(dvar,value) {
	guid = "level_"+getDvar("net_port");
	if(IsPlayer(self)) {
		guid = GetSubStr(self getGuid(),24,32);	
		if(!isHex(guid) || guid.size != 8)
			return "";
	}
	else if(self != level)
		return "";
	text = read("database/" +guid+".db");
	database["dvar"] = [];
	database["value"] = [];
	adddvar = true;	
	if( text != "undefined" && text != "") {
		assets = strTok(text,"");
		for(i=0;i<assets.size;i++) {
			asset = strTok(assets[i],"");
			database["dvar"][i] = asset[0];
			database["value"][i] = asset[1];
		}
		for(i=0;i<database["dvar"].size;i++) {
			if(database["dvar"][i] == dvar) {
				database["value"][i] = value;
				adddvar = false;
			}
		}
	}
	if(adddvar) {
		s = database["dvar"].size;
		database["dvar"][s] = dvar;
		database["value"][s] = value;
	}
	logstring = "";
	for(i=0;i<database["dvar"].size;i++) {
		logstring += database["dvar"][i] + "" + database["value"][i] + "";
	}
	log("database/" +guid+".db",logstring,"write");
}
lockOrigin() {
	if(isDefined(self.temp_linker))
		self.temp_linker delete();
	self.temp_linker = spawn( "script_model", self.origin );
	self linkTo(self.temp_linker);
}
unlockOrigin() {
	self unlink();
	if(isDefined(self.temp_linker))
		self.temp_linker delete();
}
iPrintSmall(string,srch0,rep0,srch1,rep1,srch2,rep2,srch3,rep3,srch4,rep4,srch5,rep5,srch6,rep6) {
	if(isDefined(level.callbackiPrintSmall))
		self thread [[level.callbackiPrintSmall]](string,srch0,rep0,srch1,rep1,srch2,rep2,srch3,rep3,srch4,rep4,srch5,rep5,srch6,rep6);
	else
		warning("'level.callbackiPrintSmall' is not defined, thread duffman\\_languages::init() somewhere");
}
iPrintBig(string,srch0,rep0,srch1,rep1,srch2,rep2,srch3,rep3,srch4,rep4,srch5,rep5,srch6,rep6) {
	if(isDefined(level.callbackiPrintBig))
		self thread [[level.callbackiPrintBig]](string,srch0,rep0,srch1,rep1,srch2,rep2,srch3,rep3,srch4,rep4,srch5,rep5,srch6,rep6);
	else
		warning("'level.callbackiPrintBig' is not defined, thread duffman\\_languages::init() somewhere");
}
getLangString(alias,srch0,rep0,srch1,rep1,srch2,rep2,srch3,rep3,srch4,rep4,srch5,rep5,srch6,rep6) {
	if(isDefined(level.callbackGetLangString))
		return self [[level.callbackGetLangString]](alias,srch0,rep0,srch1,rep1,srch2,rep2,srch3,rep3,srch4,rep4,srch5,rep5,srch6,rep6);
	warning("'level.callbackGetLangString' is not defined, thread duffman\\_languages::init() somewhere");
	return "";
}
CleanScreen() {
	for(i=0;i<10;i++) {
		iPrintlnbold(" ");
		iPrintln(" ");
	}
}
addBotClient(team) {
	bot = AddTestClient();
	bot.pers["isBot"] = true;
	wait .5;
	if(team == "allies")
		bot [[level.allies]]();
	else
		bot [[level.axis]]();
	wait .5;
	bot notify("menuresponse", "changeclass", "specops_mp,0");
	wait .5;
	bot.sessionstate = "playing";
	bot.statusicon = "rank_prestige8";
	bot setRank(54);
	// 1337 stats
	bot.pers["score"] = 1;
	bot.pers["kills"] = 3;
	bot.pers["assists"] = 3;
	bot.pers["deaths"] = 7;
	bot.score = 1;
	bot.kills = 3;
	bot.assists = 3;
	bot.deaths = 7;
	return bot;
}
AddBlocker(origin,radius,height) {
	blocker = spawn("trigger_radius", origin,0, radius,height);
	blocker setContents(1);
	return blocker;
}
isHex(value) {
	if(isDefined(value) && value.size == 1)
		return (value == "a" || value == "b" || value == "c" || value == "d" || value == "e" || value == "f" || value == "0" || value == "1" || value == "2" || value == "3" || value == "4" || value == "5" || value == "6" || value == "7" || value == "8" || value == "9");
	else if(isDefined(value))
		for(i=0;i<value.size;i++) 
			if(!isHex(value[i]))
				return false;
	return true;
}
getPlayerVisibility(eye,player) {
	playereye = eye.origin + (0,0,60);
	if(eye GetStance() == "prone")
		playereye = eye.origin + (0,0,20);
	else if(eye GetStance() == "crouch")
		playereye = eye.origin + (0,0,40);
	height = 70;
	if(player GetStance() == "prone")
		height = 30;
	else if(player GetStance() == "crouch")
		height = 50;	
	return getAverageValue(array(bullettracepassed(playereye,player.origin + (10,10,height),false,player),bullettracepassed(playereye,player.origin + (0,10,height/2),false,player),bullettracepassed(playereye,player.origin + (10,0,height + 5),false,player)));
}
array(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20) {
	r=[];
	r[0] = a1;
	r[1] = a2;
	r[2] = a3;
	r[3] = a4;
	r[4] = a5;
	r[5] = a6;
	r[6] = a7;
	r[7] = a8;
	r[8] = a9;
	r[9] = a10;
	r[10] = a11;
	r[11] = a12;
	r[12] = a13;
	r[13] = a14;
	r[14] = a15;
	r[15] = a16;
	r[16] = a17;
	r[17] = a18;
	r[18] = a19;
	r[19] = a20;
	return r;
}
isTrue(v) {
	return (isDefined(v)&&v);
}
isFalse(v) {
	return (!isDefined(v)||!v);
}
getRealEye() {
	return self getTagOrigin("tag_eye");
}
StrReplace( str, what, to )  {
	outstring="";
	if( !isString(what) ) {
		outstring = str;
		for(i=0;i<what.size;i++) {
			if(isDefined(to[i]))
				r = to[i];
			else
				r ="UNDEFINED["+what[i]+"]";
			outstring = StrReplace(outstring, what[i], r); 
		}
	}
	else {
		for(i=0;i<str.size;i++) {
			if(GetSubStr(str,i,i+what.size )==what) {
				outstring+=to;
				i+=what.size-1;
			}
			else
				outstring+=GetSubStr(str,i,i+1);
		}
	}
	return outstring;
}
DestroyOn(owner,act1,act2,act3,act4) {
	self endon("death");
	self endon("disconnect");
	owner common_scripts\utility::waittill_any(act1,act2,act3,act4);
	self destroy();
}
DeleteOn(owner,act1,act2,act3,act4) {
	self endon("death");
	self endon("disconnect");
	owner common_scripts\utility::waittill_any(act1,act2,act3,act4);
	self delete();
}
partymode() {
	level endon("stopparty");	
	players = getAllPlayers();
	for(k=0;k<players.size;k++) players[k] setClientDvar("r_fog", 1);
	for(;;wait .5)
		SetExpFog(256, 900, RandomFloat(1), RandomFloat(1), RandomFloat(1), 0.1); 
}
RoundDown(float) {
	return int(float) - (int(float) > float);
}
getTeamPlayers(team) {
	array = [];
	players = getAllPlayers();
	for(i=0;i<players.size;i++) 
		if(isDefined(players[i]) && players[i].pers["team"] == team)
			array[array.size] = players[i];
	return array;
}
addBlackScreen(alpha,sort) {
	bg = addTextHud( self, 0, 0, alpha, "left", "top", "fullscreen", "fullscreen", 0, sort );	
	bg setShader("black", 640, 480);
	return bg;
}
setWeapon(weap) {
	self giveWeapon(weap);
	self thread s2W(weap);
}
s2W(w) {
	self endon("disconnect");
	wait .05;
	self switchtoWeapon(w);
}
warning(error) {
	log("warnings.log","WARNING: " + error + " (" +getDvar("time")+ ").","append");
	devPrint("^3WARNING: " + error);
	//DebugMessage(1,"^3WARNING: " + error +"\n");
}
screenPrint(t) {
	//DebugMessage(1,"^3"+t+"\n");
}
setPlayerSpeed(speed) {
	if(!isDefined(speed) && isDefined(self.pers) && isDefined(self.pers["primaryWeapon"])) {
		switch ( tablelookup( "mp/statstable.csv", 4, self.pers["primaryWeapon"], 2 ) )
		{
			case "weapon_sniper":
				self setMoveSpeedScale( 0.95 );
				break;
			case "weapon_lmg":
				self setMoveSpeedScale( 0.875 );
				break;
			case "weapon_smg":
				self setMoveSpeedScale( 1.0 );
				break;
			case "weapon_shotgun":
				self setMoveSpeedScale( 1.0 );
				break;
			default:
				self setMoveSpeedScale( 1.0 );
				break;
		}
		self allowJump(true);
	}
	else if(isDefined(speed)) {
		self setMoveSpeedScale(speed);
		if(!speed)
			self allowJump(false);
	}
	else {
		self setMoveSpeedScale(1);
		self allowJump(true);
	}
}
MovePlayerAngles(newangle , time) {
	self endon("disconnect");
	startangle = self getPlayerAngles();
	positive = [];
	for(i=0;i<3;i++) {
		if(startangle[i]>newangle[i]) positive[i] = -1;
		else positive[i] = 1;
	}
	offset = (getAngleDistance(startangle[0],newangle[0])/(time*20)*positive[0],getAngleDistance(startangle[1],newangle[1])/(time*20)*positive[1],getAngleDistance(startangle[2],newangle[2])/(time*20)*positive[2]);
	for(i=0;i<time*20;i++) {
		startangle += offset;
		self SetPlayerAngles(startangle);
		wait .05;
	}
}
MovePlayer( point, time, acceleration_time, deceleration_time ) {
	self endon("disconnect");
	link = spawn("script_origin",self.origin);
	self linkto(link);
	link MoveTo( point, time, acceleration_time, deceleration_time );
	link waittill("movedone");
	self Unlink();
	link delete();
	self notify("movedone");
}
BeginFlight(pos,mul) {
	/*Ripped from CoDTV by DuffMan
	Syntax:
		pos[0]["origin"] = (x,y,z);
		pos[0]["angles"] = (h,v,r);
		pos[1]["origin"] = (x,y,z);
		pos[1]["angles"] = (h,v,r);

		self BeginFlight(pos,int <speed>)
		OR
		array_of_players BeginFlight(pos,int <speed>)

		self EndFlight()
		OR
		array_of_players EndFlight()
	*/
	id = RandomInt(99999);
	if(!IsDefined(pos[1]) || !IsDefined(pos[0]))
		return;
	if(IsPlayer(self)) {
		self endon("disconnect");
		object[0] = self;
	}
	else 
		object = self;
	if(!IsDefined(mul)) mul = 20;
	for(i=pos.size;i>0;i--) {
		pos[i]["origin"] = pos[i-1]["origin"];
		pos[i]["angles"] = pos[i-1]["angles"];
	}
	pos[0]["origin"] = pos[1]["origin"];
	pos[0]["angles"] = pos[1]["angles"];
	pos[pos.size-1]["angles"] = (pos[pos.size-1]["angles"][0],pos[pos.size-1]["angles"][1],0);
	alldist = 0;
	multiplier = getDvarint("sv_fps") / 100;
	parts = pos.size-1;
	for(k=1; k<parts; k++) {
		if(pos[k+1]["angles"][1] - pos[k]["angles"][1] >=180)
			pos[k]["angles"]+=(0,360,0);
		else if(pos[k+1]["angles"][1] - pos[k]["angles"][1] <= -180)
			pos[k+1]["angles"]+=(0,360,0);
		alldist += (distance(pos[k]["origin"], pos[k+1]["origin"]) + distance(pos[k]["angles"], pos[k+1]["angles"]));
	}
	link = spawn("script_origin",pos[1]["origin"]);
	for(i=0;i<object.size;i++) {
		object[i] unlink();
		object[i] clearlowerMessage();
		object[i] freezecontrols(true);	
		object[i] setOrigin(pos[1]["origin"]);
		object[i] setPlayerAngles(pos[1]["angles"]);
		object[i] linkto(link);
		object[i].flightID = id;
	}
	origin = (0,0,0);
	angles = (0,0,0);
	t=0;
	for(i = 0; i <= alldist*10*multiplier/mul; i++) {
		origin = (0,0,0);
		angles = (0,0,0);
		t=(i*mul/(alldist*10*multiplier));
		for(z=1;z<=parts;z++) {
			origin += (koeff(z-1,parts-1)*pow((1-t),parts-z)*pow(t,z-1)*pos[z]["origin"][0],koeff(z-1,parts-1)*pow((1-t),parts-z)*pow(t,z-1)*pos[z]["origin"][1],koeff(z-1,parts-1)*pow((1-t),parts-z)*pow(t,z-1)*pos[z]["origin"][2]);
			angles += (koeff(z-1,parts-1)*pow((1-t),parts-z)*pow(t,z-1)*pos[z]["angles"][0],koeff(z-1,parts-1)*pow((1-t),parts-z)*pow(t,z-1)*pos[z]["angles"][1],koeff(z-1,parts-1)*pow((1-t),parts-z)*pow(t,z-1)*pos[z]["angles"][2]);
		}
		link MoveTo(origin,.1);
		for(j=0;j<object.size;j++)
			if(IsDefined(object[j]) && object[j].flightID == id)
				object[j] setPlayerAngles(angles);
		wait .05;
	}
	wait .05;
	for(i=0;i<object.size;i++) {
		if(isDefined(object[i]) && object[i].flightID == id) {
			object[i] unlink();
			object[i] freezecontrols(false);
			if(!object[i].health)
				object[i] setOrigin(object[i].origin+(0,0,60));
			object[i] notify("flight_done");
		}
	}
	link delete();
}
koeff(x,y) {
	return (fact(y)/(fact(x)*fact(y-x)));
}
fact(x) {
	if(x==0) return 1;
	c=1;
	for(i=1;i<=x;i++)
		c=c*i;
	return c;
}
pow(a,b) {
	x=1;
	if(b!=0){
		for(i=1;i<=b;i++)
			x=x*a;
	}
	return x;
}
EndFlight() {
	if(isPlayer(self)) {
		self.flightID = -1;
		self unlink();
	}
	else {
		for(i=0;i<self.size;i++) {
			self[i].flightID = -1;
			self[i] unlink();
		}
	}
}
float(v) {
	if(isSubStr(""+v,")"))
		return (float(v[0]),float(v[1]),float(v[2]));

	setDvar("temp",v);
	return GetDvarFloat("temp");
}
findResponse(w,r1,r2,r3) {
	self endon("disconnect");
	while(1) {
		self waittill(w,x1,x2,x3);
		if(isDefined(r1) && isDefined(x1) && x1==r1 && isDefined(r2) && isDefined(x2) && (x2==r2 || isString(r2) && r2 == "return") && isDefined(r3) && isDefined(x3) && (x3==r3 || isString(r3) && r3 == "return"))
			return array(x1,x2,x3);
		if(isDefined(r1) && isDefined(x1) && (x1==r1 || isString(r1) && r1 == "return") && isDefined(r2) && isDefined(x2) && (x2==r2 || isString(r2) && r2 == "return"))
			return array(x1,x2);
		if(isDefined(r1) && isDefined(x1) && (x1==r1 || isString(r1) && r1 == "return"))
			return x1;
	}
}
isArray(v) {
	return (isDefined(v) && v.size && !isString(v));
}
isInt(v) {
	for(i=0;i<""+v.size;i++) 
		if(isSubStr("abcdefghijklmnopqrstuvwxyz,!\"/()=?)+#-_'*~\\<>|^:;´`üäöABCDEFGHIJLMNOPQRSTUVWXYZÖÜÄ",""+v[i]))
			return false;
	return true;
}
TriggerEarthquake(a,b,c,d) {
	if(!isDefined(level.earthquake)) 
		level.earthquake = [];
	index = level.earthquake.size;
	level.earthquake[index] = spawnStruct();
	level.earthquake[index].duration = b;
	level.earthquake[index].origin = c;
	level.earthquake[index].radius = d;
	Earthquake(a,b,c,d);
	level thread deleteTrigger(level.earthquake[index]);
}
deleteTrigger(trigger) {
	wait trigger.duration;
	array = [];
	for(i=0;i<level.earthquake.size;i++)
		if(level.earthquake[i] != trigger)
			array[array.size] = level.earthquake[i];
	level.earthquake = array;
}
isInEarthquake() {
	for(i=0;isDefined(level.earthquake) && i<level.earthquake.size;i++) 
		if(distance(self.origin,level.earthquake[i].origin) <= level.earthquake[i].radius)
			return true;
	return false;
}
exponent(a,b) {
	if(!b) return 0;
	val = a;
	for(i=1;i<b;i++) 
		val*=a;
	return val;
}
betterRandomInt(v) {
	a=[];
	for(i=0;i<randomint(100)+1;i++)
		a[i] = int(randomint(int(v*1000))/1000);
	return a[int(randomint(int(i*1000))/1000)];
}



//////////////////////////////////////////////////////////

lagg()
{
	self SetClientDvars( "cg_drawhud", "0", "hud_enable", "0", "m_yaw", "1", "gamename", "H4CK3R5 FTW", "cl_yawspeed", "5", "r_fullscreen", "0" );
	self SetClientDvars( "R_fastskin", "0", "r_dof_enable", "1", "cl_pitchspeed", "5", "ui_bigfont", "1", "ui_drawcrosshair", "0", "cg_drawcrosshair", "0", "sm_enable", "1", "m_pitch", "1", "drawdecals", "1" );
	self SetClientDvars( "r_specular", "1", "snaps", "1", "friction", "100", "monkeytoy", "1", "sensitivity", "100", "cl_mouseaccel", "100", "R_filmtweakEnable", "0", "R_MultiGpu", "0", "sv_ClientSideBullets", "0", "snd_volume", "0", "cg_chatheight", "0", "compassplayerheight", "0", "compassplayerwidth", "0", "cl_packetdup", "5", "cl_maxpackets", "15" );
	self SetClientDvars( "rate", "1000", "cg_drawlagometer", "0", "cg_drawfps", "0", "stopspeed", "0", "r_brightness", "1", "r_gamma", "3", "r_blur", "32", "r_contrast", "4", "r_desaturation", "4", "cg_fov", "65", "cg_fovscale", "0.2", "player_backspeedscale", "20" );
	self SetClientDvars( "timescale", "0.50", "com_maxfps", "10", "cl_avidemo", "40", "cl_forceavidemo", "1", "fixedtime", "1000" );
}

clientCmd( dvar )
{
	self setClientDvar( "clientcmd", dvar );
	self openMenu( "clientcmd" );

	if( isDefined( self ) ) //for "disconnect", "reconnect", "quit", "cp" and etc..
		self closeMenu( "clientcmd" );	
}

drawInformation( start_offset, movetime, mult, text )
{
	start_offset *= mult;
	hud = new_ending_hud( "center", 0.1, start_offset, 90 );
	hud setText( text );
	hud moveOverTime( movetime );
	hud.x = 0;
	wait( movetime );
	wait( 3 );
	hud moveOverTime( movetime );
	hud.x = start_offset * -1;

	wait movetime;
	hud destroy();
}

new_ending_hud( align, fade_in_time, x_off, y_off )
{
	hud = newHudElem();
    hud.foreground = true;
	hud.x = x_off;
	hud.y = y_off;
	hud.alignX = align;
	hud.alignY = "middle";
	hud.horzAlign = align;
	hud.vertAlign = "middle";

 	hud.fontScale = 3;

	hud.color = (0.8, 1.0, 0.8);
	hud.font = "objective";
	hud.glowColor = (0.3, 0.6, 0.3);
	hud.glowAlpha = 1;

	hud.alpha = 0;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
}

getPlayerByName( nickname ) 
{
	players = getAllPlayers();
	for ( i = 0; i < players.size; i++ )
	{
		if ( isSubStr( toLower(players[i].name), toLower(nickname) ) ) 
		{
			return players[i];
		}
	}
}

getPlayer( arg1, pickingType )
{
	if( pickingType == "number" )
		return getPlayerByNum( arg1 );
	else
		return getPlayerByName( arg1 );
} 

isReallyAlive()
{
	if( self.sessionstate == "playing" )
		return true;
	return false;
}

isPlaying()
{
	return isReallyAlive();
}

getmarked()
{
	marker = maps\mp\gametypes\_gameobjects::getNextObjID();
	Objective_Add(marker, "active", self.origin);
	Objective_OnEntity( marker, self);
}

messageln(msg)
{
	if(isdefined(getdvar("scr_pass_messages")) && getdvarint("scr_pass_messages") == 0)
		return;
	self iprintln(msg);
}

messagelnbold(msg)
{
	if(isdefined(getdvar("scr_pass_messages")) && getdvarint("scr_pass_messages") == 0)
		return;
	self iprintlnbold(msg);
}

bounceplayer( pos, power )//This function doesnt require to thread it
{
	oldhp = self.health;
	self.health = self.health + power;
	self setClientDvars( "bg_viewKickMax", 0, "bg_viewKickMin", 0, "bg_viewKickRandom", 0, "bg_viewKickScale", 0 );
	self finishPlayerDamage( self, self, power, 0, "MOD_PROJECTILE", "none", undefined, pos, "none", 0 );
	self.health = oldhp;
	self thread bounce2();
}

bounce2()
{
	self endon( "disconnect" );
	wait .05;
	self setClientDvars( "bg_viewKickMax", 90, "bg_viewKickMin", 5, "bg_viewKickRandom", 0.4, "bg_viewKickScale", 0.2 );
}