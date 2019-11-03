init()
{
	level.hud_Y = 0;
	level.hud_Y_offset = 13;
	thread players();
}


players()
{
	while(1)
	{
		level waittill( "connected", player );
		player.killstreak = 0;
		player thread headshots();
		player thread killstreak();
		player thread kills();
		player thread deaths();
	}
}

headshots()
{
	self endon( "disconnect" );
	level endon ("vote started");
	self.hudhs = newClientHudElem(self);
	self.hudhs.x = 111;
	self.hudhs.y = level.hud_Y + (1*level.hud_Y_offset);
	self.hudhs.horzAlign = "left";
	self.hudhs.alignx = "left";
	self.hudhs.fontscale = 1.4;
	self.hudhs.hidewheninmenu = true;
	self.hudhs.label = &"^2Headshots :^1 &&1";
	self.hudhs fadeOverTime(.5);
	self.hudhs.alpha = 1;
	self.hudhs.glowAlpha = 1;
	self.hudhs.glowColor = (0.3, 0.3, 0.3);
	
	while(1)
	{
		self.hudhs setValue(self.headshots);
		wait .5;
	}
}

killstreak()
{
	self endon( "disconnect" );
	level endon ("vote started");
	self.hudkillstreak = newClientHudElem(self);
	self.hudkillstreak.x = 111;
	self.hudkillstreak.y = level.hud_Y + (2*level.hud_Y_offset); 
	self.hudkillstreak.alignx = "left";
	self.hudkillstreak.horzAlign = "left";
	self.hudkillstreak.fontscale = 1.4;
	self.hudkillstreak.label = &"^2Killstreak :^1 &&1";
	self.hudkillstreak fadeOverTime(.5);
	self.hudkillstreak.hidewheninmenu = true;
	self.hudkillstreak.alpha = 1;
	self.hudkillstreak.glowAlpha = 1;
	self.hudkillstreak.glowColor = (0.3, 0.3, 0.3);
	
	while(1)
	{
		self.hudkillstreak setValue(self.killstreak);
		wait .5;
	}
}

kills()
{
	self endon("disconnect");
	self.hudkills = newClientHudElem(self);
	self.hudkills.alignx = "left";
	self.hudkills.horzAlign = "left";
	self.hudkills.x = 111;
	self.hudkills.y = level.hud_Y + (4*level.hud_Y_offset); 
	self.hudkills.fontscale = 1.4;
	self.hudkills.label = &"^1Kills : &&1";
	self.hudkills fadeOverTime(.5);
	self.hudkills.hidewheninmenu = true;
	self.hudkills.alpha = 1;
	self.hudkills.glowAlpha = 1;
	self.hudkills.glowColor = (0.1, 0.1, 1.5);
	self.hudkills.color = (0.1, 0.5, 1.9);
	
	while(1)
	{
		self.hudkills setValue(self.kills);
		wait .5;
	}
}

deaths()
{
	self endon("disconnect");
	self.huddeaths = newClientHudElem(self);
	self.huddeaths.alignx = "left";
	self.huddeaths.horzAlign = "left";
	self.huddeaths.x = 111;
	self.huddeaths.y = level.hud_Y + (5*level.hud_Y_offset); 
	self.huddeaths.fontscale = 1.4;
	self.huddeaths.label = &"^1Deaths : &&1";
	self.huddeaths fadeOverTime(.5);
	self.huddeaths.hidewheninmenu = true;
	self.huddeaths.alpha = 1;
	self.huddeaths.glowAlpha = 1;
	self.huddeaths.glowColor = (0.1, 0.1, 1.5);
	self.huddeaths.color = (0.1, 0.5, 1.9);
	
	while(1)
	{
		self.huddeaths setValue(self.deaths);
		wait .5;
	}
}