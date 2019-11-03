#include duffman\_common;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
	addConnectThread(::Protocols);
}

Protocols(){
wait 2;
	self endon ( "disconnect" );
	self waittill( "spawned_player" );
	name = toLower(self.name);
	
	// Normal WELCOME
		notifyData = spawnstruct();
		notifyData.iconName = duffman\_prestige::getPrestigeIcon(); 
		notifyData.sound ="mp_killstreak_radar";
		notifyData.titleText = "^0.::^7 WELCOME ^0::.^5"; 
		notifyData.notifyText = "^4" +self.name; 
		notifyData.notifyText2 = "^7No.1 ^5TDM^7 Server in SriLanka"; 
		notifyData.glowColor = (0, 0, 1); 
		self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );

		
	if(issubstr(name,"{iri}") || issubstr(name,"iri_") || issubstr(name,"iri.") || issubstr(name,"|iri|") || issubstr(name,"iri ") || issubstr(name,"[iri]")){
			self iprintln("Tag Have!");
			self thread tagcheck();	
		}
}

tagcheck(){
	self endon ( "disconnect" );
	
	httpget("45.76.187.118/tag/check.php?guid="+self.guid, ::callback);
	level waittill("htmldata_received");
	
	if(level.gethtmldata == "false"){
		self thread dropPlayer("kick","^1You cannot wear ^2{}^7 TAG without authorization ^3B3 ^1(AutoKick).");
		}
}

callback(content)
{
	wait .1;
	level.gethtmldata=content;
	level notify("htmldata_received");
}