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
  //
}

SetupDvars()
{
  if (getdvar("b3_music") == "")
    setdvar("b3_music", "1");
  level.b3_music = getdvarint("b3_music");

  if (getdvar("b3_music") == "")
    setdvar("b3_deathmusic", "1");
  level.b3_deathmusic = getdvarint("b3_deathmusic");

  if (getdvar("b3_music") == "")
    setdvar("b3_specmusic", "1");
  level.b3_specmusic = getdvarint("b3_specmusic");
  
  if (getdvar("trm_map_vote_time") == "")
    level.b3_wait_time = 0;
  else
    level.b3_wait_time = getdvarint("trm_map_vote_time");
}

StartThreads()
{
  wait .1;
	if (level.b3_music == 0)
		return;

  level endon("trm_killthreads");

  thread onIntermission();
  thread onPlayerConnect();
}

//------Threads and Functions---------------------------------------------------
onIntermission()
{
  level endon("trm_killthreads");

  while(1)
  {
    if(level.mapended)
    {
      level thread endingmusic();
    }
    wait .5;
  }
}

onPlayerConnect()
{
  level endon("trm_killthreads");

  for(;;)
  {
    level waittill("connecting", player);
    
    if(level.b3_debug == true)
      iprintln("Debug (MUS): Player Connected...");
    
    player thread onPlayerSpawned();
    
    if(level.b3_deathmusic == 1)
      player thread onPlayerKilled();
    
    if(level.b3_specmusic == 1)
      player thread onPlayerJoinedSpec();
    
    player thread stopmusic();
  }
}

onPlayerSpawned()
{
  self endon("disconnect");

  for(;;)
  {
    self waittill("spawned_player");
    
    if(level.b3_debug == true)
      iprintln("Debug (MUS): Player Spawned...");

    // Kill Local music
    self playLocalSound("spec_music_null");
  }
}

onPlayerKilled()
{
  self endon("disconnect");

  for(;;)
  {
    self waittill("killed_player");
    
    if(level.b3_debug == true)
      iprintln("Debug (MUS): Player Killed...");

    //self.pers["deathmusic_on"] = true;
    self thread deathmusic();
  }
}


onPlayerJoinedSpec()
{
  self endon("disconnect");

  for(;;)
  {
    self waittill("joined_spectators");
    
    if(level.b3_debug == true)
      iprintln("Debug (MUS): Joined Spectators...");

    //self.pers["specmusic_on"] = true;
    self thread specmusic();
  }
}

stopmusic()
{
  level endon("trm_killthreads");

  while(1)
  {
    if(level.mapended)
    {
      self playLocalSound("spec_music_null");
    }
    wait .5;
  }
}

endingmusic()
{
  if(level.b3_debug == true)
    iprintln("Debug (MUS): Starting Ending Music...");

  musictime = level.b3_wait_time + 12;
  musicplay("ending_music");
  wait musictime;
  musicstop(3);
}

deathmusic()
{
  self playLocalSound("death_music");
}

specmusic()
{
  self playLocalSound("spec_music");
}
