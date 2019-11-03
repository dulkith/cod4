//  ________/\\\\\\\\\__________________________________________________________        
//   _____/\\\////////___________________________________________________________       
//    ___/\\\/_________________________________________________________/\\\__/\\\_      
//     __/\\\______________/\\/\\\\\\\___/\\\\\\\\\_____/\\\\\\\\\\\___\//\\\/\\\__     
//      _\/\\\_____________\/\\\/////\\\_\////////\\\___\///////\\\/_____\//\\\\\___    
//       _\//\\\____________\/\\\___\///____/\\\\\\\\\\_______/\\\/________\//\\\____   
//        __\///\\\__________\/\\\__________/\\\/////\\\_____/\\\/_______/\\_/\\\_____  
//         ____\////\\\\\\\\\_\/\\\_________\//\\\\\\\\/\\__/\\\\\\\\\\\_\//\\\\/______ 
//          _______\/////////__\///___________\////////\//__\///////////___\////________

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include duffman\_common;

init()
{
	if(level.gametype != "sd")
		return;
	[[level.on]]( "spawned", ::knifegame );
}

knifegame()
{
	self endon( "disconnect" );
	for(;;wait 0.1)
	{
		if(!isAlive(self))
		{
			if(self MeleeButtonPressed())
			{
				self.isKnifing = true;
				if(getDvar("mapname") == "mp_crash" || getDvar("mapname") == "mp_crash_snow")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((-202.878,3736.02,832.126));
					else
						self delayedSpawn((-421.492,3748.29,832.126));
				}
				if(getDvar("mapname") == "mp_crossfire")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((3159.94,-4317.97,-137.338));
					else
						self delayedSpawn((2872,-3561.69,-140.208));
				}
				if(getDvar("mapname") == "mp_backlot")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((2756.35,-58.0878,120.125));
					else
						//self delayedSpawn((-1436,2312,75));
						self delayedSpawn((2756.35,-58.0878,120.125));
				}
				if(getDvar("mapname") == "mp_strike")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((224,-2534,480));
					else
						self delayedSpawn((367,-2636,480));
				}
				if(getDvar("mapname") == "mp_vacant")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((-2813,1122,-101));
					else
						self delayedSpawn((-3449,279,-101));
				}
				if(getDvar("mapname") == "mp_citystreets")
				{
					if ( RandomInt( 100 ) > 50 )
						//self delayedSpawn((3124.82,-3679.09,592.125));
						self delayedSpawn((2901.88,-3829.32,592.125));
					else
						self delayedSpawn((2901.88,-3829.32,592.125));
				}
				if(getDvar("mapname") == "mp_convoy")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((-3276,634,-61));
					else
						self delayedSpawn((-3292,-120,-45));
				}
				if(getDvar("mapname") == "mp_bloc")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((2079,-8328,19));
					else
						self delayedSpawn((1351,-9061,19));
				}
				if(getDvar("mapname") == "mp_bog")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((6511,-15,345));
					else
						self delayedSpawn((6814,639,345));
				}
				if(getDvar("mapname") == "mp_cargoship")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((-2510,510,763));
					else
						self delayedSpawn((-2512,-516,763));
				}
				if(getDvar("mapname") == "mp_countdown")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((2396,4087,-1));
					else
						self delayedSpawn((1555,5056,-1));
				}
				if(getDvar("mapname") == "mp_farm")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((505,-2040,135));
					else
						self delayedSpawn((975,-1543,144));
				}
				if(getDvar("mapname") == "mp_overgrown")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((3274,-1663,-117));
					else
						self delayedSpawn((3930,-1299,-117));
				}
				if(getDvar("mapname") == "mp_pipeline")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((-1632,-3399, 368));
					else
						self delayedSpawn((-2012,-3924, 295));
				}
				if(getDvar("mapname") == "mp_showdown")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((1316,-272, 403));
					else
						self delayedSpawn((1641,903, 403));
				}
				if(getDvar("mapname") == "mp_shipment")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((-2264,1822, 203));
					else
						self delayedSpawn((-3021,967, 203));
				}
				if(getDvar("mapname") == "mp_nuketown")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((1313,-1349,247));
					else
						self delayedSpawn((870,-1090,209));
				}
				if(getDvar("mapname") == "mp_marketcenter")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((743,3538,211));
					else
						self delayedSpawn((1287,3535,211));
				}
				if(getDvar("mapname") == "mp_killhouse")
				{
					if ( RandomInt( 100 ) > 50 )
						self delayedSpawn((2588.06,-2577.47,49.4661));
					else
						self delayedSpawn((2368.03,-978.61,12.1272));
				}
			}
		}
	}
}

delayedSpawn(origin)
{

	if( !isDefined(self.spawnedKnifing) )
		wait 3.0;
	self.spawnedKnifing = true;
	self maps\mp\gametypes\_globallogic::roofspawn();
	self setOrigin(origin);
}