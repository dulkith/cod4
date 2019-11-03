#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include crazy\_utility;
#include crazy\splash_utility;
init()
{
	level.splashNum = int( tableLookup( "mp/splashTable.csv", 0, "splashnum", 1 ) );

	for ( ID = 1; ID <= level.SplashNum; ID++ )
	{
		precacheString( tableLookupIString( "mp/splashTable.csv", 0, ID, 2 ) );
		precacheString( tableLookupIString( "mp/splashTable.csv", 0, ID, 3 ) );
	}
	
	precacheShader("gradient_top");
	precacheShader("gradient_bottom");
	precacheShader("line_horizontal");
	
	level.numKills = 0;
	
	level thread onPlayerConnect();	
}
onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );
		
		player thread onPlayerSpawned();
		player.lastKilledBy = undefined;
		player.pers["cur_kill_streak"] = 0;
		player.pers["cur_death_streak"] = 0;
		
		player.recentKillCount = 0;
		player.lastKillTime = 0;
		player.cardTitle = int(player getStat( 988 ));
		if(player.cardTitle == 0)
		{
			stat = int(1);
			player.cardTitle = stat;
			player setStat( 988 , stat );
		}
	}
}
onPlayerSpawned()
{
	self endon("disconnect");
	level endon ( "game_ended" );

	for(;;)
	{
		self waittill("spawned");
		self thread countDeathStreak();
		self thread countKillStreak();
		self.firstTimeDamaged = [];
		self.damaged = undefined;
	}
}
killedPlayer( victim, weapon, meansOfDeath )
{
	if(victim.team == self.team)
	return;
	victimGuid = victim.guid;
	myGuid = self.guid;
	curTime = getTime();
	
	self thread updateRecentKills();
	self.lastKillTime = getTime();
	self.lastKilledPlayer = victim;

	self.modifiers = [];

	level.numKills++;
	
		if ( weapon == "none" )
			return false;

		
		if ( isDefined(victim.damaged) && victim.damaged == getTime() )
		{	
			weaponClass = getWeaponClass( weapon );
						
			if ( meansOfDeath != "MOD_MELEE" && ( weaponClass == "weapon_sniper" ) )
				self thread splashNotifyDelayed( "one_shot_kill" );	
		}
		if ( level.numKills == 1 )
			self firstBlood();
			
		if ( self.pers["cur_death_streak"] > 3 )
			self comeBack();
			
		if ( meansOfDeath == "MOD_HEAD_SHOT" )
			headShot();
					
		if ( !isAlive( self ) && self.deathtime + 800 < getTime() )
			postDeathKill();
		
		if ( level.teamBased && curTime - victim.lastKillTime < 500 )
		{
			if ( victim.lastkilledplayer != self )
				self avengedPlayer();		
		}
	
		if ( isDefined( victim.attackerPosition ) )
			attackerPosition = victim.attackerPosition;
		else
			attackerPosition = self.origin;
	
		if ( isAlive( self ) && (meansOfDeath == "MOD_RIFLE_BULLET" || meansOfDeath == "MOD_PISTOL_BULLET" || meansOfDeath == "MOD_HEAD_SHOT") && distance( attackerPosition, victim.origin ) > 1536 && !isDefined( self.assistedSuicide ) )
			self thread longshot();
	
		if ( isDefined( victim.pers["cur_kill_streak"] ) && victim.pers["cur_kill_streak"] >= max(3,int( level.aliveCount[level.otherTeam[victim.team]] / 2 )) )
			self buzzKill();	
			
		//if(isWallbang(self,victim))
			//self wallbang();

	victim.lastKilledBy = self;		
}

wallbang()
{
	self thread splashNotifyDelayed( "wallbang" );
	self thread maps\mp\gametypes\_rank::giveRankXP( "wallbang" );
}

longshot()
{
	self thread splashNotifyDelayed( "longshot" );
	self thread maps\mp\gametypes\_rank::giveRankXP( "longshot" );
}


execution()
{
	self thread splashNotifyDelayed( "execution" );
	self thread maps\mp\gametypes\_rank::giveRankXP( "execution" );
}


headShot()
{
	self thread splashNotifyDelayed( "headshot_splash" );
	self thread maps\mp\gametypes\_rank::giveRankXP( "headshot_splash" );
}


avengedPlayer()
{
	self thread splashNotifyDelayed( "avenger" );
	self thread maps\mp\gametypes\_rank::giveRankXP( "avenger" );
}

assistedSuicide()
{
	self thread splashNotifyDelayed( "assistedsuicide" );
	self thread maps\mp\gametypes\_rank::giveRankXP( "assistedsuicide" );
}

defendedPlayer()
{
	self thread splashNotifyDelayed( "defender" );
	self thread maps\mp\gametypes\_rank::giveRankXP( "defender" );
}


postDeathKill()
{
	self thread splashNotifyDelayed( "posthumous" );
	self thread maps\mp\gametypes\_rank::giveRankXP( "posthumous" );
}

revenge()
{
	self thread splashNotifyDelayed( "revenge" );
	self thread maps\mp\gametypes\_rank::giveRankXP( "revenge" );
}


multiKill( killCount )
{
	assert( killCount > 1 );
	
	if ( killCount == 2 )
	{
		self thread splashNotifyDelayed( "doublekill" );
		self playlocalsound("doublekill");
	}
	else if ( killCount == 3 )
	{
		self thread splashNotifyDelayed( "triplekill" );
		thread teamPlayerCardSplash( "callout_3xkill", self );
		self stoplocalsound("doublekill");
		self playlocalsound("triplekill");
	}
	else
	{
		self thread splashNotifyDelayed( "multikill" );
		thread teamPlayerCardSplash( "callout_3xpluskill", self );
		self stoplocalsound("triplekill");
		self playlocalsound("holyshit");
	}	
}


firstBlood()
{
	self thread splashNotifyDelayed( "firstblood" );
	thread playSoundOnPlayers("firstblood");
	self thread maps\mp\gametypes\_rank::giveRankXP( "firstblood" );
	thread teamPlayerCardSplash( "callout_firstblood", self );
}


buzzKill()
{
	self thread splashNotifyDelayed( "buzzkill" );
	self thread maps\mp\gametypes\_rank::giveRankXP( "buzzkill" );
}


comeBack()
{
	self thread splashNotifyDelayed( "comeback" );
	self thread maps\mp\gametypes\_rank::giveRankXP( "comeback" );
}

updateRecentKills()
{
	self endon ( "disconnect" );
	level endon ( "game_ended" );
	
	self notify ( "updateRecentKills" );
	self endon ( "updateRecentKills" );
	
	self.recentKillCount++;
	
	wait ( 1.0 );
	
	if ( self.recentKillCount > 1 )
		self multiKill( self.recentKillCount );
	
	self.recentKillCount = 0;
}
countDeathStreak()
{
	self endon("disconnect");
	self endon("joined_spectators");
	self.pers["cur_death_streak"] = 0;
	before = self.deaths;
	for(;;)
	{
		current = self.deaths;
		while(current == self.deaths) 
		wait 0.05;
		self.pers["cur_death_streak"] = self.deaths - before;
	}
}
countKillStreak()
{
	self endon("disconnect");
	self endon("joined_spectators");
	self.pers["cur_kill_streak"] = 0;
	before = self.kills;
	for(;;)
	{
		current = self.kills;
		while(current == self.kills) 
		wait 0.05;
		self.pers["cur_kill_streak"] = self.kills - before;
	}
}
isWallBang( attacker, victim )
{
	return bulletTracePassed( attacker getEye(), victim getEye(), true, attacker );
}