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
  // Precache stuff goes here
}

SetupDvars()
{
  if (getdvar("b3_droponhandhit") == "")
    setdvar("b3_droponhandhit", "0");
  level.b3_droponhandhit = getdvarint("b3_droponhandhit");

  if (getdvar("b3_droponarmhit") == "")
    setdvar("b3_droponarmhit", "0");
  level.b3_droponarmhit = getdvarint("b3_droponarmhit");

  if (getdvar("b3_viewshiftdamaged") == "")
    setdvar("b3_viewshiftdamaged", "1");
  level.b3_viewshiftdamaged = getdvarint("b3_viewshiftdamaged");

	wait .05;
  level.b3_orignalPlayerDamage = level.callbackPlayerDamage;	  			// [[level.b3_orignalPlayerDamage]]
	level.callbackPlayerDamage = b3\_b3_playerdamage::b3playerdamage;  	// [[level.callbackPlayerDamage]]
}

StartThreads()
{
}

//------Threads and Functions---------------------------------------------------

b3PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime)
{
	self endon("disconnect");

	if(level.b3_droponhandhit == 1)
		if(sHitLoc == "left_hand" || sHitLoc == "right_hand" || sHitLoc == "gun")
			self dropItem(self getcurrentweapon());


	if(level.b3_droponarmhit == 1)
		if(sHitLoc == "left_arm_lower" || sHitLoc == "right_arm_lower" || sHitLoc == "left_arm_upper" || sHitLoc == "right_arm_upper")
			self dropItem(self getcurrentweapon());

	if(level.b3_viewshiftdamaged == 1)
	  self thread viewShift(level.b3_viewshiftdamaged);
	
  [[level.b3_orignalPlayerDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
}


//------ViewShift-------------------------------------------------------------

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
}

