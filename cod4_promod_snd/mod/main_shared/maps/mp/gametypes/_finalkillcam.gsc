#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_endroundmusic;

finalKillcamWaiter()
{
	if ( !level.inFinalKillcam )
		return;
		
	while (level.inFinalKillcam)
		wait(0.05);
}

postRoundFinalKillcam()
{
	level notify( "play_final_killcam" );
	//thread partymode(); 

	if(game["roundsplayed"] != 1){
    		level notify( "play_final_killcam" );
 
    		song = (0+ game["roundsplayed"]-1);
		   
    		if(game["roundsplayed"] >= 22){
    	    		song = (1+randomInt(20));
    		}
    	  
    		level thread playSoundOnAllPlayers( "endround" + song );
    		level thread displaysName_hud( "endround" + song );
    	}  

/*	
	song = (1+randomInt(20));
	if(game["roundsplayed"] != 1){
		level thread playSoundOnAllPlayers( "endround" + song );
		level thread displaysName_hud( "endround" + song );
	}
*/
	maps\mp\gametypes\_globallogic_utils::resetOutcomeForAllPlayers();
	finalKillcamWaiter();	
}

startFinalKillcam( 
	attackerNum,
	targetNum,
	killcamentityindex,
	sWeapon,
	deathTime,
	deathTimeOffset,
	offsetTime, 
	attacker,
	victim
)
{
	if(attackerNum < 0)
		return;
	recordKillcamSettings( attackerNum, targetNum, sWeapon, deathTime, deathTimeOffset, offsetTime, attacker, killcamentityindex, victim );
	startLastKillcam();
}

startLastKillcam()
{
	if ( level.inFinalKillcam )
		return;

	if ( !isDefined(level.lastKillCam) )
		return;
	
	level.inFinalKillcam = true;
	level waittill ( "play_final_killcam" );

	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		player closeMenu(); 
		player closeInGameMenu();
		player thread finalKillcam();
	}
	
	wait( 0.1 );

	while ( areAnyPlayersWatchingTheKillcam() )
		wait( 0.05 );

	level.inFinalKillcam = false;
}


areAnyPlayersWatchingTheKillcam()
{
	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		if ( isDefined( player.killcam ) )
			return true;
	}
	
	return false;
}

waitKillcamTime()
{
	self endon("disconnect");
	self endon("end_finalkillcam");

	wait(self.killcamlength - 0.07);
	self notify("end_finalkillcam");
}

displaysName_hud( song ){
players = level.players;
for ( index = 0; index < players.size; index++ ){
		player = players[index];
		player thread displayone(song);

	}
}

//Function is Developed by Duka

displayone( song ) { 
	notifyData = spawnstruct();
	self setClientDvar( "last_play", getS_name(song) ); // set track name
	notifyData.songName = createFontString( "default", level.lowerTextFontSize );
	notifyData.songName setPoint( "CENTER", "BOTTOM", 0, -105 );  
	notifyData.songName.archived = false;
	notifyData.songName setText( "Song Name : "+ getS_name(song));
	notifyData.songName.alpha = 0;
	notifyData.songName.glowalpha = 3;
	notifyData.songName.glowColor = (0.2,0.6,1);
	notifyData.songName fadeOverTime( 4 );
	notifyData.songName.fontscale = 1.7;
	
	notifyData.songName fadeOverTime( 4 );
	notifyData.songName.alpha = 1;
	wait 6;
	notifyData.songName fadeOverTime( 0.50 );
	notifyData.songName.alpha = 0;
	wait 0.5;
	notifyData.songName destroy();

}

getS_name(song)
{
	switch( song )
	{

		case "endround1":
			return "Tiesto - Seavolution From Hotel Transylvania 3"; //
			
		case "endround2":
			return "J Balvin, Willy William - Mi Gente";
			
		case "endround3":
			return "Numb - Linkin Park";
			
		case "endround4":
			return "Pitbull - Feel This Moment ft. Christina Aguilera";
			
		case "endround5": 
			return "DJ Snake - Taki Taki ft. Selena Gomez, Ozuna, Cardi B"; //

		case "endround6":
			return "Udalla Deepan Song"; //

		case "endround7":
			return "Alan Walker - Alone";

		case "endround8":
			return "Marshmello - Alone (Official Music Video)";
			
		case "endround9":
			return "Unknown";
			
		case "endround10":
			return "Pitbull - Fireball ft. John Ryan";
			
		case "endround11":
			return "Unknown";
			
		case "endround12":
			return "Legends Never Die [Alan Walker Remix]"; //
			
		case "endround13": 
			return "SKRILLEX - Bangarang feat. Sirah"; //

		case "endround14":
			return "Dimitri Vegas, Martin Garrix, Like Mike - Tremor";

		case "endround15":
			return "DJ Snake - Magenta Riddim"; //

		case "endround16":
			return "Flo Rida ft. Sage The Gemini & Lookas - GDRF";
			
		case "endround17":
			return "ZAYN - Dusk Till Dawn (Official Video) ft. Sia";
			
		case "endround18":
			return "Unknown";
		
		case "endround19":
			return "Marshmello - Alone"; //
			
		case "endround20":
			return "Alan Walker - Faded"; //
			
		case "endround21":
			return "Unknown";
		
		case "endround22":
			return "Unknown";
			
		case "endround23":
			return "Unknown";

		case "endround24":
			return "Unknown";	
						
		case "endround25":
			return "Unknown";
			
		default:
			return "";
	}
}

waitFinalKillcamSlowdown( startTime )
{
	self endon("disconnect");
	self endon("end_finalkillcam");
	secondsUntilDeath = ( ( level.lastKillCam.deathTime - startTime ) / 1000 );
	deathTime = getTime() + secondsUntilDeath * 1000;
	waitBeforeDeath = 2;
	wait( max(0, (secondsUntilDeath - waitBeforeDeath) ) );
	setTimeScale( 1, int( deathTime - 500 ));
	wait( waitBeforeDeath );
	setTimeScale(1,getTime());
}
setTimeScale(to,time)
{
	difference = (abs(getTime() - time)/1000);
	timescale = getDvarFloat("timescale");
	if(difference != 0) 
	{
		for(i = timescale*20; i >= to*20; i -= 1 )
		{
			wait ((int(difference)/int(getDvarFloat("timescale")*20))/20);
			setDvar("timescale",i/20);
		} 
	}
	else
	setDvar("timescale",to);
}
endKillcam()
{
	if(isDefined(self.fkc_timer))
		self.fkc_timer.alpha = 0;
		
	if(isDefined(self.killertext))
	self.killertext.alpha = 0;
			
	self.killcam = undefined;
	
}

checkForAbruptKillcamEnd()
{
	self endon("disconnect");
	self endon("end_finalkillcam");
	
	while(1)
	{
		if ( self.archivetime <= 0 )
			break;
		wait .05;
	}
	
	self notify("end_finalkillcam");
}
checkPlayers()
{
	self endon("disconnect");
	self endon("end_finalkillcam");
	
	while(1)
	{
		if(! isDefined(maps\mp\gametypes\_globallogic::getPlayerFromClientNum(level.lastKillCam.spectatorclient)) )
			break;
		wait 0.05;
	}
	self notify("end_finalkillcam");
}
recordKillcamSettings( spectatorclient, targetentityindex, sWeapon, deathTime, deathTimeOffset, offsettime, attacker, entityindex, victim )
{
	if ( ! isDefined(level.lastKillCam) )
		level.lastKillCam = spawnStruct();
	
	level.lastKillCam.spectatorclient = spectatorclient;
	level.lastKillCam.weapon = sWeapon;
	level.lastKillCam.deathTime = deathTime;
	level.lastKillCam.deathTimeOffset = deathTimeOffset;
	level.lastKillCam.offsettime = offsettime;
	level.lastKillCam.targetentityindex = targetentityindex;
	level.lastKillCam.attacker = attacker;
	level.lastKillCam.entityindex = entityindex;
	level.lastKillCam.victim = victim;
}

finalKillcam()
{
	self endon("disconnect");
	level endon("game_ended");
	
	self notify( "end_killcam" );

	self setClientDvar("cg_airstrikeKillCamDist", 20);
	
	postDeathDelay = (getTime() - level.lastKillCam.deathTime) / 1000;
	predelay = postDeathDelay + level.lastKillCam.deathTimeOffset;

	camtime = calcKillcamTime( level.lastKillCam.weapon, predelay, false, undefined );
	postdelay = calcPostDelay();

	killcamoffset = camtime + predelay;
	killcamlength = camtime + postdelay - 0.05;

	killcamstarttime = (gettime() - killcamoffset * 1000);

	self notify ( "begin_killcam", getTime() );

	self.sessionstate = "spectator";
	self.spectatorclient = level.lastKillCam.spectatorclient;
	self.killcamentity = -1;
	if ( level.lastKillCam.entityindex >= 0 )
		self thread setKillCamEntity( level.lastKillCam.entityindex, 0 - killcamstarttime - 100 );
	self.killcamtargetentity = level.lastKillCam.targetentityindex;
	self.archivetime = killcamoffset;
	self.killcamlength = killcamlength;
	self.psoffsettime = level.lastKillCam.offsettime;

	self allowSpectateTeam("allies", true);
	self allowSpectateTeam("axis", true);
	self allowSpectateTeam("freelook", false);
	self allowSpectateTeam("none", false);

	wait 0.05;

	if ( self.archivetime <= predelay )
	{
		self.sessionstate = "dead";
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;

		self notify ( "end_finalkillcam" );
		
		return;
	}
	
	self thread checkForAbruptKillcamEnd();
	self thread checkPlayers();

	self.killcam = true;

	self addKillcamTimer(camtime);
	self addKillcamKiller(level.lastKillCam.attacker,level.lastKillCam.victim);
	
	level thread AutoTeamsBalancer(); // Auto team balancer
	
	self thread waitKillcamTime();
	self thread waitFinalKillcamSlowdown( killcamstarttime );

	self waittill("end_finalkillcam");
	
	self.villain destroy();
	self.versus destroy();
	self.victim destroy();

	self endKillcam();
}

isKillcamGrenadeWeapon( sWeapon )
{
	if (sWeapon == "frag_grenade_mp")
		return true;
		
	else if (sWeapon == "frag_grenade_short_mp"  )
		return true;
	
	return false;
}
calcKillcamTime( sWeapon, predelay, respawn, maxtime )
{
	camtime = 0.0;
	
	if ( isKillcamGrenadeWeapon( sWeapon ) )
	{
		camtime = 4.25; 
	}
	else
		camtime = 5;
	
	if (isdefined(maxtime)) {
		if (camtime > maxtime)
			camtime = maxtime;
		if (camtime < .05)
			camtime = .05;
	}
	
	return camtime;
}

calcPostDelay()
{
	postdelay = 0;
	
		// time after player death that killcam continues for
	if (getDvar( "scr_killcam_posttime") == "")
		postdelay = 2;
		
	else 
	{
		postdelay = getDvarFloat( "scr_killcam_posttime");
		if (postdelay < 0.05)
			postdelay = 0.05;
	}
	
	return postdelay;
}
addKillcamKiller(attacker,victim)
{
	self.villain = createFontString( "default", level.lowerTextFontSize );
	self.villain setPoint( "CENTER", "BOTTOM", -500, -127 ); 
	self.villain.alignX = "right";
	self.villain.archived = false;
	self.villain setPlayerNameString( attacker );
	self.villain.alpha = 1;
	self.villain.glowalpha = 2;
	self.villain.glowColor = (1,0,0.1);
	self.villain moveOverTime( 4 );
	self.villain.x = -20;  

	self.versus = createFontString( "default", level.lowerTextFontSize );
	self.versus.alpha = 0;
	self.versus setPoint( "CENTER", "BOTTOM", 0, -127 );  
	self.versus.archived = false;
	self.versus setText( "vs" );
	self.versus.glowColor = level.randomcolour;
	self.versus fadeOverTime( 4 );
	self.versus.alpha = 1;
  
	self.victim = createFontString( "default", level.lowerTextFontSize );
	self.victim setPoint( "CENTER", "BOTTOM", 500, -127 );
	self.victim.alignX = "left";  
	self.victim.archived = false;
	self.victim setPlayerNameString( victim );
	self.victim.glowalpha = 2; 
	self.victim.glowColor = (0,0.9,0.5);
	self.victim moveOverTime( 4 );
	self.victim.x = 20; 
	
	if ( isDefined( self.carryIcon ) )
		self.carryIcon destroy();
}
addKillcamTimer(camtime)
{
	if (! isDefined(self.fkc_timer))
	{
			self.fkc_timer = createFontString("big", 2.0);
			self.fkc_timer.archived = false;
			self.fkc_timer.x = 0;
			self.fkc_timer.alignX = "center";
			self.fkc_timer.alignY = "middle";
			self.fkc_timer.horzAlign = "center_safearea";
			self.fkc_timer.vertAlign = "top";
			self.fkc_timer.y = 55;
			self.fkc_timer.sort = 1;
			self.fkc_timer.font = "big";
			self.fkc_timer.foreground = true;
			self.fkc_timer.color = (0.9,0,0.2);
			self.fkc_timer.hideWhenInMenu = true;
	}
	self.fkc_timer.y = 50;
	self.fkc_timer.alpha = 1;
	self.fkc_timer setTenthsTimer(camtime);
}
setKillCamEntity( killcamentityindex, delayms )
{
	self endon("disconnect");
	self endon("end_killcam");
	self endon("spawned");
	
	if ( delayms > 0 )
		wait delayms / 1000;
	
	self.killcamentity = killcamentityindex;
}

/////// Auto Team Balancer ///////////


getTeamPlayers(team) {
   result = [];
   players = level.players;
   for(i = 0; i < players.size; i++) {
       if (isDefined(players[i]) && players[i].pers["team"] == team){
           result[result.size] = players[i];
       }
   }
   return result;
}

getLowScorePlayers(team, nPlayers) {
   result = [];
   if (team.size > 0 && nPlayers > 0 && team.size >= nPlayers) {
       //Sorting team by score (bubble sort algorithm @TODO optimize)
       for (x = 0; x < team.size; x++) {
           for (y = 0; y < team.size - 1; y++) {
               if (isDefined(team[y]) && isDefined(team[y+1]) && team[y].pers["score"] > team[y+1].pers["score"]) {
                   temp = team[y+1];
                   team[y+1] = team[y];
                   team[y] = temp;
               }
           }
       }
       for (i = 0; i < nPlayers; i++) {
           if (isDefined(team[i])) {
               result[i] = team[i];
           }
       }
   }
   return result;
}

AutoTeamsBalancer() {
   if(level.gametype == "dm")
       return;
   pl_change_team = [];
   changeteam = "";
   offset = 0;

       if (isDefined(game["state"]) && game["state"] == "playing" || game["state"] == "postgame") {
           pl_change_team = [];
           changeteam = "";
           offset = 0;
           team["axis"] = getTeamPlayers("axis");
           team["allies"] = getTeamPlayers("allies");
           if(team["axis"].size == team["allies"].size)
               return;
           
           if(team["axis"].size < team["allies"].size) {
               changeteam = "axis";
               offset = team["allies"].size - team["axis"].size;
           }
           else {
               changeteam = "allies";
               offset = team["axis"].size - team["allies"].size;
           }
           if (offset < 2)
               return;
           //iPrintlnbold("^7Teams will be balanced in 5 sec...");
           //wait 5;
           if (isDefined(game["state"]) && game["state"] == "playing" || game["state"] == "postgame") {
               team["axis"] = getTeamPlayers("axis");
               team["allies"] = getTeamPlayers("allies");
               if(team["axis"].size == team["allies"].size) {
                   iPrintln("^7AutoBalance aborted: teams are already balanced!");
                   return;
               }
               if(team["axis"].size < team["allies"].size) {
                   changeteam = "axis";
                   offset = team["allies"].size - team["axis"].size;
               }
               else {
                   changeteam = "allies";
                   offset = team["axis"].size - team["allies"].size;
               }
               if (offset < 2) {
                   iPrintln("^7AutoBalance aborted: teams are already balanced!");
                   return;
               }
               offset = offset / 2;
               pl_to_add = int(offset) - (int(offset) > offset);
               pl_change_team = [];
               bigger_team = [];
               if (changeteam == "allies"){
                   bigger_team = team["axis"];
               }
               else {
                   bigger_team = team["allies"];
               }
               pl_change_team = getLowScorePlayers(bigger_team, pl_to_add);
               for(i = 0; i < pl_change_team.size; i++) {
                   if(changeteam == "axis")
                       pl_change_team[i] [[level.axis]]();
                   else 
                       pl_change_team[i] [[level.allies]]();
               }
               iPrintln("^7Teams were auto balanced!");
               iPrintlnbold("^7Teams were balanced!");
           }
       }
}