init( modVersion )
{
  for(;;)
  {
     
	 level waittill("player_spawn",player);
		player thread credit();  
  }
}

isReallyAlive()
{
	return self.sessionstate == "playing";
}
 
isPlaying()
{
	return isReallyAlive();
}


tps()
{
  level endon ( "endmap" );
  self endon("disconnect");
  self endon ( "death" );
  self endon("joined_spectators");
  
	{	 
		if( !isDefined( self.pers["thirdperson"] ) )
			{
				self.pers["thirdperson"] = true;
				self setClientDvar( "cg_thirdperson", 1 );
				self iprintlnbold( "^5" + player.name + "^7 thirdperson ^7[^2ON^7]" );
			}
		else
			{
				self.pers["thirdperson"] = undefined;
				self setClientDvar( "cg_thirdperson", 0 );
				self iprintlnbold( "^5" + player.name + "^7 thirdperson ^7[^1OFF^7]" );
			}
	}
         wait .1;
}