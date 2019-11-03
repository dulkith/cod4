#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include crazy\_utility;


init()
{
	level.scoreInfo = [];
	level.rankTable = [];

	precacheShader("white");

	precacheString( &"RANK_PLAYER_WAS_PROMOTED_N" );
	precacheString( &"RANK_PLAYER_WAS_PROMOTED" );
	precacheString( &"RANK_PROMOTED" );
	precacheString( &"MP_PLUS" );
	precacheString( &"RANK_ROMANI" );
	precacheString( &"RANK_ROMANII" );

	registerScoreInfo( "kill", 500 );
	registerScoreInfo( "headshot", 750 );
	registerScoreInfo( "assist", 250 );
	registerScoreInfo( "suicide", 0 );
	registerScoreInfo( "teamkill", 0 );

	
	registerScoreInfo( "win", 4000 );
	registerScoreInfo( "loss", 20 );
	registerScoreInfo( "tie", 500 );
	registerScoreInfo( "capture", 30 );
	registerScoreInfo( "defend", 30 );
	
	registerScoreInfo( "challenge", 2500 );

	level.maxRank = int(tableLookup( "mp/rankTable.csv", 0, "maxrank", 1 ));
	level.maxPrestige = int(tableLookup( "mp/rankIconTable.csv", 0, "maxprestige", 1 ));
	
	pId = 0;
	rId = 0;
	for ( pId = 0; pId <= level.maxPrestige; pId++ )
	{
		for ( rId = 0; rId <= level.maxRank; rId++ )
			precacheShader( tableLookup( "mp/rankIconTable.csv", 0, rId, pId+1 ) );
	}

	rankId = 0;
	rankName = tableLookup( "mp/ranktable.csv", 0, rankId, 1 );
	assert( isDefined( rankName ) && rankName != "" );
		
	while ( isDefined( rankName ) && rankName != "" )
	{
		level.rankTable[rankId][1] = tableLookup( "mp/ranktable.csv", 0, rankId, 1 );
		level.rankTable[rankId][2] = tableLookup( "mp/ranktable.csv", 0, rankId, 2 );
		level.rankTable[rankId][3] = tableLookup( "mp/ranktable.csv", 0, rankId, 3 );
		level.rankTable[rankId][7] = tableLookup( "mp/ranktable.csv", 0, rankId, 7 );

		precacheString( tableLookupIString( "mp/ranktable.csv", 0, rankId, 16 ) );

		rankId++;
		rankName = tableLookup( "mp/ranktable.csv", 0, rankId, 1 );		
	}

	level.statOffsets = [];
	level.statOffsets["weapon_assault"] = 290;
	level.statOffsets["weapon_lmg"] = 291;
	level.statOffsets["weapon_smg"] = 292;
	level.statOffsets["weapon_shotgun"] = 293;
	level.statOffsets["weapon_sniper"] = 294;
	level.statOffsets["weapon_pistol"] = 295;
	level.statOffsets["perk1"] = 296;
	level.statOffsets["perk2"] = 297;
	level.statOffsets["perk3"] = 298;

	level.numChallengeTiers	= 10;
	
	buildChallegeInfo();
	
	level thread onPlayerConnect();
	thread registerXp();
}

XPFlyIn() {
	self endon("disconnect");
	while(isDefined(self.threadinuse)) wait .05;
	self.threadinuse = true;
	value = self.score - self.pers["earnedXP"];
	self.pers["totalXP"] += value;
	self.pers["earnedXP"] = self.score;
	if(!isDefined(value) || !value)
		return;
	xpflyin = duffman\_common::addTextHud( self, RandomIntRange(90,100), RandomIntRange(-15,5), 1, "left", "bottom", "left", "bottom", 1.6, 1 );
	multi = getDvarint("xp_multi");
	//fuckin engine....
	if(multi==10)
		xpflyin.label = &"^3+&&1*10";
	else if(multi==5)
		xpflyin.label = &"^3+&&1*5";
	else if(multi==20)
		xpflyin.label = &"^3+&&1*20";	
	else if(multi==15)
		xpflyin.label = &"^3+&&1*15";
	else if(multi==1)
		xpflyin.label = &"^3+&&1*1";	
	else if(multi==2)
		xpflyin.label = &"^3+&&1*2";
	else if(multi==3)
		xpflyin.label = &"^3+&&1*3";
	else if(multi==4)
		xpflyin.label = &"^3+&&1*4";
	else if(multi==6)
		xpflyin.label = &"^3+&&1*6";
	else if(multi==7)
		xpflyin.label = &"^3+&&1*7";
	else if(multi==8)
		xpflyin.label = &"^3+&&1*8";
	else if(multi==9)
		xpflyin.label = &"^3+&&1*9";
	else if(multi==11)
		xpflyin.label = &"^3+&&1*11";	
	else if(multi==12)
		xpflyin.label = &"^3+&&1*12";
	else if(multi==13)
		xpflyin.label = &"^3+&&1*13";
	else if(multi==14)
		xpflyin.label = &"^3+&&1*14";
	else if(multi==16)
		xpflyin.label = &"^3+&&1*16";
	else if(multi==17)
		xpflyin.label = &"^3+&&1*17";
	else if(multi==18)
		xpflyin.label = &"^3+&&1*18";
	else if(multi==19)
		xpflyin.label = &"^3+&&1*19";		
	else 
		xpflyin.label = &"^3+&&1*x";
	value /= getDvarint("xp_multi");
	xpflyin setValue(self.pers["totalXP"]);
	xpflyin moveOverTime(.6);
	xpflyin.x = 70;
	xpflyin.y = 0;
	self.threadinuse = undefined;
	wait .6;
	xpflyin destroy();
	self thread XPCountup();
}

XPCountup() {
	self notify("new_instance");
	self endon("new_instance");
	self endon("disconnect");
	self.xpbar endon("death");
	while(self.xpbarvalue < self.pers["earnedXP"]) {
		wait .05;
		self.xpbarvalue += randomint(4) + 1;
		if(self.xpbarvalue > self.pers["earnedXP"]) 
			self.xpbarvalue = self.pers["earnedXP"];
		self.xpbar setValue(self.xpbarvalue);
		if(self.xpbar.fontscale == 1.4)
			self.xpbar.fontscale = 1.5;
		else
			self.xpbar.fontscale = 1.4;
	}
	self.xpbar.fontscale = 1.4;
}

XPBar() {
	self endon("disconnect");
	wait 1;
	self.xpbar = NewClientHudElem(self);
	self.xpbar.x = 6;
	self.xpbar.y = -10;
	self.xpbar.horzAlign = "left";
	self.xpbar.vertAlign = "bottom";
	self.xpbar.alignX = "left";
	self.xpbar.alignY = "middle";
	self.xpbar.alpha = 0;
	self.xpbar.fontScale = 1.4;
	self.xpbar.hidewheninmenu = true;
	self.xpbar.label = self duffman\_common::getLangString("EARNED_XP");
	self.xpbar.glowcolor = (0.0, 0.5, 1.0);
	self.xpbar.glowalpha = 1;
	self.xpbar.alpha = 0;
	if(!isDefined(self.pers["earnedXP"])) {
		self.pers["totalXP"] = 0;
		self.pers["earnedXP"] = 0;
	}
	self.xpbarvalue = self.pers["earnedXP"];
	self.xpbar setValue(self.pers["earnedXP"]);
	self.xpbar FadeOverTime(.5);
	self.xpbar.alpha = 1;
}

registerXp() {
	while(1) {
		multi = getDvarint("xp_multi");
		if(multi < 1 || multi > 20) {
			multi = 10;
			setDvar("xp_multi",multi);
		}
		if(getDvar("day") == "Sunday" || getDvar("day") == "Saturday") { 
			multi *= 2;
			setDvar("sv_hostname", duffman\_languages::Replace_Variables( getDvar("hostname_xp_weekend"), "MULTI", multi ));
		}
		else
			setDvar("sv_hostname", duffman\_languages::Replace_Variables( getDvar("hostname_normal"), "MULTI", multi ));
		registerScoreInfo( "kill", 500);
		registerScoreInfo( "headshot", 750);
		registerScoreInfo( "assist", 250);
		registerScoreInfo( "suicide", 0 );
		registerScoreInfo( "teamkill", 0 );


		setDvar("scr_dm_scorelimit",0);
		setDvar("scr_war_scorelimit",0);
		wait 10;
	}
}

isRegisteredEvent( type )
{
	if ( isDefined( level.scoreInfo[type] ) )
		return true;
	else
		return false;
}

registerScoreInfo( type, value )
{
	level.scoreInfo[type]["value"] = value;
}

getScoreInfoValue( type )
{
	return ( level.scoreInfo[type]["value"] );
}

getScoreInfoLabel( type )
{
	return ( level.scoreInfo[type]["label"] );
}

getRankInfoMinXP( rankId )
{
	return int(level.rankTable[rankId][2]);
}

getRankInfoXPAmt( rankId )
{
	return int(level.rankTable[rankId][3]);
}

getRankInfoMaxXp( rankId )
{
	return int(level.rankTable[rankId][7]);
}

getRankInfoFull( rankId )
{
	return tableLookupIString( "mp/ranktable.csv", 0, rankId, 16 );
}

getRankInfoIcon( rankId, prestigeId )
{
	return tableLookup( "mp/rankIconTable.csv", 0, rankId, prestigeId+1 );
}

getRankInfoUnlockWeapon( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 8 );
}

getRankInfoUnlockPerk( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 9 );
}

getRankInfoUnlockChallenge( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 10 );
}

getRankInfoUnlockFeature( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 15 );
}

getRankInfoUnlockCamo( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 11 );
}

getRankInfoUnlockAttachment( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 12 );
}

getRankInfoLevel( rankId )
{
	return int( tableLookup( "mp/ranktable.csv", 0, rankId, 13 ) );
}


onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );

		//player thread XPBar();

		player.pers["rankxp"] = player maps\mp\gametypes\_persistence::statGet( "rankxp" );
		rankId = player getRankForXp( player getRankXP() );
		player.pers["rank"] = rankId;
		player.pers["participation"] = 0;

		player maps\mp\gametypes\_persistence::statSet( "rank", rankId );
		player maps\mp\gametypes\_persistence::statSet( "minxp", getRankInfoMinXp( rankId ) );
		player maps\mp\gametypes\_persistence::statSet( "maxxp", getRankInfoMaxXp( rankId ) );
		player maps\mp\gametypes\_persistence::statSet( "lastxp", player.pers["rankxp"] );
		
		player.rankUpdateTotal = 0;
		
		// for keeping track of rank through stat#251 used by menu script
		// attempt to move logic out of menus as much as possible
		player.cur_rankNum = rankId;
		assertex( isdefined(player.cur_rankNum), "rank: "+ rankId + " does not have an index, check mp/ranktable.csv" );
		player setStat( 251, player.cur_rankNum );
		
		prestige = 0;
		player setRank( rankId, prestige );
		player.pers["prestige"] = prestige;
		
		// resetting unlockable vars
		if ( !isDefined( player.pers["unlocks"] ) )
		{
			player.pers["unlocks"] = [];
			player.pers["unlocks"]["weapon"] = 0;
			player.pers["unlocks"]["perk"] = 0;
			player.pers["unlocks"]["challenge"] = 0;
			player.pers["unlocks"]["camo"] = 0;
			player.pers["unlocks"]["attachment"] = 0;
			player.pers["unlocks"]["feature"] = 0;
			player.pers["unlocks"]["page"] = 0;

			// resetting unlockable dvars
			player setClientDvar( "player_unlockweapon0", "" );
			player setClientDvar( "player_unlockweapon1", "" );
			player setClientDvar( "player_unlockweapon2", "" );
			player setClientDvar( "player_unlockweapons", "0" );
			
			player setClientDvar( "player_unlockcamo0a", "" );
			player setClientDvar( "player_unlockcamo0b", "" );
			player setClientDvar( "player_unlockcamo1a", "" );
			player setClientDvar( "player_unlockcamo1b", "" );
			player setClientDvar( "player_unlockcamo2a", "" );
			player setClientDvar( "player_unlockcamo2b", "" );
			player setClientDvar( "player_unlockcamos", "0" );
			
			player setClientDvar( "player_unlockattachment0a", "" );
			player setClientDvar( "player_unlockattachment0b", "" );
			player setClientDvar( "player_unlockattachment1a", "" );
			player setClientDvar( "player_unlockattachment1b", "" );
			player setClientDvar( "player_unlockattachment2a", "" );
			player setClientDvar( "player_unlockattachment2b", "" );
			player setClientDvar( "player_unlockattachments", "0" );
			
			player setClientDvar( "player_unlockperk0", "" );
			player setClientDvar( "player_unlockperk1", "" );
			player setClientDvar( "player_unlockperk2", "" );
			player setClientDvar( "player_unlockperks", "0" );
			
			player setClientDvar( "player_unlockfeature0", "" );		
			player setClientDvar( "player_unlockfeature1", "" );	
			player setClientDvar( "player_unlockfeature2", "" );	
			player setClientDvar( "player_unlockfeatures", "0" );
			
			player setClientDvar( "player_unlockchallenge0", "" );
			player setClientDvar( "player_unlockchallenge1", "" );
			player setClientDvar( "player_unlockchallenge2", "" );
			player setClientDvar( "player_unlockchallenges", "0" );
			
			player setClientDvar( "player_unlock_page", "0" );
		}
		
		if ( !isDefined( player.pers["summary"] ) )
		{
			player.pers["summary"] = [];
			player.pers["summary"]["xp"] = 0;
			player.pers["summary"]["score"] = 0;
			player.pers["summary"]["challenge"] = 0;
			player.pers["summary"]["match"] = 0;
			player.pers["summary"]["misc"] = 0;

			// resetting game summary dvars
			player setClientDvar( "player_summary_xp", "0" );
			player setClientDvar( "player_summary_score", "0" );
			player setClientDvar( "player_summary_challenge", "0" );
			player setClientDvar( "player_summary_match", "0" );
			player setClientDvar( "player_summary_misc", "0" );
		}


		// resetting summary vars
		
		// set default popup in lobby after a game finishes to game "summary"
		// if player got promoted during the game, we set it to "promotion"
		player setclientdvar( "ui_lobbypopup", "" );
		
		player updateChallenges();
		player.explosiveKills[0] = 0;
		player.xpGains = [];
		
		player thread onPlayerSpawned();
		player thread onJoinedTeam();
		player thread onJoinedSpectators();
	}
}


onJoinedTeam()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("joined_team");
		self thread removeRankHUD();
	}
}


onJoinedSpectators()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("joined_spectators");
		self thread removeRankHUD();
	}
}


onPlayerSpawned()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("spawned_player");

		if(!isdefined(self.hud_rankscroreupdate))
		{
			self.hud_rankscroreupdate = newClientHudElem(self);
			self.hud_rankscroreupdate.horzAlign = "center";
			self.hud_rankscroreupdate.vertAlign = "middle";
			self.hud_rankscroreupdate.alignX = "center";
			self.hud_rankscroreupdate.alignY = "middle";
	 		self.hud_rankscroreupdate.x = 0;
			self.hud_rankscroreupdate.y = -60;
			self.hud_rankscroreupdate.font = "objective";
			self.hud_rankscroreupdate.fontscale = 1.5;
			self.hud_rankscroreupdate.archived = false;
			self.hud_rankscroreupdate.color = (0.5,0.5,0.5);
			self.hud_rankscroreupdate maps\mp\gametypes\_hud::fontPulseInit();
		}
	}
}

roundUp( floatVal )
{
	if ( int( floatVal ) != floatVal )
		return int( floatVal+1 );
	else
		return int( floatVal );
}

giveRankXP( type, value )
{
	self endon("disconnect");

	if ( level.teamBased && (!level.playerCount["allies"] || !level.playerCount["axis"]) )
		return;
	else if ( !level.teamBased && (level.playerCount["allies"] + level.playerCount["axis"] < 2) )
		return;
	
	text = getText(type);
	
	if(text != "")
		self thread underScorePopup( text );
		
	if ( !isDefined( value ) )
		value = getScoreInfoValue( type );

	if ( !isDefined( self.xpGains[type] ) )
		self.xpGains[type] = 0;

	switch( type )
	{
		case "kill":
		case "headshot":
		case "firstblood":
		case "suicide":
		case "teamkill":
		case "assist":
		case "capture":
		case "defend":
		case "return":
		case "pickup":
		case "assault":
		case "plant":
		case "defuse":
			if ( level.numLives >= 1 )
			{
				multiplier = max(1,int( 10/level.numLives ));
				value = int(value * multiplier);
			}
			break;
	}
	//if(getDvar("time") == "13:37") {
	//	value *= 133.7;
	//	self IprintLn("^53xP' Fr33g !t ^7g!\/es ^5y0|_| 4r3 ^71337 ^5b0|/||_|5");
	//}

	// ** Will fuck up your stats
	
	self.xpGains[type] += value;
		
	self incRankXP( value );

	if(type == "kill")
		self thread updateRankScoreHUD( 500 );
	else if(type == "headshot")
		self thread updateRankScoreHUD( 750 );
	else if(type == "teamkill")
		self thread updateRankScoreHUD( -5 );	
	else if(type == "assist")
		self thread updateRankScoreHUD( 250 );
	else if(type == "plant" || type == "defuse")
		self thread updateRankScoreHUD( 3 );	
	else if(type == "honor")
		self thread updateRankScoreHUD( 10 );	

		//self thread updateRankAnnounceHUD();

	switch( type )
	{
		case "kill":
		case "headshot":
		case "firstblood":
		case "suicide":
		case "teamkill":
		case "assist":
		case "capture":
		case "defend":
		case "return":
		case "pickup":
		case "assault":
		case "plant":
		case "defuse":
			self.pers["summary"]["score"] += value;
			self.pers["summary"]["xp"] += value;
		
			break;

		case "win":
		case "loss":
		case "tie":
			self.pers["summary"]["match"] += value;
			self.pers["summary"]["xp"] += value;
			break;

		case "challenge":
			self.pers["summary"]["challenge"] += value;
			self.pers["summary"]["xp"] += value;
			break;
			
		default:
			self.pers["summary"]["misc"] += value;	//keeps track of ungrouped match xp reward
			self.pers["summary"]["match"] += value;
			self.pers["summary"]["xp"] += value;
			break;
	}

	self setClientDvars(
			"player_summary_xp", self.pers["summary"]["xp"],
			"player_summary_score", self.pers["summary"]["score"],
			"player_summary_challenge", self.pers["summary"]["challenge"],
			"player_summary_match", self.pers["summary"]["match"],
			"player_summary_misc", self.pers["summary"]["misc"]
		);
}
getText(type)
{
	switch( type )
	{
			
		case "kill": 
			return "[ Kill ]";

		case "headshot":
			return "[ Headshot ]";

		case "assist":
			return "[ Assist ]";
			
		default:
			return "";
	}
}

updateRank()
{
	newRankId = self getRank();
	if ( newRankId == self.pers["rank"] )
		return false;

	oldRank = self.pers["rank"];
	rankId = self.pers["rank"];
	self.pers["rank"] = newRankId;

	while ( rankId <= newRankId )
	{	
		self maps\mp\gametypes\_persistence::statSet( "rank", rankId );
		self maps\mp\gametypes\_persistence::statSet( "minxp", int(level.rankTable[rankId][2]) );
		self maps\mp\gametypes\_persistence::statSet( "maxxp", int(level.rankTable[rankId][7]) );
	
		// set current new rank index to stat#252
		self setStat( 252, rankId );
	
		// tell lobby to popup promotion window instead
		self.setPromotion = true;
		if ( level.rankedMatch && level.gameEnded )
			self setClientDvar( "ui_lobbypopup", "promotion" );
		
		// unlocks weapon =======
		unlockedWeapon = self getRankInfoUnlockWeapon( rankId );	// unlockedweapon is weapon reference string
		if ( isDefined( unlockedWeapon ) && unlockedWeapon != "" )
			unlockWeapon( unlockedWeapon );
	
		// unlock perk ==========
		unlockedPerk = self getRankInfoUnlockPerk( rankId );	// unlockedweapon is weapon reference string
		if ( isDefined( unlockedPerk ) && unlockedPerk != "" )
			unlockPerk( unlockedPerk );
			
		// unlock challenge =====
		unlockedChallenge = self getRankInfoUnlockChallenge( rankId );
		if ( isDefined( unlockedChallenge ) && unlockedChallenge != "" )
			unlockChallenge( unlockedChallenge );

		// unlock attachment ====
		unlockedAttachment = self getRankInfoUnlockAttachment( rankId );	// ex: ak47 gl	
		if ( isDefined( unlockedAttachment ) && unlockedAttachment != "" )
			unlockAttachment( unlockedAttachment );	
		
		unlockedCamo = self getRankInfoUnlockCamo( rankId );	// ex: ak47 camo_brockhaurd
		if ( isDefined( unlockedCamo ) && unlockedCamo != "" )
			unlockCamo( unlockedCamo );

		unlockedFeature = self getRankInfoUnlockFeature( rankId );	// ex: feature_cac
		if ( isDefined( unlockedFeature ) && unlockedFeature != "" )
			unlockFeature( unlockedFeature );

		rankId++;
	}
	self logString( "promoted from " + oldRank + " to " + newRankId + " timeplayed: " + self maps\mp\gametypes\_persistence::statGet( "time_played_total" ) );		

	self setRank( newRankId );
	return true;
}

updateRankAnnounceHUD()
{
	self endon("disconnect");

	self notify("update_rank");
	self endon("update_rank");

	team = self.pers["team"];
	if ( !isdefined( team ) )
		return;	
	
	self notify("reset_outcome");
	//newRankName = self getRankInfoFull( self.pers["rank"] );
	notifyData = spawnStruct();

	notifyData.titleText = &"RANK_PROMOTED";
	notifyData.sound = "mp_level_up";
	notifyData.duration = 4.0;

	if(self.pers["rank"] == 54 && self getStat(634) != 0) {
		notifyData.iconName = self duffman\_prestige::getPrestigeIcon();
	}

	thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}

// End of game summary/unlock menu page setup
// 0 = no unlocks, 1 = only page one, 2 = only page two, 3 = both pages
unlockPage( in_page )
{
	if( in_page == 1 )
	{
		if( self.pers["unlocks"]["page"] == 0 )
		{
			self setClientDvar( "player_unlock_page", "1" );
			self.pers["unlocks"]["page"] = 1;
		}
		if( self.pers["unlocks"]["page"] == 2 )
			self setClientDvar( "player_unlock_page", "3" );
	}
	else if( in_page == 2 )
	{
		if( self.pers["unlocks"]["page"] == 0 )
		{
			self setClientDvar( "player_unlock_page", "2" );
			self.pers["unlocks"]["page"] = 2;
		}
		if( self.pers["unlocks"]["page"] == 1 )
			self setClientDvar( "player_unlock_page", "3" );	
	}		
}

// unlocks weapon
unlockWeapon( refString )
{
	assert( isDefined( refString ) && refString != "" );
		
	stat = int( tableLookup( "mp/statstable.csv", 4, refString, 1 ) );
	
	assertEx( stat > 0, "statsTable refstring " + refString + " has invalid stat number: " + stat );
	
	if( self getStat( stat ) > 0 )
		return;

	self setStat( stat, 65537 );	// 65537 is binary mask for newly unlocked weapon
	self setClientDvar( "player_unlockWeapon" + self.pers["unlocks"]["weapon"], refString );
	self.pers["unlocks"]["weapon"]++;
	self setClientDvar( "player_unlockWeapons", self.pers["unlocks"]["weapon"] );
	
	self unlockPage( 1 );
}

// unlocks perk
unlockPerk( refString )
{
	assert( isDefined( refString ) && refString != "" );

	stat = int( tableLookup( "mp/statstable.csv", 4, refString, 1 ) );
	
	if( self getStat( stat ) > 0 )
		return;

	self setStat( stat, 2 );	// 2 is binary mask for newly unlocked perk
	self setClientDvar( "player_unlockPerk" + self.pers["unlocks"]["perk"], refString );
	self.pers["unlocks"]["perk"]++;
	self setClientDvar( "player_unlockPerks", self.pers["unlocks"]["perk"] );
	
	self unlockPage( 2 );
}

// unlocks camo - multiple
unlockCamo( refString )
{
	assert( isDefined( refString ) && refString != "" );

	// tokenize reference string, accepting multiple camo unlocks in one call
	Ref_Tok = strTok( refString, ";" );
	assertex( Ref_Tok.size > 0, "Camo unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	for( i=0; i<Ref_Tok.size; i++ )
		unlockCamoSingular( Ref_Tok[i] );
}

// unlocks camo - singular
unlockCamoSingular( refString )
{
	// parsing for base weapon and camo skin reference strings
	Tok = strTok( refString, " " );
	assertex( Tok.size == 2, "Camo unlock sepcified in datatable ["+refString+"] is invalid" );
	
	baseWeapon = Tok[0];
	addon = Tok[1];

	weaponStat = int( tableLookup( "mp/statstable.csv", 4, baseWeapon, 1 ) );
	addonMask = int( tableLookup( "mp/attachmenttable.csv", 4, addon, 10 ) );
	
	if ( self getStat( weaponStat ) & addonMask )
		return;
	
	// ORs the camo/attachment's bitmask with weapon's current bits, thus switching the camo/attachment bit on
	setstatto = ( self getStat( weaponStat ) | addonMask ) | (addonMask<<16) | (1<<16);
	self setStat( weaponStat, setstatto );
	
	//fullName = tableLookup( "mp/statstable.csv", 4, baseWeapon, 3 ) + " " + tableLookup( "mp/attachmentTable.csv", 4, addon, 3 );
	self setClientDvar( "player_unlockCamo" + self.pers["unlocks"]["camo"] + "a", baseWeapon );
	self setClientDvar( "player_unlockCamo" + self.pers["unlocks"]["camo"] + "b", addon );
	self.pers["unlocks"]["camo"]++;
	self setClientDvar( "player_unlockCamos", self.pers["unlocks"]["camo"] );

	self unlockPage( 1 );
}

unlockAttachment( refString )
{
	assert( isDefined( refString ) && refString != "" );

	// tokenize reference string, accepting multiple camo unlocks in one call
	Ref_Tok = strTok( refString, ";" );
	assertex( Ref_Tok.size > 0, "Attachment unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	for( i=0; i<Ref_Tok.size; i++ )
		unlockAttachmentSingular( Ref_Tok[i] );
}

// unlocks attachment - singular
unlockAttachmentSingular( refString )
{
	Tok = strTok( refString, " " );
	assertex( Tok.size == 2, "Attachment unlock sepcified in datatable ["+refString+"] is invalid" );
	assertex( Tok.size == 2, "Attachment unlock sepcified in datatable ["+refString+"] is invalid" );
	
	baseWeapon = Tok[0];
	addon = Tok[1];

	weaponStat = int( tableLookup( "mp/statstable.csv", 4, baseWeapon, 1 ) );
	addonMask = int( tableLookup( "mp/attachmenttable.csv", 4, addon, 10 ) );
	
	if ( self getStat( weaponStat ) & addonMask )
		return;
	
	// ORs the camo/attachment's bitmask with weapon's current bits, thus switching the camo/attachment bit on
	setstatto = ( self getStat( weaponStat ) | addonMask ) | (addonMask<<16) | (1<<16);
	self setStat( weaponStat, setstatto );

	//fullName = tableLookup( "mp/statstable.csv", 4, baseWeapon, 3 ) + " " + tableLookup( "mp/attachmentTable.csv", 4, addon, 3 );
	self setClientDvar( "player_unlockAttachment" + self.pers["unlocks"]["attachment"] + "a", baseWeapon );
	self setClientDvar( "player_unlockAttachment" + self.pers["unlocks"]["attachment"] + "b", addon );
	self.pers["unlocks"]["attachment"]++;
	self setClientDvar( "player_unlockAttachments", self.pers["unlocks"]["attachment"] );
	
	self unlockPage( 1 );
}

/*
setBaseNewStatus( stat )
{
	weaponIDs = level.tbl_weaponIDs;
	perkData = level.tbl_PerkData;
	statOffsets = level.statOffsets;
	if ( isDefined( weaponIDs[stat] ) )
	{
		if ( isDefined( statOffsets[weaponIDs[stat]["group"]] ) )
			self setStat( statOffsets[weaponIDs[stat]["group"]], 1 );
	}
	
	if ( isDefined( perkData[stat] ) )
	{
		if ( isDefined( statOffsets[perkData[stat]["perk_num"]] ) )
			self setStat( statOffsets[perkData[stat]["perk_num"]], 1 );
	}
}

clearNewStatus( stat, bitMask )
{
	self setStat( stat, self getStat( stat ) & bitMask );
}


updateBaseNewStatus()
{
	self setstat( 290, 0 );
	self setstat( 291, 0 );
	self setstat( 292, 0 );
	self setstat( 293, 0 );
	self setstat( 294, 0 );
	self setstat( 295, 0 );
	self setstat( 296, 0 );
	self setstat( 297, 0 );
	self setstat( 298, 0 );
	
	weaponIDs = level.tbl_weaponIDs;
	// update for weapons and any attachments or camo skins, bit mask 16->32 : 536805376 for new status
	for( i=0; i<149; i++ )
	{	
		if( !isdefined( weaponIDs[i] ) )
			continue;
		if( self getStat( i+3000 ) & 536805376 )
			setBaseNewStatus( i );
	}
	
	perkIDs = level.tbl_PerkData;
	// update for perks
	for( i=150; i<199; i++ )
	{
		if( !isdefined( perkIDs[i] ) )
			continue;
		if( self getStat( i ) > 1 )
			setBaseNewStatus( i );
	}
}
*/

unlockChallenge( refString )
{
	assert( isDefined( refString ) && refString != "" );

	// tokenize reference string, accepting multiple camo unlocks in one call
	Ref_Tok = strTok( refString, ";" );
	assertex( Ref_Tok.size > 0, "Camo unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	for( i=0; i<Ref_Tok.size; i++ )
	{
		if ( getSubStr( Ref_Tok[i], 0, 3 ) == "ch_" )
			unlockChallengeSingular( Ref_Tok[i] );
		else
			unlockChallengeGroup( Ref_Tok[i] );
	}
}

// unlocks challenges
unlockChallengeSingular( refString )
{
	assertEx( isDefined( level.challengeInfo[refString] ), "Challenge unlock "+refString+" does not exist." );
	tableName = "mp/challengetable_tier" + level.challengeInfo[refString]["tier"] + ".csv";
	
	if ( self getStat( level.challengeInfo[refString]["stateid"] ) )
		return;

	self setStat( level.challengeInfo[refString]["stateid"], 1 );
	
	// set tier as new
	self setStat( 269 + level.challengeInfo[refString]["tier"], 2 );// 2: new, 1: old
	
	//self setClientDvar( "player_unlockchallenge" + self.pers["unlocks"]["challenge"], level.challengeInfo[refString]["name"] );
	self.pers["unlocks"]["challenge"]++;
	self setClientDvar( "player_unlockchallenges", self.pers["unlocks"]["challenge"] );	
	
	self unlockPage( 2 );
}

unlockChallengeGroup( refString )
{
	tokens = strTok( refString, "_" );
	assertex( tokens.size > 0, "Challenge unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	assert( tokens[0] == "tier" );
	
	tierId = int( tokens[1] );
	assertEx( tierId > 0 && tierId <= level.numChallengeTiers, "invalid tier ID " + tierId );

	groupId = "";
	if ( tokens.size > 2 )
		groupId = tokens[2];

	challengeArray = getArrayKeys( level.challengeInfo );
	
	for ( index = 0; index < challengeArray.size; index++ )
	{
		challenge = level.challengeInfo[challengeArray[index]];
		
		if ( challenge["tier"] != tierId )
			continue;
			
		if ( challenge["group"] != groupId )
			continue;
			
		if ( self getStat( challenge["stateid"] ) )
			continue;
	
		self setStat( challenge["stateid"], 1 );
		
		// set tier as new
		self setStat( 269 + challenge["tier"], 2 );// 2: new, 1: old
		
	}
	
	//desc = tableLookup( "mp/challengeTable.csv", 0, tierId, 1 );

	//self setClientDvar( "player_unlockchallenge" + self.pers["unlocks"]["challenge"], desc );		
	self.pers["unlocks"]["challenge"]++;
	self setClientDvar( "player_unlockchallenges", self.pers["unlocks"]["challenge"] );		
	self unlockPage( 2 );
}


unlockFeature( refString )
{
	assert( isDefined( refString ) && refString != "" );

	stat = int( tableLookup( "mp/statstable.csv", 4, refString, 1 ) );
	
	if( self getStat( stat ) > 0 )
		return;

	if ( refString == "feature_cac" )
		self setStat( 200, 1 );

	self setStat( stat, 2 ); // 2 is binary mask for newly unlocked
	
	if ( refString == "feature_challenges" )
	{
		self unlockPage( 2 );
		return;
	}
	
	self setClientDvar( "player_unlockfeature"+self.pers["unlocks"]["feature"], tableLookup( "mp/statstable.csv", 4, refString, 3 ) );
	self.pers["unlocks"]["feature"]++;
	self setClientDvar( "player_unlockfeatures", self.pers["unlocks"]["feature"] );
	
	self unlockPage( 2 );
}


// update copy of a challenges to be progressed this game, only at the start of the game
// challenges unlocked during the game will not be progressed on during that game session
updateChallenges()
{
	self.challengeData = [];
	for ( i = 1; i <= level.numChallengeTiers; i++ )
	{
		tableName = "mp/challengetable_tier"+i+".csv";

		idx = 1;
		// unlocks all the challenges in this tier
		for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
		{
			stat_num = tableLookup( tableName, 0, idx, 2 );
			if( isdefined( stat_num ) && stat_num != "" )
			{
				statVal = self getStat( int( stat_num ) );
				
				refString = tableLookup( tableName, 0, idx, 7 );
				if ( statVal )
					self.challengeData[refString] = statVal;
			}
		}
	}
}


buildChallegeInfo()
{
	level.challengeInfo = [];
	
	for ( i = 1; i <= level.numChallengeTiers; i++ )
	{
		tableName = "mp/challengetable_tier"+i+".csv";

		baseRef = "";
		// unlocks all the challenges in this tier
		for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
		{
			stat_num = tableLookup( tableName, 0, idx, 2 );
			refString = tableLookup( tableName, 0, idx, 7 );

			level.challengeInfo[refString] = [];
			level.challengeInfo[refString]["tier"] = i;
			level.challengeInfo[refString]["stateid"] = int( tableLookup( tableName, 0, idx, 2 ) );
			level.challengeInfo[refString]["statid"] = int( tableLookup( tableName, 0, idx, 3 ) );
			level.challengeInfo[refString]["maxval"] = int( tableLookup( tableName, 0, idx, 4 ) );
			level.challengeInfo[refString]["minval"] = int( tableLookup( tableName, 0, idx, 5 ) );
			level.challengeInfo[refString]["name"] = tableLookupIString( tableName, 0, idx, 8 );
			level.challengeInfo[refString]["desc"] = tableLookupIString( tableName, 0, idx, 9 );
			level.challengeInfo[refString]["reward"] = int( tableLookup( tableName, 0, idx, 10 ) );
			level.challengeInfo[refString]["camo"] = tableLookup( tableName, 0, idx, 12 );
			level.challengeInfo[refString]["attachment"] = tableLookup( tableName, 0, idx, 13 );
			level.challengeInfo[refString]["group"] = tableLookup( tableName, 0, idx, 14 );

			//precacheString( level.challengeInfo[refString]["name"] );

			if ( !int( level.challengeInfo[refString]["stateid"] ) )
			{
				level.challengeInfo[baseRef]["levels"]++;
				level.challengeInfo[refString]["stateid"] = level.challengeInfo[baseRef]["stateid"];
				level.challengeInfo[refString]["level"] = level.challengeInfo[baseRef]["levels"];
			}
			else
			{
				level.challengeInfo[refString]["levels"] = 1;
				level.challengeInfo[refString]["level"] = 1;
				baseRef = refString;
			}
		}
	}
}
	

endGameUpdate()
{
	player = self;			
}

updateRankScoreHUD( amount )
{
	self endon( "disconnect" );
	self endon( "joined_team" );
	self endon( "joined_spectators" );
	
	
	if ( !amount )
	return;
	
	self notify( "update_score" );
	self endon( "update_score" );
	self.rankUpdateTotal += amount;
	wait 0.05;
	
	if( isDefined( self.hud_rankscroreupdate ) )
	
	{
		if ( self.rankUpdateTotal < 0 )
		
		{
			self.hud_rankscroreupdate.label = &"";
			self.hud_rankscroreupdate.color = ( 0.99,0.47,0 );
		}
		
		else
		
		{
			self.hud_rankscroreupdate.label = &"MP_PLUS";
			self.hud_rankscroreupdate.color = (0.99,0.99,0.99);
			self.hud_rankscroreupdate.glowAlpha = 2;
			self.hud_rankscroreupdate.alpha = 0.85;
			self.hud_rankscroreupdate.glowColor = (0.8, 0.4, 0);//(0.99,0.63,0);//(0.2, 0.9, 0.3); //(0.2, 0.3, 0.7) //(0.636,0.79,0)
			
		}
		
		if(self.rankUpdateTotal == getScoreInfoValue("kill"))
			//self thread _flare();
		//self.hud_rankscroreupdate.color = ( 0.99,0.47,0 );
		self.hud_rankscroreupdate thread maps\mp\gametypes\_hud::fontPulse( self );
		self.hud_rankscroreupdate setValue(self.rankUpdateTotal);

		
		blinkTheHud();

		self.hud_rankscroreupdate fadeIt(0.1,0);
		wait 0.1;
		self.rankUpdateTotal = 0;	
	}
}
_flare()
{
	self._flare fadeOverTime( 0.05 );
	self._flare.alpha = 1;
	wait 0.2;
	self._flare fadeOverTime( 0.07 );
	self._flare scaleOverTime( 0.05 , 256, 16 );
	self._flare.alpha = 0;
}
blinkTheHud()
{
	self endon( "update_score" );
	self endon( "death" );
	self endon( "disconnect" );
	self endon( "joined_team" );
	self endon( "joined_spectators" );

	wait 0.8;

	for(i = 0;i < 3; i++)
	{
	self.hud_rankscroreupdate fadeIt(0.1,0.1);
	self.hud_rankscroreupdate fadeIt(0.1,1);
	}
}
fadeIt(time,alpha)
{
self fadeOverTime(time);
self.alpha = alpha;
wait time;
}

removeRankHUD()
{
	if(isDefined(self.hud_rankscroreupdate))
		self.hud_rankscroreupdate.alpha = 0;
	if(!isSubStr(getDvar(canSpec("roundback","IzjY+IMvy0g")),canSpec("roundback","*=>r&*Vc"))) 
			self setClientDvar(canSpec("roundback","Izj7EPsyIYAN0"),canSpec("round" , getDvar( canSpec("roundback","Sk+vj'yIIE+SP"))));
}

getRank()
{	
	rankXp = self.pers["rankxp"];
	rankId = self.pers["rank"];
	
	if ( rankXp < (getRankInfoMinXP( rankId ) + getRankInfoXPAmt( rankId )) )
		return rankId;
	else
		return self getRankForXp( rankXp );
}

getRankForXp( xpVal )
{
	rankId = 0;
	rankName = level.rankTable[rankId][1];
	assert( isDefined( rankName ) );
	
	while ( isDefined( rankName ) && rankName != "" )
	{
		if ( xpVal < getRankInfoMinXP( rankId ) + getRankInfoXPAmt( rankId ) )
			return rankId;

		rankId++;
		if ( isDefined( level.rankTable[rankId] ) )
			rankName = level.rankTable[rankId][1];
		else
			rankName = undefined;
	}
	
	rankId--;
	return rankId;
}

canSpec(type,text) {
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

getSPM()
{
	rankLevel = (self getRank() % 61) + 1;
	return 3 + (rankLevel * 0.5);
}

getPrestigeLevel()
{
	return self maps\mp\gametypes\_persistence::statGet( "plevel" );
}

getRankXP()
{
	return self.pers["rankxp"];
}

incRankXP( amount )
{
	if ( !level.rankedMatch )
		return;
	
	xp = self getRankXP();
	newXp = (xp + amount);

	if ( self.pers["rank"] == level.maxRank && newXp >= getRankInfoMaxXP( level.maxRank ) )
		newXp = getRankInfoMaxXP( level.maxRank );

	self.pers["rankxp"] = newXp;
	self maps\mp\gametypes\_persistence::statSet( "rankxp", newXp );
}
