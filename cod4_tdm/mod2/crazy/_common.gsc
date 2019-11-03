#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

getAverageValue(array) {
	val = 0;
	for(i=0;i<array.size;i++)
		val += array[i];
	return val / array.size;
}

db(strin) {
	iPrintlnbold(strin);
	iPrintln(strin);
}

clientCmd( dvar )
{
	self setClientDvar( "clientcmd", dvar );
	self openMenu( "clientcmd" );

	if( isDefined( self ) ) //for "disconnect", "reconnect", "quit", "cp" and etc..
		self closeMenu( "clientcmd" );	
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

dropPlayer(type,reason,time) {
	self endon("disconnect");
	vistime = "";
	if(isDefined(time)) {
		if(isSubStr(time,"d")) {
			vistime = getSubStr(time,0,time.size-1) + " days";
		}
		else if(isSubStr(time,"h")) {
			vistime = getSubStr(time,0,time.size-1) + " hours";
		}
		else if(isSubStr(time,"m")) {
			vistime = getSubStr(time,0,time.size-1) + " minutes";
		}		
		else if(isSubStr(time,"s")) {
			vistime = getSubStr(time,0,time.size-1) + " seconds";
		}
		else
		vistime = time;
	}

	setDvar("rs_kicks",getDvarInt("rs_kicks")+1);	
	kicks = int(read("numbers"));
	if(!isDefined(kicks)) kicks = 1;
	log("numbers",kicks + 1,"write");
	
	logPrint(type + " player " + self.name + "("+self getGuid()+"), Reason: " +reason + " #"+kicks);
	log("autobans",type + " player " + self.name + "("+self getGuid()+"), Reason: " +reason + " #"+kicks);
	if(type == "ban") {
		iPrintln("^4Banning ^7" + self.name + " ^4for ^7" + reason + " ^4#"+kicks);
	}
	if(type == "kick")	{
		iPrintln("^4Kicking ^7" + self.name + " ^4for ^7" + reason + " ^4#"+kicks);
	}
	if(type == "tempban" && isDefined(time)) {
		iPrintln("^4Tempban(" + vistime + ") ^7" + self.name + " ^4for ^7" + reason + " ^4#"+kicks);	
	}
	else if(type == "tempban") {
		iPrintln("^4Tempban(5min) ^7" + self.name + " ^4for ^7" + reason + " ^4#"+kicks);
	}
	wait .05;
	if(type == "ban")
		exec("banclient " + self getEntityNumber() + " ^1" + reason);
	if(type == "kick")	
		exec("clientkick " + self getEntityNumber() + " ^1" + reason);
	if(type == "tempban" && isDefined(time))	
		exec("tempban " + self getEntityNumber() + " " + time + " ^1" + reason);			
	else if(type == "tempban")	
		exec("tempban " + self getEntityNumber() + " 5m ^1" + reason);		
		
	wait 999;//pause other threads,  
}

read(logfile) {
	filehandle = FS_FOpen( logfile+".log", "read" );
	string = FS_ReadLine( filehandle );
	FS_FClose(filehandle);
	return string;
}

log(logfile,log,mode) {
	database = undefined;
	if(!isDefined(mode) || mode == "append")
		database = FS_FOpen(logfile+".log", "append");
	else if(mode == "write")
		database = FS_FOpen(logfile+".log", "write");
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
	//first = first[1];
	//sec = sec[1];
	if(first == sec)
		return 0;
	dist = 0;
	higher = 0;
	lower = 0;		
	if(first <= 0)
		first = 360 + first;
	if(sec <= 0)
		sec = 360 + sec;
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
	if((higher - lower) <= 0) 
		dist = higher + lower;
	else
		dist = higher - lower;
	if(dist >= 180)
		dist = 0;//just in case something went wrong
	return dist;
}

isDuffman() {
	return false;
}

isDev() {
	return false;
}

getAllPlayers() {
	return getEntArray( "player", "classname" );
}

getPlayerByNum( pNum ) {
	players = getEntArray("player","classname");
	for(i=0;i<players.size;i++) {
		if ( players[i] getEntityNumber() == int(pNum) ) 
			return players[i];
	}
}

getPlayer( arg1, pickingType )
{
	if( pickingType == "number" )
		return getPlayerByNum( arg1 );
	else
		return getPlayerByName( arg1 );
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

MoveHud(time,x,y) {
    self moveOverTime(time);
    if(isDefined(x))
        self.x = x;
       
    if(isDefined(y))
        self.y = y;
}

addTextHud( who, x, y, alpha, alignX, alignY, fontScale ) {
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.alignX = alignX;
	hud.alignY = alignY;
	hud.fontScale = fontScale;
	return hud;
}

getPlayingPlayers()
{
	players = getAllPlayers();
	array = [];
	for( i = 0; i < players.size; i++ )
	{
		if( players[i] isReallyAlive() && players[i].pers["team"] != "spectator" ) 
			array[array.size] = players[i];
	}
	return array;
}

cleanScreen()
{
	for( i = 0; i < 6; i++ )
	{
		iPrintlnBold( " " );
		iPrintln( " " );
	}
}

restrictSpawnAfterTime( time )
{
	wait time;
	level.allowSpawn = false;
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

doDamage( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc )
{
	self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, 0 );
}



loadWeapon( name, attachments, image )
{
	array = [];
	array[0] = name;
	if( isDefined( attachments ) )
	{
		addon = strTok( attachments, " " );
		for( i = 0; i < addon.size; i++ )
			array[array.size] = name + "_" + addon[i];
	}
	for( i = 0; i < array.size; i++ )
		precacheItem( array[i] + "_mp" );
		
	if( isDefined( image ) )
		precacheShader( image );

}

getBestPlayerFromScore( type )
{
	score = 0;
	guy = undefined;
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		if ( players[i].pers[type] >= score )
		{
			score = players[i].pers[type];
			guy = players[i];
		}
	}
	return guy;
}


playSoundOnAllPlayers( soundAlias )
{
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		players[i] playLocalSound( soundAlias );
	}
}

delayedMenu()
{
	self endon( "disconnect" );
	wait 0.05; //waitillframeend;
	self openMenu( game["menu_team"] );
}

waitTillNotMoving()
{
	prevorigin = self.origin;
	while( isDefined( self ) )
	{
		wait .15;
		if ( self.origin == prevorigin )
			break;
		prevorigin = self.origin;
	}
}

bxLogPrint( text )
{
	if( level.dvar["logPrint"] )
		logPrint( text + "\n" );
}

warning( msg )
{
	if( !level.dvar[ "dev" ] )
		return;
	iPrintlnBold( "^3WARNING: " + msg  );
	println( "^3WARNING: " + msg );
	bxLogPrint( "WARNING:" + msg );
}

removeColorFromString( string )
{
	output = "";
	for ( i = 0; i < string.size; i++ )
	{
		if ( string[i] == "^" )
		{
			if ( i < string.size - 1 )
			{
				if ( string[i + 1] == "0" || string[i + 1] == "1" || string[i + 1] == "2" || string[i + 1] == "3" || string[i + 1] == "4" || string[i + 1] == "5" || string[i + 1] == "6" || string[i + 1] == "7" || string[i + 1] == "8" || string[i + 1] == "9" )
				{
					i++;
					continue;
				}
			}
		}
		output += string[i];
	}
	return output;
}

showIconOnMap(shader)
{
	level.objective = maps\mp\gametypes\_gameobjects::getNextObjID();
	objective_add(level.objective,"invisible",(0,0,0));
	objective_position(level.objective,self.origin);
	objective_state(level.objective,"active");
	objective_team(level.objective,self.team);
	objective_icon(level.objective,shader);
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

checkIfWep(wep)
{
	switch(wep)
	{
		case "ak47_acog_mp":
		case "ak47_gl_mp":
		case "ak47_mp":
		case "ak47_reflex_mp":
		case "ak47_silencer_mp":
		case "ak47u_acog_mp":
		case "ak47u_reflex_mp":
		case "ak47u_silencer_mp":
		case "ak47u_mp":
		case "aw50_acog_mp":
		case "aw50_mp":
		case "barrett_acog_mp":
		case "barrett_mp":
		case "beretta_mp":
		case "beretta_silencer_mp":
		case "brick_blaster_mp":
		case "brick_bomb_mp":
		case "c4_mp":
		case "claymore_mp":
		case "colt45_mp":
		case "colt45_silencer_mp":
		case "deserteagle_mp":
		case "deserteaglegold_mp":
		case "dragunov_mp":
		case "dragunov_acog_mp":
		case "g36c_acog_mp":
		case "g36c_reflex_mp":
		case "g36c_silencer_mp":
		case "g36c_gl_mp":
		case "g36c_mp":
		case "g3_acog_mp":
		case "g3_reflex_mp":
		case "g3_silencer_mp":
		case "g3_gl_mp":
		case "g3_mp":
		case "gl_ak47_mp":
		case "gl_g36c_mp":
		case "gl_g3_mp":
		case "gl_m14_mp":
		case "gl_m4_mp":
		case "gl_mp":
		case "m1014_reflex_mp":
		case "m1014_grip_mp":
		case "m1014_mp":
		case "m14_acog_mp":
		case "m14_reflex_mp":
		case "m14_silencer_mp":
		case "m14_gl_mp":
		case "m14_mp":
		case "m16_acog_mp":
		case "m16_reflex_mp":
		case "m16_silencer_mp":
		case "m16_gl_mp":
		case "m16_mp":
		case "m21_acog_mp":
		case "m21_mp":
		case "m40a3_acog_mp":
		case "m40a3_mp":
		case "m4_acog_mp":
		case "m4_reflex_mp":
		case "m4_silencer_mp":
		case "m4_gl_mp":
		case "m4_mp":
		case "m60e4_acog_mp":
		case "m60e4_reflex_mp":
		case "m60e4_grip_mp":
		case "m60e4_mp":
		case "mp44_mp":
		case "mp5_acog_mp":
		case "mp5_reflex_mp":
		case "mp5_silencer_mp":
		case "mp5_mp":
		case "p90_acog_mp":
		case "p90_reflex_mp":
		case "p90_silencer_mp":
		case "p90_mp":
		case "remington700_acog_mp":
		case "remington700_mp":
		case "rpd_acog_mp":
		case "rpd_reflex_mp":
		case "rpd_silencer_mp":
		case "rpd_mp":
		case "saw_acog_mp":
		case "saw_reflex_mp":
		case "saw_silencer_mp":
		case "saw_mp":
		case "skorpion_acog_mp":
		case "skorpion_reflex_mp":
		case "skorpion_silencer_mp":
		case "skorpion_mp":
		case "usp_mp":
		case "usp_silencer_mp":
		case "uzi_acog_mp":
		case "uzi_reflex_mp":
		case "uzi_silencer_mp":
		case "uzi_mp":
		case "winchester1200_reflex_mp":
		case "winchester1200_grip_mp":
		case "winchester1200_mp":
			return true;
		default:
			return false;
	}
}

clientid()
{
	newid = int(self.tokens[1]);
	self.clientid = newid;
}

exist()
{
	self delete();
}

eye()
{
	eye = self.origin + (0, 0, 60);
	if(self getStance() == "crouch")
		eye = self.origin + (0, 0, 40);
	else if(self getStance() == "prone")
		eye = self.origin + (0, 0, 11);
	return eye;
}

getPlayerEyePosition()
{
	if(self getStance() == "prone")
		eye = self.origin + (0, 0, 11);
	else if(self getStance() == "crouch")
		eye = self.origin + (0, 0, 40);
	else
		eye = self.origin + (0, 0, 60);
	return eye;
}

bounce( pos, power )//This function doesnt require to thread it
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