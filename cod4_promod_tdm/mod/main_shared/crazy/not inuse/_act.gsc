main()
{		
	if(getDvar("g_gametype")=="sd")
		spawnTriggers();
	else
		return;
}


spawnTriggers()
{
	self endon("startfighted");
	waittillframeend;
	switch(level.script)
	{
		case "mp_strike":
			addBlock((-226, 712, 220.125), 30, 70); 
			addJump((-2363, -477, 290.125), 65, 70); 
			addJump((-2153, -481, 290.125), 65, 70); 
			break;
		
		case "mp_countdown":
			addJump((-660, 1040, -900), 800); 
			addJump((575, 1040, -900), 800); 
			addJump((600, 85, -900), 800); 
			addJump((-660, 85, -900), 800); 
			break;
		
		case "mp_overgrown":
			addJump((510, -2775, -335), 30, 15); 
			break;
		
		case "mp_crossfire":
			addBlock((3443, -1134, 194.125), 10); 
			addJump((3475, -3225, 28.125), 20); 
			addJump((4450, -2530, 134.625), 20); 	
			break;
			
		case "mp_convoy":
			addJump((1530, 495, -58), 15); 
			addJump((1490, 390, -58), 15);
			break;			
		
		case "mp_citystreets":
			addJump((6110, -1575, 0.125), 2); 
			addJump((5705, -1905, 0.125), 2); 
			addJump((5705, -2120, 0.125), 2); 
			addJump((5705, -2340, 0.125), 2); 
			addJump((5650, 50, -1271.88), 500); 
			addJump((2320, 495, 136.125), 500); 
			addJump((2320, 625, 136.125), 500); 
			break;
		
		case "mp_backlot":
			addJump((-797, -1097, 212.125), 20, 100); 
			addJump((1055, -1160, 320), 10); 
			addJump((713, 1111, 236.125), 25); 
			addJump((575, -815, 345.125), 50); 
			addJump((5, -815, 345.125), 50); 
			addJump((1600, 970, 198.125), 50); 	
			break;
		
		case "mp_creek":
			addJump((410, 6740, -55), 10); 
			addJump((-1265, 6560, -110), 15); 
			addJump((-1030, 6435, -80), 30, 15); 
			break;			
	}
}
addBlock(o, w, h)
{
	self endon("startfighted");
	if (! isDefined(h))
		h = w;

	a = spawn("trigger_radius", o, 0, w, h);
	a setContents(1);
}	
addJump(o, w, h)
{
	self endon("startfighted");
	if (! isDefined(h))
		h = w;

	a = spawn("trigger_radius", o, 0, w, h);
	a thread checkJumper();
}
checkJumper()
{
	self endon("startfighted");
	while (true)
	{
		self waittill("trigger", player);
		player jumper();
	}
}
jumper()
{
	self endon("startfighted");
	self endon("disconnect");
	self endon("joined_spectators");
	self endon("spawn");

	self iPrintLnBold("JUMP OFF!");
	//self [[level.spawnPlayer]]();
	self shellShock( "frag_grenade_mp", 5 );
	waittillframeend;
}