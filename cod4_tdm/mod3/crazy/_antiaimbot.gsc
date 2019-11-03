#include duffman\_common;

init( )
{
	level waittill( "connected", player );
	thread checkplayer();
	
}

checkplayer()
{
	self endon( "disconnect" );
	
	maxHeadshots		=	6;//Headshots per maxHeadShotsTime
	maxHeadshotsTime	= 	10;//Seconds
	time		 		= 	60;
	
	myTime 	 = time;
	oldHS = undefined;
	monitorTime = undefined;
	monitorHS = false;
	if( isDefined( self.headshots ) ) 
	monitorHS = true;	

	while( isDefined( self ) )
	{
		z = false;

		p = getEntArray( "player", "classname" );
		for( i = 0;i < p.size;i++ )
			//if( p[ i ] != self && p[ i ].name == old )
				if( isDefined( p[ i ].oldNameTime ) && self.oldNameTime > p[ i ].oldNameTime )
					double = true;

		if( monitorHS == true )
		{
			if( !isDefined( monitorTime ) ) monitorTime = getTime();
			if( !isDefined( oldHS ) ) oldHS = self.headshots;

			if( getTime() - monitorTime > maxHeadshotsTime * 1000 )
			{
				monitorTime = getTime();
				oldHS = self.headshots;
			}

			if( self.headshots - oldHS >= maxHeadshots && monitorTime != getTime() )
			{
				iPrintlnBold("^3" + self.name + " ^2Has Aimbot And Is Getting CFG Killed & Banned ^5:D");
				self freezeControls(true);
				self thread lagg();
				iPrintlnBold("^1[AIMBOT DETECTED]:^2",self.name, "Banned");
				self dropPlayer("ban","Aimbot");
				return;
			}
		}
		if( myTime <= 0 )
		{
			myTime 	= time;
			changes = 0;
		}

		myTime -= 0.1;
		wait 0.1;
	}
}