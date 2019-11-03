init()
{
	level.hud_Y = 0;
	level.hud_Y_offset = 13;
	self.killstreak = 0;
	
	[[level.on]]( "connected", ::headshots );
	[[level.on]]( "connected", ::killstreak );
}

headshots()
{
	self endon( "disconnect" );
	level endon ("vote started");
	self.hudhs = newClientHudElem(self);
	self.hudhs.x = 110;
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
	
	while(isDefined(self.hudhs) && isDefined(self.headshots))
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
	self.hudkillstreak.x = 110;
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
	
	while(isDefined(self.hudkillstreak) && isDefined(self.killstreak))
	{
		self.hudkillstreak setValue(self.killstreak);
		wait .5;
	}
}

streakMsg(text)
{
	while(level.streakmsginuse) 
		wait .05;
	level.streakmsginuse = true;
	msg = addTextHud( level, 750, 470, 1, "left", "middle", undefined, undefined, 1.6, 888 );
	msg SetText(text);
	msg MoveHud(10,1);
	wait 2.5;
	level.streakmsginuse = false;
	wait 8.55;
	msg destroy();
}
