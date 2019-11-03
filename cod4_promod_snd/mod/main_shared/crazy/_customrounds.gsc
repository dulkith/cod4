init()
{
	addRoundEvent(1, ::knifer, "^5Knife Round Starting In..." );
	//addRoundEvent(2, ::sniper, "^5SNIPER ROUND" );
}

sniper()
{
	if(level.gametype != "sd")
	return;

	players = getEntArray("player", "classname");

	for(i = 0; i < players.size ; i++)
		players[i] thread _giveWeapons("m40a3","knife");
}

knifer()
{
	if(level.gametype != "sd")
	return;
	
	players = getEntArray("player", "classname");

	for(i = 0; i < players.size ; i++)
		players[i] setClientDvar("g_compassShowEnemies", 1 );
}
_giveWeapons(primary,secondary)
{	
	self endon("disconnect");
	if(isDefined(self.customRoundWeapon)) return;
	self.customRoundWeapon = true;
	self takeAllWeapons();
	if(isDefined(primary))
	self giveWeapon(primary + "_mp");
	
	if(isDefined(secondary))
	self giveWeapon(secondary + "_mp");
	wait 0.05;
	if(isDefined(primary))
	self switchToWeapon(primary + "_mp");
	else
	self switchToWeapon(secondary + "_mp");
}
addRoundEvent( value, eventFunc, stratText )
{
	if ( ! isDefined( level.roundEvents ) )
		level.roundEvents = [];
	
	value--;
	level.roundEvents[value] = spawnStruct();
	
	level.roundEvents[value].function = eventFunc;
	level.roundEvents[value].text = stratText;
}

executeRoundEvents()
{
	if ( ! isDefined( level.roundEvents ) || ! isDefined( game["roundsplayed"] ))
		return;
		
	if(isDefined(level.roundEvents[game["roundsplayed"]]))
		[[level.roundEvents[game["roundsplayed"]].function]]();
}
stratText(eredeti)
{
	if ( ! isDefined( level.roundEvents ) || ! isDefined( game["roundsplayed"] ))
		return eredeti;
		
	if(isDefined(level.roundEvents[game["roundsplayed"]]))
		return level.roundEvents[game["roundsplayed"]].text;
	
	return eredeti;
}