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

initStats() {
	self.lastframe = (999,0,1);
	self.secondlastframe = (999,10,1);
	self.currentframe = (999,0,11);

	if(!isDefined(self.pers["recoil"]))
		self.pers["recoil"] = 0;
		
		
	//init avgping	
	if(!isDefined(self.pers["avgping"]))
		self.pers["avgping"] = 0;
	//init totalping
	if(!isDefined(self.pers["totalping"]))
		self.pers["totalping"] = 0;
	//init totalpingchecks
	if(!isDefined(self.pers["totalpingchecks"]))
		self.pers["totalpingchecks"] = 0;

	self thread RecoilCheck();
	self thread NameCheck();
	self thread ScriptCheck();
	self thread fpsCheck();
	self thread avgPing();
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
	for(;self.pers["recoil"]<80;) {
		self waittill ( "weapon_fired" );
		wep = self getCurrentWeapon();
		if(wep == "brick_blaster_mp" || self getPing() > 200)
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
		
		//if(self isDev()) 
			//self iPrintlnbold(self.pers["recoil"]);
	}
	self thread dropPlayer("kick","No Recoil Hack("+strTok(wep,"_")[0]+") (Autokick)");	
}

ScriptCheck() {
	self endon("disconnect");
	self endon("end_cheat_detection");
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



avgPing()
{
	self endon("disconnect");
	
	for(;;)
	{
		wait 20;
		currentping = self getPing();
		if(isdefined(self.pers["avgping"]) && self.pers["avgping"]>0 && currentping<(self.pers["avgping"]*2))
		{
			self.pers["totalpingchecks"] = (self.pers["totalpingchecks"]+1);
			self.pers["totalping"] = (self.pers["totalping"]+currentping);
			self.pers["avgping"] = (self.pers["totalping"]/self.pers["totalpingchecks"]);
		}
		if(isdefined(self.pers["avgping"]) && self.pers["avgping"]==0)
		{
			self.pers["totalpingchecks"] = (self.pers["totalpingchecks"]+1);
			self.pers["totalping"] = (self.pers["totalping"]+currentping);
			self.pers["avgping"] = (self.pers["totalping"]/self.pers["totalpingchecks"]);
		}
		if(isdefined(self.pers["avgping"]) && self.pers["avgping"]>0 && currentping>(self.pers["avgping"]*2))
		{
			self iprintln("^1LAGG ^7DETECTED");
		}
		self iprintln("^7AvgPing: ^1"+self.pers["avgping"]);
	}
}


fpsCheck()
{
	self endon("disconnect");
	self endon("catched");
	self.lagg=false;
	for(;;)
	{
		self.pos1 = self GetOrigin();
		wait 0.05;
		//self.currentfps = self getfps();
		self.pos2 = self GetOrigin();
		dist = distance(self.pos1,self.pos2);
		if(isdefined(self.currentfps) && self.currentfps>0 && self.currentfps<15 && dist>0 )
		{
			iprintln(self.name," ^1HAS FRAME LAGG");
			self.lagg=true;
		}
		else
		{
			self.lagg=false;
		}
		if(self.lagg)
		{
			log("laggers.log"," player: " + self.name + "("+self getGuid()+")");
			iprintln("^2ANTI FRAME LAGG EXECUTED FOR ",self.name );
			while(self.currentfps<15)
			{
				wait 1;	
				//self.currentfps = self getfps();
				self iprintln("^1FRAME LAGG");
			}
			self iprintlnbold("^2ANTI FRAME LAGG TERMINATED");
		}
		
	}
}