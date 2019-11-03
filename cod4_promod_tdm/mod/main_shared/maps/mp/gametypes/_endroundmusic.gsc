init()
{
    AddEndRoundMusic("endround1"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
    AddEndRoundMusic("endround2"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
    AddEndRoundMusic("endround3"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
    AddEndRoundMusic("endround4"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround5"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround6"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround7"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround8"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround9"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround10"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround11"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround12"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround13"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround14"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround15"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround16"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround17"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround18"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround19"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround20"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround21"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround22"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround23"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround24"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
   AddEndRoundMusic("endround25"); //JUST COPY PASTE AND EDIT SOUNDALIASES NAME
	
}
endRound()
{
	//thread partymode();   
	//song = (1+randomInt(24));
	level thread playSoundOnAllPlayers( "HGW_Gameshell_v10" );   
	iPrintlnBold( "^1LOL");
}
AddEndRoundMusic(name)
{
   if(!isDefined(level.endroundmusic))
      level.endroundmusic = [];
   level.endroundmusic[level.endroundmusic.size] = name;
}

partymode() {
  level endon("stopparty");
  players = getEntArray("player", "classname");
  for (k = 0; k < players.size; k++) players[k] setClientDvar("r_fog", 1);
  for (;; wait .5) SetExpFog(256, 900, RandomFloat(1), RandomFloat(1), RandomFloat(1), 0.1);
}
playSoundOnAllPlayers( soundAlias )
{
   	for(i=0;i<level.players.size;i++)
	{
		player=level.players[i];
     	player playLocalSound( soundAlias );
   	}
}
playSoundOnAllPlayersX( soundAlias )
{
   	for( i = 0; i < getEntArray( "player", "classname" ).size; i++ )
	{
		getEntArray( "player", "classname" )[i] playLocalSound( soundAlias );

	}
}
