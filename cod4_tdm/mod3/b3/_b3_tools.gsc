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
  // Head Icon
  game["headicon_protected"] = "gfx/hud/hud@health_cross.tga";
  precacheHeadIcon(game["headicon_protected"]);

  // Health Icon for Heal/Spawn Protect
  game["hud_health_cross"] = "gfx/hud/hud@health_cross.tga";
  precacheShader(game["hud_health_cross"]);

  game["hud_text_protected"] = &"Spawn Protection Active";
  precacheString(game["hud_text_protected"]);
}

SetupDvars()
{
  if (getdvar("b3_tools_enable") == "")
    setdvar("b3_tools_enable", "0");

  if (getdvar("b3_mercylimit") == "")
    setdvar("b3_mercylimit", "0");

  if (getdvar("b3_spawnsafe") == "")
    setdvar("b3_spawnsafe", "0");

  if (getdvar("b3_afklimit") == "")
    setdvar("b3_afklimit", "0");
}

StartThreads()
{
	if (getdvarint("b3_tools_enable") < 1)
		return;

  wait .05;
  level endon("trm_killthreads");

  thread onPlayerConnect();
  thread MercyLimitChecker();
}

//------Threads and Functions---------------------------------------------------
onPlayerConnect()
{
  level endon("trm_killthreads");

  for(;;)
  {
    level waittill("connecting", player);
    if(level.b3_debug == true)
      iprintln("Debug (TOOLS): Player Connected...");
    player thread onPlayerSpawned();
    player thread onJoinedSpectators();
  }
}

onPlayerSpawned()
{
  self endon("disconnect");
  self notify("stop_afk_monitor");

  for(;;)
  {
    self waittill("spawned_player");
    
    if(level.b3_debug == true)
      iprintln("Debug (TOOLS): Player Spawned...");

    // Now start the threads
    self thread SpawnSafe();

    // Give afk_monitor a little time to die.
    wait .1;
    self thread AFK_Monitor();

  }
}

onJoinedSpectators()
{
  self endon("disconnect");
  
  for(;;)
  {
    self waittill("joined_spectators");
    self notify("stop_afk_monitor");
  }
}



//------Mercy Limit-------------------------------------------------------------
MercyLimitChecker()
{
  level endon("trm_killthreads");

  while(1)
  {
    MercyLimit();
    wait 10;
  }
}
MercyLimit()
{
  level.b3_mercylimit = getdvarint("b3_mercylimit");
  if(level.b3_mercylimit > 0  &&  game["state"] == "playing")
  {
    mercydif = 0;

    if(level.b3_debug == true)
      iprintln("Debug: Checking Mercy Limit");
    
    if(getTeamScore("allies") < getTeamScore("axis"))
    {
      mercydif = int(getTeamScore("axis") - getTeamScore("allies"));
      if(level.b3_debug == true)
        iprintln("Debug: Opfor leading. Diff: " + mercydif);
    }
    else if(getTeamScore("axis") < getTeamScore("allies"))
    {
      mercydif = int(getTeamScore("allies") - getTeamScore("axis"));
      if(level.b3_debug == true)
        iprintln("Debug: Allies leading. Diff: " + mercydif);
    }
    else
    {
      if(level.b3_debug == true)
        iprintln("Debug (TOOLS): Tie. Diff: " + mercydif);
      return;
    }
    
    if(mercydif >= level.b3_mercylimit)
    {
      iprintlnbold("Mercy Limit Reached");
      wait 5;
      level.b3endmap = true;
      return;
    }
  }
}

//------Spawn Protection--------------------------------------------------------
//SpawnProtection
SpawnSafe()
{     
  level.b3_spawnsafe = getdvarint("b3_spawnsafe");
  if(self.pers["team"] != "spectator" && level.b3_spawnsafe > 0)
  {
    self endon("disconnect");

    self.spawnprotected = true;
    self.protectiontime = level.b3_spawnsafe * 10;
    if (self.protectiontime < 10)
      self.protectiontime = 50;
    if(level.b3_debug == true)
      iprintln("Debug (SPP): Protection Units: " + self.protectiontime);
    
    startinghealth = self.health;
    if(level.b3_debug == true)
      iprintln("Debug (SPP): Starting Health: " + self.health);

    self thread _cmd_Head_Icon();

    self.protected_hud = newClientHudElem(self);
    self.protected_hud.x = 0;
    self.protected_hud.y = 180;
    self.protected_hud.alignX = "center";
    self.protected_hud.alignY = "middle";
    self.protected_hud.horzAlign = "center_safearea";
    self.protected_hud.vertAlign = "center_safearea";
    self.protected_hud.alpha = 1;
    self.protected_hud.archived = false;
    self.protected_hud.font = "default";
    self.protected_hud.fontscale = 1;
    self.protected_hud.color = (0.980,0.996,0.388);
    self.protected_hud setText(game["hud_text_protected"]);

    self thread _cmd_MonitorAttackKey();

    for (i=self.protectiontime; i>0 ; i--)  
    {   
      if (!self.spawnprotected || self.sessionstate == "dead")
        break;
      self.health = 5000000;
      wait .1;
      self notify("end_healthregen");
      self stopShellshock();
      self stoprumble("damage_heavy");

      //if(level.b3_debug == true)
      //  iprintln("Debug (SPP): Protection Health: " + self.health);
    }

    self.spawnprotected = false;

    if (isDefined(self.protected_hud) )
      self.protected_hud fadeOverTime(1);
    if (isDefined(self.protected_hud))
      self.protected_hud destroy();
    if (isDefined(self.protected_hudicon))
      self.protected_hudicon destroy();
    
    if (self.sessionstate != "dead")
      self.health = startinghealth;
    self notify("end_healthregen");
    self stopShellshock();
    self stoprumble("damage_heavy");
    if(level.b3_debug == true)
      iprintln("Debug (SPP): End Protection. Health: " + self.health);
    
    // We've stopped healthregeneration, need to fire it up again.
    self thread maps\mp\gametypes\_healthoverlay::playerHealthRegen();
    if(level.b3_debug == true)
      iprintln("Debug (SPP): Starting Original healthregen...");
  }
}

_cmd_MonitorAttackKey()
{
  self endon("disconnect");

  while (self.spawnprotected)
  {
    wait 0.1;

    if (self attackButtonPressed())
    {
      if(level.b3_debug == true)
        iprintln("Debug (SPP): Attack Button Pressed...");
      self.spawnprotected = false;
    }
  }
}

_cmd_Return_Head_Icon()
{
  if(isDefined(self.pers["team"]) && self.pers["team"] != "spectator" && self.sessionstate == "playing")
  {
    if(level.drawfriend)
    {
      if(self.pers["team"] == "allies")
      {
        self.headicon = game["headicon_allies"];
        self.headiconteam = "allies";
      }
      else
      {
        self.headicon = game["headicon_axis"];
        self.headiconteam = "axis";
      }
    }
    else
    {
      self.headicon = "";
    }
  }
}

_cmd_Head_Icon()
{
  self endon("disconnect");

  if (!level.drawfriend)
    return;

  if ( isDefined(self.headiconteam) )
    self.headiconteam = "none";
  self.headicon = game["headicon_protected"];

  while (self.protectiontime)
  {
    if (!self.spawnprotected)
      break;

    wait .5;
  }
  self _cmd_Return_Head_Icon();
}


//------AFK Monitor-------------------------------------------------------------
// Original code by bullet-worm
AFK_Monitor()
{
  level.b3_afklimit = getdvarint("b3_afklimit");
  if(self.pers["team"] != "spectator" && level.b3_afklimit > 0)
  {
    self endon("disconnect");
    self endon("killed_player");
    self endon("stop_afk_monitor");
    level endon("intermission");
    level endon("trm_killthreads");
  
    old_origin = self.origin;
    afk_limit = level.b3_afklimit * 2;
    afk_time = 0;
  
    while (1)
    {
      wait 0.5;
  
      if (self.sessionstate != "playing" || 
        (isDefined(self.healing) && self.healing) || 
        (isDefined(self.beinghealed) && self.beinghealed ) ||
        (isDefined(self.bomb_interraction) && self.bomb_interraction ) )
  
      {
        afk_time = 0;
        wait 5;
        continue;
      }
  
      new_origin = self.origin;
  
      if (old_origin == new_origin)
        afk_time++;
      else
      {
        old_origin = new_origin;
        afk_time = 0;
        continue;
      }
  
      if (afk_time >= afk_limit)
      {
        thisPlayerNum = self getEntityNumber();
        setdvar("g_switchspec", thisPlayerNum);
        self iprintlnbold("^7You were moved to Spec for being AFK");
        return;
      }
      if (afk_time == afk_limit - 30)
      {
        self iprintlnbold("^1Warning!^7 You seem to be AFK!");
        self iprintlnbold("^7Soon you will be forced to spectator if you don't start moving");
      }
    }
  }
}
