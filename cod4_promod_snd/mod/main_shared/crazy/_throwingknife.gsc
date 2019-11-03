#include maps\mp\_utility;
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
		self thread KnifeForKill();
		self.knifesleft = 1;
	}
}

ThrowKnife()
{
	self notify("knife_fix");
	self endon("knife_fix");
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	self endon( "death" );
	for(;;)
	{
		/*while( !self SecondaryOffhandButtonPressed() )
			wait .05;*/
		if(self.knifesleft >= 1)
		{
			self GiveWeapon( "throwingknife_mp" );
			self givemaxammo( "throwingknife_mp" );
			self.knifesleft--;
			self waittill("throwingknife_mp", knife, weaponName);
		
			if(weaponName == "throwingknife_mp")
			knife DeleteAfterThrow();
	
			wait .2;
			self takeWeapon( "throwingknife_mp" );
		}
		wait 0.8;
	}	
}

DeleteAfterThrow()
{
	self endon("death");
	waitTillNotMoving();
	thread AddGlobalKnife(self.origin,self.angels);
	if(isDefined(self))
		self delete();
}		

AddGlobalKnife(ori,angel)
{
	knife = spawn("script_model", ori); 
	knife.angels = angel;
	knife SetModel("weapon_knife");
	trigger = spawn( "trigger_radius", ori + ( 0, 0, -40 ), 0, 35, 80 );
	trigger.killmsg = false;
	thread AddGlobalTriggerMsg(ori,trigger,"^7Press ^3[{+activate}] ^7para recoger el cuchillo!");
	while(1)
	{
		trigger waittill("trigger", player);
		
		if(player usebuttonpressed())
		{
			player thread ThrowKnife();
			if(!isDefined(player.knifesleft))
				player.knifesleft = 0;
			player.knifesleft++;
			trigger.killmsg = true;
			wait .05;
			knife delete();
			trigger delete();
			break;
		}
	}
}

AddGlobalTriggerMsg(ori,attacker,msg)
{
	while(isDefined(attacker) && !attacker.killmsg )
	{
		pl = getentarray("player", "classname");
		for(i=0;i<pl.size;i++)
		{	
			if(!isDefined(pl[i].notified))
				pl[i].notified = false;
			if(distance(pl[i].origin,ori) <= 30 && !pl[i].notified )
			{
				pl[i].notified = true;
				pl[i] maps\mp\_utility::setLowerMessage(msg);
			}
			else if( isDefined(pl[i].notified) && pl[i].notified && distance(pl[i].origin,ori) >= 50)
			{
				pl[i].notified = false;
				pl[i] maps\mp\_utility::clearLowerMessage();
			}
		}
		wait .05;
	}
	pl = getentarray("player", "classname");
	for(i=0;i<pl.size;i++)	
		pl[i] maps\mp\_utility::clearLowerMessage();
}

waitTillNotMoving()
{
	prevorigin = self.origin;
	while(1)
	{
		wait .15;
		if ( self.origin == prevorigin )
			break;
		prevorigin = self.origin;
	}
}

KnifeForKill()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	self endon( "death" );
	
	for(;;)
	{
		kills = self.pers["kills"];
		
		wait .5;
			
		if(kills != self.pers["kills"])
		{
			self.knifesleft++;
			self iPrintln("Usted gano un cuchillo adicional");
			self thread ThrowKnife();
		}
	}
}