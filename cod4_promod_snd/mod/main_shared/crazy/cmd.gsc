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
			iPrintln( "^1SLeS^2[Admin]:^7 " + player.name + " ^7killed." );
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
				iPrintln( "^1SLeS^2[^1SLeS^2[Admin]]: ^7Bounced " + player.name + "^7." );
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
			iPrintln( "^1SLeS^2[Admin]:^1 " + toport.name + " ^7was teleported to ^1" + caller.name + "^7." );
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
			if(player.pers["fov"] == 0)
			{
				player setClientDvar( "cg_fovscale", 1 );
				player setstat(1322,1);
				player.pers["fov"] = 1;
				player quickNotify("^5FOV scale","^11");
			}
			else if(player.pers["fov"] == 1)
			{
				player setClientDvar( "cg_fovscale", 1.125 );
				player setstat(1322,2);
				player.pers["fov"] = 2;
				player quickNotify("^5FOV scale","^11.125");
			}
			else if(player.pers["fov"] == 2)
			{
				player setClientDvar( "cg_fovscale", 1.25 );
				player setstat(1322,3);
				player.pers["fov"] = 3;
				player quickNotify("^5FOV scale","^11.25");
			}
			else if(player.pers["fov"] == 3 )
			{
				player setClientDvar( "cg_fovscale", 1.3 );
				player setstat(1322,4);
				player.pers["fov"] = 4;
				player quickNotify("^5FOV scale","^11.3");
			}
			else if(player.pers["fov"] == 4)
			{
				player setClientDvar( "cg_fovscale", 1.4 );
				player setstat(1322,5);
				player.pers["fov"] = 5;
				player quickNotify("^5FOV scale","^11.4");
			}
			else if(player.pers["fov"] == 5)
			{
				player setClientDvar( "cg_fovscale", 1.5 );
				player setstat(1322,0);
				player.pers["fov"] = 0;
				player quickNotify("^5FOV scale","^11.5");
			}
		}
		break;
	
	case "fps":
        player = getPlayer( arg1, pickingType );
        if( isDefined( player ) )
        {
			if(player.pers["fb"] == 0)
			{
				player setClientDvar( "r_fullbright", 1 );
				player setstat(1222,1);
				player.pers["fb"] = 1;
				player quickNotify("^5FullBright","^3ON");
			}
			else if(player.pers["fb"] == 1)
			{
				player setClientDvar( "r_fullbright", 0 );
				player setstat(1222,0);
				player.pers["fb"] = 0;
				player quickNotify("^5FullBright","^2OFF");
			}
        }
        break;
	/*	
	case "dot":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
        {
			if(player.pers["dot"] == 0)
			{
				player reddot();
				player iPrintlnBOld("^1RED DOT ^0<^2ON^0>");
				//player iPrintln("^5NOOB <<"+player.name+">> ^7ON  ^1RED DOT");
				player setstat(1600,1); 
				player.pers["dot"] = 1;
			}
			else if (player.pers["dot"] == 1)
			{
				player iPrintlnBOld("^1RED DOT ^0<^3OFF^0>");
				player.reddot destroy();
				//player iPrintln("^5NOOB <<"+player.name+">> ^7OFF  ^1RED DOT");
				player setstat(1600,0); 
				player.pers["dot"] = 0;
			}
		}
		break;
*/
	case "knifemusic":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
        {
			if(player.pers["knifeMusic"] == 0)
			{
				self setClientDvar( "sles_knife_mute", 1 );
				player setstat(1601,1); 
				player.pers["knifeMusic"] = 1;
				player quickNotify("^5Knife Round Music","^2OFF");
			}
			else if (player.pers["knifeMusic"] == 1)
			{
				self setClientDvar( "sles_knife_mute", 0 );
				player setstat(1601,0); 
				player.pers["knifeMusic"] = 0;
				player quickNotify("^5Knife Round Music","^3ON");
			}
		}
		break;

	case "killcammusic":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
        {
			if(player.pers["killCamMusic"] == 0)
			{
				self setClientDvar( "sles_kill_mute", 1 );
				player setstat(1602,1); 
				player.pers["killCamMusic"] = 1;
				player quickNotify("^5Kill Cam Music","^2OFF");
			}
			else if (player.pers["killCamMusic"] == 1)
			{
				self setClientDvar( "sles_kill_mute", 0 );
				player setstat(1602,0); 
				player.pers["killCamMusic"] = 0;
				player quickNotify("^5Kill Cam Music","^3ON");
			}
		}
		break;
		
	case "profile":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
        {
			//player thread crazy\_welcomebox::Protocols();
		}
		break;

	case "gid":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ))
		{
			player iPrintlnBOld("^2Your Game ID ^7: ^1<^0" + GetSubStr(player getGuid(), player getGuid().size - 8, player getGuid().size) + "^1>");

		}
		break;
		
	case "balance":

			iPrintln( "^1Teams will be balanced soon..." );
			level thread AutoTeamsBalancer();
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
	//self dropPlayer("ban","Cheating");
	//iPrintlnBold("^3" + self.name + "^1Cheater Banned");
}

quickNotify(msg,action){

	self endon( "disconnect" );
	
	self.title = newclientHudElem(self);
	self.title.x = -20;
	self.title.y = 120;
	self.title.alignx = "center";
	self.title.horzAlign = "center";
	self.title.sort = 1002;
	self.title.alpha = 1;
	self.title.glowalpha = 1;
	self.title.glowcolor = (0.3, 0.3, 0.3);
	self.title.glowAlpha = 2;
	self.title.fontscale = 2.4;
	self.title.foreground = false;
	self.title.hidewheninmenu = false;
	self.title setText( msg );
	
	self.happen = newclientHudElem(self);
	self.happen.x = -20;
	self.happen.y = 143;
	self.happen.alignx = "center";
	self.happen.horzAlign = "center";
	self.happen.sort = 1003;
	self.happen.alpha = 1;
	self.happen.glowalpha = 1;
	self.happen.fontscale = 2.2;
	self.happen.foreground = false;
	self.happen.hidewheninmenu = false;
	self.happen setText( "^0> "+action );
	
	//wait 0.1;
	self.title moveOverTime(0.15);
	self.title.x = 5;
	
	self.happen moveOverTime(0.15);
	self.happen.x = 0;
	wait 1;
	self.title destroy();
	self.happen destroy();
}

reddot()
{
    self.reddot = newClientHudElem(self);
    self.reddot.x = 0;
    self.reddot.y = 0;
    self.reddot.alpha = 1;
    self.reddot.alignX = "center";
    self.reddot.alignY = "middle";
    self.reddot.horzAlign = "center";
    self.reddot.vertAlign = "middle";
    self.reddot setShader( "white", 3, 3);
    self.reddot.color = (1, 0, 0);
}

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
               iPrintln("^7Teams were balanced!");
               iPrintlnbold("^7Teams were balanced!");
           }
       }
}