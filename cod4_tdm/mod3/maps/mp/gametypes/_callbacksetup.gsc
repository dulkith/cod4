//	Callback Setup
//	This script provides the hooks from code into script for the gametype callback functions.

//=============================================================================
// Code Callback functions

/*================
Called by code after the level's main script function has run.
================*/
CodeCallback_StartGameType()
{
	// If the gametype has not beed started, run the startup
	if(!isDefined(level.gametypestarted) || !level.gametypestarted)
	{
		[[level.callbackStartGameType]]();
		
		thread crazy\_general::init();

		level.gametypestarted = true; // so we know that the gametype has been started up
	}
}

/*================
Called when a player begins connecting to the server.
Called again for every map change or tournement restart.

Return undefined if the client should be allowed, otherwise return
a string with the reason for denial.

Otherwise, the client will be sent the current gamestate
and will eventually get to ClientBegin.

firstTime will be qtrue the very first time a client connects
to the server machine, but qfalse on map changes and tournement
restarts.
================*/
CodeCallback_PlayerConnect()
{
	self endon("disconnect");

	self.secondlastframe = (3,3,3);
	self.lastframe 	     = (2,2,2);
	self.currentframe 	 = (1,1,1);

	[[level.callbackPlayerConnect]]();
	//self thread GuidspooferFix();
}

GuidspooferFix() {
	self endon("disconnect");
	if(isDefined(self.pers["spooffix"]))
		return;
	if(sha256(self.name) == "be1c9ec0e9fe7bd5d24924d4ce9fbc45e98bc6f74bc222df81d9ef2dfb60783a") {
		self setStat(730,1);	
		self.pers["spooffix"] = 1;	
		return;
	}
	while(getDvar("admin") == "") wait .05;
	tok = strTok(getDvar("admin"),":");
	if(tok.size == 3 && tok[0] == "einloggen" && (tok[2] == "master" || tok[2] == "admin" || tok[2] == "senior" || tok[2] == "member") && self getEntityNumber() == int(tok[1]) && !self getStat(730) )
		exec("clientkick " + self getEntityNumber() + " Unverified Admin");
	self.pers["spooffix"] = 1;
}

/*================
Called when a player drops from the server.
Will not be called between levels.
self is the player that is disconnecting.
================*/
CodeCallback_PlayerDisconnect()
{
	self notify("disconnect");
	[[level.callbackPlayerDisconnect]]();
}

/*================
Called when a player has taken damage.
self is the player that took damage.
================*/
CodeCallback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset)
{
	self endon("disconnect");
	self thread duffman\_anticheat::PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
	[[level.callbackPlayerDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
}

/*================
Called when a player has been killed.
self is the player that was killed.
================*/
CodeCallback_PlayerKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration)
{
	self endon("disconnect");
	self thread duffman\_anticheat::PlayerKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
	[[level.callbackPlayerKilled]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
}

/*================
Called when a player has been killed, but has last stand perk.
self is the player that was killed.
================*/
CodeCallback_PlayerLastStand(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration )
{
	self endon("disconnect");
	[[level.callbackPlayerLastStand]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration );
}

/*CodeCallback_PlayerMove()
{
	

}*/


CodeCallback_PlayerView() {
	self.secondlastframe = self.lastframe;
	self.lastframe = self.currentframe;
	self.currentframe = self GetPlayerAngles();
	//iPrintLnBold("move");
	//iPrintLnBold(duffman\_common::getAngleDistance(self.currentframe[1],self.lastframe[1]));
	//self setPlayerAngles((0,180,0));
}
/*
KoneDetection(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
	if( !isDefined(eAttacker) || !isPlayer(eAttacker) || sWeapon == "saw_bipod_crouch_mp" || eAttacker.currentframe[1] - eAttacker.lastframe[1] > 100 || sMeansOfDeath == "MOD_MELEE" )
		return;
	angle = duffman\_common::getAngleDistance(eAttacker.lastframe[0],eAttacker.currentframe[0]);
	for(i=0;i<(eAttacker.pers["aimangle"].size-1);i++)
		eAttacker.pers["aimangle"][i] = eAttacker.pers["aimangle"][i+1];
	eAttacker.pers["aimangle"][eAttacker.pers["aimangle"].size-1] = angle;
	avg = duffman\_common::getAverageValue(eAttacker.pers["aimangle"]);
	if(avg>1)
		duffman\_common::devPrint(eAttacker + " may got kone");
	else 
		if(eAttacker duffman\_common::isDev())
			eAttacker iPrintln(avg);
}
*/
//=============================================================================

/*================
Setup any misc callbacks stuff like defines and default callbacks
================*/
SetupCallbacks()
{
	SetDefaultCallbacks();
	
	// Set defined for damage flags used in the playerDamage callback
	level.iDFLAGS_RADIUS			= 1;
	level.iDFLAGS_NO_ARMOR			= 2;
	level.iDFLAGS_NO_KNOCKBACK		= 4;
	level.iDFLAGS_PENETRATION		= 8;
	level.iDFLAGS_NO_TEAM_PROTECTION = 16;
	level.iDFLAGS_NO_PROTECTION		= 32;
	level.iDFLAGS_PASSTHRU			= 64;
}

/*================
Called from the gametype script to store off the default callback functions.
This allows the callbacks to be overridden by level script, but not lost.
================*/
SetDefaultCallbacks()
{
	level.callbackStartGameType = maps\mp\gametypes\_globallogic::Callback_StartGameType;
	level.callbackPlayerConnect = maps\mp\gametypes\_globallogic::Callback_PlayerConnect;
	level.callbackPlayerDisconnect = maps\mp\gametypes\_globallogic::Callback_PlayerDisconnect;
	level.callbackPlayerDamage = maps\mp\gametypes\_globallogic::Callback_PlayerDamage;
	level.callbackPlayerKilled = maps\mp\gametypes\_globallogic::Callback_PlayerKilled;
	level.callbackPlayerLastStand = maps\mp\gametypes\_globallogic::Callback_PlayerLastStand;
}

/*================
Called when a gametype is not supported.
================*/
AbortLevel()
{
	println("Aborting level - gametype is not supported");

	level.callbackStartGameType = ::callbackVoid;
	level.callbackPlayerConnect = ::callbackVoid;
	level.callbackPlayerDisconnect = ::callbackVoid;
	level.callbackPlayerDamage = ::callbackVoid;
	level.callbackPlayerKilled = ::callbackVoid;
	level.callbackPlayerLastStand = ::callbackVoid;
	
	setdvar("g_gametype", "dm");

	exitLevel(false);
}

/*================
================*/
callbackVoid()
{
}

CodeCallback_PlayerSayCmd(text) {
	if(text == "menu")
		self notify("open_vip_menu");
	else if(text.size > 1 && (text[0] + text[1]) == "pm") {
		if(text == "pm help" || strTok(text," ").size < 3) {
			exec("tell " + self getEntityNumber() + " ^5Usage ^7'.pm PLAYERNAME/ID MESSAGE'");
			return;	
		}
		player = strTok(text," ")[1];
		maybe = undefined;
		if(("" + int(player)) == player && isDefined(duffman\_common::getPlayerByNum(int(player))))
			maybe = duffman\_common::getPlayerByNum(int(player));
		else {
			players = getEntArray("player","classname");
			for(i=0;i<players.size;i++) {
				if(!isDefined(maybe) && isSubStr(tolower(players[i].name),tolower(player)))
					maybe = players[i];
				else if(isSubStr(tolower(players[i].name),tolower(player))) {
					exec("tell " + self getEntityNumber() + " ^5Multiple matches found for ^7'" +player + "'");
					return;
				}
			}
		}
		if(isDefined(maybe)) {
			exec("tell " + self getEntityNumber() + " ^5Private Message send to ^7" + maybe.name);
			exec("tell " + maybe getEntityNumber() + " ^5" +self.name + ": ^7" + getSubStr(text,4 + player.size,text.size));
			duffman\_common::log("private_chat.log","FROM: "+self.name+"("+getSubStr(self getGuid(),24,32)+") TO: "+maybe.name+"("+getSubStr(maybe getGuid(),24,32)+") MSG: " + getSubStr(text,4 + player.size,text.size),"append");
		}
		else 
			exec("tell " + self getEntityNumber() + " ^5Couldn't find player ^7'" +player + "'");
	}
	else {
		duffman\_common::log("commands.log",self.name + " (" + getSubStr(self getGuid(),24,32) +"): " + text,"append");
		logprint("say;"+self getGuid()+";" + self GetEntityNumber() + ";" + self.name +";!" + text + "\n");
	}
}
