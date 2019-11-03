#include duffman\_common;
init()
{
	level.test = loadfx("smoke/smoke_trail_black_heli");
	
	setdvar( "bg_fallDamageMinHeight", "8999" ); 
	setdvar( "bg_fallDamagemaxHeight", "9999" ); 
	setDvar("jump_height","999");
	setDvar("g_gravity","500");
	
	addSpawnThread(::jumpfx);
}
jumpfx()
{
	self endon("disconnect");
	while(1)
	{
		if(!self isOnGround())
		{
			while(!self isOnGround())
				wait 0.05;
				
			playfx(level.test, self.origin - (0, 0, 10)); 
			earthquake (0.3, 1, self.origin, 100); 
		}
		wait .2;
	}
}