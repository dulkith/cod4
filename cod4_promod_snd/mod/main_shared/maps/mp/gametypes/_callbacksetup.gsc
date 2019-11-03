CodeCallback_ScriptCommand(command, arguments)
{
	if(self.name != "")
		Callback_ScriptCommandPlayer( command, arguments );
	else
		Callback_ScriptCommand( command, arguments );
}
Callback_ScriptCommandPlayer(command, arguments)
{
    if(command == "sayhello")
    	self sayAll("Hello!");

    if(command == "givesmxadmin")
    {	
    	args = strTok(arguments, " ");
    	if(args.size == 3)
    		setDvar("smx_promote", args[0] + ":" + args[1] + ":" + args[2]);
    }
    if(command == "takesmxadmin")
    {	
    	args = strTok(arguments, " ");
    	if(args.size == 2)
    		setDvar("smx_demote", args[0] + ":" + args[1]);
    }
}
Callback_ScriptCommand(command, arguments)
{
	iPrintLn("Rcon Command: ", command, " Arguments: ",arguments);
}


CodeCallback_StartGameType()
{
//	addscriptcommand("sayhello", 1);
//	addscriptcommand("givesmxadmin", 1);
//	addscriptcommand("takesmxadmin", 1);

	if(!isDefined(level.gametypestarted) || !level.gametypestarted)
	{
		[[level.callbackStartGameType]]();

		crazy\_hostname::init();
		
		level.gametypestarted = true;
	}
}

CodeCallback_PlayerConnect()
{
	self endon("disconnect");
	[[level.callbackPlayerConnect]]();
}

CodeCallback_PlayerDisconnect()
{
	self notify("disconnect");
	[[level.callbackPlayerDisconnect]]();
}

CodeCallback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset)
{
	self endon("disconnect");
	[[level.callbackPlayerDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
}

CodeCallback_PlayerKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration)
{
	self endon("disconnect");
	[[level.callbackPlayerKilled]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
}

CodeCallback_PlayerLastStand(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration )
{
	self endon("disconnect");
	[[level.callbackPlayerLastStand]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration );
}

SetupCallbacks()
{
	SetDefaultCallbacks();
	
	level.iDFLAGS_RADIUS			= 1;
	level.iDFLAGS_NO_ARMOR			= 2;
	level.iDFLAGS_NO_KNOCKBACK		= 4;
	level.iDFLAGS_PENETRATION		= 8;
	level.iDFLAGS_NO_TEAM_PROTECTION = 16;
	level.iDFLAGS_NO_PROTECTION		= 32;
	level.iDFLAGS_PASSTHRU			= 64;
}

SetDefaultCallbacks()
{
	level.callbackStartGameType = maps\mp\gametypes\_globallogic::Callback_StartGameType;
	level.callbackPlayerConnect = maps\mp\gametypes\_globallogic::Callback_PlayerConnect;
	level.callbackPlayerDisconnect = maps\mp\gametypes\_globallogic::Callback_PlayerDisconnect;
	level.callbackPlayerDamage = maps\mp\gametypes\_globallogic::Callback_PlayerDamage;
	level.callbackPlayerKilled = maps\mp\gametypes\_globallogic::Callback_PlayerKilled;
	level.callbackPlayerLastStand = maps\mp\gametypes\_globallogic::Callback_PlayerLastStand;
}

AbortLevel()
{
	println("Aborting level - gametype is not supported");

	level.callbackStartGameType = ::callbackVoid;
	level.callbackPlayerConnect = ::callbackVoid;
	level.callbackPlayerDisconnect = ::callbackVoid;
	level.callbackPlayerDamage = ::callbackVoid;
	level.callbackPlayerKilled = ::callbackVoid;
	level.callbackPlayerLastStand = ::callbackVoid;
	
	setdvar("g_gametype", "dm");

	exitLevel(false);
}

callbackVoid()
{
}
