#include duffman\_common;

init()
{
	if(getentarray("player", "classname").size < 6)
		setDvar( "sv_maprotation", "gametype sd map mp_backlot gametype sd map mp_citystreets gametype sd map mp_crash gametype sd map mp_crossfire gametype sd map mp_strike gametype sd map mp_nuketown" );
		
	level.windowheight = 180;
	level.windowwidth  = 500;
	level.borderwidth  = 20;
	level.maps4vote    = 6;
	level.endmap_weapon_falldown = array("ak74u_mp","p90_mp","mp44_mp","saw_mp","m40a3_mp","deserteaglegold_mp","remington700_mp","uzi_mp","m60e4_mp","mp5_mp");
	maprotation = strTok(getDvar("sv_maprotation")," ");
	level.voteablemaps = [];
	tryes = 0;
	i = 0;
	while(level.voteablemaps.size < level.maps4vote && tryes < 100) {
		tryes++;
		i = randomint(maprotation.size);
		while(maprotation[i] != "gametype")
			i = randomint(maprotation.size);
		i+=2;
		if((i+1)<maprotation.size && maprotation[i] == "map" && isLegal(maprotation[i+1] + ";" + maprotation[i-1]))
			level.voteablemaps[level.voteablemaps.size] = maprotation[i+1] + ";" + maprotation[i-1];
	}

	level.mapvote = true;
	level notify("mapvote");

	thread FallDownWeapon();

	arraymaps = level.voteablemaps;

	//center
	hud[0] = addTextHud( level, 0, 0, .6, "center", "middle", "center", "middle", 0, 100 );
	hud[0] setShader("white",level.windowwidth,level.windowheight);
	hud[0].color = (0,0,0);
	hud[0] thread fadeIn(.3);
	//left
	hud[1] = addTextHud( level, level.windowwidth/-2, 0, .6, "right", "middle", "center", "middle", 0, 100 );
	hud[1] setShader("gradient_fadein",level.borderwidth,level.windowheight);
	hud[1].color = (0,0,0);
	hud[1] thread fadeIn(.3);
	//right
	hud[2] = addTextHud( level, level.windowwidth/2, 0, .6, "left", "middle", "center", "middle", 0, 100 );
	hud[2] setShader("gradient",level.borderwidth,level.windowheight);
	hud[2].color = (0,0,0);
	hud[2] thread fadeIn(.3);
	//text
	hud[3] = addTextHud( level, 0, level.windowheight/-2-8, 1, "center", "bottom", "center", "middle", 2.2, 102 );
	hud[3] setText("^3SL^1e^3SPORT ^2Promod Mapvote System");
	hud[3] thread fadeIn(.3);
	//timer
	hud[4] = addTextHud( level, level.windowwidth/2 - 20, level.windowheight/-2-8, 1, "center", "bottom", "center", "middle", 2.2, 102 );
	hud[4] SetTenthsTimer(20);
	hud[4] thread fadeIn(.3);
	//blue top bg
	hud[5] = addTextHud( level, 0, level.windowheight/-2+5, .8, "center", "bottom", "center", "middle", 2.2, 101 );
	hud[5].color = (0, 0.402 ,1);
	hud[5] SetShader("line_vertical",level.windowwidth+level.borderwidth+level.borderwidth,50);
	hud[5] thread fadeIn(.3);
	//mappool
	string = "";
	hud[6] = addTextHud( level, 0, level.windowheight/-2+6, .1, "center", "top", "center", "middle", 2.2, 101 );
	hud[6].color = (0, 0.402 ,1);
	hud[6] SetShader("white",level.windowwidth,int(arraymaps.size * 26.8 + 3));
	hud[6] thread fadeIn(.3);
	//voting results
	map = [];
	for(i=0;i<arraymaps.size;i++) {
		index = i + hud.size;
		hud[index] = addTextHud( level, -55, level.windowheight/-2+11.5+(i*26.8), 1, "left", "top", "center", "middle", 1.4, 102 );
		hud[index] setText("...");
		map[arraymaps[i]] = hud[index];
		hud[index] thread fadeIn(.3);
	}

	players = getAllPlayers();
	for(i=0;i<players.size;i++) {
		if(isDefined(players[i]) && isFalse(players[i].pers["isBot"]))
			players[i] thread PlayerVote();
	}

	addConnectThread(::PlayerVote);

	wait .1;

	level thread updateVotes(arraymaps,map);

	for(y=20;y>0;y--) {
		if(!(y%2) || y<6)
			level thread playSoundOnAllPlayers( "ui_mp_timer_countdown" );
		hud[5] fadeOverTime(.9);
		hud[5].alpha = .5;
		hud[4] fadeOverTime(.9);
		hud[4].alpha = .5;
		wait .9;
		hud[5] fadeOverTime(.1);
		hud[5].alpha = 1;	
		hud[4] fadeOverTime(.1);
		hud[4].alpha = 1;	
		wait .1;
	}
	level notify("end_vote");
	for(i=0;i<arraymaps.size;i++)
		map[arraymaps[i]] thread fadeOut(.5);

	hud[6] thread fadeOut(.5);
	hud[4] thread fadeOut(.5);
	level.mapvotes thread fadeOut(.5);

	players = getAllPlayers();
	for(i=0;i<players.size;i++)
		if(isDefined(players[i]) && isDefined(players[i].mapvote_selection))
			players[i].mapvote_selection thread fadeOut(.5);

	wait .5;


	hud[4] = addTextHud( level, 0, -20, 1, "center", "middle", "center", "middle", 2.2, 102 );
	hud[4] setText("Next Map:");
	hud[4].glowalpha = 1;
	hud[4].glowcolor = (0,.5,1);
	hud[4] thread fadeIn(.5);

	hud[6] = addTextHud( level, 0, 10, 1, "center", "middle", "center", "middle", 3, 102 );
	hud[6] setText(getMapNameString(strTok(level.winning,";")[0]) + " " + getGameTypeString(strTok(level.winning,";")[1]));
	hud[6].glowalpha = 1;
	hud[6].glowcolor = (0,.5,1);
	hud[6] thread fadeIn(.5);

	wait 3;

	blackscreen = addTextHud( level, 0, 0, 1, "center", "middle", "center", "middle", 3, 9999999 );
	blackscreen setShader("white",1000,1000);
	blackscreen.color = (0,0,0);
	blackscreen1 = addTextHud( level, 0, 0, 1, "center", "middle", "center", "middle", 3, 9999999 );
	blackscreen1 setShader("white",1000,1000);
	blackscreen1.color = (0,0,0);	
	blackscreen thread fadeIn(1.5);
	blackscreen1 thread fadeIn(1.5);
	wait 1.8;
	changeMap();
}

updateVotes(arraymaps,map) {
	level endon("end_vote");
	string = "";
	array = [];
	mostvotes = 0;
	players = getAllPlayers();
	level.mapvotes = addTextHud( level, level.windowwidth/-2 + 3, level.windowheight/-2+8, 1, "left", "top", "center", "middle", 2.2, 102 );
	level.mapvotes thread fadeIn(.3);
	while(1) {
		array = [];
		mostvotes = 0;
		level.winning = getDvar("mapname") + ";" +getDvar("g_gametype");//just in case
		players = getAllPlayers();
		for(i=0;i<players.size;i++) {
			if(isDefined(players[i]) && isDefined(players[i].votedmap)) {
				if(!isDefined(array[players[i].votedmap]))
					array[players[i].votedmap] = [];
				array[players[i].votedmap][array[players[i].votedmap].size] = players[i];
			}
		}
		string = "";
		for(i=0;i<arraymaps.size;i++) { 
			if(!isDefined(array[arraymaps[i]]))
				voted = 0;
			else 
				voted = array[arraymaps[i]].size;
			string += (voted + " - " + getMapNameString(strTok(arraymaps[i],";")[0]) + " " + getGameTypeString(strTok(arraymaps[i],";")[1]) + "\n");
			level.voteablemapstring = "";
			if(isDefined(array[arraymaps[i]])) {
				for(k=0;k<array[arraymaps[i]].size;k++) {
					if(level.voteablemapstring.size < 30 )
						level.voteablemapstring += (array[arraymaps[i]][k].name + ", ");
					else {
						level.voteablemapstring = getSubStr(level.voteablemapstring,0,level.voteablemapstring.size-2);
						level.voteablemapstring += (" and " + (array[arraymaps[i]].size-k+1) + " more..., ");
						k = 999;
					} 
				}
				if(mostvotes < array[arraymaps[i]].size) {
					mostvotes = array[arraymaps[i]].size;
					level.winning = arraymaps[i];
				}
				level.voteablemapstring = getSubStr(level.voteablemapstring,0,level.voteablemapstring.size-2);
				map[arraymaps[i]] setText(level.voteablemapstring);
			}
			else 
				map[arraymaps[i]] setText("...");
		}
		level.mapvotes setText(string);
		wait 1;
		level.mapvotes destroy();
		level.mapvotes = addTextHud( level, level.windowwidth/-2 + 3, level.windowheight/-2+8, 1, "left", "top", "center", "middle", 2.2, 102 );
	}
}

changeMap() 
{ 	
	setDvar("timescale",1);
	setDvar( "sv_maprotationcurrent", "gametype " + strTok(level.winning,";")[1] + " map " + strTok(level.winning,";")[0] );
	exitLevel(false);
}

PlayerVote() {
	self endon("disconnect");
	level endon("end_vote");

	self thread Rotate();

	wait .05;

	self.sessionteam = "spectator";
	self.sessionstate = "spectator";
	self [[level.spawnSpectator]]();

	ads = self AdsButtonPressed();
	self.howto = addTextHud( self, 0, level.windowheight/2+5, 1, "center", "top", "center", "middle", 2.4, 101 );
	self.howto thread fadeIn(.3);
	self.howto setText("Start MapVote");
	while(!self AttackButtonPressed() && ads == self AdsButtonPressed()) wait .05;
	self.howto thread fadeOut(1);
	selected = -1;
	offset = 26.8;
	self.mapvote_selection = addTextHud( self, 0, level.windowheight/-2+9+(selected*offset), 1, "center", "top", "center", "middle", 1.6, 101 );
	self.mapvote_selection setShader("line_vertical",level.windowwidth,25);
	self.mapvote_selection.color = (0, 0.402 ,1);
	self.mapvote_selection thread fadeIn(.3);
	maps = level.voteablemaps;
	while(1) {
		self allowSpectateTeam( "allies", false );
		self allowSpectateTeam( "axis", false );
		self allowSpectateTeam( "freelook", false );
		self allowSpectateTeam( "none", true );
		if(ads != self AdsButtonPressed()) {
			ads = self AdsButtonPressed();
			selected--;
			if(selected < 0)
				selected = maps.size-1;
			self.votedmap = maps[selected];
			self.mapvote_selection MoveOverTime(.1);
			self.mapvote_selection.y = level.windowheight/-2+9+(selected*offset);
		}
		if(self AttackButtonPressed()) {
			selected++;
			if(selected >= maps.size)
				selected = 0;
			self.votedmap = maps[selected];
			self.mapvote_selection MoveOverTime(.1);
			self.mapvote_selection.y = level.windowheight/-2+9+(selected*offset);
			for(k=0;k<8 && self attackButtonPressed();k++) wait .05;
		}
		wait .05;
	}
}

Rotate() {
	self endon("disconnect");
	wait .05;
	i=randomint(360);
	offset = 150;
	centerposition = self.origin;
	link = spawn("script_model",(centerposition[0]+(offset*cos(i)),centerposition[1]+(offset*sin(i)),centerposition[2]));
	self setOrigin((centerposition[0]+(offset*cos(i)),centerposition[1]+(offset*sin(i)),centerposition[2]));
	self linkTo(link);
	while(1) {
		for(;i<360;i+=1) {
			self FreezeControls(true);
			if(i%3==0)
				link moveTo((centerposition[0]+(offset*cos(i)),centerposition[1]+(offset*sin(i)),centerposition[2]),.15);
			self setPlayerAngles((0,i-180,0));
			wait .05;
		}
		i=0;
	}
}

FallDownWeapon() {
	wait .1;
	link = spawn("script_origin",maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(getentarray("mp_global_intermission", "classname")).origin+(0,0,200));
	bot = addBotClient("axis");
	bot freezeControls(true);
	bot setOrigin(link.origin);
	bot.pers["player_welcomed"] = true;
	bot linkTo(link);
	while(1) {
		for(i=0;i<level.endmap_weapon_falldown.size;i++) {
			bot giveWeapon(level.endmap_weapon_falldown[i]);
			wep = bot dropItem(level.endmap_weapon_falldown[i]);
			if(isDefined(wep))
				wep thread destroyAfterTime(1);
			wait .15;
		}
		wait .05;
	}
}

destroyAfterTime(time) {
	wait time;
	if(isDefined(self)) 
		self delete();
}

getGameTypeString( gt ) {
	switch( toLower( gt ) )
	{
		case "kc":
			gt = "(KC)";
			break;
		case "war":
			gt = "(TDM)";
			break;
		case "dm":
			gt = "(DM)";
			break;
		case "sd":
			gt = "(S&D)";
			break;
		case "koth":
			gt = "(HQ)";
			break;
		case "sab":
			gt = "(SAB)";
			break;			
		default:
			gt = "";
	}
	return gt;
}

getMapNameString( mapName )  {
	switch( toLower( mapName ) ) {
		case "mp_crash":
			mapName = "Crash";
			break;	
		case "mp_crossfire":
			mapName = "Crossfire";
			break;	
		case "mp_shipment":
			mapName = "Shipment";
			break;	
		case "mp_convoy":
			mapName = "Ambush";
			break;	
		case "mp_bloc":
			mapName = "Bloc";
			break;	
		case "mp_bog":
			mapName = "Bog";
			break;	
		case "mp_broadcast":
			mapName = "Broadcast";
			break;	
		case "mp_carentan":
			mapName = "Chinatown";
			break;			
		case "mp_countdown":
			mapName = "Countdown";
			break;	
		case "mp_crash_snow":
			mapName = "Crash Snow";
			break;	
		case "mp_creek":
			mapName = "Creek";
			break;		
		case "mp_citystreets":
			mapName = "District";
			break;
		case "mp_farm":
			mapName = "Downpour";
			break;
		case "mp_killhouse":
			mapName = "Killhouse";
			break;
		case "mp_overgrown":
			mapName = "Overgrown";
			break;
		case "mp_pipeline":
			mapName = "Pipeline";
			break;
		case "mp_showdown":
			mapName = "Showdown";
			break;
		case "mp_strike":
			mapName = "Strike";
			break;
		case "mp_vacant":
			mapName = "Vacant";
			break;	
		case "mp_cargoship":
			mapName = "Wetwork";
			break;		
		case "mp_backlot":
			mapName = "Backlot";
			break;		
		case "mp_nuketown":
			mapName = "Nuketown";
			break;
		
		case "mp_marketcenter":
			mapName = "Marketcenter";
			break;
	}
	return mapName;
}

isLegal(map) {
	if(map == (getDvar("mapname") + ";" + getDvar("g_gametype"))) 
		return false;
	for(i=0;i<level.voteablemaps.size;i++)
		if(level.voteablemaps[i] == map)
			return false;
	return true;
}