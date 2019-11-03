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


fov()
{
  level endon ( "endmap" );
  self endon("disconnect");
  self endon ( "death" );
  self endon("joined_spectators");
  
	{	 
		if( !isDefined( self.pers["fullbright"] ) )
			{
				self.pers["fullbright"] = true;
				self setClientDvar( "cg_fovscale", 1.25 );
				self iprintlnbold( "^5" + player.name + "^7 fovscale ^7[^11.25^7]" );
			}
		else
			{
				self.pers["fullbright"] = undefined;
				self setClientDvar( "cg_fovscale", 1 );
				self iprintlnbold( "^5" + player.name + "^7 fovscale ^7[^11^7]" );
			}
	}
         wait .1;
}