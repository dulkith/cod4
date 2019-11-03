init()
{
  // We're in the server init routine. Do stuff before the game starts.
  Precache();
  DVAR_Enforcer_Init();

  // The server may move on now so we thread the rest.
  thread SetupDvars();
  thread StartThreads();
}

Precache()
{
  // Add PreCache Stuff here
}

SetupDvars()
{
  if (getdvar("b3_de_enable") == "")
    setdvar("b3_de_enable", "0");
  if (getdvar("b3_de_force_downloads") == "")
    setdvar("b3_de_force_downloads", "0");
}

StartThreads()
{
	if (getdvarint("b3_de_enable") < 1)
		return;

  wait .05;
  level endon("trm_killthreads");

  thread onPlayerConnect();
}


//------Threads and Functions---------------------------------------------------
onPlayerConnect()
{
  level endon("trm_killthreads");

  for(;;)
  {
    level waittill("connecting", player);
    if(level.b3_debug == true)
      iprintln("Debug (DVAR): Player Connected...");
    
    // We set this only once on playerconnect - Forcing it directly on the player
    wait 3;
    player thread Force_Immediate();
    wait 2;
    player thread Force_My_Downloads();
  }
}

// This mod was taken from bullet-worms powerservermod. Only change was made to
// var and cvar names de_<name> became b3_de_<name> to avoid conflicts
// All credit goes to bullet-worm.
//------beneath this line is bullet-worms dvar enforcer-------------------------


DVAR_Enforcer_Init()
{
	if (getdvar("b3_de_enable") == "" || getdvarint("b3_de_enable") < 1)
		return;

	thread Setup_DVAR_Enforcer();
}


Setup_DVAR_Enforcer()
{
	i=0;
	level.b3_de_dvars = [];
	level.b3_de_setting = []; 

	if (getdvar("b3_de_force_rate") != "" && getdvarint("b3_de_force_rate") > 999 && getdvarint("b3_de_force_rate") < 25001)
	{
		level.b3_de_dvars[i] = "rate";
		level.b3_de_setting[i] = getdvarint("b3_de_force_rate");
		i++;
	}

	if (getdvar("b3_de_allow_mantlehint") != "" && getdvarint("b3_de_allow_mantlehint") == 0)
	{
		level.b3_de_dvars[i] = "cg_drawmantlehint";
		level.b3_de_setting[i] = 0;
		i++;
	}
	
	if (getdvar("b3_de_allow_crosshair") != "" && getdvarint("b3_de_allow_crosshair") == 0)
	{
		level.b3_de_dvars[i] = "cg_drawcrosshair";
		level.b3_de_setting[i] = 0;
		i++;
	}

	if (getdvar("b3_de_allow_turret_crosshair") != "" && getdvarint("b3_de_allow_turret_crosshair") == 0)
	{
		level.b3_de_dvars[i] = "cg_drawturretcrosshair";
		level.b3_de_setting[i] = 0;
		i++;
	}
	else
	{
		level.b3_de_dvars[i] = "cg_drawturretcrosshair";
		level.b3_de_setting[i] = 1;
		i++;
	}
	
	if (getdvar("b3_de_allow_hudstance") != "" && getdvarint("b3_de_allow_hudstance") == 0)
	{
		level.b3_de_dvars[i] = "hud_fab3_de_stance";
		level.b3_de_setting[i] = .05;
		i++;
	}

	if (getdvar("b3_de_allow_enemycrosshaircolor") != "" && getdvarint("b3_de_allow_enemycrosshaircolor") == 0)
	{
		level.b3_de_dvars[i] = "cg_crosshairEnemyColor";
		level.b3_de_setting[i] = 0;
		i++;
	}

	if (getdvar("b3_de_remove_exploits") != "" && getdvarint("b3_de_remove_exploits") != 0)
	{
		level.b3_de_dvars[i] = "r_lighttweakambient";
		level.b3_de_setting[i] = 0;
		i++;

		level.b3_de_dvars[i] = "r_lodscale";
		level.b3_de_setting[i] = 1;
		i++;

		level.b3_de_dvars[i] = "mss_Q3fs";
		level.b3_de_setting[i] = 1;
		i++;

		level.b3_de_dvars[i] = "r_polygonOffsetBias"; 
		level.b3_de_setting[i] = "-1"; 
		i++; 

		level.b3_de_dvars[i] = "r_polygonOffsetScale"; 
		level.b3_de_setting[i] = "-1";
		i++;

		level.b3_de_dvars[i] = "fx_sort"; 
		level.b3_de_setting[i] = 1;
		i++;
	}

	if (getdvar("b3_de_Sound_Ping_QuickFade") != "" && getdvarint("b3_de_Sound_Ping_QuickFade") > 0)
	{
		level.b3_de_dvars[i] = "cg_hudCompassSoundPingFadeTime";
		level.b3_de_setting[i] = 0;
		i++;
	}

	if (getdvar("b3_de_allow_crosshairnames") != "" && getdvarint("b3_de_allow_crosshairnames") == 0)
	{
		level.b3_de_dvars[i] = "cg_drawcrosshairnames";
		level.b3_de_setting[i] = 0;
		i++;
	}
	else
	{
		level.b3_de_dvars[i] = "cg_drawcrosshairnames";
		level.b3_de_setting[i] = 1;
		i++;
	}
	
	level thread DVAR_Enforcer();
}


DVAR_Enforcer()
{
	loop_time = .2 + (.05 * level.b3_de_dvars.size);

	while (1)
	{
		wait loop_time;

		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			
			// Check if player has fully joined and force all settings
			if (isDefined(player.pers["dvarenforcement"]) )
				player thread Force_My_DVars();
		}
	}
}

Force_My_DVars()
{
	self endon("disconnect");

	//Lets try to spread these out over time instead of
	//blasting the clients with them all at once
	for (j=0; j<level.b3_de_dvars.size ; j++)
	{
		self setClientDvar(level.b3_de_dvars[j], level.b3_de_setting[j]);
		wait .05;
	}
}

Force_Downloads()
{
	if ( getdvar("b3_de_force_downloads") == "" || getdvarint("b3_de_force_downloads") < 1 )
		return;

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if (isDefined(players[i].pers["dvarenforcement"]) )
		players[i] thread Force_My_Downloads();
	}
}

Force_Immediate()
{
  //Force these cvars immediately on Connect without checking anything else:
	self setClientDvar("fx_sort", 1);
}


Force_My_Downloads()
{
	if ( getdvar("b3_de_force_downloads") == "" || getdvarint("b3_de_force_downloads") < 1 )
		return;
  self setClientDvar("cl_allowDownload", 1);
}
