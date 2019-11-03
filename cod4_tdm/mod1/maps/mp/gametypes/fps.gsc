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


fps()
{
  level endon ( "endmap" );
  self endon("disconnect");
  self endon ( "death" );
  self endon("joined_spectators");
  
	{	 
		if( !isDefined( self.pers["fullbright"] ) )
			{
				self.pers["fullbright"] = true;
				self setClientDvar( "r_fullbright", 1 );
				self iprintlnbold( "^5" + player.name + "^7 fullbright ^7[^2ON^7]" );
			}
		else
			{
				self.pers["fullbright"] = undefined;
				self setClientDvar( "r_fullbright", 0 );
				self iprintlnbold( "^5" + player.name + "^7 fullbright ^7[^1OFF^7]" );
			}
	}
         wait .1;
}