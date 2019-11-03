#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include common_scripts\utility;
#include crazy\_utility;

init()
{	
	level.missionCallbacks = [];
	registerMissionCallback( "playerKilled", ::ch_kills );	
}

AngleClamp180( angle )
{
	angleFrac = angle / 360.0;
	angle = ( angleFrac - floor( angleFrac ) ) * 360.0;
	if( angle > 180.0 )
		return angle - 360.0;
	return angle;
}

registerMissionCallback(callback, func)
{
	if (! isDefined(level.missionCallbacks[callback]))
		level.missionCallbacks[callback] = [];
	level.missionCallbacks[callback][level.missionCallbacks[callback].size] = func;
}

ch_kills( data )
{
	if ( !isDefined( data.attacker ) || !isPlayer( data.attacker ))
		return;
	
	player = data.attacker;
	
	time = data.time;
	
	player processChallenge( "ch_intel_kills" );
	
	weaponClass = getWeaponClass( data.sWeapon );
	ch_bulletDamageCommon( data, player, weaponClass );

	if(!isDefined(player.tBagCheckStarted))
		player thread tBagCheck(data.victim.origin);

	if ( isDefined( player.tookWeaponFrom[ data.sWeapon ] ) )
		player processChallenge( "ch_intel_foundshot" );

	if ( isSubStr( data.sMeansOfDeath, "MOD_GRENADE" ) || isSubStr( data.sMeansOfDeath, "MOD_EXPLOSIVE" ) || isSubStr( data.sMeansOfDeath, "MOD_PROJECTILE" ) )
		player processChallenge( "ch_intel_explosivekill" );

	else if ( isSubStr( data.sMeansOfDeath,	"MOD_MELEE" ) )
		player processChallenge( "ch_intel_knifekill" );

	else if ( data.sMeansOfDeath == "MOD_HEAD_SHOT" )
		player processChallenge( "ch_intel_headshots" );
		
}
tBagCheck(origin)
{
	self endon("death");
	self endon("disconnect");
	
	self.tBagCheckStarted = true;
	
	while(distance2D(self.origin,origin) > 50)
		wait 0.05;
	
	for(i = 0;i < 2;i++)
	{
		while(self getStance() != "crouch") wait 0.05;
		while(self getStance() != "stand") wait 0.05;
	}
	self processChallenge( "ch_intel_tbag" );
}
ch_bulletDamageCommon( data, player, weaponClass )
{	
	if ( !data.attackerOnGround )
		player processChallenge( "ch_intel_jumpshot" );
	
	if ( data.attackerStance == "crouch" )
		player processChallenge( "ch_intel_crouchkills" );
		
	if ( data.attackerStance == "prone" )
		player processChallenge( "ch_intel_pronekills" );
		
	if (weaponClass == "weapon_pistol")
		player processChallenge( "ch_intel_secondarykills" );
	
	vAngles = data.victim.anglesOnDeath[1];
	pAngles = player.anglesOnKill[1];
	angleDiff = AngleClamp180( vAngles - pAngles );
	if ( abs(angleDiff) < 30 && !isSubStr( data.sMeansOfDeath,	"MOD_MELEE" ) )
		player processChallenge( "ch_intel_backshots" );
}
playerKilled( eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, sHitLoc )
{	
	self thread reset();

	if(!isDefined(attacker.infieldOrders))
		return;
		
	self.anglesOnDeath = self getPlayerAngles();
	if ( isDefined( attacker ) )
		attacker.anglesOnKill = attacker getPlayerAngles();
	
	self endon("disconnect");

	data = spawnStruct();

	data.victim = self;
	data.eInflictor = eInflictor;
	data.attacker = attacker;
	data.iDamage = iDamage;
	data.sMeansOfDeath = sMeansOfDeath;
	data.sWeapon = sWeapon;
	data.sHitLoc = sHitLoc;
	data.time = getTime();
	
	data.victimOnGround = data.victim isOnGround();
	
	if ( isPlayer( attacker ) )
	{
		data.attackerOnGround = data.attacker isOnGround();
		data.attackerStance = data.attacker getStance();
	}
	else
	{
		data.attackerOnGround = false;
		data.attackerStance = "stand";
	}
	
	waitAndProcessPlayerKilledCallback( data );
}

waitAndProcessPlayerKilledCallback( data )
{
	if ( isDefined( data.attacker ) )
		data.attacker endon("disconnect");
	
	wait .05;
	maps\mp\gametypes\_globallogic::WaitTillSlowProcessAllowed();
	
	doMissionCallback( "playerKilled", data );
}

doMissionCallback( callback, data )
{	
	if ( !isDefined( level.missionCallbacks[callback] ) )
		return;
	
	if ( isDefined( data ) ) 
	{
		for ( i = 0; i < level.missionCallbacks[callback].size; i++ )
			thread [[level.missionCallbacks[callback][i]]]( data );
	}
	else 
	{
		for ( i = 0; i < level.missionCallbacks[callback].size; i++ )
			thread [[level.missionCallbacks[callback][i]]]();
	}
}
processChallenge(challengeRef)
{
	if(!isDefined(self.infieldOrders))
		return;

	if(challengeRef == self.fieldOrders)
	{
		self.fieldOrdersCompleted++;
		if(isDefined(self.ui_fieldorders[3]))
			self.ui_fieldorders[3] setText( crazy\fieldorders::getFieldText(self.fieldOrders,(self.fieldOrdersDifficulty-self.fieldOrdersCompleted)));
	}
		
	if(self.fieldOrdersCompleted >= self.fieldOrdersDifficulty)
	{
		self thread givePlayerScore("fieldorders",self.fieldOrdersXP);
		self thread underScorePopup(&"INTEL_COMPLETED");
		level.fieldowner = undefined;
		self reset();
	}
}
givePlayerScore( event, score )
{
	self maps\mp\gametypes\_rank::giveRankXP( event, score );
		
	self.pers["score"] += score;
	self maps\mp\gametypes\_persistence::statAdd( "score", (self.pers["score"] - score) );
	self.score = self.pers["score"];
	self notify ( "update_playerscore_hud" );
}
createChallenge()
{
	self.infieldOrders = true;
	random = randomInt(10);
	level.fieldowner = self;
	self.fieldOrders = getInfo(random,1);
	self.fieldOrdersDifficulty = int(getInfo(random,4));
	self.fieldOrdersXP = int(getInfo(random,3));
	self.fieldOrdersCompleted = 0;
	self.tBagCheckStarted = undefined;
	self thread crazy\fieldorders::fieldOrdersSplashNotify();
}
getInfo(what,returns)
{
	return tableLookup( "mp/intelchallenges.csv", 0, what, returns );
}
getString(challange)
{
	return tableLookupIString( "mp/intelchallenges.csv", 1, challange, 2 );
}
reset()
{
	self notify("fieldordersdone");
	self.infieldOrders = undefined;
	self.fieldOrders = "";
	self.fieldOrdersDifficulty = 0;
	self.fieldOrdersXP = 0;
	self.fieldOrdersCompleted = 0;
	self.tBagCheckStarted = undefined;
}