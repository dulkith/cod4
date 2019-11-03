init()
{
	// Enabled
	crazy\_eventmanager::init();
	thread crazy\ninja_serverfile::init();
	thread crazy\_precache::init();
	thread crazy\splash::init();
	thread crazy\cmd::main();
	thread crazy\_antiaimbot::init();
	//thread crazy\_welcome::init();
	thread crazy\_antiafk::init();
	//thread crazy\_advertisement::init();
	thread crazy\_clock::init();
	thread crazy\_togglebinds::init();
	//thread crazy\playerstat::playerstat();
	//thread crazy\vip_menu_standalone::init(1);
	thread crazy\_geo::init();
	thread crazy\_throwingknife::init();
	thread Rules();
	thread advs();
	if(level.gametype == "sd")
	{
		thread crazy\_customrounds::init();
		thread crazy\_roofbattle::init();
		thread crazy\_walls::main();
		thread crazy\_serverfull::init();
	}
	
	level thread onPlayerConnect();
	thread onDisconnect();
	thread onPlayerSpawned();

	
	// Disabled
	//thread rain();
	//thread snow();
	//thread crazy\_maxfps::init();
	// thread crazy\_camp::init();
	// thread crazy\_act::main();
	// thread crazy\bots::addTestClients();
	// thread crazy\_killstreak::init();
	//if(level.gametype != "sd")
	//{
		//thread crazy\fieldorders::init();
		//thread crazy\_missions::init();
	//}
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);
	}
}
onPlayerSpawned()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("spawned");
		self thread NoAds();
	}
}
onDisconnect()
{
	self waittill("disconnect");
}
snow()
{
	fxObj = spawnFx( level._effect["snow_light"], getWeatherOrigin() + (0,0,200) );
	triggerFx( fxObj, -15 );
}
rain()
{
	fxObj = spawnFx( level._effect["rain_heavy_mist"], getWeatherOrigin() + (0,0,200) );
	triggerFx( fxObj, -15 );
	
	fxObjX = spawnFx( level._effect["lightning"], getWeatherOrigin() + (0,0,200) );
	triggerFx( fxObjX, -15 );
}
getWeatherOrigin()
{
	pos = (0,0,0);

	if(level.script == "mp_crossfire")
		pos = (5000, -3000, 0);
	if(level.script == "mp_cluster")
		pos = (-2000, 3500, 0);
	if(level.script == "mp_overgrown")
		pos = (200, -2500, 0);
		
	return pos;
}
NoAds()
{
	self notify("sdfsdfsf");
	self endon("disconnect");
	self endon("sdfsdfsf");
	
	for(;;)
	{
		if ( issubstr(self.name, "www.") || issubstr(self.name, ".de") ||issubstr(self.name, ".com") ||issubstr(self.name, ".at") ||issubstr(self.name, ".net") ||issubstr(self.name, ".org") ||issubstr(self.name, ".info") ||issubstr(self.name, ".tk") ||issubstr(self.name, ".ru") ||issubstr(self.name, ".pl") ||issubstr(self.name, ":289"))
		{
			self crazy\_common::ClientCmd("name TROLOLOLOL");
			self iPrintlnBold("NO ADVERTISEMENT, your name was changed");
		}
		wait 2;
	}
}

advs()
{
	level endon("game_ended");
	
	while(1)
	{
		wait 30;
		exec("say ^7For a list of your commands type ^3!help ");
		wait 30;
		exec("say ^7Type ^1!menu ^7 to enter your ^3SL^1e^3S Menue ");
		wait 30;
		exec("say ^7Type ^1!emblem <Your Text> ^7to change your emblem ");	
		wait 30;
		exec("say ^7List of rules type ^3!rules ");
		wait 30;
		//exec("say ^7Press ^18 ^7to change ^2FPS ");
		//wait 15;
		//exec("say ^7Press ^19 ^7to change ^2FOV ");
		//wait 15;
		//exec("say ^6Report ^7suspected hackers ^3Quietly via ^2Admin ^7 on teamchat. ");
		//wait 15;
		//exec("say ^7Type ^1!register ^2then ^1^1!xlrstats ^7to view stats! ");
		//wait 15;
		//exec("say ^3Rule #6: ^1Respect ^3All Players ");
		//wait 60;
		//exec("say ^3Rule #7: ^1No ^3arguing with admins ");
	}
}

Rules()
{
	level endon("disconnect");

	if( isDefined( level.logoText ) )
		level.logoText destroy();

		level.logoText = newHudElem();
		level.logoText.y = 480;
		level.logoText.x = 0;
		level.logoText.alignX = "center";
		level.logoText.alignY = "bottom";
		level.logoText.horzAlign = "center_safearea";

		level.logoText.alpha = 0;
		level.logoText.sort = -3;
		level.logoText.fontScale = 1.4;
		level.logoText.archieved = true;

	for(;;)
	{
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^7We are ^1DARK LiON ^2GaMinG^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^7Type ^1!register ^7& use more ^3features.^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^7Type ^1!help ^7to view your ^3commands.^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^7Type ^1!xlr ^7& view your ^3stats.^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^7Type ^1!getss <player_name> ^7to take player's ^3screenshots.^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^1Press 8 ^3On/Off ^2FPS^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^1Press 9 ^3change ^2FOV^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^7Join TeamSpeak3 ^1darklion.tk^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^7No camp^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^7No insulting^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^7No cheating^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^7Don't ask for Admin!^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^4FB ^2Group ^0: ^3www.fb.com/groups/darklioncod4/^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^3Visit For More details & Player's ^1screenshots^3 : www.darklion.tk^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^7English and Singlish Only^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^7Server specially edited by ^3TEAM DARK LION^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^7Respect Admins and Players^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^3Using ^1cheats ^3and ^1scripts ^3will get an instant ^1ban.^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5>>^7Like to join our team ^3please visit www.darklion.tk^5<<");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
	}
}
	