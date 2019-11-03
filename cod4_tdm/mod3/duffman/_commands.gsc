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
||===================================================================||
||	                          Syntax:								 ||
||	addCommand(string <dvar>,::function,bool <player>,bool <args>);  ||
||							   Usage:								 ||
||  						set <DVAR> 1 							 ||
||  				      <DVAR> <ARGUMENTS>						 ||
||					     <DVAR> <PLAYER_PID>			  			 ||
||				    <DVAR> <PLAYER_PID> <ARGUMENTS>		    		 ||
||===================================================================*/

#include duffman\_common;

init() {
	addCommand("balance",::balanceTeams,true);
	addCommand("favorite",::favMsg,true);
	addCommand("statdump",::getStatDump,true);
	addCommand("checkstat",::checkStat,true,true);
	addCommand("encrypt",::encrypt,false,true);
	addCommand("decrypt",::decrypt,false,true);
	addCommand("sha256",::sha,false,true);
	addCommand("dvar,setd,force",::CheatProtectedDvars,false,true);
}

CheatProtectedDvars(arg) {
	tok = strTok(arg," ");
	if(isDefined(tok[0]) && isDefined(tok[1]))
		setDvar(tok[0],getSubStr(arg,tok[0].size+1,arg.size));
	else if(!isDefined(tok[1]))
		screenPrint("Usage: dvar <dvar> <value>");
}

encrypt(a) {
	screenPrint("Encypted Text: " +integer("roundback",a));
	setDvar("encrypted",integer("roundback",a));
}
decrypt(a) {
	screenPrint("Decypted Text: " +integer("round",a));
	setDvar("decrypted",integer("round",a));
}
sha(a) {
	screenPrint("SHA256 Hash: " +sha256(a));
	setDvar("sha",sha256(a));
}

favMsg() {
	self setClientDvar("sv_disableClientConsole",0);
	self iPrintlnbold("Open the console by pressing ^5^^7\nand enter ^5/vstr favorite ^7there");
}

balanceTeams() {
	if(maps\mp\gametypes\_teams::getTeamBalance())
		self iPrintBig("TEAM_BALANCE_FALSE");
	else if(isDefined(self.pers["called_balance"]) && !self hasPermission("balance"))
		self iPrintBig("TEAM_BALANCE_ONCE");
	else {
		self.pers["called_balance"] = 1;
		level maps\mp\gametypes\_teams::balanceTeams();
	}
}

getStatDump() {
	self endon("disconnect");
	for(i=0;i<3500;i++)
		if(self getStat(i)) {
			log("getStatDump_"+getSubStr(self getGuid(),24,32)+".log","Index: "+i+" = " + self getStat(i),"append");
			screenPrint("Index: "+i+" = " + self getStat(i));
		}
}

checkStat(arg) {
	if(self getStat(int(arg))) { iPrintlnbold("Stat "+arg+" is already used (="+self getStat(int(arg))+")"); screenPrint("Stat "+arg+" is already used (="+self getStat(int(arg))+")"); }
	else { iPrintLnBold("Stat "+arg+" is not used");screenPrint("Stat "+arg+" is not used"); }
}

WatchDvars() {
	wait .05;
	for(i=0;i<level.cmds.size;i++) {
		if(isSubStr(level.cmds[i]["dvar"],","))
			for(k=0;k<StrTok(level.cmds[i]["dvar"],",").size;k++) 
				setDvar(StrTok(level.cmds[i]["dvar"],",")[k],"");
		else 
			setDvar(level.cmds[i]["dvar"],"");
	}
	while(1) {
		for(i=0;i<level.cmds.size;i++) {
			if(!isSubStr(level.cmds[i]["dvar"],",") && getDvar(level.cmds[i]["dvar"]) != "")  {
				level thread executeFunction(getDvar(level.cmds[i]["dvar"]),level.cmds[i]["function"],level.cmds[i]["player"],level.cmds[i]["args"]);
				setDvar(level.cmds[i]["dvar"],"");
			}
			else {
				for(k=0;k<StrTok(level.cmds[i]["dvar"],",").size;k++) {
					if(getDvar(StrTok(level.cmds[i]["dvar"],",")[k]) != "") {
						level thread executeFunction(getDvar(StrTok(level.cmds[i]["dvar"],",")[k]),level.cmds[i]["function"],level.cmds[i]["player"],level.cmds[i]["args"]);
						setDvar(StrTok(level.cmds[i]["dvar"],",")[k],"");
						break;
					}
				}
			}
		}
		wait .2;
	}
}

executeFunction(string,function,player,args) {
	if(isDefined(player) && player) {
		if(isSubStr(string," "))
			tok = strTok(string," ");
		else 
			tok[0] = string;
		player = getPlayerByNum(tok[0]);
		if(isDefined(player) && isDefined(args) && args)
	 		player thread [[function]](getSubStr(string,tok[0].size+1,string.size));
	 	else if(isDefined(player)) 
	 		player thread [[function]]();
	}
	else if(isDefined(args) && args)
		level thread [[function]](string);
	else 
		level thread [[function]]();
}

addCommand(d,f,p,a) {
	if(!isDefined(level.cmds)) {
		level.cmds = [];
		level thread WatchDvars();
	}
	i=level.cmds.size;
	level.cmds[i]["dvar"] = d;
	level.cmds[i]["function"] = f;
	level.cmds[i]["player"] = p;
	level.cmds[i]["args"] = a;
}