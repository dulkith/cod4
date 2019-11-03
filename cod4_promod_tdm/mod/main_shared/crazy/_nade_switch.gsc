init() {
	thread playerConnect();
}

playerConnect() {
	while(1)
	{
		level waittill("connected", pl);
		pl thread AntiNadeSwitch();
	}
}

AntiNadeSwitch() {
	self endon("disconnect");
	for(;;) {
		self waittill( "grenade_fire", nade );
		grenade = nade;
		startteam = self.sessionteam;
		for(i=0;i<120;i++) {
			wait .05;
			if(startteam != self.sessionteam) {
				if(isDefined(grenade))
					grenade delete();
				i=121;
			}
		}
	}
}
