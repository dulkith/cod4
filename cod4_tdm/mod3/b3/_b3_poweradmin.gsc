init()
{
  // We're in the server init routine. Do stuff before the game starts.
  Precache();

  // The server may move on now so we thread the rest.
  thread SetupDvars();
  thread StartThreads();
}

PreCache()
{
  precacheShellShock("default");
  precacheShellshock("groggy");	
  level._effect["bombexplosion"] = loadfx("props/barrelexp"); 
  level._effect["b3burn"]	= loadfx("props/barrel_fire");	
}

SetupDvars()
{
	// Lets make sure were empty before we start the threads
	setdvar("b3_saybold", "");
    setdvar("b3_endmap", "");
    setdvar("b3_rcid", "");
	setdvar("b3_rname", "");
	setdvar("b3_shock", "");
	setdvar("b3_burn", "");
	setdvar("b3_explode", "");
	setdvar("b3_forceteamcid", "");
	setdvar("b3_forceteamname", "");
	setdvar("b3_scorecid", "");
	setdvar("b3_score", "");
	setdvar("b3_deathcid", "");
	setdvar("b3_death", "");
	setdvar("b3_compensate", "");
	setdvar("b3_losepoint", "");
	level.b3endmap = false;

}

StartThreads()
{
	wait .05;
	level endon("trm_killthreads");

  thread DvarChecker();

  // !EDIT!
  // Ravir's (also used in Bullet Worms Powerserver mod)
  // Comment the next 3 lines if you already have the admintools installed (eg. bullet-worms powerservermod)
  // Commenting is done by adding // to the beginning of each line.
    thread switchteam();
	thread killum();
	thread switchspec();

}

//------Threads and Functions---------------------------------------------------

// Communication between b3 and this mod depends on cvars/dvars.
// This is our major thread that checks our specific cvars/dvars changing
// Each command will clean up the leftovers on its own.
DvarChecker()
{
	level endon("trm_killthreads");

	while(1)
  {
    if ( getdvar( "b3_saybold" ) != "" )
      _b3_saybold();
    if ( ( getdvar( "b3_endmap" ) != "" ) || ( level.b3endmap == true ) )
      _b3_endmap();
    if( getdvar( "b3_rcid" ) != "" )
      thread _b3_renamer();
    if( getdvar( "b3_shock" ) != "" )
      thread _b3_shock();
    if( getdvar( "b3_burn" ) != "" )
      thread _b3_burn();
    if( getdvar( "b3_explode" ) != "" )
      thread _b3_explode();
    if( getdvar( "b3_scorecid" ) != "" )
      thread _b3_score();
    if( getdvar( "b3_forceteamcid" ) != "" )
      thread _b3_forceteam();
    if( getdvar( "b3_deathcid" ) != "" )
      thread _b3_death();
    if( getdvar( "b3_compensate" ) != "" )
      thread _b3_compensate();
    if( getdvar( "b3_losepoint" ) != "" )
      thread _b3_losepoint();
    wait .1;
  }
}


//Print a message on the center of the screen
_b3_saybold()
{
	msg  = getdvar("b3_saybold");
	setdvar("b3_saybold", "");

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)			
		players[i] playLocalSound("bullet_impact_headshot_2");	
	iprintlnbold(msg);
}


// End the map?
_b3_endmap()

// !EDIT!
// Make sure you remove/comment any gametypes that you do NOT have installed on your server.
{
  // If the command was given by an admin it must be in the cvar
	if(getdvar("b3_endmap") != "")
    {
    iprintlnbold("^1*** ^7Admin is ending the map! ^1***^7");
    wait 5;
    }
  setdvar("b3_endmap", "");

	// If we come from within the script we use level.b3endmap so we better reset it.
  level.b3endmap = false;
	
  currenttype = getdvar("g_gametype");
	level.mapended = true;
	
  //if ( currenttype == "ctf" )
  //{
   // level thread maps\mp\gametypes\ctf::EndMap();
    //return;
  //}
  //if ( currenttype == "dm" )
  //{
   // level thread maps\mp\gametypes\dm::EndMap();
    //return;
  //}
  //if ( currenttype == "hq" )
  //{
   // level thread maps\mp\gametypes\hq::EndMap();
    //return;
  //}
  //if ( currenttype == "sd" )
  //{
   // level thread maps\mp\gametypes\sd::EndMap();
    //return;
  //}
  //if ( currenttype == "tdm" )
  //{
   // level thread maps\mp\gametypes\tdm::EndMap();
    //return;
  //}


	//maps\mp\_utility::error("Unsupported Gametype");
	//Since we're still here, we need to end the map. Let's take a shortcut.
	endMapSafety();
}

endMapSafety()
{
	game["state"] = "intermission";
	level notify("intermission");

	exitLevel(false);
}

// Force a player to a team
_b3_forceteam()
{
	forcePlayerNum = getdvarint("b3_forceteamcid");
	moveToTeam = getdvar("b3_forceteamname");
	setdvar("b3_forceteamcid", "");
	setdvar("b3_forceteamname", "");

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		thisPlayerNum = player getEntityNumber();
		if(thisPlayerNum == forcePlayerNum) // this is the one we're looking for
		{

      if(player.pers["team"] == moveToTeam)
        return;

      if(moveToTeam == "allies")
				newTeam = "allies";
			else if(moveToTeam == "axis")
				newTeam = "axis";
			else
        return;

			if(isAlive(player))
			{
				
        player unlink();
				player suicide();

        player.deaths--;
			}

			player.pers["team"] = newTeam;
			player.pers["weapon"] = undefined;
			player.pers["weapon1"] = undefined;
			player.pers["weapon2"] = undefined;
			player.pers["spawnweapon"] = undefined;
			player.pers["savedmodel"] = undefined;
			player.pers["secondary_weapon"] = undefined;

			player setClientDvar("ui_allow_weaponchange", "1");

			if(newTeam == "allies")
			{
				player openMenu(game["menu_weapon_allies"]);
				scriptMainMenu = game["menu_weapon_allies"];
			}
			else
			{
				player openMenu(game["menu_weapon_axis"]);
				scriptMainMenu = game["menu_weapon_axis"];
			}
		}
	}
}

// Alter a players scorepoints
_b3_score()
{
	forcePlayerNum = getdvarint("b3_scorecid");
	forceScoreDiff = getdvarint("b3_score");
	setdvar("b3_scorecid", "");
	setdvar("b3_score", "");

	if(forceScoreDiff == 0)
    return;

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		thisPlayerNum = player getEntityNumber();
		if(thisPlayerNum == forcePlayerNum) // this is the one we're looking for
		{

        newscore = player.score + forceScoreDiff;
        player.score = newscore;

				if(forceScoreDiff < 0)
				  iprintln(player.name + "^7's score was reduced:  " + forceScoreDiff + " by the admin");
				if(forceScoreDiff > 0)
				  iprintln(player.name + "^7's score was increased:  " + forceScoreDiff + " by the admin");
		}
	}
}

// ALter a players deathcount
_b3_death()
{
	forcePlayerNum = getdvarint("b3_deathcid");
	forceDeathDiff = getdvarint("b3_death");
	setdvar("b3_deathcid", "");
	setdvar("b3_death", "");

	if(forceDeathDiff == 0)
    return;

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		thisPlayerNum = player getEntityNumber();
		if(thisPlayerNum == forcePlayerNum) // this is the one we're looking for
		{

        newdeaths = player.deaths + forceDeathDiff;
        player.deaths = newdeaths;

				if(forceDeathDiff < 0)
				  iprintln(player.name + "^7's deathcount was reduced:  " + forceDeathDiff + " by the admin");
				if(forceDeathDiff > 0)
				  iprintln(player.name + "^7's deathcount was increased:  " + forceDeathDiff + " by the admin");
		}
	}
}

// Compensate a player: score +1 and deaths -1
_b3_compensate()
{
	forcePlayerNum = getdvarint("b3_compensate");
	setdvar("b3_compensate", "");

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		thisPlayerNum = player getEntityNumber();
		if(thisPlayerNum == forcePlayerNum) // this is the one we're looking for
		{
        player.score++;
        player.deaths--;

			  iprintln(player.name + "^7 was compensated by the admin (Score +1 // Deaths -1)");
		}
	}
}

// Make a player lose a point
_b3_losepoint()
{
	forcePlayerNum = getdvarint("b3_losepoint");
	setdvar("b3_losepoint", "");

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		thisPlayerNum = player getEntityNumber();
		if(thisPlayerNum == forcePlayerNum) // this is the one we're looking for
		{
        player.score--;

			  iprintln(player.name + "^7 lost a scorepoint!");
		}
	}
	setdvar("b3_losepoint", "");
}


// The B3 !rename command:
_b3_renamer()
{
	B3PlayerNum = getdvarint("b3_rcid");
	B3CvarValue = getdvar("b3_rname");
	setdvar("b3_rcid", "");
	setdvar("b3_rname", "");

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
    thisPlayerNum = player getEntityNumber();
		if(thisPlayerNum == B3PlayerNum) // this is the one we're looking for
		{
			player unlink();
			player setClientdvar("name", B3CvarValue);
		}
	}
}


//------PUNISHMENTS-------------------------------------------------------------

// The B3 !pashock command:
_b3_shock()
{
	B3PlayerNum = getdvarint("b3_shock");
  B3CvarValue = getdvarint("b3_shocktime");
	setdvar("b3_shocktime", "");
	setdvar("b3_shock", "");

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
    thisPlayerNum = player getEntityNumber();
		if(thisPlayerNum == B3PlayerNum) // this is the one we're looking for
		{
			player thread _cmd_shock_threaded(B3CvarValue);
		}
	}
	return;
}
_cmd_shock_threaded(time)
{	
  if (time)
    self shellshock("default", time);
  else
    self shellshock("default", 7);
 	iprintln(self.name + "^7 just had a SHOCKING experience!");		
	return;
}


//Light players on fire
_b3_burn()
{
	B3PlayerNum = getdvarint("b3_burn");
	setdvar("b3_burn", "");

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
    thisPlayerNum = player getEntityNumber();
		if(thisPlayerNum == B3PlayerNum) // this is the one we're looking for
		{
			player thread _cmd_burn_threaded();
		}
	}
}
_cmd_burn_threaded()
{	
	if (self.pers["team"] != "spectator")
	{
		if(isAlive(self))
		{
    	self.burnedout = false;
    	self thread _cmd_burn_damage();
    	self thread _cmd_burn_breath();
    	iprintln(self.name + "^7 is on FIRE!");		
    	while(self.burnedout == false)
    	{			
    		playfx(level._effect["b3burn"], self.origin);
        wait .1;	
    	}
	  } 
  }
  return;
}
//Do heavy breathing while burning
_cmd_burn_breath()
{
  while(self.burnedout == false)
  {
    self playLocalSound("breathing_hurt");
    wait 1;
  }
  return;
}
//Do the burn damage and sounds, kill player after 10 seconds
_cmd_burn_damage()
{
  wait 5;
  self shellshock("groggy", 5);
  wait 5;
 	self suicide();
 	self.burnedout = true;

  return;
}


//Blow the player up
_b3_explode()
{
	B3PlayerNum = getdvarint("b3_explode");
	setdvar("b3_explode", "");

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
    thisPlayerNum = player getEntityNumber();
		if(thisPlayerNum == B3PlayerNum) // this is the one we're looking for
		{
			player thread _cmd_explode_threaded();
		}
	}
}
_cmd_explode_threaded()
{	
	if (self.pers["team"] != "spectator")
	{
		if(isAlive(self))
		{
      playfx(level._effect["bombexplosion"], self.origin);
      self playSound("exp_suitcase_bomb_main");
    	wait .05;
    	self suicide();
    	iprintln(self.name + "^7 was blown to bits!");		
	  } 
  }
  return;
}


//------ORIGINAL-CODE-BY-RAVIR-AND-BULLET-WORM-MODIFIED-BY-XLR8OR---------------

switchteam()
{
	level endon("trm_killthreads");
	newTeam = undefined;
	setdvar("g_switchteam", "");
	while(1)
	{
		if(getdvar("g_switchteam") != "")
		{
			if (getdvar("g_switchteam") == "all")
				setdvar("g_switchteam", "-1");

			movePlayerNum = getdvarint("g_switchteam");
			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
			{
				player = players[i];

				thisPlayerNum = player getEntityNumber();
				if(thisPlayerNum == movePlayerNum || movePlayerNum == -1) // this is the one we're looking for
				{

					if(player.pers["team"] == "axis")
						newTeam = "allies";
					if(player.pers["team"] == "allies")
						newTeam = "axis";

					if(isAlive(player))
					{
						player unlink();
						player suicide();

            player.deaths--;
					}

					player.pers["team"] = newTeam;
					player.pers["weapon"] = undefined;
					player.pers["weapon1"] = undefined;
					player.pers["weapon2"] = undefined;
					player.pers["spawnweapon"] = undefined;
					player.pers["savedmodel"] = undefined;
					player.pers["secondary_weapon"] = undefined;

					player setClientDvar("ui_allow_weaponchange", "1");

					if(newTeam == "allies")
					{
						player openMenu(game["menu_weapon_allies"]);
						scriptMainMenu = game["menu_weapon_allies"];
					}
					else
					{
						player openMenu(game["menu_weapon_axis"]);
						scriptMainMenu = game["menu_weapon_axis"];
					}
					if(movePlayerNum != -1)
						iprintln(player.name + "^7 was forced to switch teams by the admin");
				}
			}
			if(movePlayerNum == -1)
				iprintln("The admin forced all players to switch teams.");

			setdvar("g_switchteam", "");
		}
		wait 0.05;
	}
}

killum()
{
	level endon("trm_killthreads");

	setdvar("g_killplayer", "");
	while(1)
	{
		if(getdvar("g_killplayer") != "")
		{
			killPlayerNum = getdvarint("g_killplayer");
			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
			{
				thisPlayerNum = players[i] getEntityNumber();
				if(thisPlayerNum == killPlayerNum && isAlive(players[i]) ) // this is the one we're looking for
				{
					players[i] unlink();
					players[i] suicide();
					iprintln(players[i].name + "^7 was killed by the admin");
				}
			}
			setdvar("g_killplayer", "");
		}
		wait 0.05;
	}
}

switchspec()
{
	level endon("trm_killthreads");
	setdvar("g_switchspec", "");
	while(1)
	{
		if(getdvar("g_switchspec") != "")
		{
			if (getdvar("g_switchspec") == "all")
				setdvar("g_switchspec", "-1");

			movePlayerNum = getdvarint("g_switchspec");
			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
			{
				thisPlayerNum = players[i] getEntityNumber();
				if(thisPlayerNum == movePlayerNum || movePlayerNum == -1) // this is the one we're looking for
				{
					player = players[i];

					if(isAlive(player))
					{

						player unlink();
						player suicide();

						player.switching_teams = true;
						player.joining_team = "spectator";
						player.leaving_team = player.pers["team"];

            /*
            player.deaths--;
  		      */

						wait 2;
					}
						
					player.pers["team"] = "spectator";
					player.pers["teamTime"] = 1000000;
					player.pers["weapon"] = undefined;
					player.pers["weapon1"] = undefined;
					player.pers["weapon2"] = undefined;
					player.pers["spawnweapon"] = undefined;
					player.pers["savedmodel"] = undefined;
					player.pers["secondary_weapon"] = undefined;
					
					player.sessionteam = "spectator";
					player.sessionstate = "spectator";
					player.spectatorclient = -1;
					player.archivetime = 0;
					player.friendlydamage = undefined;
					player setClientDvar("g_scriptMainMenu", game["menu_team"]);
					player setClientDvar("ui_weapontab", "0");
					player.statusicon = "";
					
					player notify("spawned");
					player notify("end_respawn");
					resettimeout();

					player thread maps\mp\gametypes\_spectating::setSpectatePermissions();

					spawnpointname = "mp_teamdeathmatch_intermission";
					spawnpoints = getentarray(spawnpointname, "classname");
					spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);
	
					if(isDefined(spawnpoint))
						player spawn(spawnpoint.origin, spawnpoint.angles);
					else
						maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");

					if(movePlayerNum != -1)
            iprintln(player.name + "^7 was forced to Spectate by the admin");
					self notify("joined_spectators");
				}
			}

			if(movePlayerNum == -1)
				iprintln("The admin forced all players to Spectate.");

			setdvar("g_switchspec", "");
		}
		wait 0.05;
	}
}



