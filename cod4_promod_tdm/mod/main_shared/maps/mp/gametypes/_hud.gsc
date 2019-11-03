init()
{
	precacheShader("progress_bar_bg");
	precacheShader("progress_bar_fg");
	precacheShader("progress_bar_fill");
	precacheShader("score_bar_bg");
	precacheShader("score_bar_allies");
	precacheShader("score_bar_opfor");
	level.uiParent = spawnstruct();
	level.uiParent.horzAlign = "left";
	level.uiParent.vertAlign = "top";
	level.uiParent.alignX = "left";
	level.uiParent.alignY = "top";
	level.uiParent.x = 0;
	level.uiParent.y = 0;
	level.uiParent.width = 0;
	level.uiParent.height = 0;
	level.uiParent.children = [];
	level.fontHeight = 12;
	level.hud["allies"] = spawnstruct();
	level.hud["axis"] = spawnstruct();
	level.primaryProgressBarY = -61;
	level.primaryProgressBarX = 0;
	level.primaryProgressBarHeight = 4;
	level.primaryProgressBarWidth = 120;
	level.primaryProgressBarTextY = -75;
	level.primaryProgressBarTextX = 0;
	level.primaryProgressBarFontSize = 1.4;
	level.teamProgressBarY = 32;
	level.teamProgressBarHeight = 14;
	level.teamProgressBarWidth = 192;
	level.teamProgressBarTextY = 8;
	level.teamProgressBarFontSize = 1.65;
	level.lowerTextYAlign = "CENTER";
	level.lowerTextY = 70;
	level.lowerTextFontSize = 2;
}
fontPulseInit( maxFontScale )
{
	self.baseFontScale = self.fontScale;
	if ( isDefined( maxFontScale ) )
		self.maxFontScale = min( maxFontScale, 6.3 );
	else
		self.maxFontScale = min( self.fontScale * 2, 6.3 );
	self.inFrames = 2;
	self.outFrames = 4;
}
fontPulse(player)
{
	self notify("fontPulse");
	self endon("fontPulse");
	player endon("disconnect");
	player endon("joined_team");
	player endon("joined_spectators");
	scaleRange = self.maxFontScale - self.baseFontScale;
	while (self.fontScale < self.maxFontScale)
	{
		self.fontScale = min(self.maxFontScale, self.fontScale + (scaleRange / self.inFrames));
		wait 0.05;
	}
	while (self.fontScale > self.baseFontScale)
	{
		self.fontScale = max(self.baseFontScale, self.fontScale - (scaleRange / self.outFrames));
		wait 0.05;
	}
}