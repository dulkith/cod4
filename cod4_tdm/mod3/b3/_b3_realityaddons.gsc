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
  // Add PreCache Stuff here
}

SetupDvars()
{
  if (getdvar("b3_reality_enable") == "")
    setdvar("b3_reality_enable", "0");

  if (getdvar("b3_distortaim") == "")
    setdvar("b3_distortaim", "0");

  if (getdvar("b3_pronepause") == "")
    setdvar("b3_pronepause", "0");

  if (getdvar("b3_proneaim") == "")
    setdvar("b3_proneaim", "70");

  if (getdvar("b3_fallDamageModifier") == "")
    setdvar("b3_fallDamageModifier", "0");

  if (getdvar("b3_bob") == "")
    setdvar("b3_bob", "0");

  if (getdvar("b3_viewshift") == "")
    setdvar("b3_viewshift", "0");
}

StartThreads()
{
	if (getdvarint("b3_reality_enable") < 1)
		return;

  wait .05;
  level endon("trm_killthreads");

  if (getdvar("b3_fallDamageModifier") == "1") FallDamageInit();
  thread onPlayerConnect();
}


//------Threads and Functions---------------------------------------------------

FallDamageInit()
{
	// Fall Damage Heigths (in feet)
	min = 0;
	max = 0;
	if(getDvar("b3_fallDamageMinHeight") == "")
		setDvar("b3_fallDamageMinHeight", "16");
	min = getdvarfloat("b3_fallDamageMinHeight");
	if(getDvar("b3_fallDamageMaxHeight") == "")
		setDvar("b3_fallDamageMaxHeight", "21");
	max = getdvarfloat("b3_fallDamageMaxHeight");

	min = int(min * 12);
	max = int(max * 12);
	setdvar("bg_fallDamageMaxHeight", max);
	setdvar("bg_fallDamageMinHeight", min);
}

onPlayerConnect()
{
  level endon("trm_killthreads");

  for(;;)
  {
    level waittill("connecting", player);
    if(level.b3_debug == true)
      iprintln("Debug (REC): Player Connected...");
    player thread onPlayerSpawned();
    player thread onPlayerKilled();
  }
}

onPlayerSpawned()
{
  self endon("disconnect");

  for(;;)
  {
    self waittill("spawned_player");
    
    if(level.b3_debug == true)
      iprintln("Debug (REC): Player Spawned...");

    self thread pronePause();
    self thread distortAim();
    self thread playerBobFactor();
  }
}

onPlayerKilled()
{
  self endon("disconnect");

  for(;;)
  {
    self waittill("killed_player");
    
    if(level.b3_debug == true)
      iprintln("Debug (REC): Player Killed...");

    self thread CleanupKilled();
  }
}


//------Disable weapon on prone timer-------------------------------------------
// Original code by Wanna Ganoush
pronePause()
{
  level.b3_pronepause = getdvarint("b3_pronepause");  // 0=disable 1=weaponpause 2=aimswirl 3=viewshift
  level.b3_proneaim = getdvarint("b3_proneaim");      // For the ammount of aimswirling (default 70)
  level.b3_viewshift = getdvarint("b3_viewshift");    // For the amount of viewshift

  if(self.pers["team"] != "spectator" && level.b3_pronepause > 0)
  {

    self endon("killed_player");
    self endon("disconnect");
    level endon("intermission");
    level endon("trm_killthreads");

    wait 0.5;
    // Attach spinemarker, used by GetStance()
    self.spinemarker = spawn("script_origin",(0,0,0));
    self.spinemarker linkto (self, "J_Spine4",(0,0,0),(0,0,0));   
  
    first = true;
    last = 0;
    for(;;)
    {
      //sStance = self trm\_util::GetStance(false);
      sStance = self GetStance();

      if(sStance == 2 && last != 2 && !first)
      {
        // Decide what we need to do:
        if(level.b3_pronepause == 1)
          weaponPause(0.4 + randomInt(5)/10);
        if(level.b3_pronepause == 2)
          self.swaytime = level.b3_proneaim;
        if(level.b3_pronepause == 3)
          ViewShift(level.b3_viewshift);
      }

      last = sStance;
      first = false;
      wait(0.05);
    }
  }
}

// Code to give the player a swirl when getting shot.
viewShift(severity)
{
  //Hit causes random aimpoint shift
  if(!isDefined(severity) || severity < 3) severity = randomint(10)+5;
  else severity = int(severity);
  if(severity > 45) severity = 45;
  pShift = randomint(severity) - randomInt(severity);
  yShift = randomint(severity) - randomInt(severity);
  self setPlayerAngles(self.angles + (pShift, yShift, 0));
  
  return;
}

// Disable weapon
// Code by SpacepiG (TRM)
weaponPause(waittime)
{
  self endon("killed_player");
  self endon("spawned");
  level endon("intermission");

  self disableWeapons();
  wait waittime;
  while(self UseButtonPressed())
    wait(0.05);
  self enableWeapons();
  return;
}

// Method to determine a player's current stance
// Code by Bell (AWE))
GetStance()
{
  if(isdefined(self.spinemarker))
  {
    distance = self.spinemarker.origin[2] - self.origin[2];
    if(distance<18)
      return 2;
    else if(distance<43)
      return 1;
    else
      return 0;
  }
  else
    return 0;
}


CleanupKilled()
{
  // Remove spine marker if present
  if(isdefined(self.spinemarker))
  {
    self.spinemarker unlink();
    self.spinemarker delete();
  }
}


// Original code by Wanna Ganoush
distortAim()
{
  level.b3_distortaim = getdvarint("b3_distortaim");

  if(self.pers["team"] != "spectator")
  {

    self endon("killed_player");
    self endon("disconnect");
    level endon("intermission");
    level endon("trm_killthreads");
    
    horiz[1] = .26;
    horiz[2] = .26;
    horiz[3] = .25;
    horiz[4] = .25;
    horiz[5] = .25;
    horiz[6] = .25;
    horiz[7] = .25;
    horiz[8] = .25;
    horiz[9] = .25;
    horiz[10] = .25;
    horiz[11] = .25;
    horiz[12] = .15;
    horiz[13] = .13;
    vert[1] = 0.0;
    vert[2] = 0.025;
    vert[3] = 0.036;
    vert[4] = 0.037;
    vert[5] = 0.053;
    vert[6] = 0.072;
    vert[7] = 0.080;
    vert[8] = 0.100;
    vert[9] = 0.11;
    vert[10] = 0.15;
    vert[11] = 0.244;
    vert[12] = 0.238;
    vert[13] = 0.085;
    
    wait 1;
    self.swaytime = 0;
    i = 1;
    idir = 0;
    pshift = 0;
    yshift = 0;
    
    
    for(;;)
    {
      VMag = 0;
      YMag = 0;
    
      if (level.b3_distortaim != 0 && int(self.health) < 98)
      {
        VMag = 10 / self.health;
        YMag = 10 / self.health;
      }
      else if (self.swaytime > 0)
      {
        VMag = self.swaytime / 125;
        YMag = self.swaytime / 40;
        self.swaytime = self.swaytime - 1;
      }

      //VMag = self.VaxisMag;
      //YMag = self.YaxisMag;

      if(i >= 1 && i <= 13)
      {
        pShift = horiz[i]*VMag;
        yShift = (0 - vert[i])*YMag;
      }
      else if(i >= 14 && i <= 26)
      {
        j = 14 - (i -13);
        pShift = (0 - horiz[j])*VMag;
        yShift = (0 - vert[j])*YMag;
      }
      else if(i >= 27 && i <= 39)
      {
        pShift = (0-horiz[i-26])*VMag;
        yShift = (vert[i-26])*YMag;
      }
      else if(i >= 40 && i <= 52)
      {
        j = 14 - (i -39);
        pShift = (horiz[j])*VMag;
        yShift = (vert[j])*YMag;
      }
        angles = self getplayerangles();
        self setPlayerAngles(angles + (pShift, yShift, 0));
        if(randomInt(50) == 0)
      {
        if(idir == 0) idir = 1;
        else idir = 0;
        i = i + 26;
      }
        if(idir == 0) i++;
        if(idir == 1) i--;
        if( i > 52) i = i - 52;
        if( i < 0) i = 52 - i;
      
      //if(level.b3_debug == true)
      //{
      //  iprintln("DIS health: " + self.health);
      //  iprintln("DIS V: " + VMag);
      //  iprintln("DIS Y: " + YMag);
      //}
      //wait 1;
      wait 0.03;
    }
  }
}

playerBobFactor()
{
  self endon("killed_player");
  self endon("disconnect");
  level endon("intermission");
  level endon("trm_killthreads");

	level.b3_bob = getdvarint("b3_bob");
	if(level.b3_bob == 1)
	{
    while (isPlayer(self) && self.sessionstate == "playing")
  	{
  		if(isPlayer(self)) self setClientDvar("bg_bobMax", "4");								// Default 8
  		wait 0.5;
  		if(isPlayer(self)) self setClientDvar("bg_bobAmplitudeStanding", "0.02");	// Default 0.007
  		wait 0.5;
  		if(isPlayer(self)) self setClientDvar("bg_bobAmplitudeDucked", "0.02");		// Default 0.0075
  		wait 0.5;
  		if(isPlayer(self)) self setClientDvar("bg_bobAmplitudeProne", "0.03");		// Default 0.03
  		wait 2.5;
  	}
  }
}
