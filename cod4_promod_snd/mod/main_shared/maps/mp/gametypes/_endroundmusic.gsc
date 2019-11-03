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
	thread partymode();   
	song = (1+randomInt(24));
	level thread playSoundOnAllPlayers( "endround" + song );   
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
		if(player.pers["killCamMusic"] == 0){
     	 		player playLocalSound( soundAlias );
		}else if (player.pers["killCamMusic"] == 1){
			player iPrintln( "You ^1Muted^7 Kill-Cam Music, ^7Type ^1!kmusic ^7to enable." );
			notifyData = spawnstruct();
			notifyData.notifyText =  "You ^1Muted^7 Kill-Cam Music, ^7Type ^1!kmusic ^7to un-Mute."; //Title
			notifyData.glowColor = (1, 0, 0); //RGB Color array divided by 100
			notifyData.duration = 6.0;
			player thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
		}


   	}
}
playSoundOnAllPlayersX( soundAlias )
{
   	for( i = 0; i < getEntArray( "player", "classname" ).size; i++ )
	{
		getEntArray( "player", "classname" )[i] playLocalSound( soundAlias );

	}
}
