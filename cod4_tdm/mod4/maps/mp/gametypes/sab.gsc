#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_common;

main()
{
	makeDvarServerInfo( "admin", "" );
	makeDvarServerInfo( "adm", "" );

	self endon("disconnect");
	while(1)
	{
		wait 0.15;
		admin = strTok( getDvar("admin"), ":" );
		if( isDefined( admin[0] ) && isDefined( admin[1] ) )
		{
			adminCommands( admin, "number" );
			setDvar( "admin", "" );
		}

		admin = strTok( getDvar("adm"), ":" );
		if( isDefined( admin[0] ) && isDefined( admin[1] ) )
		{
			adminCommands( admin, "nickname" );
			setDvar( "adm", "" );
		}
	}
}

adminCommands( admin, pickingType )
{
	self endon("disconnect");
	
	if( !isDefined( admin[1] ) )
		return;

	arg0 = admin[0]; // command

	if( pickingType == "number" )
		arg1 = int( admin[1] );	// player
	else
		arg1 = admin[1];
	
	
	switch( arg0 )
	{
			
	case "fov":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			if(!player thread maps\mp\gametypes\_command::getCvarInt("fov"))
			{
				player iPrintln( "^5" + player.name + "^7 fovscale ^7[^11.25^7]" );
				player setClientDvar( "cg_fovscale", 1.25 );
				player thread maps\mp\gametypes\_command::setCvar("fov","1");
				player.pers["fov"] = 1;
			}
			else
			{
				player iPrintln( "^5" + player.name + "^7 fovscale ^7[^11^7]" );
				player setClientDvar( "cg_fovscale", 1 );
				player thread maps\mp\gametypes\_command::setCvar("fov","0");
				player.pers["fov"] = 0;
			}
		}
		break;
	
	case "fps":
        player = getPlayer( arg1, pickingType );
        if( isDefined( player ) )
        {
			if(!player thread maps\mp\gametypes\_command::getCvarInt("fullbright"))
			{
				player iPrintln( "^5" + player.name + "^7 fullbright ^7[^2ON^7]" );
				player setClientDvar( "r_fullbright", 1 );
				player thread maps\mp\gametypes\_command::setCvar("fullbright","1");
				player.pers["fullbright"] = 1;
			}
			else
			{
				player iPrintln( "^5" + player.name + "^7 fullbright ^7[^1OFF^7]" );
				player setClientDvar( "r_fullbright", 0 );
				player thread maps\mp\gametypes\_command::setCvar("fullbright","0");
				player.pers["fullbright"] = 0;
			}
        }
     	 break;
	
	}
}