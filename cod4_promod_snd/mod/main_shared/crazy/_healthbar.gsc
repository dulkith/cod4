#include maps\mp\gametypes\_hud_util;

init()
{
	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for( ;; )
	{
		level waittill( "connecting", player );
		player thread onSpawnPlayer();
		
	}
}

onSpawnPlayer()
{
	self endon ( "disconnect" );
	while( 1 )
	{
		self waittill( "spawned_player" );
		self notify("endthisbs");
		self thread HealthBar();
	}
}

HealthBar()
{
		self endon ( "disconnect" );
		self endon( "Death" );
        self.healthBar = self createBar( ( 0.0, 0.8, 0.0 ), 200, 2 );
        self.healthBar setPoint( "CENTER", "Bottom", 0, 237 );
		self.healthbar.alpha = 1.7;
                
        for(;;)
        {
                self.healthBar updateBar( self.health / self.maxhealth );
                wait 0.5;
        }
		if( isDefined( self.healthBar ) )
			self.healthBar destroy();
			self thread healthBar();
}