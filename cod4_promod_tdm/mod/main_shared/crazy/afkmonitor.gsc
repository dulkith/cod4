#include duffman\extras;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init()
{
	thread playerSpawned();	
	thread playerConnect();
}

playerConnect()
{
	while(1)
	{
		level waittill("connected", pl);
		pl thread EndonSpec();
	}
}

playerSpawned()
{
	while( 1 )
	{
		level waittill( "player_spawned", player );
		if(getDvar("g_gametype") != "sd")
			player thread AntiCamp();
		player thread AFKMonitor();
	//player thread duffman\reaper::reaper();
	}
}

AFKMonitor()
{
	self notify("sdfsdfdsf");
	wait 0.05;
    self endon("disconnect");
	self endon("sdfsdfdsf");
    self endon("death");
	self endon("joined_spectators");
    level endon("game_ended");
	level endon("mapvote");
	hmmmmm = 0;
	while(isAlive(self) && self.sessionteam != "spectator")
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
			if(hmmmmm == 15)
			{
				self iPrintlnBOld("^1You ^5appear to be ^1AFK!");
			}
			if(hmmmmm >= 20)
			{
				self.sessionteam = "spectator";
				self.sessionstate = "spectator";
				self [[level.spawnSpectator]]();
				self notify("sdfsdfdsf");
				iPrintln("^1" +self.name + " ^5appears to be ^1AFK!");
				return;
			}
		}
		else	
		{
			hmmmmm = 0;
		}
	}
}

AntiCamp()
{
	self notify("sdfsdfdsf");
	wait 0.05;
    self endon("disconnect");
	self endon("sdfsdfdsf");
	self endon("joined_spectators");
    level endon("game_ended");
	level endon("mapvote");
    self.camping = 0;
	self.blended = 0;
    if(!isDefined(self.camp))
    {
        self.camp = self maps\mp\gametypes\_hud_util::createBar((0, 0, 0), 64, 8);
		
        self.camp maps\mp\gametypes\_hud_util::setPoint("CENTER", "LEFT", 40, -112);
		self.camp.bar.color = (0, 1, 0);
		self.camp.bar.alpha = .3;
    }
	wait 1;
	angles = self.angles;
	while(angles == self.angles)
		wait .05;	
    while(isAlive(self) && self.sessionteam != "spectator" && isDefined(self.camp))
    {
		oldorg = self.origin;
		wait .1;
		if(distance(oldorg, self.origin) < 5 && self playerAds() == 1 )
		{
			self.camping += 0.01;
			if(self.camping >= .9 && self.camping <= .92)
				self thread Blend();	
		}
		else if(distance(oldorg, self.origin) < 5)
		{
			self.camping += 0.007;
					if(self.camping >= .9 && self.camping <= .92)
				self thread Blend();	
		}	
        else
            self.camping -= distance(oldorg, self.origin) * 0.000468;
			
        if(self.camping > 1)
            self.camping = 1;
        else if(self.camping < 0)
            self.camping = 0;			
		if(isDefined(self.camp))
		{
			self.camp.bar FadeOverTime(.1);
			self.camp.bar.color = (self.camping, 1 - self.camping, 0);
			self.camp.bar.alpha = .3 + (self.camping / 2);
		}
		if(self.camping != 0 && isDefined(self.camp))
			self.camp maps\mp\gametypes\_hud_util::updateBar(self.camping,.05);
		else if(isDefined(self.camp))
			self.camp maps\mp\gametypes\_hud_util::updateBar(0);
		if(self.camping == 1)
		{
			self iprintlnbold("^1Move or you will be killed!");
			oldorg = self.origin;
			wait 2;
			if(distance(oldorg, self.origin) < 150)
			{
				playfx(level.chopper_fx["explode"]["medium"],self.origin);
				iprintln(self.name + " ^2got killed for Camping!");
				if(isdefined(self.camp))
					self.camp maps\mp\gametypes\_hud_util::destroyElem();
				self suicide();
			}
		}
	}
}

FinishKill()
{
	self endon("disconnect");
	self endon("sdfsdfdsf");
	self waittill("death");
	playfx(level.chopper_fx["explode"]["medium"],self.origin);
	iprintln(self.name + " ^ got killed for Camping!");
	self.camp maps\mp\gametypes\_hud_util::destroyElem();	
}

EndonSpec()
{
	self endon("disconnect");
	for(;;)
	{
		if(self.sessionteam == "spectator")
		{
			if(isdefined(self.camp))
				self.camp maps\mp\gametypes\_hud_util::destroyElem();
				
			self notify("sdfsdfdsf");	
			wait 5;
		}
		wait 1;
	}
}

Blend()
{
	self endon("disconnect");
	if(isdefined(self.blended) && self.blended == 1)
		return;
	self.blended = 1;	
	self ShellShock( "frag_grenade_mp", .4 );
	wait 6;
	self.blended = 0;
}