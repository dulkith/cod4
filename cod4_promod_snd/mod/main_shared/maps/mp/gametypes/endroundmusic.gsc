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
	song = (1+randomInt(16));
	level thread playSoundOnAllPlayers( "endround" + song );   
	iPrintlnBold( "^1LOL");
}
AddEndRoundMusic(name)
{
	if(!isDefined(level.endroundmusic))
		level.endroundmusic = [];
	level.endroundmusic[level.endroundmusic.size] = name;
}
partymode()
{
	for(;;)
	{	
		SetExpFog(256, 900, 1, 0, 0, 0.1); 
        wait .2; 
        SetExpFog(256, 900, 0, 1, 0, 0.1); 
        wait .2;
        SetExpFog(256, 900, 0, 0, 1, 0.1); 
		wait .2;
        SetExpFog(256, 900, 0.4, 1, 0.8, 0.1); 
        wait .2; 
        SetExpFog(256, 900, 0.8, 0, 0.6, 0.1); 
        wait .2; 
        SetExpFog(256, 900, 1, 1, 0.6, 0.1); 
        wait .2;
        SetExpFog(256, 900, 1, 1, 1, 0.1); 
        wait .2; 
        SetExpFog(256, 900, 0, 0, 0.8, 0.1); 
        wait .2; 
        SetExpFog(256, 900, 0.2, 1, 0.8, 0.1); 
        wait .2;
        SetExpFog(256, 900, 0.4, 0.4, 1, 0.1); 
        wait .2;
        SetExpFog(256, 900, 0, 0, 0, 0.1); 
        wait .2; 
        SetExpFog(256, 900, 0.4, 0.2, 0.2, 0.1); 
        wait .2;
        SetExpFog(256, 900, 0.4, 1, 1, 0.1); 
		wait .2;
        SetExpFog(256, 900, 0.6, 0, 0.4, 0.1); 
        wait .2;
        SetExpFog(256, 900, 1, 0, 0.8, 0.1); 
        wait .2;
        SetExpFog(256, 900, 1, 1, 0, 0.1); 
        wait .2;
        SetExpFog(256, 900, 0.6, 1, 0.6, 0.1); 
        wait .2;
        SetExpFog(256, 900, 1, 0, 0, 0.1); 
        wait .2;
        SetExpFog(256, 900, 0, 1, 0, 0.1); 
        wait .2; 
        SetExpFog(256, 900, 0, 0, 1, 0.1); 
        wait .2;
        SetExpFog(256, 900, 0.4, 1, 0.8, 0.1); 
        wait .2;
        SetExpFog(256, 900, 0.8, 0, 0.6, 0.1); 
        wait .2; 
        SetExpFog(256, 900, 1, 1, 0.6, 0.1); 
        wait .2; 
        SetExpFog(256, 900, 1, 1, 1, 0.1); 
        wait .2; 
        SetExpFog(256, 900, 0, 0, 0.8, 0.1); 
        wait .2; 
        SetExpFog(256, 900, 0.2, 1, 0.8, 0.1); 
        wait .2;
        SetExpFog(256, 900, 0.4, 0.4, 1, 0.1); 
        wait .2;
        SetExpFog(256, 900, 0, 0, 0, 0.1); 
        wait .2;
        SetExpFog(256, 900, 0.4, 0.2, 0.2, 0.1); 
        wait .2;
        SetExpFog(256, 900, 0.4, 1, 1, 0.1); 
        wait .2;
        SetExpFog(256, 900, 0.6, 0, 0.4, 0.1); 
        wait .2;
        SetExpFog(256, 900, 1, 0, 0.8, 0.1); 
        wait .2;
        SetExpFog(256, 900, 1, 1, 0, 0.1); 
        wait .2; 
        SetExpFog(256, 900, 0.6, 1, 0.6, 0.1); 
	}
}
playSoundOnAllPlayers( soundAlias )
{
	for( i = 0; i < getEntArray( "player", "classname" ).size; i++ )
	{
		getEntArray( "player", "classname" )[i] playLocalSound( soundAlias );

	}
}

