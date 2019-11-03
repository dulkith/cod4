#include plugin\_utils;
start()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("endSpawn");
	
	if(level.inPrematchPeriod)
		level waittill("prematch_over");
		
	self.spawnprotected = true;
		
	wait 0.01; // to avoid HP bugging
	
	startPos = self.origin;


	self.protectiontime = 5;


	self hide();
	self thread monitorAttackKey();
	self thread health("endSpawn");

	if(!isDefined(self.spawnprot_text))
	{
		self.spawnprot_text = newClientHudElem(self);
		self.spawnprot_text.x = 0;
		self.spawnprot_text.y = 180;
		self.spawnprot_text.alignX = "center";
		self.spawnprot_text.alignY = "middle";
		self.spawnprot_text.horzAlign = "center_safearea";
		self.spawnprot_text.vertAlign = "center_safearea";
		self.spawnprot_text.alpha = 1;
		self.spawnprot_text.archived = false;
		self.spawnprot_text.font = "default";
		self.spawnprot_text.fontscale = 1.4;
		self.spawnprot_text.color = (0.980,0.996,0.388);
		self.spawnprot_text.label = &"^3[SL^2e^3SPORT] ^1Spawn protection";
	}

	if(!isDefined(self.spawnprot_cntr))
	{
		self.spawnprot_cntr = newClientHudElem(self);
		self.spawnprot_cntr.x = 0;
		self.spawnprot_cntr.y = 160;
		self.spawnprot_cntr.alignX = "center";
		self.spawnprot_cntr.alignY = "middle";
		self.spawnprot_cntr.horzAlign = "center_safearea";
		self.spawnprot_cntr.vertAlign = "center_safearea";
		self.spawnprot_cntr.alpha = 1;
		self.spawnprot_cntr.fontScale = 1.8;
		self.spawnprot_cntr.color = (.99, .00, .00);	
		self.spawnprot_cntr setTenthsTimer( self.protectiontime );	
	}

	self.protectiontime = self.protectiontime * 20;
	while (self.protectiontime)
	{
		if(!self.spawnprotected)
			break;
			
		if(distancesquared(startPos, self.origin) > 160000)
			break;

		wait .05;

		self.protectiontime--;
	}

	self show();

	if(isDefined(self.spawnprot_cntr)) self.spawnprot_cntr destroy(); 
	if(isDefined(self.spawnprot_text)) self.spawnprot_text destroy();
	
	self.spawnprotected = undefined;
	self notify("endSpawn");
}

monitorAttackKey()
{
	self endon("disconnect");
	self endon("endSpawn");

	while(isDefined(self.spawnprotected))
	{
		if(self attackButtonPressed() || self meleeButtonPressed() || self fragButtonPressed())
			self.spawnprotected = false;
		
		wait 0.05;
	}
}