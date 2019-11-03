#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_globallogic_utils;

setStarttime( time )
{
	self thread fontPulseInit();
	self thread strTime( time );
}
strTime( time )
{
	self.alpha = 0;
	self.x += 10;
	while( isDefined( self ) && time > 0)
	{
		self setValue( time );
		self thread fontPulse( self );
		self fadeOverTime( 0.3 );
		self.alpha = 1;
		self.Color = (0.0, 0.8, 0.0);
		self moveOverTime( 0.3 );
		self.x -= 10;
		wait 0.7;
		self moveOverTime( 0.3 );
		self.x -= 10;
		self fadeOverTime( 0.3 );
		self.alpha = 0;
		time --;
		wait 0.3;
		self.x += 20;
	}
	self destroyElem();
}
fontPulseInit()
{
	self.baseFontScale = self.fontScale;
	self.maxFontScale = self.fontScale * 2;
	self.inFrames = 3; 
	self.outFrames = 5;
}
fontPulse(player)
{
	self notify ( "fontPulse" );
	self endon ( "fontPulse" );	
	player endon("disconnect");
	player endon("joined_team");
	player endon("joined_spectators");	
	scaleRange = self.maxFontScale - self.baseFontScale;
	while ( self.fontScale < self.maxFontScale && isDefined(self) )	
	{
		self.fontScale = min( self.maxFontScale, self.fontScale + (scaleRange / self.inFrames) );
		wait 0.05;
	}	
	while ( self.fontScale > self.baseFontScale && isDefined(self) )	
	{
		self.fontScale = max( self.baseFontScale, self.fontScale - (scaleRange / self.outFrames) );
		wait 0.05;
	}
}