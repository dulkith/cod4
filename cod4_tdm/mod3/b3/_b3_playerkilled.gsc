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
}

SetupDvars()
{
  if (getdvar("b3_extobituary") == "")
    setdvar("b3_extobituary", "0");
  level.b3_extobituary = getdvarint("b3_extobituary");

  wait .05;
  level.b3_orignalPlayerKilled = level.callbackPlayerKilled;	  			// [[level.b3_orignalPlayerKilled]]
	level.callbackPlayerKilled = b3\_b3_playerkilled::b3PlayerKilled;  	// [[level.callbackPlayerKilled]]
}

StartThreads()
{
}

//------Threads and Functions---------------------------------------------------

b3PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration)
{
	self endon("disconnect");

	if(self.sessionteam == "spectator")
		return;

  // Send extended Obituaries
  if(level.b3_extobituary == 1)
    thread ExtendedObituary(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration);

  [[level.b3_orignalPlayerKilled]](eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration);
}


//------Extended Obituaries-----------------------------------------------------

ExtendedObituary(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration)
{
  if(isPlayer(attacker) && attacker != self && sMeansOfDeath != "MOD_MELEE" && sWeapon != "frag_grenade_british_mp" && sWeapon != "frag_grenade_american_mp" && sWeapon != "frag_grenade_russian_mp" && sWeapon != "frag_grenade_german_mp" && sWeapon != "potato_mp")
  {
    hitlocation = "";
    
    if(sHitLoc == "head")
      hitlocation = "Head ";
    if(sHitLoc == "helmet")
      hitlocation = "Helmet ";
    if(sHitLoc == "neck")
      hitlocation = "Neck ";
    if(sHitLoc == "torso_upper")
      hitlocation = "Upper Torso ";
    if(sHitLoc == "torso_lower")
      hitlocation = "Lower Torso ";
    if(sHitLoc == "right_arm_upper")
      hitlocation = "Upper Right Arm ";
    if(sHitLoc == "right_arm_lower")
      hitlocation = "Lower Right Arm ";
    if(sHitLoc == "right_hand")
      hitlocation = "Right Hand ";
    if(sHitLoc == "left_arm_upper")
      hitlocation = "Upper Left Arm ";
    if(sHitLoc == "left_arm_lower")
      hitlocation = "Lower Left Arm ";
    if(sHitLoc == "left_hand")
      hitlocation = "Left Hand ";
    if(sHitLoc == "right_leg_upper")
      hitlocation = "Upper Right Leg ";
    if(sHitLoc == "right_leg_lower")
      hitlocation = "Lower Right Leg ";
    if(sHitLoc == "right_foot")
      hitlocation = "Right Foot ";
    if(sHitLoc == "left_leg_upper")
      hitlocation = "Upper Left Leg ";
    if(sHitLoc == "left_leg_lower")
      hitlocation = "Lower Left Leg ";
    if(sHitLoc == "left_foot")
      hitlocation = "Left Foot ";
    
    weapon = "unknown weapon";
    if(sWeapon != "")
      weapon= sWeapon;
    
    //American
    if(sWeapon == "greasegun_mp")
      weapon= "Greese Gun";
    if(sWeapon == "m1carbine_mp")
      weapon = "M1 Carbine";
    if(sWeapon == "m1garand_mp")
      weapon = "M1 Garand";
    if(sWeapon == "springfield_mp")
      weapon = "Springfield";
    if(sWeapon == "thompson_mp")
      weapon = "Thompson";
    if(sWeapon == "bar_mp")
      weapon = "Bar";
    
    //British
    if(sWeapon == "sten_mp")
      weapon = "Sten";
    if(sWeapon == "enfield_mp")
      weapon = "Enfield";
    if(sWeapon == "enfield_scope_mp")
      weapon = "Enfield Scope";
    if(sWeapon == "bren_mp")
      weapon = "Bren";
    
    //Russian
    if(sWeapon == "pps42_mp")
      weapon = "PPS42";
    if(sWeapon == "mosin_nagant_mp")
      weapon = "Mosin Nagant";
    if(sWeapon == "svt40_mp")
      weapon = "SVT40";
    if(sWeapon == "mosin_nagant_sniper_mp")
      weapon = "Scoped Mosin Nagant ";
    if(sWeapon == "ppsh_mp")
      weapon = "PPSH";
    
    //German
    if(sWeapon == "mp40_mp")
      weapon = "MP40";
    if(sWeapon == "kar98k_mp")
      weapon = "Kar98k";
    if(sWeapon == "g43_mp")
      weapon = "G43";
    if(sWeapon == "kar98k_sniper_mp")
      weapon = "Scoped Kar98k";
    if(sWeapon == "mp44_mp")
      weapon = "MP44";
    if(sWeapon == "g43_sniper_mp")
      weapon = "Scoped G43";
    
    //Pistols
    if(sWeapon == "colt_mp")
      weapon = "Colt";
    if(sWeapon == "luger_mp")
      weapon = "Luger";
    if(sWeapon == "TT30_mp")
      weapon = "TT30";
    if(sWeapon == "webley_mp")
      weapon = "Webley";
    if(sWeapon == "mp5_mp")
      weapon = "MP5";
    if(sWeapon == "9mm_mp")
      weapon = "9MM";
    
    //Other
    if(sWeapon == "shotgun_mp")
      weapon = "NOOB GUN";
    if(sWeapon == "30cal_prone_mp")
      weapon = "30cal";
    if(sWeapon == "30cal_stand_mp")
      weapon = "30cal";
    if(sWeapon == "mg42_bipod_duck_mp")
      weapon = "MG42";
    if(sWeapon == "mg42_bipod_prone_mp")
      weapon = "MG42";
    if(sWeapon == "mg42_bipod_stand_mp")
      weapon = "MG42";
    
    distance = distance(Attacker.origin , self.origin);
    meters = distance * 0.0254;
    name = self.name;
    killer = attacker.name;
    
    if(sWeapon == "panzerschreck_mp")
    {
      iprintln("^5" + name + "^7 was killed from ^5" + meters + "^7 meters with a ^5Bazooka ^7 by ^5" + killer +"^7!!");
      self iprintlnBold("Shot ^7from ^5" + meters + "^7 meters with a ^5Bazooka ^7 by ^5" + killer +"^7!!");
    }
    else
    {
      iprintln("^5" + name + "^7 was killed by a ^5" + hitlocation + "shot ^7from ^5" + meters + "^7 meters with a ^5" + weapon + "^7 by ^5" + killer +"^7!");
      self iprintlnBold("^5" + hitlocation + "shot ^7from ^5" + meters + "^7 meters with a ^5" + weapon + "^7 by ^5" + killer +"^7!");
    }
  }
  
  name = self.name;
  killer = attacker.name;
  
  if(isPlayer(attacker) && attacker != self && sMeansOfDeath == "MOD_MELEE")
  {
    self iprintlnBold("You were ^5Bashed^7!");
    iprintln("^5Bashed^7!");
  }
  if(sWeapon == "frag_grenade_american_mp")
  {
    iprintln("" + name + "^7 was ^5naded^7 by ^5" + killer +"^7!");
    self iprintlnBold("You were ^5naded^7 by ^5" + killer +"^7!");
  }
  if(sWeapon == "frag_grenade_russian_mp")
  {
    iprintln("" + name + "^7 was ^5naded^7 by ^5" + killer +"^7!");
    self iprintlnBold("You were ^5naded^7 by ^5" + killer +"^7!");
  }
  if(sWeapon == "frag_grenade_british_mp")
  {
    iprintln("" + name + "^7 was ^5naded^7 by ^5" + killer +"^7!");
    self iprintlnBold("You were ^5naded^7 by ^5" + killer +"^7!");
  }
  if(sWeapon == "frag_grenade_german_mp")
  {
    iprintln("" + name + "^7 was ^5naded^7 by ^5" + killer +"^7!");
    self iprintlnBold("You were ^5naded^7 by ^5" + killer +"^7!");
  }
}
