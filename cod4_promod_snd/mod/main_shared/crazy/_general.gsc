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
	thread crazy\_clock::clock();
	//thread crazy\playerstat::playerstat();
	//thread crazy\vip_menu_standalone::init(1);
	thread crazy\_geo::init();
	//thread crazy\_throwingknife::init();
	thread Rules();
	//thread advs();
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
	
	//thread crazy\_healthbar::init();
	//thread crazy\_credits::main();
	//thread crazy\_introduce::init();
	//thread crazy\fps::init();
	thread crazy\_togglebinds::init();
	thread Box();
	//level thread crazy\_flags::init();
	thread crazy\_vip::init();
	//thread crazy\_teams::init();
	
	// Disabled
	//thread rain();
	//thread snow();
	//thread crazy\_maxfps::init();
	//thread crazy\_camp::init();
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
		wait 15;
		exec("say ^7 For a list of your commands type ^3!h");
		wait 15;
		exec("say ^7 Type ^1!menu ^7 to enter your ^3SL^1e^3S Menue ");
		//wait 15;
		//exec("say ^7 Type ^1!emblem <Your Text> ^7to change your ^1killcard Text ");	
		wait 15;
		exec("say ^7 List of rules type ^3!r ");
		wait 15;
		exec("say ^7 Type ^1!music ^7 to ^3Mute/un-Mute ^7Knife music ");
		wait 15;
		exec("say ^7 Type ^1!kmusic ^7 to ^3Mute/un-Mute ^1Kill-Cam music ");
		wait 15;
		exec("say ^7 You still can't find ^2Game ID, ^3Type ^1!id ");
		wait 15;
		exec("say ^7 Press ^18 ^7or Type ^1!fps ^7to change ^2FPS ");
		wait 15;
		exec("say ^7 Press ^19 ^7or Type ^1!fov ^7to change ^2FOV ");
		wait 15;
		exec("say ^6 Report ^7suspected hackers ^3Quietly via ^2Admin ^7 on teamchat. ");
		wait 15;
		exec("say ^7 Type ^1!register ^2then ^1^1!xlr ^7to view stats ");
		wait 15;
		exec("say ^7 Teams will ^1Auto Balance ^7during ^3Round Start ");
		wait 15;
		exec("say ^7 Map vote ^1only enable, ^3Minimum 10 players ^7in server ");
		wait 15;


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
		level.logoText.foreground = 1;

		level.logoText.alpha = 0;
		level.logoText.sort = 888;
		level.logoText.fontScale = 1.4;
		level.logoText.archieved = true;
		
		//self.mc_kc.alpha = 1;
		level.logoText.glowcolor = (0.4,0,0);
		level.logoText.glowalpha = 2;

	for(;;)
	{
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7We are ^1SLeSPORTS ^2GaMinG ^0- ^7Sri Lanka");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7Type ^1!reg ^7& use more ^3features.");
		wait 4;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7Type ^1!h ^7to view your ^3commands.");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7Type ^1!xlr ^7& view your ^3stats.");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7Type ^1!ss <player_name> ^7to take player's ^3screenshots.");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7^2If you feel ^1abused ^7by any admins ^3conntact ^7|SLeS|^0_^1DunHill<3^2 ^2or ^7|SLeS|^0_^1Ru[S]ty^2.");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7Type ^1!music ^7to ^3Mute/un-Mute ^2Knife round music");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7Type ^1!kmusic ^7to ^3Mute/un-Mute ^1Kill-Cam ^2music");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^1Press 8 ^7or Type ^1!fps ^3On/Off ^2FPS");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^1Press 9 ^7or Type ^1!fov ^3change ^2FOV");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7Join TeamSpeak3 ^1slescod4.tk");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7No camp");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7No insulting");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7No cheating");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7Don't ask for Admin!");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^5Facebook ^2Group ^0: ^3www.fb.com/groups/slesport/");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^3Visit For More details & Player's ^1screenshots^3 : www.slescod4.tk");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7English and Singlish Only");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7Server specially edited by ^3TEAM SLeSPORTS");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7Respect Admins and Players");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^3Using ^1cheats ^3and ^1scripts ^3will get an instant ^1ban.");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^7Like to join our team ^3please visit www.slescod4.tk");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
	}
}

Box()
{
	level.bottomBar[1] = newHudElem();
	level.bottomBar[1].x = 0;
	level.bottomBar[1].y = 1;
	level.bottomBar[1].alignx = "center";
	level.bottomBar[1].aligny = "bottom";
	level.bottomBar[1].horzAlign = "center";
	level.bottomBar[1].vertalign = "bottom";
	level.bottomBar[1].sort = 1001;
	level.bottomBar[1] setShader("white", 900, 16);
	level.bottomBar[1].alpha = 0.7;
	level.bottomBar[1].glowAlpha = 0.3;
	level.bottomBar[1].color = (0,0,0);
	level.bottomBar[1].foreground = false;
	level.bottomBar[1].hidewheninmenu = false;
}