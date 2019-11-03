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
  game["hud_text_guid"] = &"Please Reconnect! Your CD Key was not validated!";
  precacheString(game["hud_text_guid"]);
  game["hud_text_guidhint"] = &"To reconnect open console with the ~ key and type /reconnect";
  precacheString(game["hud_text_guidhint"]);
}

SetupDvars()
{
  if (getdvar("b3_guidcontrol_enable") == "")
    setdvar("b3_guidcontrol_enable", "0");

  if (getdvar("b3_guidspec") == "")
    setdvar("b3_guidspec", "0");

  if (getdvar("b3_guidshow") == "")
    setdvar("b3_guidshow", "0");
}

StartThreads()
{
	if (getdvarint("b3_guidcontrol_enable") < 1)
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
      iprintln("Debug (GUID): Player Connected...");

    player thread onPlayerSpawned();
  }
}


onPlayerSpawned()
{
  self endon("disconnect");
  self.looping = false;

  for(;;)
  {
    self waittill("spawned_player");
    self.guid = self GetGuid();
    
    if(level.b3_debug == true)
      iprintln("Debug (GUID): Player Spawned...");

    // Now start the threads
    if (self.looping != true)
      self thread hud_loop();

    if(!isDefined(self.guidshown) && getdvarint("b3_guidshow") == 1)
      self thread showMyGuid();
    
    self thread specCheck();
  }
}


//------Guid Check Functions----------------------------------------------------
showMyGuid()
{
  wait 3;
  self iprintln("^7You connected with Guid: ^5" + self.guid + "^7");
  self.guidshown = true;
}


specCheck()
{
  level.b3_guidspec = getdvarint("b3_guidspec");
  while(self.guid == 0)
  {
    if(self.sessionstate != "spectator" && level.b3_guidspec == 1)
    {
      self iprintlnbold ("^1*** ^7Warning: You are not allowed to play with an invalid CD-Key ^1***^7");
      self.sessionstate = "spectator";
      self.sessionteam = "spectator";
      self.pers["team"] = "spectator";
      self.spectatorclient = -1;
    }
    wait 5;  
  }
}


hud_loop()
{
  wait 5;
  while(self.guid == 0)
  {
    self remove_guid_hud();
    self show_guid_hud();
    self show_guidhint_hud();
    self.looping = true;
    wait 20; // 20
    self remove_guid_hud();
    wait 90; // 90
  }
}


show_guid_hud()
{
  self.guid_hud = newClientHudElem(self);
  self.guid_hud.x = 0;
  self.guid_hud.y = -220;
  self.guid_hud.alignX = "center";
  self.guid_hud.alignY = "middle";
  self.guid_hud.horzAlign = "center_safearea";
  self.guid_hud.vertAlign = "center_safearea";
  self.guid_hud.alpha = 0;
  self.guid_hud.archived = false;
  self.guid_hud.font = "default";
  self.guid_hud.fontscale = 1.2;
  self.guid_hud.color = (0.999,0.001,0.001);
  self.guid_hud setText(game["hud_text_guid"]);
  self.guid_hud fadeOverTime(2);
  self.guid_hud.alpha = 1;
  
  return;
}

show_guidhint_hud()
{
  self.guidhint_hud = newClientHudElem(self);
  self.guidhint_hud.x = 0;
  self.guidhint_hud.y = -210;
  self.guidhint_hud.alignX = "center";
  self.guidhint_hud.alignY = "middle";
  self.guidhint_hud.horzAlign = "center_safearea";
  self.guidhint_hud.vertAlign = "center_safearea";
  self.guidhint_hud.alpha = 0;
  self.guidhint_hud.archived = false;
  self.guidhint_hud.font = "default";
  self.guidhint_hud.fontscale = 0.8;
  self.guidhint_hud.color = (0.999,0.999,0.999);
  self.guidhint_hud setText(game["hud_text_guidhint"]);
  self.guidhint_hud fadeOverTime(2);
  self.guidhint_hud.alpha = 1;
  
  return;
}

remove_guid_hud()
{
  if(isDefined(self.guid_hud))
  {
    self.guid_hud fadeOverTime(2);
    self.guid_hud.alpha = 0;
  }
  if(isDefined(self.guidhint_hud))
  {
    self.guidhint_hud fadeOverTime(2);
    self.guidhint_hud.alpha = 0;
  }
  wait 2;
  if(isDefined(self.guid_hud))
    self.guid_hud destroy();
  if(isDefined(self.guidhint_hud))
    self.guidhint_hud destroy();

  return;
}
