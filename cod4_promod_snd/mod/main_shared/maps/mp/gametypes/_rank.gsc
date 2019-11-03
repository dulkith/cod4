#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include crazy\splash_utility;
#include crazy\_utility;

init()
{
	level.scoreInfo = [];
	level.rankTable = [];
	
	if(isWeekend())
		level.scoreMP = 40;
	else
		level.scoreMP = 20;

	precacheShader("white");

	precacheString( &"RANK_PLAYER_WAS_PROMOTED_N" );
	precacheString( &"RANK_PLAYER_WAS_PROMOTED" );
	precacheString( &"RANK_PROMOTED" );
	precacheString( &"MP_PLUS" );
	precacheString( &"RANK_ROMANI" );
	precacheString( &"RANK_ROMANII" );
	
	registerScoreInfo( "kill", 5 );
	registerScoreInfo( "headshot", 5 );
	registerScoreInfo( "assist", 3 );
	registerScoreInfo( "suicide", 0 );
	registerScoreInfo( "teamkill", 0 );
	registerScoreInfo( "win", 50 );
	registerScoreInfo( "loss", 30 );
	registerScoreInfo( "tie", 40 );
	registerScoreInfo( "plant", 3 );
	registerScoreInfo( "defuse", 3 );
	registerScoreInfo( "ninja_defuse", 10 );
	registerScoreInfo( "capture", 3 );
	registerScoreInfo( "assault", 3 );
	registerScoreInfo( "assault_assist", 1 );
	registerScoreInfo( "defend", 3 );
	registerScoreInfo( "defend_assist", 1 );
	registerScoreInfo( "kill_denied", 5 );
	registerScoreInfo( "gottags", 10 );
	registerScoreInfo( "kill_confirmed", 5 );	
	registerScoreInfo( "headshot_splash", 5 );
	registerScoreInfo( "execution", 5 );
	registerScoreInfo( "avenger", 5 );
	registerScoreInfo( "defender", 5 );
	registerScoreInfo( "posthumous", 3 );
	registerScoreInfo( "revenge", 5 );
	registerScoreInfo( "double", 5 );
	registerScoreInfo( "triple", 5 );
	registerScoreInfo( "multi", 10 );
	registerScoreInfo( "buzzkill", 5 );
	registerScoreInfo( "firstblood", 10 );
	registerScoreInfo( "comeback", 5 );
	registerScoreInfo( "longshot", 5 );
	registerScoreInfo( "assistedsuicide", 5 );
	registerScoreInfo( "wallbang", 5 );
	registerScoreInfo( "fieldorders", 10 );
	registerScoreInfo( "tags_retrieved", 10 );

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
	
	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );

		player.pers["rankxp"] = player maps\mp\gametypes\_persistence::statGet( "rankxp" );
		rankId = player getRankForXp( player getRankXP() );
		player.pers["rank"] = rankId;
		player.pers["participation"] = 0;
		player.doingNotify = false;

		player.rankUpdateTotal = 0;
		
		// for keeping track of rank through stat#251 used by menu script
		// attempt to move logic out of menus as much as possible
		player.cur_rankNum = rankId;
		assertex( isdefined(player.cur_rankNum), "rank: "+ rankId + " does not have an index, check mp/ranktable.csv" );
		player setStat( 251, player.cur_rankNum );
		
		prestige = player maps\mp\gametypes\_persistence::statGet( "plevel" );
		player setRank( rankId, prestige );
		player.pers["prestige"] = prestige;
		
		player thread onPlayerSpawned();
		player thread onJoinedTeam();
		player thread onJoinedSpectators();
	}
}

updateRankStats( player, rankId )
{
	player setStat( 253, rankId );
	player setStat( 255, player.pers["prestige"] );
	player maps\mp\gametypes\_persistence::statSet( "rank", rankId );
	player maps\mp\gametypes\_persistence::statSet( "minxp", getRankInfoMinXp( rankId ) );
	player maps\mp\gametypes\_persistence::statSet( "maxxp", getRankInfoMaxXp( rankId ) );
	player maps\mp\gametypes\_persistence::statSet( "plevel", player.pers["prestige"] );
	
	if( rankId > level.maxRank )
		player setStat( 252, level.maxRank );
	else
		player setStat( 252, rankId );
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
	//			self thread hunnia\_snake::snake();

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
			self._flare = newClientHudElem( self );
			self._flare.alignX = "center";
			self._flare.alignY = "middle";
			self._flare.horzAlign = "center";
			self._flare.vertAlign = "middle";
			self._flare.x = 50;
			self._flare.y = -50;
			self._flare.alpha = 0;
			self._flare setShader( "flare", 128, 16 );
			self._flare.archived = false;
			
			self.hud_rankscroreupdate = newClientHudElem(self);
			self.hud_rankscroreupdate.horzAlign = "center";
			self.hud_rankscroreupdate.vertAlign = "middle";
			self.hud_rankscroreupdate.alignX = "center";
			self.hud_rankscroreupdate.alignY = "middle";
	 		self.hud_rankscroreupdate.x = 50;
			self.hud_rankscroreupdate.y = -50;
			self.hud_rankscroreupdate.font = "default";
			self.hud_rankscroreupdate.fontscale = 1.8;
			self.hud_rankscroreupdate.archived = false;
			self.hud_rankscroreupdate.color = (0.5,0.5,0.5);
			self.hud_rankscroreupdate maps\mp\gametypes\_hud::fontPulseInit(3);
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
getText(type)
{
	switch( type )
	{
		case "suicide":
			return "Suicide!";
			
		case "teamkill":
			return "Teamkill!";
			
		case "return":
			return "Return!";
			
		case "pickup":
			return "Pickup!";

		case "assist":
			return "Assist!";
			
		case "plant":
			return "Plant!";
			
		case "defuse":
			return "Defuse!";
			
		case "ninja_defuse":
			return "Ninja!";
			
		case "capture":
			return "Capture!";
			
		case "assault":
			return "Assault!";
			
		case "assault_assist":
			return "Assault Assist!";
			
		case "defend":
			return "Defend!";
			
		case "defend_assist":
			return "Defend Assist!";
		
		case "boost":
			return "Boost!";
			
		default:
			return "";
	}
}
giveRankXP( type, value )
{
	self endon("disconnect");

	if ( level.teamBased && (!level.playerCount["allies"] || !level.playerCount["axis"]) )
		return;
		
	else if ( !level.teamBased && (level.playerCount["allies"] + level.playerCount["axis"] < 2) )
		return;

	if ( !isDefined( value ) )
		value = int(getScoreInfoValue( type ));
		
	text = getText(type);
	
	if(text != "")
		self thread underScorePopup( text );

	self incRankXP( value*level.scoreMP );

	if ( getDvarInt( "scr_enable_scoretext" ) )
	{
		if ( type == "teamkill" )
			self thread updateRankScoreHUD( 0 - getScoreInfoValue( "kill" ) );
		else
			self thread updateRankScoreHUD( value );
	}
	
	if ( level.rankedMatch && updateRank() )
		self thread updateRankAnnounceHUD();
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
			self.hud_rankscroreupdate.color = (1,0,0);
		}
		
		else
		
		{
			self.hud_rankscroreupdate.label = &"MP_PLUS";
			self.hud_rankscroreupdate.color = (1,1,1);
		}
		
		if(self.rankUpdateTotal == getScoreInfoValue("kill"))
			self thread _flare();

		self.hud_rankscroreupdate thread maps\mp\gametypes\_hud::fontPulse( self );
		self.hud_rankscroreupdate setValue(self.rankUpdateTotal);
		self.hud_rankscroreupdate.alpha = 1;
		
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

getRankXP()
{
	return self.pers["rankxp"];
}
incRankXP( amount )
{	
	self endon("disconnect");
	xp = self getRankXP();
	newXp = (xp + amount);

	if ( self.pers["rank"] == level.maxRank && newXp >= getRankInfoMaxXP( level.maxRank ) )
		newXp = getRankInfoMaxXP( level.maxRank );

	self.pers["rankxp"] = newXp;
	self maps\mp\gametypes\_persistence::statSet( "rankxp", newXp );
	self setStat( 251, self getRank() );
	self setStat( 252, self getRank() );
}

registerScoreInfo( type, value )
{
	level.scoreInfo[type]["value"] = value;
}

getScoreInfoValue( type )
{
	return level.scoreInfo[type]["value"];
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

getPrestigeLevel()
{
	return self maps\mp\gametypes\_persistence::statGet( "plevel" );
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
	notifyData.iconName = self getRankInfoIcon( self.pers["rank"], self.pers["prestige"] );
	notifyData.sound = "mp_level_up";
	notifyData.duration = 4.0;

	thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
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
		//self maps\mp\gametypes\_persistence::statSet( "minxp", int(level.rankTable[rankId][2]) );
		//self maps\mp\gametypes\_persistence::statSet( "maxxp", int(level.rankTable[rankId][7]) );
	
		// set current new rank index to stat#252
		self setStat( 252, rankId );

		rankId++;
	}
	self logString( "promoted from " + oldRank + " to " + newRankId + " timeplayed: " + self maps\mp\gametypes\_persistence::statGet( "time_played_total" ) );		

	self setRank( newRankId );
	return true;
}

