/*
 * 
 * Made by: Justin
 * Xfire: rumabatu
 * 
 */

init()
{
	if(!isDefined( level.event )) //Singleton
	{
		level.event = [];
		level.event[ "connecting" ] = [];
		level.event[ "connected" ] = [];
		level.event[ "spawned" ] = [];
		level.event[ "death" ] = [];
		level.event[ "killed" ] = [];
		level.event[ "disconnected" ] = [];
		level.event[ "joined_team" ] = [];
		level.event[ "joined_spectators" ] = [];
		level.event[ "menu_response" ] = [];
		level.event[ "weapon_fired" ] = [];
		
		level.on = ::addEvent; //create callback pointer for addEvent( event, proces )

		thread onPlayerConnecting();
		thread onPlayerConnected();
	}
}

addEvent( event, process )
{
	if( !isdefined( level.event[ event ] ) || !isdefined( process ))
		return;
	level.event[ event ][ level.event[ event ].size ] = process;
	
}

onPlayerConnecting()
{
	while(1)
	{
		level waittill( "connecting", player );
		for( i=0; i<level.event[ "connecting" ].size; i++ )
			player thread [[level.event[ "connecting" ][i]]]();
	}	
}

onPlayerConnected()
{
	while(1)
	{
		level waittill( "connected", player );

		player thread onPlayerSpawned();
		player thread onPlayerDeath();
		player thread onPlayerKilled();
		player thread onPlayerDisconnected();
		player thread onPlayerJoinedSpectators();
		player thread onPlayerJoinedTeam();
		player thread onPlayerMenuResponse();
		player thread onPlayerWeaponFired();
		for( i=0; i<level.event[ "connected" ].size; i++ )
			player thread [[level.event[ "connected" ][i]]]();
	}	
}

onPlayerSpawned()
{
	self endon( "disconnect" );

	while(1)
	{
		self waittill( "spawned_player" );
		for( i=0; i<level.event[ "spawned" ].size; i++ )
			self thread [[level.event[ "spawned" ][i]]]();
	}
}

onPlayerDeath()
{
	self endon( "disconnect" );

	while(1)
	{
		self waittill( "death" );
		for( i=0; i<level.event[ "death" ].size; i++ )
			self thread [[level.event[ "death" ][i]]]();
	}
}

onPlayerKilled()
{
	self endon( "disconnect" );

	while(1)
	{
		self waittill( "killed_player" );
		for( i=0; i<level.event[ "killed" ].size; i++ )
			self thread [[level.event[ "killed" ][i]]]();
	}
}

onPlayerJoinedTeam()
{
	self endon( "disconnect" );

	while(1)
	{
		self waittill( "joined_team" );
		for( i=0; i<level.event[ "joined_team" ].size; i++ )
			self thread [[level.event[ "joined_team" ][i]]]();
	}
}

onPlayerJoinedSpectators()
{
	self endon( "disconnect" );

	while(1)
	{
		self waittill( "joined_spectators" );
		for( i=0; i<level.event[ "joined_spectators" ].size; i++ )
			self thread [[level.event[ "joined_spectators" ][i]]]();
	}
}

onPlayerDisconnected()
{
	self waittill( "disconnect" );
	for( i=0; i<level.event[ "disconnected" ].size; i++ ) //gives infinite loop error?
		self thread [[level.event[ "disconnected" ][i]]]();
}

onPlayerMenuResponse()
{
	self endon( "disconnect" );

	while(1)
	{
		self waittill( "menuresponse", menu, response );
		for( i=0; i<level.event[ "menu_response" ].size; i++ )
			self thread [[level.event[ "menu_response" ][i]]]( menu, response );
	}
}

onPlayerWeaponFired()
{
	self endon( "disconnect" );

	while(1)
	{
		self waittill("weapon_fired");
		for( i=0; i<level.event[ "weapon_fired" ].size; i++ )
			self thread [[level.event[ "weapon_fired" ][i]]]();
	}
}