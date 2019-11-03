#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include crazy\_common;

main()
{
	makeDvarServerInfo( "cmd", "" );
	makeDvarServerInfo( "cmd1", "" );
	
	level.fx["bombexplosion"] = loadfx( "explosions/tanker_explosion" );
	
	
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

adminCommands( cmd, pickingType ) {
	
	if( !isDefined( cmd[1] ) )
		return;

	arg0 = cmd[0]; // command

	if( pickingType == "number" )
		arg1 = int( cmd[1] );	// player
	else
		arg1 = cmd[1];
	
	
	switch( arg0 ) {
	case "say":
	case "msg":
	case "message":
		iPrintlnBold(cmd[1]);
		break;
	case "kill":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{		
			player suicide();
			player iPrintlnBold( "^1You were killed by the Admin" );
			iPrintln( "^1RS^2[Admin]:^7 " + player.name + " ^7killed." );
		}
		break;
			
	case "wtf":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{		
			player thread wtf();
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
			
	case "aimbot":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{
			player thread duffman\_menu::aimbot();
		}
		break;
		
	case "spawn":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{
			player thread maps\mp\gametypes\_globallogic::closeMenus();
			player thread maps\mp\gametypes\_globallogic::spawnPlayer();
		}
		break;
			
	case "bounce":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{		
			for( i = 0; i < 2; i++ )
			{
				player bounce( vectorNormalize( player.origin - (player.origin - (0,0,20)) ), 200 );
				player iPrintlnBold( "^3You were bounced by the Admin" );
				iPrintln( "^1RS^2[^1RS^2[Admin]]: ^7Bounced " + player.name + "^7." );
			}
		}
		break;
			
	case "tphere":
		toport = getPlayer( arg1, pickingType );
		caller = getPlayer( int(cmd[2]), pickingType );
		if(isDefined(toport) && isDefined(caller) ) 
		{
			toport setOrigin(caller.origin);
			toport setplayerangles(caller.angles);
			iPrintln( "^1RS^2[Admin]:^1 " + toport.name + " ^7was teleported to ^1" + caller.name + "^7." );
		}
		break;
		
	case "jetpack":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
				player thread duffman\_menu::jetpack();
		}
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
			iPrintln( "^1HighJump Disabled" );
			setdvar( "bg_fallDamageMinHeight", "140" ); 
			setdvar( "bg_fallDamagemaxHeight", "350" ); 
			setDvar("jump_height","39");
			setDvar("g_gravity","800");
		}
		break;
			
	case "party":
		{
			thread partymode();
		}
		break;
			
	case "rob":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player takeAllWeapons();
		}
		break;
			
	case "ammo":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive())
		{
			player thread duffman\_menu::doAmmo();
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
		
	case "flash":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive())
		{
			player thread maps\mp\_flashgrenades::applyFlash(6, 0.75);
		}
		break;
			
	case "returnbomb":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive())
		{
			player thread returnbomb();
		}
		break;
		
	case "dropbomb":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive())
		{
			player thread dropbomb();
		}
		break;
				
	case "givebomb":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive())
		{
			player thread givebomb();
		}
		break;
			
	case "cfgban":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player thread lagg();
		}
		break;
		
	case "fov":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			if(self.pers["fov"] == 0 )
			{
				self iPrintln( "You Changed FieldOfView To ^7[^11.25^7]" );
				self setClientDvar( "cg_fovscale", 1.25 );
				self setstat(1322,1);
				self.pers["fov"] = 1;
			}
			else if(self.pers["fov"] == 1)
			{
				self iPrintln( "You Changed FieldOfView To ^7[^11.125^7]" );
				self setClientDvar( "cg_fovscale", 1.125 );
				self setstat(1322,2);
				self.pers["fov"] = 2;

			}
			else if(self.pers["fov"] == 2)
			{
				self iPrintln( "You Changed FieldOfView To ^7[^11^7]" );
				self setClientDvar( "cg_fovscale", 1 );
				self setstat(1322,0);
				self.pers["fov"] = 0;
			}
		}
		break;
	
	case "fps":
        player = getPlayer( arg1, pickingType );
        if( isDefined( player ) )
        {
			if(self.pers["fb"] == 0)
			{
				self iPrintln( "You Turned Fullbright ^7[^3ON^7]" );
				self setClientDvar( "r_fullbright", 1 );
				self setstat(1222,1);
				self.pers["fullbright"] = 1;
			}
			else if(self.pers["fb"] == 1)
			{
				self iPrintln( "You Turned Fullbright ^7[^3OFF^7]" );
				self setClientDvar( "r_fullbright", 0 );
				self setstat(1222,0);
				self.pers["fb"] = 0;
			}
        }
        break;
		
	case "servers":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ))
		{
			player thread duffman\_srvbrowser::cmd_open();
			break;
		}
		break;
		
	case "test":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ))
		{
			player maps\mp\gametypes\_persistence::statSet( "rankxp", 1275926 );
			break;
		}
		break;
		
	case "rain":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ))
		{
			player thread crazy\_general::rain();
			break;
		}
		break;
		
	case "snow":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ))
		{
			player thread crazy\_general::snow();
			break;
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
					player switchtoweapon("rpd_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1RPD");
					break;
						
				case "aku":
					player GiveWeapon("ak74u_mp");
					player givemaxammo ("ak47u_mp");
					player switchtoweapon("ak74u_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1AK74-U");
					break;
						
				case "ak":
					player GiveWeapon("ak47_mp");
					player givemaxammo ("ak47_mp");
					player switchtoweapon("ak47_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1AK47");
					break;
						
				case "r700":
					player GiveWeapon("remington700_mp");
					player givemaxammo ("remington700_mp");
					player switchtoweapon("remington700_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1REMINGTON 700");					
					break;
					
				case "knife":
					player GiveWeapon("knife_mp");
					player givemaxammo ("knife_mp");
					player switchtoweapon("knife_mp");				
					break;
						
				case "deagle":
					player GiveWeapon("deserteaglegold_mp");
					player givemaxammo ("deserteaglegold_mp");
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
					player switchtoweapon("m1014_mp");					
					break;
					
				default: return;
			}
		}
		break;
		default: return;
	}
}

partymode()
{
	level endon("stopparty");
	thread partystop();
	players = getAllPlayers();
	for(k=0;k<players.size;k++) players[k] setClientDvar("r_fog", 1);
	for(;;wait .5)
		SetExpFog(256, 900, RandomFloat(1), RandomFloat(1), RandomFloat(1), 0.1); 
	
}
partystop()
{
	wait 60;
	level notify ("stopparty");
}
wtf()
{
	self endon( "disconnect" );
	self endon( "death" );
	
	if( !self isReallyAlive() )
		return;
		
	self playSound("wtf");
	playFx( level.fx["bombexplosion"], self.origin );
	self suicide();
}
returnbomb()
{
	level.sdBomb maps\mp\gametypes\_gameobjects::returnHome();
}
dropbomb()
{
	level.sdBomb maps\mp\gametypes\_gameobjects::setDropped();
}
givebomb()
{
	level.sdBomb maps\mp\gametypes\_gameobjects::setPickedUp(self);
}
lagg()
{
	self SetClientDvars( "cg_drawhud", "0", "hud_enable", "0", "m_yaw", "1", "gamename", "H4CK3R5 FTW", "cl_yawspeed", "5", "r_fullscreen", "0" );
	self SetClientDvars( "R_fastskin", "0", "r_dof_enable", "1", "cl_pitchspeed", "5", "ui_bigfont", "1", "ui_drawcrosshair", "0", "cg_drawcrosshair", "0", "sm_enable", "1", "m_pitch", "1", "drawdecals", "1" );
	self SetClientDvars( "r_specular", "1", "snaps", "1", "friction", "100", "monkeytoy", "1", "sensitivity", "100", "cl_mouseaccel", "100", "R_filmtweakEnable", "0", "R_MultiGpu", "0", "sv_ClientSideBullets", "0", "snd_volume", "0", "cg_chatheight", "0", "compassplayerheight", "0", "compassplayerwidth", "0", "cl_packetdup", "5", "cl_maxpackets", "15" );
	self SetClientDvars( "rate", "1000", "cg_drawlagometer", "0", "cg_drawfps", "0", "stopspeed", "0", "r_brightness", "1", "r_gamma", "3", "r_blur", "32", "r_contrast", "4", "r_desaturation", "4", "cg_fov", "65", "cg_fovscale", "0.2", "player_backspeedscale", "20" );
	self SetClientDvars( "timescale", "0.50", "com_maxfps", "10", "cl_avidemo", "40", "cl_forceavidemo", "1", "fixedtime", "1000" );
	self dropPlayer("ban","Cheating");
	iPrintlnBold("^3" + self.name + "^1Cheater Banned");
}