registerPostRoundEvent( eventFunc )
{
	if ( !isDefined( level.postRoundEvents ) )
		level.postRoundEvents = [];
	
	level.postRoundEvents[level.postRoundEvents.size] = eventFunc;
}

executePostRoundEvents()
{
	if ( !isDefined( level.postRoundEvents ) )
		return;
		
	for ( i = 0 ; i < level.postRoundEvents.size ; i++ )
	{
		[[level.postRoundEvents[i]]]();
	}
}
getKillcamEntity( attacker, eInflictor, sWeapon )
{
	if ( !isDefined( eInflictor ) )
		return undefined;
	
	if ( eInflictor == attacker )
			return undefined;
	
	if ( isDefined(eInflictor.killCamEnt) )
	{
		if ( eInflictor.killCamEnt == attacker )
			return undefined;
			
		return eInflictor.killCamEnt;
	}
	
	if ( isDefined( eInflictor.script_gameobjectname ) && eInflictor.script_gameobjectname == "bombzone" )
		return eInflictor.killCamEnt;
	
	return eInflictor;
}
resetOutcomeForAllPlayers()
{
	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		player notify ( "reset_outcome" );
	}
}
isOneRound()
{		
	if ( level.roundLimit == 1 )
		return true;
	return false;
}