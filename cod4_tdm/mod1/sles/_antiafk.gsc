#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

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
		//if(getDvar("g_gametype") != "war")
		self thread AFKMonitor();
	}
}

AFKMonitor()
{
    self endon("disconnect");
	self endon("joined_spectators");
    self endon("game_ended");
	level endon ("vote started");
	hmmmmm = 0;
	while(isAlive(self))
	{
		ori = self.origin;
		angles = self.angles;
		wait 1;
		if(isAlive(self) && self.sessionteam != "spectator")
		{
			if(self.origin == ori && angles == self.angles)
			{
				hmmmmm++;
			}
			else
			{
				hmmmmm = 0;
			}
			if(hmmmmm == 20)
			{
				self iPrintlnBOld("^3[AFK] : Move or will be switch the spectators!");
			}
			if(hmmmmm >= 30)
			{
				self.sessionteam = "spectator";
				self.sessionstate = "spectator";
				self [[level.spawnSpectator]]();
				self notify("sdfsdfdsf");
				iPrintln("^2" +self.name + " ^3 Switch to spectators [AFK] ");
				return;
			}
		}
		else	
		{
			hmmmmm = 0;
		}
	}
}