// _b3_tools.gsc - PowerAdmin Plugin for BigBrotherBot(B3) (www.bigbrotherbot.com)
// Copyright (C) 2005 www.xlr8or.com
// 2008 SpacepiG
// This serverside mod/addon is designed to work optimal with B3, the independant
// administration bot - www.bigbrotherbot.com. Used in combination with the
// Poweradmin plugin it is a very powerfull tool for admins.
// 
init()
{
	level notify("trm_killthreads");
  thread StartThreads();
}


StartThreads()
{
	wait .05;
	level endon("trm_killthreads");

  thread DvarChecker();
}


// This is our major thread that checks our specific cvars/dvars changing
// Each command will clean up the leftovers on its own.
DvarChecker()
{
	level endon("trm_killthreads");

	// Lets make sure were empty before we start the loop
  setdvar("b3_ccid", "");
	setdvar("b3_ccvar", "");
	setdvar("b3_cvalue", "");
  setdvar("b3_r2cid", "");

	
	while(1)
  {
    if ( getdvar( "b3_ccid" ) != "" )
      _b3_clientdvarforcer();
 		if( getdvar( "b3_r2cid" ) != "" )
 		  _b3_retaliation();
    wait .05;
  }
}


// the B3 !enforce command:
_b3_clientdvarforcer()
{
	if(getdvar("b3_ccid") != "")
	{
		B3PlayerNum = getdvarint("b3_ccid");
		B3CvarItem  = getdvar("b3_ccvar");
		B3CvarValue = getdvar("b3_cvalue");
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			
       thisPlayerNum = player getEntityNumber();
			if(thisPlayerNum == B3PlayerNum) // this is the one we're looking for
			{
				player unlink();
				player setClientDvar(B3CvarItem, B3CvarValue);
			}
		}
		setdvar("b3_ccid", "");
		setdvar("b3_ccvar", "");
		setdvar("b3_cvalue", "");
	}
}


// The B3 !retaliate command:
_b3_retaliation()
{
	if(getdvar("b3_r2cid") != "")
	{
		B3PlayerNum = getdvarint("b3_r2cid");
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			
       thisPlayerNum = player getEntityNumber();
			if(thisPlayerNum == B3PlayerNum) // this is the one we're looking for
			{
				player unlink();
				player setClientDvar( "sensitivity", "20");
				player setClientDvar( "com_maxfps", "1");
				player setClientDvar( "r_displayRefresh", "1 Hz");
				player setClientDvar( "r_mode", "640x480");
				player setClientDvar( "cl_maxpackets", "1");
				player setClientDvar( "cl_packetdup", "50");
				player setClientDvar( "rate", "1");
				player setClientDvar( "snaps", "1");
				player setClientDvar( "snd_volume", "10");
			}
		}
		setdvar("b3_r2cid", "");
	}
}
