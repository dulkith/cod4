randomPopUp( amount )
{	
	self endon( "disconnect" );
	self endon( "joined_team" );
	self endon( "joined_spectators" );
		
	if(self.pers["sles_dPop"] == 1)
		return;
	
	if ( !amount ) 
	return;
	
	if ( ! isDefined( self.pointPulseCount ) || ! isDefined( self.pointPulseIndex ) )
	{
		self.hud_pointpulse = [];
		self.pointPulseCount = 0;
		self.pointPulseIndex = 0;
		self.thirdPointPulseSide = 0;
	}
	wait 0.05;
	size = self.hud_pointpulse.size;
	self.hud_pointpulse[size] = newClientHudElem(self);
	self.hud_pointpulse[size].horzAlign = "center";
	self.hud_pointpulse[size].vertAlign = "middle";
	self.hud_pointpulse[size].alignX = "center";
	self.hud_pointpulse[size].alignY = "middle";
	self.hud_pointpulse[size] set_origin_in_radius(self);
	self.hud_pointpulse[size].font = "big";
	self.hud_pointpulse[size].fontscale = 1.4;
	self.hud_pointpulse[size].archived = false;
	self.hud_pointpulse[size].sort = 10000;
	
	self.pointPulseCount++;
	self.pointPulseIndex++;

	self.hud_pointpulse[size].label = &"MP_PLUS";
	self.hud_pointpulse[size].color = (0.2,0.7,1);
	self.hud_pointpulse[size].glowColor = (0.3,0.1,1);
	self.hud_pointpulse[size].glowAlpha = 1;
	self.hud_pointpulse[size] setValue(amount);
	self.hud_pointpulse[size].alpha = 1;
	self.hud_pointpulse[size] changeFontScaleOverTime( 0.15,2 );
	self.hud_pointpulse[size] changeFontScaleOverTime( 0.25,1.5 );
	wait 0.5;
	
	self.hud_pointpulse[size] fadeOverTime( 1.1 );
	self.hud_pointpulse[size].alpha = 0;
	wait 1.1;
	self.hud_pointpulse[size] destroy();
	
	self.pointPulseCount--;
	if ( self.pointPulseCount <= 0 ) self.pointPulseIndex = 0;
}
changeFontScaleOverTime(time, scale)
{

	start = self.fontscale;
	frames = (time/.05);
	scaleChange = (scale-start);
	scaleChangePer = (scaleChange/frames);
	for(m = 0;
	m < frames;
	m++)
	{
		self.fontscale += scaleChangePer;
		wait .05;
	}
}
set_origin_in_radius(player)
{
	r = 60;
	theta = 90;
	if ( player.pointPulseIndex > 0 )
	{
		if ( player.pointPulseIndex == 1 )
		{
			side = randomInt(1);
			player.thirdPointPulseSide = 1 - side;
			if ( side ) theta = 45;
			else theta = 135;
		}
		else if ( player.pointPulseIndex == 2 )
		{
			side = player.thirdPointPulseSide;
			if ( side ) theta = 45;
			else theta = 135;
		}
		else if ( player.pointPulseIndex <= 4 )
		{
			theta = randomFloatRange( 0, 180 );
			r = randomFloatRange( 60, 120 );
		}
		else if ( player.pointPulseIndex <= 8 )
		{
			theta = randomFloatRange( 0, 180 );
			r = randomFloatRange( 60, 160 );
		}
		else
		{
			theta = randomFloatRange( -30, 210 );
			r = randomFloatRange( 60, 200 );
		}
	}
	r += 20;
	theta += 20;
	
	self.x = r * cos( theta );
	self.y = 0 - r * sin( theta );
}