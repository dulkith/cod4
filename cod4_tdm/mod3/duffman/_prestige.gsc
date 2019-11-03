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
	level.prestigeicons[1] = "rank_prestige2";
	level.prestigeicons[2] = "rank_prestige3";
	level.prestigeicons[3] = "rank_prestige4";
	level.prestigeicons[4] = "rank_prestige5";
	level.prestigeicons[5] = "rank_prestige8";
	level.prestigeicons[6] = "rank_prestige9";
	level.prestigeicons[7] = "rank_prestige10";

	for(i=1;i<level.prestigeicons.size+1;i++)
		precacheStatusIcon(level.prestigeicons[i]);
	for(i=1;i<level.prestigeicons.size+1;i++)
		PreCacheShader(level.prestigeicons[i]);

	addConnectThread(::PrestigeSettings);
}

PrestigeSettings() {
	self thread Prestige();
	self thread PrestigeAdvantages();
	if(!isDefined(self.pers["laser"]))
		self.pers["laser"] = self duffman\_common::getCvarInt("reflex_laser");
}

ToggleLaser()
{
	if(self getStat(634) >= 3)
	{
		if(!self.pers["laser"]) {
			self duffman\_common::setCvar("reflex_laser",1);
			self iPrintBig("Laser reflex On");
			self.pers["laser"] = 1;
		}
		else {
			self duffman\_common::setCvar("reflex_laser",0);
			self iPrintBig("Laser reflex Off");
			self.pers["laser"] = 0;
		}
	}
	else
		self iPrintBig("PRESTIGE_UNLOCK","LEVEL",3,"FEATURE","LASER");
}
ToggleThermal()
{
	if(self getStat(634) >= 2)
	{
		if(self.pers["thermal"] == 0)
		{
			self iPrintln( "You ^7 Turned Thermal ^7[^3ON^7]" );
			self crazy\visions::Thermal();
			self setstat(1422,1);
			self.pers["thermal"] = 1;
		}
		else if(self.pers["thermal"] == 1)
		{
			self iPrintln( "You ^7 Turned Thermal ^7[^3OFF^7]" );
			self crazy\visions::Default();
			self setstat(1422,0);
			self.pers["thermal"] = 0;
		}
	}
	else
		self iPrintBig("PRESTIGE_UNLOCK","LEVEL",2,"FEATURE","THERMAL");
}

PrestigeAdvantages() {
	self endon("disconnect");
	wait .05;
	while(1) {
		if(!self.pers["forceLaser"] && self.pers["laser"] && self.sessionstate == "playing") {
			if(isSubStr(self GetCurrentWeapon(), "reflex"))
				self setClientDvar("cg_laserforceon",1);
			else
				self setClientDvar("cg_laserforceon",0);
		}
		self waittill("weapon_change");
	}
}

Prestige() {
	self endon("disconnect");
	wait .05;
	while(self.pers["rank"] < 54 || self getStat(634) == 0) wait 5;
	if(self getStat(634) > 7) // ** Bugfix 
		self setStat(634,7);
	self thread StatusIcon();
	if(self.pers["rank"] == 54 && self getStat(634) == 7 && self getStat(635) == 255) 
		return;
	self thread GiveXpforKill();
}

StatusIcon() {
	self endon("disconnect");
	self setRank(int(self getStat(635)/255*54),0);
	for(;;) {
		if(!isDefined(self) || !isDefined(self.statusicon) || self getStat(635) == 0)
			return;
		rank = int(self getStat(635)/255*54);
		if(isDefined(self.statusicon) && self.statusicon == "") {
			self.statusicon = self getPrestigeIcon();
		}
		self common_scripts\utility::waittill_any("disconnect","update_score","spawned_player");
		waittillframeend;
		if(int(self getStat(635)/255*54) != rank) {
			self setRank(rank,0);
			self thread maps\mp\gametypes\_rank::updateRankAnnounceHUD();
		}
	}
}

GiveXpforKill() {
	self endon("disconnect");
	
	for(;;) {
		self waittill( "update_score" );
		wait .05;
		self waittill( "update_score" );
		wait .05;
		//jmd gekillt
		prestigexp = self getStat(635);
		if(prestigexp != 255) {
			self setStat(635,prestigexp+1);
		}
	}
}

LevelUp()
{
	prestigexp = self getStat(635);
	prestigelv = self getStat(634);
	if(prestigelv > 7)
	{
		self iPrintBig("MAX_PRESTIGE");
		return;
	}
	else if(self.pers["rank"] != 54)
		self iPrintBig("NOT_REACHED_LVL");
	else if(prestigexp == 255 || prestigelv == 0)
	{
		self setStat(634,prestigelv+1);
		self setStat(635,0);
		notifyData = spawnStruct();
		notifyData.titleText = &"RANK_PROMOTED";
		notifyData.iconName = self getPrestigeIcon();
		notifyData.sound = "mp_level_up";
		notifyData.duration = 4.0;
		rankname = "";
		name = "";
		switch(prestigelv)
		{
			case 1:
				rankname = "Youre still not done";
				name = "1st";
				break;
			case 2:
				rankname = "Getting better and better";
				name = "2nd";
				break;
			case 3:
				rankname = "Youre da pro";
				name = "3rd";
				break;
			case 4:
				rankname = "You are really good";
				name = "4th";
				break;
			case 5:
				rankname = "Keep it up, just 1 level left";
				name = "5th";
				break;
			case 6:
				rankname = "!!!! HAXOR !!!!";
				name = "6th";
				break;	
			case 7:
				rankname = "Greetz, youre finally the best";
				name = "7th";
				break;
		}
		thread duffman\_iprint::streakMsg(self.name + " reached the " + name + " prestige level!");
		notifyData.notifyText = rankname;
		self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
		self.statusicon = self getPrestigeIcon();
		self setRank(int(self getStat(635)/255*54),0);
	}
	else
		self iPrintBig("PRESTIGE_KILLS_LEFT","KILLS",(255-prestigexp)*2);
}

getPrestigeIcon() {
	return level.prestigeicons[self getStat(634)];
}