#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include duffman\_common;

main()
{
	makeDvarServerInfo( "cmd", "" );
	makeDvarServerInfo( "cmd1", "" );
	
	self endon("disconnect");
	while(1)
	{
		wait 0.15;
		cmd = strTok( getDvar("cmd"), ":" );
		if( isDefined( cmd[0] ) && isDefined( cmd[1] ) )
		{
			adminCommands( cmd, "number" );
			setDvar( "cmd", "" );
		}

		cmd = strTok( getDvar("cmd1"), ":" );
		if( isDefined( cmd[0] ) && isDefined( cmd[1] ) )
		{
			adminCommands( cmd, "nickname" );
			setDvar( "cmd1", "" );
		}
	}
}

adminCommands( cmd, pickingType )
{
	self endon("disconnect");
	
	if( !isDefined( cmd[1] ) )
		return;

	arg0 = cmd[0]; // command

	if( pickingType == "number" )
		arg1 = int( cmd[1] );	// player
	else
		arg1 = cmd[1];
	
	
	switch( arg0 )
	{
		case "say":
		case "msg":
		case "message":
		thread drawInformation( 800, 0.8, 1, cmd[1] );
			break;

	case "uav":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player thread uav();
		}
		break;
			
	case "wtf":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{		
			playSoundOnPlayers( "artillery_impact" );
			wait 0.8;
			if( !player isReallyAlive() )
			return;
			
			playFx( level.fx["bombexplosion"], player.origin );
			player suicide();
		}
		break;
			
	case "target":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{	
			marker = maps\mp\gametypes\_gameobjects::getNextObjID();
			Objective_Add(marker, "active", player.origin);
			Objective_OnEntity( marker, player );
		}
		break;
			
	case "rob":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player takeAllWeapons();
		}
		break;
			
	case "tphere":
		toport = getPlayer( arg1, pickingType );
		caller = getPlayer( int(cmd[2]), pickingType );
		if(isDefined(toport) && toport isReallyAlive() && isDefined(caller) && caller isReallyAlive() ) 
		{
			toport setOrigin(caller.origin);
		}
		break;
			
	case "bounce":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{		
			for( i = 0; i < 2; i++ )
			player bounceplayer( vectorNormalize( player.origin - (player.origin - (0,0,20)) ), 200 );
		}
		break;
			
	case "party":
		thread partymode();
		break;
			
	case "partyoff":
		level notify ("stopparty");
		setDvar("r_fog", 0);
		break;
			
	case "jump":
		{
			iPrintlnBold("^3" + self.name + " ^2Enabled HighJump ");
			iPrintln( "^1HighJump Enabled" );
			setdvar( "bg_fallDamageMinHeight", "8999" ); 
			setdvar( "bg_fallDamagemaxHeight", "9999" ); 
			setDvar("jump_height","999");
			setDvar("g_gravity","600");
		}
		break;
			
	case "jumpoff":
		{
			iPrintlnBold("^3" + self.name + " ^1Disabled HighJump ");
			setDvar("g_gravity","800");
			setDvar("jump_height","39");
			wait 5;
			setdvar( "bg_fallDamageMinHeight", "140" ); 
			setdvar( "bg_fallDamagemaxHeight", "350" ); 
		}
		break;
			
	case "flash":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive())
		{
				player thread maps\mp\_flashgrenades::applyFlash(6, 0.75);
		}
		break;
			
	case "save":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive())
		{
			player.pers["Saved_origin"] = player.origin;
			player.pers["Saved_angles"] = player.angles;
			player messageln("Position saved.");
		}
		break;
			
	case "load":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive())
		{
			if(!isDefined(player.pers["Saved_origin"]))
			player messageln("No position found.");
			else
			{
				player freezecontrols(true);
				wait 0.05;
				player setPlayerAngles(player.pers["Saved_angles"]);
				player setOrigin(player.pers["Saved_origin"]);
				player messageln("Position loaded.");
				player freezecontrols(false);
			}
		}
		break;
			
	case "cfgban":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			iPrintlnBold("^3" + self.name + " ^1Cheater Banned");
			player thread lagg();
				wait 2;
			player dropPlayer("ban","Cheating");
		}
		break;
		
	case "fps":
        player = getPlayer( arg1, pickingType );
        if( isDefined( player ) )
        {
			if(player.pers["fullbright"] == 0)
			{
				player iPrintln( "You Turned Fullbright ^7[^3ON^7]" );
				player setClientDvar( "r_fullbright", 1 );
				player setstat(1222,1);
				player.pers["fullbright"] = 1;
			}
			else if(player.pers["fullbright"] == 1)
			{
				player iPrintln( "You Turned Fullbright ^7[^3OFF^7]" );
				player setClientDvar( "r_fullbright", 0 );
				player setstat(1222,0);
				player.pers["fullbright"] = 0;
			}
        }
        break;
			
	case "fov":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			if(player.pers["fov"] == 0 )
			{
				player iPrintln( "You Changed FieldOfView To ^7[^11.25^7]" );
				player setClientDvar( "cg_fovscale", 1.25 );
				player setstat(1322,1);
				player.pers["fov"] = 1;
			}
			else if(player.pers["fov"] == 1)
			{
				player iPrintln( "You Changed FieldOfView To ^7[^11.125^7]" );
				player setClientDvar( "cg_fovscale", 1.125 );
				player setstat(1322,2);
				player.pers["fov"] = 2;

			}
			else if(player.pers["fov"] == 2)
			{
				player iPrintln( "You Changed FieldOfView To ^7[^11^7]" );
				player setClientDvar( "cg_fovscale", 1 );
				player setstat(1322,0);
				player.pers["fov"] = 0;
			}
		}
		break;
		
	case "thermal":
        player = getPlayer( arg1, pickingType );
        if( isDefined( player ) )
		{
			if(player getStat(634) >= 2)
			{
				if(player.pers["thermal"] == 0)
				{
					player iPrintln( "You ^7 Turned Thermal ^7[^3ON^7]" );
					player crazy\visions::Thermal();
					player setstat(1422,1);
					player.pers["thermal"] = 1;
				}
				else if(player.pers["thermal"] == 1)
				{
					player iPrintln( "You ^7 Turned Thermal ^7[^3OFF^7]" );
					player crazy\visions::Default();
					player setstat(1422,0);
					player.pers["thermal"] = 0;
				}
			}
			else
				player iPrintBig("PRESTIGE_UNLOCK","LEVEL",2,"FEATURE","THERMAL");
		}
		break;
		
	case "laser":
        player = getPlayer( arg1, pickingType );
        if( isDefined( player ) )
		{
			if(player getStat(634) >= 3)
			{
				if(!player.pers["laser"])
				{
					player duffman\_common::setCvar("reflex_laser",1);
					player iPrintBig("Laser reflex On");
					player.pers["laser"] = 1;
				}
				else 
				{
					player duffman\_common::setCvar("reflex_laser",0);
					player iPrintBig("Laser reflex Off");
					player.pers["laser"] = 0;
				}
			}
			else
				player iPrintBig("PRESTIGE_UNLOCK","LEVEL",3,"FEATURE","LASER");
		}
		break;
			
		case "weapon":
			player = getPlayer( arg1, pickingType );
			if( isDefined( player ) && player isReallyAlive() && isDefined( cmd[2] ))
			{
				switch(cmd[2])
				{
				case "rpd":
					player GiveWeapon("rpd_mp");
					player givemaxammo ("rpd_mp");
					wait .1;
					player switchtoweapon("rpd_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1RPD");
					break;
						
				case "aku":
					player GiveWeapon("ak74u_mp");
					player givemaxammo ("ak47u_mp");
					wait .1;
					player switchtoweapon("ak74u_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1AK74-U");
					break;
						
				case "ak":
					player GiveWeapon("ak47_mp");
					player givemaxammo ("ak47_mp");
					wait .1;
					player switchtoweapon("ak47_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1AK47");
					break;
						
				case "r700":
					player GiveWeapon("remington700_acog_mp");
					player givemaxammo ("remington700_acog_mp");
					wait .1;
					player switchtoweapon("remington700_acog_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1REMINGTON 700");					
					break;
						
				case "deagle":
					player GiveWeapon("deserteaglegold_mp");
					player givemaxammo ("deserteaglegold_mp");
					wait .1;
					player switchtoweapon("deserteaglegold_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1DESERT EAGLE");
					break;
					
				case "pack":
					player giveWeapon("ak74u_mp");
					player givemaxammo("ak74u_mp");
					player giveWeapon("m40a3_mp");
					player givemaxammo("m40a4_mp");
					player giveWeapon("mp5_mp",6);
					player givemaxammo("mp5_mp");
					player giveWeapon("remington700_mp");
					player givemaxammo("remington700_mp");
					player giveWeapon("p90_mp",6);
					player givemaxammo("p90_mp");
					player giveWeapon("m1014_mp",6);
					player givemaxammo("m1014_mp");
					player giveWeapon("uzi_mp",6);
					player givemaxammo("uzi_mp");
					player giveWeapon("ak47_mp",6);
					player givemaxammo("ak47_mp");
					player giveweapon("m60e4_mp",6);
					player givemaxammo("m60e4_mp");
					player giveWeapon("deserteaglegold_mp");
					player givemaxammo("deserteaglegold_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1WEAPON PACK");
					wait .1;
					player switchtoweapon("m1014_mp");					
					break;
					
				default: return;
			}
		}
		default: return;
	}
}

uav()
{
	PlayerNum = getdvarint("compass");
	setdvar("compass", "");
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		thisPlayerNum = player getEntityNumber();
		if(thisPlayerNum == PlayerNum) // this is the one we're looking for
		{
			player setClientDvars ("g_compassShowEnemies","1");
		}
	}
}