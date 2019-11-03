init(x) {
 
	// This button is used to open the menu, you can change it to any UNUSED button you want
	level.menubutton = "L";
 
	//---------------------ViPs---------------------------------------------------
	//to add ViP, you must get their last 8 digits of their GUID, then supply their name. For example use mine.
 
	addVip("last-8-digit-guid-here","nickanme-here");
 

	precacheModel("vehicle_80s_hatch1_yel");
	precacheModel("body_mp_usmc_cqb");
	precacheModel("body_mp_sas_urban_sniper");
	precacheModel("body_zoey");
	precacheModel("body_shepherd");
	precacheModel("body_juggernaut");
	precacheModel("body_masterchief");
	precacheModel("body_makarov");
	precacheModel("body_complete_mp_russian_farmer");
	precacheModel("body_complete_mp_zakhaev");
	precacheModel("body_complete_mp_velinda_desert");
	precacheModel("body_complete_mp_al_asad");
	precacheModel("body_50cent");
	precacheModel("viewmodel_hands_50cent");
	precacheModel("viewmodel_base_viewhands");
	PreCacheModel("projectile_us_smoke_grenade");
	precacheItem("p90_silencer_mp");
	precacheItem("m4_acog_mp");
	precacheItem("remington700_acog_mp");
	precacheItem("mp5_silencer_mp");
	precacheItem("rpg_mp");
	precacheItem("rpd_acog_mp");
	precacheItem("barrett_acog_mp");
	precacheItem("ak47_acog_mp");
	precacheItem("defaultweapon_mp");
	precacheItem("brick_blaster_mp");
	precacheItem("m21_acog_mp");
	precacheItem("m40a3_acog_mp");
	precacheItem("g3_acog_mp");
	precacheItem("deserteagle_mp");
	precacheItem("saw_acog_mp");
	precacheItem("m16_acog_mp");
	precacheItem("m16_gl_mp");
	precacheItem("g36c_acog_mp");
	precacheItem("m14_acog_mp");
	precacheItem("mp44_mp");
	precacheItem("skorpion_acog_mp");
	precacheItem("uzi_silencer_mp");
	precacheItem("beretta_silencer_mp");
	precacheItem("c4_mp");
	precacheItem("colt45_silencer_mp");
	precacheItem("dragunov_acog_mp");
	precacheItem("m60e4_grip_mp");
	precacheItem("usp_silencer_mp");
	precacheitem("smoke_grenade_mp");
	precacheitem("flash_grenade_mp");
	//------------------MenuOptions-----------------------------------------------
	addSubMenu("^1FPS","fps");
		addMenuOption("^3125","fps",::fps125);
		addMenuOption("^1250","fps",::fps250);
		addMenuOption("^3333","fps",::fps333);
		addMenuOption("^1FullBright","fps",::fullbright);
		addMenuOption("^3FPS Counter","fps",::fpscounter);
	addSubMenu("^3Fov","fov");
		addMenuOption("^165","fov",::fov65);
		addMenuOption("^370","fov",::fov70);
		addMenuOption("^175","fov",::fov75);
		addMenuOption("^380","fov",::fov80);
	addSubMenu("^1Fov Scale","fovscale");
		addMenuOption("^31.00","fovscale",::fovscale_1);
		addMenuOption("^11.05","fovscale",::fovscale_2);
		addMenuOption("^31.10","fovscale",::fovscale_3);
		addMenuOption("^11.15","fovscale",::fovscale_4);
		addMenuOption("^31.20","fovscale",::fovscale_5);
		addMenuOption("^11.25","fovscale",::fovscale_6);
		addMenuOption("^31.30","fovscale",::fovscale_7);
		addMenuOption("^1Super Fov","fovscale",::superfov);
	addSubMenu("^3Speed Options","sped");
		addMenuOption("^3Super Speed","sped",::speedsuper);
		addMenuOption("^1Normal Speed","sped",::speednormal);
		addMenuOption("^3Turtle Speed","sped",::speedslow);
		addMenuOption("^1Semi Fast Speed","sped",::speedfast);
	addSubMenu("^1Fun Options","dj");
		addMenuOption("^1Run a Party","dj",::party);
		addMenuOption("^3Matrix Mode","dj",::matrix);
		addMenuOption("^1Ghost Mode","dj",::ghost);
		addMenuOption("^3Toggle Funny Charactor","dj",::dog);
		addMenuOption("^1Blur","dj",::blurr);
		addMenuOption("^3Name Spam","dj",::text2);
		addMenuOption("^1Angles","dj",::angles);
	addSubMenu("^3Visuals","vis");
		addMenuOption("^1Toggle AC130 Vision","vis",::ac130);
		addMenuOption("^3Toggle Normal Vision","vis",::normal);
		addMenuOption("^1Toggle Aftermath Vision","vis",::aftermath);
		addMenuOption("^3Toggle Cobra Sunlight Vision","vis",::cobra_sun);
		addMenuOption("^1Toggle Sniper Glow Vision","vis",::sniper_glow);
		addMenuOption("^3Toggle Grey Vision","vis",::greyscale);
		addMenuOption("^1Toggle Explosion Vision","vis",::cargo_blast);
		addMenuOption("^3Toggle Serpia Vision","vis",::serpia);
		addMenuOption("^1Toggle Disco Vision","vis",::disco);
		addMenuOption("^3Toggle Shiny Vision","vis",::chrome);
		addMenuOption("^1Toggle Promod Vision","vis",::promod_active);
		addMenuOption("^3Toggle Night Vision","vis",::Nightvision);
		addMenuOption("^1Toggle Thermal Vision","vis",::Thermal);
	addSubMenu("^1Player Options","pot");
		addMenuOption("^1Toggle Laser","pot",::laser);
		addMenuOption("^3Coloured Name","pot",::namecolourred);
		addMenuOption("^1Toggle Fastreload","pot",::sof);
		addMenuOption("^3ViP Icon","pot",::vipicon);
		addMenuOption("^1Tracer","pot",::tracer);
		addMenuOption("^3Heal Me","pot",::healme);
		addMenuOption("^1Commit Suicide","pot",::suicide);
		addMenuOption("^3Give Life","pot",braxi_mod::giveLife);
		addMenuOption("^1Spawn Me","pot",::spawnme);
	addMenuOption("^3Spawnall","main",::spawnAll);
	addSubMenu("^1Weapon Options","givewep");
		addMenuOption("^1Give Deagle","givewep",::deagle);
		addMenuOption("^3Give Colt44","givewep",::colt);
		addMenuOption("^1Give R700","givewep",::r700);
		addMenuOption("^3Give M40A3","givewep",::m40a3);
		addMenuOption("^1Give AK74u","givewep",::ak74u);
		addMenuOption("^3Give AK47","givewep",::ak47);
		addMenuOption("^1Give RPG","givewep",::rpg);
		addMenuOption("^33 Nuke Bullets","givewep",::shootnuke);
		addMenuOption("^1Give Barrett .50","givewep",::barrett);
		addMenuOption("^3Give Saw","givewep",::saw);
		addMenuOption("^1Brick-Blaster","givewep",::brick);
		addMenuOption("^3Pulsegun","givewep",::pulse);
		addMenuOption("^1Weapon Pack","givewep",::weappack);
	addSubMenu("^3Model Options","mod");
		addMenuOption("^3Toggle Alice","mod",::alice);
		addMenuOption("^1Toggle Price","mod",::usmccqb);
		addMenuOption("^3Toggle SAS","mod",::usmcsnip);
		addMenuOption("^1Toggle Zoey","mod",::zoey);
	    addMenuOption("^3Toggle Farmer","mod",::farmer);
		addMenuOption("^1Toggle Zakhaev","mod",::zakhaev);
		addMenuOption("^3Toggle Velinda","mod",::velinda);
		addMenuOption("^1Toggle Al-Asad","mod",::alasad);
		addMenuOption("^3Toggle Shepherd","mod",::shepherd);
		addMenuOption("^1Toggle Makarov","mod",::makarov);
		addMenuOption("^3Toggle 50Cent","mod",::cent);
		addMenuOption("^1Toggle Masterchief","mod",::masterchief);
		addMenuOption("^3Be a Dog","mod",::dogg);
	addSubMenu("^1Killstreak Options","strk");
		addMenuOption("^3Clones","strk",::clones);
		addMenuOption("^1Nukegun","strk",::nuke);
		addMenuOption("^3Watergun","strk",::water);
		addMenuOption("^1Melee Range","strk",::meleerange);
		addMenuOption("^3Double Health","strk",::extrahealth);
		addMenuOption("^1Mine","strk",::mine);
		addMenuOption("^3Jetpack","strk",::jetpack);
		addMenuOption("^1Nova Gas","strk",::NovaNade);
		addMenuOption("^3Throwing Knives","strk",::throw);
		addMenuOption("^1Ninja","strk",::ninja);
	addSubMenu("^3XP Options","xp");
		addMenuOption("^3Give Yourself 1500 XP!","xp",::xp1);
		addMenuOption("^1Give Yourself 1000 XP!","xp",::xp);
		addMenuOption("^3Give Everyone 125 XP!","xp",::xpall);
		addMenuOption("^1Give Everyone 50 XP!","xp",::xpall2);
		addMenuOption("^3Give Everyone 25 XP!","xp",::xpall3);
	addMenuOption("^1ViP RTD","main",::viprtd);
	addSubMenu("^3Quick Responses","qr");
		addMenuOption("^3Hello!","qr",::hi);
		addMenuOption("^1No!","qr",::no);
		addMenuOption("^3Yes!","qr",::yes);
		addMenuOption("^1Nice one!","qr",::niceone);
		addMenuOption("^3Nice try!","qr",::nicetry);
		addMenuOption("^1Come on!","qr",::comeon);
		addMenuOption("^3Respect Bitch","qr",::respect);
		addMenuOption("^1It's not free run!","qr",::notfree);
		addMenuOption("^3Trolled!","qr",::trolled);
		addMenuOption("^1GoodBye!","qr",::bb);
	addSubMenu("^1Super Fun Options","adi");
		addMenuOption("^3All Perks","adi",::perks); 
		addMenuOption("^1Teleporter weapon","adi",::TeleportGun);
		addMenuOption("^3FlameThrower","adi",::flamethrower);
		addMenuOption("^1Head Explode!","adi",::RemoveYoHead);
		addMenuOption("^3Death Machine!","strk",::toggleDM);
	addSubMenu("^3Info Options","info");
		addMenuOption("^1Rules","info",::rules); 
		addMenuOption("^1Our Other Servers","info",::ip);  
		addMenuOption("^3Menu Version","info",::click);	//do not change!!
		addMenuOption("^1TeamSpeak","info",::ts);

	shaders = strTok("ui_host;line_vertical;nightvision_overlay_goggles;hud_arrow_left",";");
	for(i=0;i<shaders.size;i++) precacheShader(shaders[i]);
 
	level.meteorfx=LoadFX( "fire/tank_fire_engine" );
    level.flame=loadfx("fire/tank_fire_engine");
    level.chopper_fx["explode"]["medium"] = loadfx("explosions/aerial_explosion");
    level._effect["iPRO"] = loadfx("explosions/grenadeExp_water");
 
	thread onPlayerConnected();
}
onPlayerConnected() 
{
	for(;;) 
	{
		level waittill("connected",player);
		if(isVip(player)) 
		{
			if(!isDefined(player.pers["wlced"])) 
			{ 
				player.pers["wlced"] = true;
				iPrintln("^1Welcome ^3ViP ^5"+self.name+" ^1To the server!");
			}
			player braxi_common::clientCmd("bind "+level.menubutton+" openscriptmenu y vipmenu");
			player thread OnMenuResponse();
			player thread lives();
		}
	}
}
addVip(guid,name) {
	if(!isDefined(level.map_vips)) level.map_vips["guid"] = [];
	level.map_vips["guid"][level.map_vips["guid"].size] = guid;
	level.map_vips["name"][level.map_vips["guid"].size] = name;
}
isVip(player) {
	for(i=0;i<level.map_vips["guid"].size;i++)
		if(level.map_vips["guid"][i] == getSubStr(player getGuid(),24,32))
			return true;
	return false;
}
OnMenuResponse() {
	self endon("disconnect");
	self.invipmenu = false;
	for(;;wait .05) {
		self waittill("menuresponse", menu, response);
		if(!self.invipmenu && response == "vipmenu") {
			self.invipmenu = true;
			for(;self.sessionstate == "playing" && !self isOnGround();wait .05){}
			self thread VipMenu();
			self disableWeapons();
			self freezeControls(true);			
			self allowSpectateTeam( "allies", false );
			self allowSpectateTeam( "axis", false );
			self allowSpectateTeam( "none", false );			
		}
		else if(self.invipmenu && response == "vipmenu") self endMenu();	
	}
}
endMenu() {
	self notify("close_vip_menu");
	for(i=0;i<self.vipmenu.size;i++) self.vipmenu[i] thread FadeOut(1,true,"right");
	self thread Blur(2,0);
	self.vipmenubg thread FadeOut(1);
	self.invipmenu = false;
	self enableWeapons();
	self freezeControls(false);
	self allowSpectateTeam( "allies", true );
	self allowSpectateTeam( "axis", true );
	self allowSpectateTeam( "none", true );
}
addMenuOption(name,menu,script) {
	if(!isdefined(level.menuoption)) level.menuoption["name"] = [];	
	if(!isDefined(level.menuoption["name"][menu])) level.menuoption["name"][menu] = [];
	level.menuoption["name"][menu][level.menuoption["name"][menu].size] = name;
	level.menuoption["script"][menu][level.menuoption["name"][menu].size] = script;
}
addSubMenu(displayname,name) {
	addMenuOption(displayname,"main",name);
}
GetMenuStuct(menu) {
	itemlist = "";
	for(i=0;i<level.menuoption["name"][menu].size;i++) itemlist = itemlist + level.menuoption["name"][menu][i] + "n";
	return itemlist;
}
VipMenu() {
	self endon("close_vip_menu");
	self endon("disconnect");
	self thread Blur(0,2);
	submenu = "main";
	self.vipmenu[0] = addTextHud( self, -200, 0, .6, "left", "top", "right",0, 101 );	
	self.vipmenu[0] setShader("nightvision_overlay_goggles", 400, 650);
	self.vipmenu[0] thread FadeIn(.5,true,"right");
	self.vipmenu[1] = addTextHud( self, -200, 0, .5, "left", "top", "right", 0, 101 );	
	self.vipmenu[1] setShader("black", 400, 650);	
	self.vipmenu[1] thread FadeIn(.5,true,"right");
	self.vipmenu[2] = addTextHud( self, -200, 89, .5, "left", "top", "right", 0, 102 );		
	self.vipmenu[2] setShader("line_vertical", 600, 22);
	self.vipmenu[2] thread FadeIn(.5,true,"right");	
	self.vipmenu[3] = addTextHud( self, -190, 93, 1, "left", "top", "right", 0, 104 );		
	self.vipmenu[3] setShader("ui_host", 14, 14);			
	self.vipmenu[3] thread FadeIn(.5,true,"right");
	self.vipmenu[4] = addTextHud( self, -165, 100, 1, "left", "middle", "right", 1.4, 103 );
	self.vipmenu[4] settext(GetMenuStuct(submenu));
	self.vipmenu[4] thread FadeIn(.5,true,"right");
	self.vipmenu[5] = addTextHud( self, -170, 400, 1, "left", "middle", "right" ,1.4, 103 );
	self.vipmenu[5] settext("^7Select: ^3[Right or Left Mouse]^7nUse: ^3[[{+activate}]]^7nLeave: ^3[[{+melee}]]n^1ViP");	
	self.vipmenu[5] thread FadeIn(.5,true,"right");
	self.vipmenubg = addTextHud( self, 0, 0, .5, "left", "top", undefined , 0, 101 );	
	self.vipmenubg.horzAlign = "fullscreen";
	self.vipmenubg.vertAlign = "fullscreen";
	self.vipmenubg setShader("black", 640, 480);
	self.vipmenubg thread FadeIn(.2);
	for(selected=0;!self meleebuttonpressed();wait .05) {
		if(self Attackbuttonpressed()) {
			self playLocalSound( "mouse_over" );
			if(selected == level.menuoption["name"][submenu].size-1) selected = 0;
			else selected++;	
		}
		if(self adsbuttonpressed()) {
			self braxi_common::clientCmd("-speed_throw");
			self playLocalSound( "mouse_over" );
			if(selected == 0) selected = level.menuoption["name"][submenu].size-1;
			else selected--;
		}
		if(self adsbuttonpressed() || self Attackbuttonpressed()) {
			if(submenu == "main") {
				self.vipmenu[2] moveOverTime( .05 );
				self.vipmenu[2].y = 89 + (16.8 * selected);	
				self.vipmenu[3] moveOverTime( .05 );
				self.vipmenu[3].y = 93 + (16.8 * selected);	
			}
			else {
				self.vipmenu[7] moveOverTime( .05 );
				self.vipmenu[7].y = 10 + self.vipmenu[6].y + (16.8 * selected);	
			}
		}
		if((self adsbuttonpressed() || self Attackbuttonpressed()) && !self useButtonPressed()) wait .15;
		if(self useButtonPressed()) {
			if(!isString(level.menuoption["script"][submenu][selected+1])) {
				self thread [[level.menuoption["script"][submenu][selected+1]]]();
				self thread endMenu();
				self notify("close_vip_menu");
			}
			else {
				abstand = (16.8 * selected);
				submenu = level.menuoption["script"][submenu][selected+1];
				self.vipmenu[6] = addTextHud( self, -430, abstand + 50, .5, "left", "top", "right", 0, 101 );	
				self.vipmenu[6] setShader("black", 200, 300);	
				self.vipmenu[6] thread FadeIn(.5,true,"left");
				self.vipmenu[7] = addTextHud( self, -430, abstand + 60, .5, "left", "top", "right", 0, 102 );		
				self.vipmenu[7] setShader("line_vertical", 200, 22);
				self.vipmenu[7] thread FadeIn(.5,true,"left");
				self.vipmenu[8] = addTextHud( self, -219, 93 + (16.8 * selected), 1, "left", "top", "right", 0, 104 );		
				self.vipmenu[8] setShader("hud_arrow_left", 14, 14);			
				self.vipmenu[8] thread FadeIn(.5,true,"left");
				self.vipmenu[9] = addTextHud( self, -420, abstand + 71, 1, "left", "middle", "right", 1.4, 103 );
				self.vipmenu[9] settext(GetMenuStuct(submenu));
				self.vipmenu[9] thread FadeIn(.5,true,"left");
				selected = 0;
				wait .2;
			}
		}
	}
	self thread endMenu();
}
addTextHud( who, x, y, alpha, alignX, alignY, vert, fontScale, sort ) { //stealed braxis function like a boss xD
	if( isPlayer( who ) ) hud = newClientHudElem( who );
	else hud = newHudElem();
 
	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.alignX = alignX;
	hud.alignY = alignY;
	if(isdefined(vert))
		hud.horzAlign = vert;
	if(fontScale != 0)
		hud.fontScale = fontScale;
	return hud;
}
FadeOut(time,slide,dir) {	
	if(!isDefined(self)) return;
	if(isdefined(slide) && slide) {
		self MoveOverTime(0.2);
		if(isDefined(dir) && dir == "right") self.x+=600;
		else self.x-=600;
	}
	self fadeovertime(time);
	self.alpha = 0;
	wait time;
	if(isDefined(self)) self destroy();
}
FadeIn(time,slide,dir) {
	if(!isDefined(self)) return;
	if(isdefined(slide) && slide) {
		if(isDefined(dir) && dir == "right") self.x+=600;
		else self.x-=600;	
		self moveOverTime( .2 );
		if(isDefined(dir) && dir == "right") self.x-=600;
		else self.x+=600;
	}
	alpha = self.alpha;
	self.alpha = 0;
	self fadeovertime(time);
	self.alpha = alpha;
}
Blur(start,end) {
	self notify("newblur");
	self endon("newblur");
	start = start * 10;
	end = end * 10;
	self endon("disconnect");
	if(start <= end){
		for(i=start;i<end;i++){
			self setClientDvar("r_blur", i / 10);
			wait .05;
		}
	}
	else for(i=start;i>=end;i--){
		self setClientDvar("r_blur", i / 10);
		wait .05;
	}
}
rtdreadyup()
{
	level.meteorfx=LoadFX( "fire/tank_fire_engine" );
	level.flame=loadfx("fire/tank_fire_engine");
 
  	for(;;)
  	{
      	level waittill("player_spawn",player);
        self.rtdused = false;
  	}
}
viprtd()
{
	if(self.rtdused == false)
	{
		self.rtdused = true;
		self iprintlnbold("^1ViP ^3Roll the Dice ^7activated");
		wait 6;
 
		if(self.pers["team"] == "axis")
			self iprintlnbold("^7You cant use ^1ViP ^3Roll the Dice ^7as ^1Activator");
		else if(level.freerun)
            self iprintlnbold("^1ViP ^3Roll the Dice ^7disabled in Freerun");
        else if(level.trapsdisabled)
            self iprintlnbold("^1ViP ^3Roll the Dice ^7disabled in Freerun");
		else
			self thread rtd_results();
 
		level waittill ("round_ended");
		wait .1;
	}
	else
		self iprintlnbold("^7You already used ^1ViP ^5Roll the Dice");
}
rtd_results() //add more if u want
{
	rs = randomint(25);
 
	if(rs==0)
	{
		self iprintlnbold("^7You got: ^53 Nuke Bullets");
		self takeallweapons();
		wait 1;
		self thread shootnuke();
	}
	if(rs==1)
	{
		self iprintlnbold("^7Lucky, You were supposed to ^1die!");
		wait 10;
		self iprintlnbold("^7Oh shit, I was wrong ^5Burn ^1Motherfucker!");
		wait .1;
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is ^5Burning to Death!");
      	self freezecontrols(true);
      	wait 1;
     	self thread flameon();
      	self thread hurttodeath();
	}
	if(rs==2)
	{
		self iprintlnbold("^7You got:^5 Ninja!");
		wait 1;
		self thread ninja();
 
	}
	if(rs==3)
    {
      	self iprintlnbold("^7You got:^5 Speed!");
      	wait 1;
		self thread speedsuper();
    }
    if(rs==4)
    {
    	self iprintlnbold("^7You got:^5 500XP");  
        self braxi_rank::giveRankXP("",500);
    }
    if(rs==5)
    {
    	self iprintlnbold("^7You got:^5 2000XP");  
        self braxi_rank::giveRankXP("",2000);;
    }
    if(rs==6)
    {
    	self iprintlnbold("^7You got:^5 Water Bullets!");  
        wait 1;
		self thread water();    
    }
	if(rs==7)
    {
    	self iprintlnbold("^7You got:^5 Nuke Bullets!");  
        wait 1;
		self thread nuke();
    }
	if(rs==8)
	{
    	self iprintlnbold("^7You fool! you just ^1Spawned ^7everyone!");  
        wait 2;
		self thread spawnAll();
    }
	if(rs==9)
	{
    	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got ^3Name Spam!");  
        wait 2;
		iprintlnbold("^1"+self.name+"<3");
		wait 3;
		iprintlnbold("^2"+self.name+"<3");
		wait 3;
		iprintlnbold("^3"+self.name+"<3");
		wait 3;
		iprintlnbold("^4"+self.name+"<3");
		wait 3;
		iprintlnbold("^5"+self.name+"<3");
		wait 3;
		iprintlnbold("^6"+self.name+"<3");
		wait 3;
		iprintlnbold("^7"+self.name+"<3");
		wait 3;
		iprintlnbold("^8"+self.name+"<3");
		wait 3;
		iprintlnbold("^9"+self.name+"<3");
		wait 3;
		iprintlnbold("^0"+self.name+"<3");
		wait 3;
		iprintlnbold("^1"+self.name+"<3");
		wait 3;
		iprintlnbold("^2"+self.name+"<3");
		wait 3;
		iprintlnbold("^3"+self.name+"<3");
		wait 3;
		iprintlnbold("^4"+self.name+"<3");
		wait 3;
		iprintlnbold("^5"+self.name+"<3");
		wait 3;
		iprintlnbold("^6"+self.name+"<3");
		wait 3;
		iprintlnbold("^7"+self.name+"<3");
		wait 3;
		iprintlnbold("^8"+self.name+"<3");
		wait 3;
		iprintlnbold("^9"+self.name+"<3");
		wait 3;
		iprintlnbold("^0"+self.name+"<3");
		wait 3;
		iprintlnbold("^1"+self.name+"<3");
		wait 3;
		iprintlnbold("^2"+self.name+"<3");
		wait 3;
		iprintlnbold("^3"+self.name+"<3");
		wait 3;
		iprintlnbold("^4"+self.name+"<3");
		wait 3;
		iprintlnbold("^5"+self.name+"<3");
		wait 3;
		iprintlnbold("^6"+self.name+"<3");
		wait 3;
		iprintlnbold("^7"+self.name+"<3");
		wait 3;
		iprintlnbold("^8"+self.name+"<3");
		wait 3;
		iprintlnbold("^9"+self.name+"<3");
		wait 3;
		iprintlnbold("^0"+self.name+"<3");
		wait 3;
		iprintlnbold("^1"+self.name+"<3");
		wait 3;
		iprintlnbold("^2"+self.name+"<3");
		wait 3;
		iprintlnbold("^3"+self.name+"<3");
		wait 3;
		iprintlnbold("^4"+self.name+"<3");
		wait 3;
		iprintlnbold("^5"+self.name+"<3");
		wait 3;
		iprintlnbold("^6"+self.name+"<3");
		wait 3;
		iprintlnbold("^7"+self.name+"<3");
		wait 3;
		iprintlnbold("^8"+self.name+"<3");
		wait 3;
		iprintlnbold("^9"+self.name+"<3");
    }
	if(rs==10)
	{
    	self iprintlnbold("^1Lel ^3Guess what?");
		wait 4;
		self iprintlnbold("^7You're now a ^1Turtle");  
        wait 1;
		self thread speedslow();
    }
	if(rs==11)
	{
    	self iprintlnbold("^7You got: ^5RPD");
		self takeallweapons();
		self giveweapon("rpd_mp");
		self switchtoweapon("rpd_mp");
		wait 10;
		self iprintlnbold("^7Why'd you change weapon? You now have ^5R700");
		self takeallweapons();
		self giveweapon("remington700_mp");
		self switchtoweapon("remington700_mp");
		wait 10;
		self iprintlnbold("^1fuck sake ^7man! pick a weapona and stick with it! You got ^5RPG");
		self takeallweapons();
		self giveweapon("rpg_mp");
		self switchtoweapon("rpg_mp");
		wait 10;
		self iprintlnbold("^7Are you trying to ^1Piss ^7me off ^1M8? ^7You got ^5MP5 Silenced");
		self takeallweapons();
		self giveweapon("mp5_silenced_mp");
		self switchtoweapon("mp5_silenced_mp");
		wait 10;
		self iprintlnbold("^7Thats it ^1Get out! ^7Who do you think you're! Take your stupid ^5M4 ^7With you!");
		self takeallweapons();
		self giveweapon("m4_acog_mp");
		self switchtoweapon("m4_acog_mp");
		wait 10;
		self iprintlnbold("^7Only kidding back to ^5RPD ^7For you");
		self takeallweapons();
		self giveweapon("rpd_mp");
		self switchtoweapon("rpd_mp");
    }
	if(rs==12)
	{
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got extra ^3Melee Range!");
		wait 1;
		self thread meleerange();
    }
	if(rs==13)
	{
    	iprintln("^3[^1ViP^3] ^5"+self.name+"^7Got ^3Promod Vision!");
		wait 1;
		self thread promod();
    }
	if(rs==14)
    {
      	self iprintlnbold("^7You got:^5 Jetpack!");
      	wait 1;
		self thread jetpack();
	}
	if(rs==15)
	{
		self iprintlnbold("^7You got: ^53 Nuke Bullets");
		self takeallweapons();
		wait 1;
		self thread shootnuke();
	}
	if(rs==16)
	{
    	iprintln("^3[^1ViP^3] ^5"+self.name+"^7Got ^3Promod Vision!");
		wait 1;
		self thread promod();
    }
	if(rs==17)
	{
    	self iprintlnbold("^7You got: ^5RPD");
		self takeallweapons();
		self giveweapon("rpd_mp");
		self switchtoweapon("rpd_mp");
		wait 10;
		self iprintlnbold("^7Why'd you change weapon? You now have ^5R700");
		self takeallweapons();
		self giveweapon("remington700_mp");
		self switchtoweapon("remington700_mp");
		wait 10;
		self iprintlnbold("^1fuck sake ^7man! pick a weapona and stick with it! You got ^5RPG");
		self takeallweapons();
		self giveweapon("rpg_mp");
		self switchtoweapon("rpg_mp");
		wait 10;
		self iprintlnbold("^7Are you trying to ^1Piss ^7me off ^1M8? ^7You got ^5MP5 Silenced");
		self takeallweapons();
		self giveweapon("mp5_silenced_mp");
		self switchtoweapon("mp5_silenced_mp");
		wait 10;
		self iprintlnbold("^7Thats it ^1Get out! ^7Who do you think you're! Take your stupid ^5M4 ^7With you!");
		self takeallweapons();
		self giveweapon("m4_acog_mp");
		self switchtoweapon("m4_acog_mp");
		wait 10;
		self iprintlnbold("^7Only kidding back to ^5RPD ^7For you");
		self takeallweapons();
		self giveweapon("rpd_mp");
		self switchtoweapon("rpd_mp");
    }
	if(rs==18)
	{
    	self iprintlnbold("^1Lel ^3Guess what?");
		wait 4;
		self iprintlnbold("^7You're now a ^1Turtle");  
        wait 1;
		self thread speedslow();
    }
	if(rs==19)
    {
    	self iprintlnbold("^7You got:^5 500XP");  
        self braxi_rank::giveRankXP("",500);
    }
    if(rs==20)
    {
    	self iprintlnbold("^7You got:^5 2000XP");  
        self braxi_rank::giveRankXP("",2000);;
    }
	if(rs==21)
	{
		self iprintlnbold("^7You got: ^53 Nuke Bullets");
		self takeallweapons();
		wait 1;
		self thread shootnuke();
	}
	if(rs==22)
	{
		self iprintlnbold("^7Lucky, You were supposed to ^1die!");
		wait 10;
		self iprintlnbold("^7Oh shit, I was wrong ^5Burn ^1Motherfucker!");
		wait .1;
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is ^5Burning to Death!");
      	self freezecontrols(true);
      	wait 1;
     	self thread flameon();
      	self thread hurttodeath();
	}
	if(rs==23)
	{
		self iprintlnbold("^7You got:^5 Ninja!");
		wait 1;
		self thread ninja();
 
	}
	if(rs==24)
    {
      	self iprintlnbold("^7You got:^5 Speed!");
      	wait 1;
		self thread speedsuper();
    }
}
hurttodeath()
{
    self endon("disconnect");
    self endon("death");
    self endon("joined_spectators");
    self endon("killed_player");
 
  	for(;;)
    {
    	self FinishPlayerDamage(self, self, 15, 0, "MOD_SUICIDE", "knife_mp", self.origin, self.angles, "none", 0);
    	self PlayLocalSound("breathing_hurt");
    	wait 1.4;
    }
}
flameon()
{
    self endon("disconnect");
    self endon ( "death" );
    self endon("joined_spectators");
    self endon("killed_player");
 
    while(isAlive(self)&&isDefined(self))
    {
        playFx(level.meteorfx,self.origin);
        wait .1;
    }
}
meleerange()
{
	self endon("disconnect");
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got extra ^3Melee Range!");
	wait .1;
	self setClientDvar( "player_meleeRange", "400" );
	level waittill( "endround" );
	self setClientDvar( "player_meleeRange", "100" );
}
spawnAll() {	
	players = braxi_common::getAllPlayers();
	for ( i = 0; i < players.size; i++ ) {
		if( players[i].pers["team"] == "allies" && players[i].sessionstate != "playing" )
			players[i] braxi_mod::spawnPlayer();
			iprintln("^3[^1ViP^3] ^5"+self.name+" ^3Spawned All!");
	}
}
healme()
{
	self.health = 100;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got ^3Healed");
}
suicide()
{
	if( self.pers["team"] == "allies" )
	{
		self suicide();
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Commited ^3Suicide!");
	}
	else if( self.pers["team"] == "axis" )
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is a noob and tried to ^1Commit ^3Suicide!");
}
spawnme()
{
	if( !isDefined( self.pers["team"] ) || isDefined( self.pers["team"] ) && self.pers["team"] == "spectator" )
				self braxi_teams::setTeam( "allies" );
			self braxi_mod::spawnPlayer();
			iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got ^3Respawned");
}
givewep(wep) 
{
	self GiveWeapon(wep); wait .05; self SwitchToWeapon(wep);
}
brick()
{
	if(self.pers["team"] == "allies")
	{
		self takeallweapons();
		self GiveWeapon("brick_blaster_mp");
		self switchtoweapon("brick_blaster_mp");
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got a ^3Brick-Blaster!");
	}
	else
		self iprintln("^7 Activator cant get ^5Brick-Gun");
}
pulse()
{
	if(self.pers["team"] == "allies")
	{
		self takeallweapons();
		self GiveWeapon("remington700_acog_mp");
		self switchtoweapon("remington700_acog_mp");
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got a ^3Pulse-Gun!");
	}
	else
		self iprintln("^7 Activator cant get ^5Pulsegun");
}
r700()
{
	if(self.pers["team"] == "allies")
	{
		self takeallweapons();
		self GiveWeapon("remington700_mp");
		self switchtoweapon("remington700_mp");
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got a ^3R700!");
	}
	else
		self iprintlnBold("^7Activator cant get a ^5R700");
}
rpg()
{
	if(self.pers["team"] == "allies")
	{
		self takeallweapons();
		self GiveWeapon("rpg_mp");
		self switchtoweapon("rpg_mp");
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got a ^3RPG!");
	}
	else
		self iprintlnBold("^7Activator cant get a ^5RPG");
}
barrett()
{
	if(self.pers["team"] == "allies")
	{
		self takeallweapons();
		self GiveWeapon("barrett_acog_mp");
		self switchtoweapon("barrett_acog_mp");
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got a ^3Barrett!");
	}
	else
		self iprintlnBold("^7Activator cant get a ^5Barrett");
}
saw()
{
	if(self.pers["team"] == "allies")
	{
		self takeallweapons();
		self GiveWeapon("saw_acog_mp");
		self switchtoweapon("saw_acog_mp");
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got a ^3Saw!");
	}
	else
		self iprintlnBold("^7Activator cant get a ^5Saw");
}
m40a3()
{
	if(self.pers["team"] == "allies")
	{
		self takeallweapons();
		self GiveWeapon("m40a3_mp");
		self switchtoweapon("m40a3_mp");
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got a ^3M4A03!");
	}
	else
		self iprintlnBold("^7Activator cant get a ^5M40A3");
}
ak47()
{
	if(self.pers["team"] == "allies")
	{
		self takeallweapons();
		self GiveWeapon("ak47_mp");
		self switchtoweapon("ak47_mp");
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got a ^3AK-47!");
	}
	else
		self iprintlnBold("^7Activator cant get a ^5AK-47");
}
colt()
{
	if(self.pers["team"] == "allies")
	{
		self takeallweapons();
		self GiveWeapon("colt44_mp");
		self switchtoweapon("colt44_mp");
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got a ^3Colt-44!");
	}
	else
		self iprintlnBold("^7Activator cant get a ^5Colt44");
}
deagle()
{
	if(self.pers["team"] == "allies")
	{
		self takeallweapons();
		self GiveWeapon("deserteagle_mp");
		self switchtoweapon("deserteagle_mp");
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got a ^3Desert Eagle!");
	}
	else
		self iprintlnBold("^7Activator cant get a ^5Desert Eagle");
}
ak74u()
{
	if(self.pers["team"] == "allies")
	{
		self takeallweapons();
		self GiveWeapon("ak74u_mp");
		self switchtoweapon("ak74u_mp");
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got a ^3AK74U!");
	}
	else
		self iprintlnBold("^7Activator cant get a ^5AK74u");
}
getAllPlayers()
{
	return getEntArray( "player", "classname" );
}
xp()
{
	self braxi_rank::giveRankXP( "", 2000 );
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got ^31000 XP!");
}
xp1()
{
	self braxi_rank::giveRankXP( "", 3000 );
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got ^31500 XP!");
}
xpall()
{
    players = getAllPlayers();
     for(i=0;i<players.size;i++) 
     {	
	 self braxi_rank::giveRankXP( "", 250 );
	 wait .1;
	 iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Gave everyone ^3125 XP!");
	 }
}
xpall2()
{
    players = getAllPlayers();
     for(i=0;i<players.size;i++) 
     {	
	 self braxi_rank::giveRankXP( "", 100 );
	 wait .1;
	 iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Gave everyone ^350 XP!");
	 }
}
xpall3()
{
    players = getAllPlayers();
     for(i=0;i<players.size;i++) 
     {	
	 self braxi_rank::giveRankXP( "", 50 );
	 wait .1;
	 iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Gave everyone ^325 XP!");
	 }
}
ninja()
{
	self endon( "disconnect" );
	self endon( "death" );
 
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Has enabled: ^3Ninja!");
	    wait 1;
		setDvar( "sv_cheats", "1" );
		self hide();
		setDvar( "sv_cheats", "0" );
		for(i=0;i<120;i++)
		{
			if(self getStance() == "stand")
			{
				playfx(level.fx[1], self.origin); 
			}
			wait .5;			
		}
		setDvar( "sv_cheats", "1" );
		self show();
		setDvar( "sv_cheats", "0" );
		self iPrintlnBold("^1You are visible");
}
tracer()
{
	self setClientDvar( "cg_tracerSpeed", "0050" ); 
	self setClientDvar( "cg_tracerwidth", "9" ); 
	self setClientDvar( "cg_tracerlength", "999" );
	wait 1;
	self iprintlnBold("^5Tracer: ^7enabled");
}
shootnuke() //3 nuke bullets
{
    self endon("death");
	self GiveWeapon("m1014_grip_mp");
	wait .1;
	self SwitchToWeapon("m1014_grip_mp");
	i=0;
    while(i<3)
    {
        self waittill ( "weapon_fired" );
			if( self getCurrentWeapon() == "m1014_grip_mp" )
			{
				self playsound("rocket_explode_default");
					vec = anglestoforward(self getPlayerAngles());
					end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
					SPLOSIONlocation = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+end, 0, self)[ "position" ];
					playfx(level.chopper_fx["explode"]["medium"], SPLOSIONlocation); 
					RadiusDamage( SPLOSIONlocation, 200, 500, 60, self ); 
					earthquake (0.3, 1, SPLOSIONlocation, 400); 
					i++;
					wait 1;
			}
       }
		self TakeWeapon( "m1014_grip_mp");
		self GiveWeapon("knife_mp");
		self switchToWeapon( "knife_mp" );
 
}
nuke() // unlimited nuke bullets
{
    self endon("death");
 
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Has enabled: ^3Nuke Bullets!");
    while(1)
    {
        self waittill("weapon_fired");
        my = self gettagorigin("j_head");
        trace=bullettrace(my, my + anglestoforward(self getplayerangles())*100000,true,self)["position"];
        playfx(level.expbullt,trace);
        self playSound( "artillery_impact" );
        dis=distance(self.origin, trace);
        if(dis<101) RadiusDamage( trace, dis, 200, 50, self );
        RadiusDamage( trace, 60, 250, 50, self );
        RadiusDamage( trace, 100, 800, 50, self );
        vec = anglestoforward(self getPlayerAngles());
        end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
        SPLOSIONlocation = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+end, 0, self)[ "position" ];
        explode = loadfx( "fire/tank_fire_engine" );
        playfx(level.chopper_fx["explode"]["medium"], SPLOSIONlocation);
        self thread DamageArea(SPLOSIONlocation,500,800,200,"artillery_mp",false);
    }
}
DamageArea(Point,Radius,MaxDamage,MinDamage,Weapon,TeamKill)
{
    KillMe = false;
    Damage = MaxDamage;
    for(i=0;i<level.players.size+1;i++)
    {
        DamageRadius = distance(Point,level.players[i].origin);
        if(DamageRadius<Radius)
        {
            if(MinDamage<MaxDamage)
            Damage = int(MinDamage+((MaxDamage-MinDamage)*(DamageRadius/Radius)));
            if((level.players[i] != self) && ((TeamKill && level.teamBased) || ((self.pers["team"] != level.players[i].pers["team"]) && level.teamBased) || !level.teamBased))
            level.players[i] FinishPlayerDamage(level.players[i],self,Damage,0,"MOD_PROJECTILE_SPLASH",Weapon,level.players[i].origin,level.players[i].origin,"none",0);
            if(level.players[i] == self)
            KillMe = true;
        }
        wait 0.01;
    }
    RadiusDamage(Point,Radius-(Radius*0.25),MaxDamage,MinDamage,self);
    if(KillMe)
    self FinishPlayerDamage(self,self,Damage,0,"MOD_PROJECTILE_SPLASH",Weapon,self.origin,self.origin,"none",0);
}
ghost() 
{ 
	self endon ( "disconnect" ); 
	self endon ( "death" ); 
 
	if(!isdefined(self.ghost)) 
		self.ghost=false; 
 
	if(self.ghost==false) 
	{ 
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Has enabled: ^3Dishonoured Ghost!");
		self.ghost=true; 
		while(1) 
		{ 
			self show(); 
			playFx( level.fx["dust"] , self.origin ); 
			wait 1.5; 
			self hide(); 
			wait 0.5; 
		} 
	} 
}
water()
{
    self endon("death");
    self endon("disconnect");
 
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got ^3Water Bullets!");
	wait 1;
    for(;;)
    {
        self waittill("weapon_fired");
        playfx(level._effect["iPRO"],bullettrace(self getEye(), self getEye()+anglestoforward(self getplayerangles())*100000,0,self)["position"]);
    }
}
speedsuper()
{
	self endon("disconnect");
 
	self SetMoveSpeedScale(1.8);
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got ^3Super Speed!");
	wait .1;
 
	while(isDefined(self) && self.sessionstate == "playing" && game["state"] != "round ended")
	{
		if(!self isOnGround() && !self.doingBH)
		{
			while(!self isOnGround())
				wait 0.05;
 
			earthquake (0.3, 1, self.origin, 100); 
		}
		wait .2;
	}
 
	if(isDefined(self))
	{
		self setClientDvar("g_gravity", 70 );
		self SetMoveSpeedScale(1);
	}
}
speednormal()
{
	self endon("disconnect");
 
	self SetMoveSpeedScale(1.1);
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got ^3Normal Speed!");
	wait .1;
 
	while(isDefined(self) && self.sessionstate == "playing" && game["state"] != "round ended")
	{
		if(!self isOnGround() && !self.doingBH)
		{
			while(!self isOnGround())
				wait 0.05;
 
			earthquake (0.3, 1, self.origin, 100); 
		}
		wait .2;
	}
 
	if(isDefined(self))
	{
		self setClientDvar("g_gravity", 70 );
		self SetMoveSpeedScale(1);
	}
}
 
speedslow()
{
	self endon("disconnect");
 
	self SetMoveSpeedScale(0.2);
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got ^3Turtle Speed!");
	wait .1;
 
	while(isDefined(self) && self.sessionstate == "playing" && game["state"] != "round ended")
	{
		if(!self isOnGround() && !self.doingBH)
		{
			while(!self isOnGround())
				wait 0.05;
 
			earthquake (0.3, 1, self.origin, 100); 
		}
		wait .2;
	}
 
	if(isDefined(self))
	{
		self setClientDvar("g_gravity", 70 );
		self SetMoveSpeedScale(1);
	}
}
speedfast()
{
	self endon("disconnect");
 
	self SetMoveSpeedScale(1.4);
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got ^3Fast Speed!");
	wait .1;
 
	while(isDefined(self) && self.sessionstate == "playing" && game["state"] != "round ended")
	{
		if(!self isOnGround() && !self.doingBH)
		{
			while(!self isOnGround())
				wait 0.05;
 
			earthquake (0.3, 1, self.origin, 100); 
		}
		wait .2;
	}
 
	if(isDefined(self))
	{
		self setClientDvar("g_gravity", 70 );
		self SetMoveSpeedScale(1);
	}
}
jetpack()
{
	self endon("death");
	self endon("disconnect");
 
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^6Jetpack!");
	wait 2;
	if(!isdefined(self.jetpackwait) || self.jetpackwait == 0)
	{
		self.mover = spawn( "script_origin", self.origin );
		self.mover.angles = self.angles;
		self linkto (self.mover);
		self.islinkedmover = true;
		self.mover moveto( self.mover.origin + (0,0,25), 0.5 );
 
		self disableweapons();
		self thread spritleer();
		iPrintlnBold("^2Is it a bird, ^3is it a plane?! ^4NOO IT's ^1"+self.name+"^4!!!");
		self iprintlnbold( "^3Press Knife button to raise and Fire Button to Go Forward" );
		self iprintlnbold( "^6Click G To Kill The Jetpack" );
 
		while( self.islinkedmover == true )
		{
			Earthquake( .1, 1, self.mover.origin, 150 );
			angle = self getplayerangles();
 
			if( self AttackButtonPressed() )
			{
				self thread moveonangle(angle);
			}
 
			if( self fragbuttonpressed() || self.health < 1 )
			{
				self notify("jepackkilled");
				self thread killjetpack();
			}
 
			if( self meleeButtonPressed() )
			{
				self jetpack_vertical( "up" );
			}
 
			if( self buttonpressed() )
			{
				self jetpack_vertical( "down" );
			}
 
			wait .05;
		}
	}
}
jetpack_vertical( dir )
{
	self endon("death");
	self endon("disconnect");
	vertical = (0,0,50);
	vertical2 = (0,0,100);
 
	if( dir == "up" )
	{
		if( bullettracepassed( self.mover.origin,  self.mover.origin + vertical2, false, undefined ) )
		{ 
		self.mover moveto( self.mover.origin + vertical, 0.25 );
		}
		else
		{
			self.mover moveto( self.mover.origin - vertical, 0.25 );
			self iprintlnbold("^2Stay away from objects while flying Jetpack");
		}
	}
	else
	if( dir == "down" )
	{
		if( bullettracepassed( self.mover.origin,  self.mover.origin - vertical, false, undefined ) )
		{ 
				self.mover moveto( self.mover.origin - vertical, 0.25 );
		}
		else
		{
			self.mover moveto( self.mover.origin + vertical, 0.25 );
			self iprintlnbold("^2Numb Nuts Stay away From Buildings :)");
		}
	}
}
moveonangle( angle )
{
	self endon("death");
	self endon("disconnect");
	forward = mapsmp_utility::vector_scale(anglestoforward(angle), 50 );
	forward2 = mapsmp_utility::vector_scale(anglestoforward(angle), 75 );
 
	if( bullettracepassed( self.origin, self.origin + forward2, false, undefined ) )
	{
		self.mover moveto( self.mover.origin + forward, 0.25 );
	}
	else
	{
		self.mover moveto( self.mover.origin - forward, 0.25 );
		self iprintlnbold("^2Stay away from objects while flying Jetpack");
	}
}
killjetpack()
{
	self endon("disconnect");
	self unlink();
	self.islinkedmover = false;
	wait .5;
	self enableweapons();
	health = self.health/self.maxhealth;
	self setClientDvar("ui_healthbar", health);
}
spritleer()
{
self endon("disconnect");
self endon("jepackkilled");
self endon("death");
 
	for(i=100;i>1;i--)
	{
		//if(i == 100 || i == 95 || i == 90 || i == 85 || i == 80 || i == 75 || i == 70 || i == 65 || i == 60 || i == 55 || i == 50 || i == 45 || i == 40 || i == 35 || i == 30 || i == 25 || i == 20 || i == 15 || i == 10 || i == 5 )
		//	self playSound("mp_enemy_obj_returned");
 
		if(i == 25)
			self iPrintlnBold("^1WARNING: Jetpack fuel: 1/4");
 
		if(i == 10)
			self iPrintlnBold("^1WARNING: Jetpack will crash in 5 seconds");
 
		ui = i / 100;
		self setClientDvar("ui_healthbar", ui);
		wait 0.5;
	}
 
	self iPrintlnBold("Jetpack is out of gas");
 
	self thread killjetpack();
}
hideClone()
{
	self endon("disconenct");
	self endon("newclone");
	level endon( "endround" );
	self.clon = [];
 
	for(k=0;k<8;k++)
		self.clon[k] = self cloneplayer(10);
 
	while( self.sessionstate == "playing" )
	{
		if(isDefined(self.clon[0]))
		{
			self.clon[0].origin = self.origin + (0, 60, 0);
			self.clon[1].origin = self.origin + (-41.5, 41.5, 0);
			self.clon[2].origin = self.origin + (-60, 0, 0);
			self.clon[3].origin = self.origin + (-41.5, -41.5, 0);
			self.clon[4].origin = self.origin + (0, -60, 0);
			self.clon[5].origin = self.origin + (41.5, -41.5, 0);
			self.clon[6].origin = self.origin + (60, 0, 0);
			self.clon[7].origin = self.origin + (41.5, 41.5, 0);
 
			for(j=0;j<8;j++)
				self.clon[j].angles = self.angles;
		}
		wait .05;
	}
 
	for(i=0;i<8;i++)
	{
		if(isDefined(self.clon[i]))
			self.clon[i] delete();
	}
}
clones()
{	
	self endon("death");
	level endon( "endround" );
 
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Has enabled: ^3Clones!");
	wait 1;
	while( self.sessionstate == "playing")
	{
		if(self getStance() == "stand" && isDefined( self.clon ))
		{
			for(j=0;j<8;j++)
			{
				if(isDefined( self.clon[j] ))
					self.clon[j] hide();
			}
 
			self notify("newclone");
		}
		else
		{
			self notify("newclone");
			self thread hideClone();
 
			while(self getStance() != "stand")
				wait .05;
		}
		wait .05;
	}
}
NovaNade() 
{ 
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Has ^3Nova Gas!!");
	wait .1;
    self giveWeapon("smoke_grenade_mp"); 
    self iPrintln("Press [{+smoke}] to throw Nova Gas"); 
    self waittill("grenade_fire", grenade, weaponName); 
    if(weaponName == "smoke_grenade_mp") 
    { 
        nova = spawn("script_model", grenade.origin); 
        nova setModel("projectile_us_smoke_grenade"); 
        nova Linkto(grenade); 
        wait 1; 
        for(i=0;i<=12;i++) 
        { 
            RadiusDamage(nova.origin,300,100,50,self); 
            wait 1; 
        } 
        nova delete(); 
    } 
}
Mine()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	self endon( "death" );
 
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Has ^3Mines!");
	wait 1;
	self GiveWeapon("frag_grenade_mp");
	for(;;)
	{
		self waittill("grenade_fire", knife, weaponName);
 
		if(weaponName == "frag_grenade_mp")
		{
			knife thread AddMine(self);
			return;
		}
	}	
}
 
AddMine(owner)
{
	model = undefined;
	trigger = undefined;
	while(isDefined(owner) && isDefined(self))
	{
		prevorigin = self.origin;
		for(i=0;i<2;)
		{
			wait .15;
			if ( self.origin == prevorigin )
				i = 3;
			prevorigin = self.origin;
		}
		model = spawn("script_model", self.origin); 
		model.angels = self.angels;
		model SetModel("weapon_m67_grenade");
		self delete();
		thread blingbling(model);
		trigger = spawn( "trigger_radius", model.origin, 0, 35, 80 );
		tokill = undefined;
		for(i=0;i<2;)
		{
			trigger waittill("trigger", player);
			tokill = player;
			if(player.pers["team"] != owner.pers["team"])
				i = 3;
		}
		trigger delete();
		tokill thread braxi_mod::PlayerDamage(self, owner, 300, false, "MOD_GRENADE_SPLASH", "frag_grenade_mp", model.origin, model.origin, "none", 0);
		playFx(level.chopper_fx["explode"]["medium"],model.origin);
		earthquake (2, 1, model.origin, 250);
		model delete();
		model = undefined;
		return;
	}
	if(isdefined(model))
		model delete();
	if(isdefined(trigger))
		trigger delete();
}
blingbling(ent)
{
	while(isdefined(ent))
	{
		playFx(level.fx["light_blink"],ent.origin+(0,0,3));
		wait 3;
	}
}
fullbright()
{
	if(self getStat(714))
	{
		self iPrintlnbold( "Fullbright ^1[OFF]" );
		self setClientDvar( "r_fullbright", 0 );
		self setStat(714,0);
	}
	else
	{
		self iPrintlnbold( "Fullbright ^1[ON]" );
		self setClientDvar( "r_fullbright", 1 );
		self setStat(714,1);
	}
}
angles()
{
	self endon ("death"); 
	self endon ("disconnect"); 
	self endon ("round_ended"); 
	{
		self setPlayerAngles(self.angles+(0,0,0));
		wait 1.5;
		self setPlayerAngles(self.angles+(0,0,-90));
		wait 1.5;
		self setPlayerAngles(self.angles+(0,0,90));
		wait 1.5;
		self setPlayerAngles(self.angles+(0,0,-180));
		wait 1.5;
		self setPlayerAngles(self.angles+(0,0,0));
		wait 1.5;
		self setPlayerAngles(self.angles+(0,0,-90));
		wait 1.5;
		self setPlayerAngles(self.angles+(0,0,90));
		wait 1.5;
		self setPlayerAngles(self.angles+(0,0,-180));
		wait 1.5;
		self setPlayerAngles(self.angles+(0,0,0));
		wait 1.5;
		self setPlayerAngles(self.angles+(0,0,-90));
		wait 1.5;
		self setPlayerAngles(self.angles+(0,0,90));
		wait 1.5;
		self setPlayerAngles(self.angles+(0,0,-180));
	}
}
toggleDM()
{
	self endon("disconnect");
	self endon("death");
	if(self.DM == false)
	{
		self.DM = true;
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Has a ^3Death Machine!");
		self thread DeathMachine();
	}
	else
	{
		self.DM = false;
		self notify("end_dm");
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Has disbled the ^3Death Machine!");
	}
}
DeathMachine()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "end_dm" );
    self thread watchGun();
    self thread endDM();
    self allowADS(false);
    self allowSprint(false);
    self setPerk("specialty_bulletaccuracy");
    self setPerk("specialty_rof");
    self setClientDvar("perk_weapSpreadMultiplier", 0.20);
    self setClientDvar("perk_weapRateMultiplier", 0.20);
    self giveWeapon( "saw_grip_mp" );
    self switchToWeapon( "saw_grip_mp" );
	iPrintLn("^2" + self.name +"^7 Has A ^2DeathMachine ");
	iPrintlnBold("^2" + self.name +"^7 Has A ^2DeathMachine ");
    for(;;)
    {
        weap = self GetCurrentWeapon();
        self setWeaponAmmoClip(weap, 150);
        wait 0.2;
    }
}
watchGun()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "end_dm" );
    for(;;)
    {
        if( self GetCurrentWeapon() != "saw_grip_mp")
        {
            self switchToWeapon( "saw_grip_mp" );
        }
        wait 0.01;
    }
}
endDM()
{
    self endon("disconnect");
    self endon("death");
    self waittill("end_dm");
    self takeWeapon("saw_grip_mp");
    self setClientDvar("perk_weapRateMultiplier", 0.7);
    self setClientDvar("perk_weapSpreadMultiplier", 0.6);
	self switchToWeapon( "deserteagle_mp" );
    self allowADS(true);
    self allowSprint(true);
}
matrix() 
{ 
	self endon("disconnect"); 
	self endon ("death"); 
 
	if(!isdefined(self.ghost)) 
		self.ghost=false; 
 
	if(self.ghost==false) 
	{ 
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Has enabled: ^3Matrix!!");
		self.ghost=true; 
		while(1) 
		{ 
			self hide(); 
			wait 0.01; 
			self show(); 
			wait 0.01; 
		} 
	} 
}
RemoveYoHead()
{
	self detachall();
	self playSound("exp_suitcase_bomb_main");
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Head Exploded!");
}
flamethrower()
{
	self endon( "death" );
	self endon( "disconnect" );
	for(;;)
		{
			self giveweapon( "defaultweapon_mp" );
			self SwitchToWeapon("defaultweapon_mp");
			self waittill ( "weapon_fired" );
			vec = anglestoforward(self getPlayerAngles());
			end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
			SPLOSIONlocation = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+end, 0, self)[ "position" ];
			explode = loadfx( "fire/tank_fire_engine" );
			playfx(explode, SPLOSIONlocation);
		}
}
TeleportGun()
{
	if(self.tpg==false)
	{
		self.tpg=true;
		self GiveWeapon("m21_acog_mp");
		self SwitchToWeapon("m21_acog_mp");
		self thread TeleportRun();
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Has a ^3Teleporter Gun!");
	}
	else
	{
		self.tpg=false;
		self TakeWeapon("m21_acog_mp");
		self notify("Stop_TP");
		iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Has Disabled the ^3Teleport Gun!");
	}
}
TeleportRun()
{
	self endon("death");
	self endon("Stop_TP");
	for(;;)
	{
		self waittill("weapon_fired");
		if(self GetCurrentWeapon() == "m21_acog_mp")
		{
			self setorigin(BulletTrace(self gettagorigin("j_head"),self gettagorigin("j_head")+anglestoforward(self getplayerangles())*1000000,0,self)[ "position" ]);
		}
	}
}
perks()
{
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Has enabled: ^3All Perks");
	wait 1;
	perk = "specialty_armorvest";
	self setPerk("specialty_armorvest");
	self thread setperks(perk);
	wait 1;
	perk = "specialty_longersprint";
	self setPerk("specialty_longersprint");
	self thread setperks(perk);
	wait 1;
	perk = "specialty_fastreload";
	self setPerk("specialty_fastreload");
	self thread setperks(perk);
	wait 1;
	perk = "specialty_bulletdamage";
	self setPerk("specialty_bulletdamage");
	self thread setperks(perk);
	wait 1;
	perk = "specialty_bulletaccuracy";
	self setPerk("specialty_bulletaccuracy");
	self thread setperks(perk);
	wait 1;
	perk = "specialty_rof";
	self setPerk("specialty_rof");
	self thread setperks(perk);
	wait 1;
	perk = "specialty_holdbreath";
	self setPerk("specialty_holdbreath");
	self thread setperks(perk);
}
setperks(perk)
{
	self notify( "show ability" );
	self endon( "show ability" );
	self endon( "disconnect" );
 
	if( isDefined( self.abilityHud ) )
		self.abilityHud destroy();
 
	self.abilityHud = newClientHudElem( self );
	self.abilityHud.x = 299.5;
	self.abilityHud.y = 370;
	self.abilityHud.alpha = 0.3;
	self.abilityHud setShader( perk, 55, 48 );
	self.abilityHud.sort = 985;
 
	self.abilityHud fadeOverTime( 0.3 );
	self.abilityHud.alpha = 1;
	wait 1;
	self.abilityHud fadeOverTime( 0.2 );
	self.abilityHud.alpha = 0;
	wait 0.2;
	self.abilityHud destroy();
}
lives()
{
	while( 1 )
	{
		level waittill( "player_spawn", player );
		{
			if( !isDefined( self.pers["got3lives"] ) ) 
			{
				self braxi_mod::giveLife();
				self braxi_mod::giveLife();
				self braxi_mod::giveLife();
				self.pers["got3lives"] = true;
			}
		}
	}
}
extrahealth()
{
	self endon("disconnect");
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Has extra ^3Health!");
	wait 1;
	self.maxhealth = 200;
	self.health = self.maxhealth;
}
blurr()
{
	self iprintlnbold("^7You not have a ^5Blured Screen!");
	wait 1;
	self setClientDvar( "r_blur", 6.0 );
	self.pers["blur"] = 6.0;
	self waittill("death");
	self setClientDvar( "r_blur", 0.0 );
}
laser()
{
	if( !isDefined( self.pers["laser"] ) || !self.pers["laser"] )
	{
		self.pers["laser"] = true;
		self setClientDvar( "cg_laserforceon",1);
		self iPrintlnBold( "^5Laser:^7 enabled" );
	}
	else
	{
		self.pers["laser"] = false;
		self setClientDvar( "cg_laserforceon",0);
		self iPrintlnBold( "^5Laser:^7 enabled" );
	}
	check = "SUCCESS";
}
sof()
{
	self endon("disconnect");
	self setperk("specialty_fastreload");
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Has ^3Faster Reload!");
}
party()
{
	ambientStop(0);
	ambientplay("end_map");
	iprintlnbold("^3[^1ViP^3] ^5"+self.name+" ^7Has thrown a ^1P^2a^3r^4t^5y!");
	wait 1;
	for(;;)
	{
		SetExpFog(256, 900, 1, (randomint(20)/20),(randomint(20)/20),(randomint(20)/20)); 
        wait .5; 
	}
}
hi()
{
	self endon( "disconnect" );
	name = "^6>>^1Hey ^3People<<^6";
	 self thread braxi_slider::unten2(self, name ,(0.0, 0, 1.0));
}
no()
{
	self endon( "disconnect" );
	name = "^6>>^1Nope!<<^6";
	 self thread braxi_slider::unten2(self, name ,(0.0, 0, 1.0));
}
respect()
{
	self endon( "disconnect" );
	name = "^6>>^1Respect ^3Bitch^6<<";
	 self thread braxi_slider::unten2(self, name ,(0.0, 0, 1.0));
}
yes()
{
	self endon( "disconnect" );
	name = "^6>>^1Sure!<<^6";
	 self thread braxi_slider::unten2(self, name ,(0.0, 0, 1.0));
}
niceone()
{
	self endon( "disconnect" );
	name = "^6>>^1Niceone ^5Man<<^6";
	 self thread braxi_slider::unten2(self, name ,(0.0, 0, 1.0));
}
nicetry()
{
	self endon( "disconnect" );
	name = "^6>>^1Your ^3Shite!<<^6";
	 self thread braxi_slider::unten2(self, name ,(0.0, 0, 1.0));
}
comeon()
{
	self endon( "disconnect" );
	name = "^6>>^1Come on!<<^6";
	 self thread braxi_slider::unten2(self, name ,(0.0, 0, 1.0));
}
notfree()
{
	self endon( "disconnect" );
	name = "^6>>^1Not ^3Free ^1Run!<<^6";
	 self thread braxi_slider::unten2(self, name ,(0.0, 0, 1.0));
}
trolled()
{
	self endon( "disconnect" );
	name = "^6>>^1Get Tolled ^3Fuck Face (-_-)<<^6";
	 self thread braxi_slider::unten2(self, name ,(0.0, 0, 2.0));
}
bb()
{
	self endon( "disconnect" );
	name = "^6>>^1Good Bye!<<^6";
	 self thread braxi_slider::unten2(self, name ,(0.0, 0, 1.0));
}
dogg()
{
	self iprintlnbold("^1Initialize ^2Modelchange");
	wait 3;
	self iprintlnbold("^1Model changed to:^2 Dog");
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+"^7Is now a ^5Dog!");
 
	self takeallweapons();
	self giveweapon( "dog_mp" );
	self switchtoweapon( "dog_mp" );
	self setModel("german_sheperd_dog");
	self.dog = 1;
 
}
dog()
{
	if (self.pers["team"] == "allies")
		{
			self iprintlnbold("^1Initialize ^2Modelchange");
			wait 3;
			self iprintlnbold("^1Model changed to:^2 Funny Charactor!");
			wait .1;
			iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is now a ^3Funny Charactor!");
			self takeallweapons();
			self giveweapon( "dog_mp" );
			self switchtoweapon( "dog_mp" );
			self setModel("vehicle_80s_hatch1_yel");
			self.dog = 1;
		}
		else
		{	
			self iPrintlnbold( "^7The Activator can't be a ^5Funny Charactor!" );
	}
}
vipicon()
{
	self endon("death");
    self endon("disconnect");
    while(true)
    {
		self.statusicon = "hudicon_marine";
	    wait 1;
    }
}
alice()
{
	self iprintlnbold("^1Initialize ^2Modelchange");
	wait 3;
	self iprintlnbold("^1Model changed to:^2 Alice");
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is now ^3Alice!");
 
	self setModel("body_alice");
}
usmccqb()
{
	self iprintlnbold("^1Initialize ^2Modelchange");
	wait 3;
	self iprintlnbold("^1Model changed to:^2 Cpt. Price");
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is now ^3Cpt. Price");
 
	self setModel("body_mp_usmc_cqb");
}
usmcsnip()
{
	self iprintlnbold("^1Initialize ^2Modelchange");
	wait 3;
	self iprintlnbold("^1Model changed to:^2 SAS Soldier");
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is now a ^3Soldier!");
 
	self setModel("body_mp_sas_urban_sniper");
}
shepherd()
{	
	self iprintlnbold("^1Initialize ^2Modelchange");
	wait 3;
	self iprintlnbold("^1Model changed to:^2 Shepherd");
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is now ^3Shepherd!");
 
	self setModel("body_shepherd");
}
makarov()
{
	self iprintlnbold("^1Initialize ^2Modelchange");
	wait 3;
	self iprintlnbold("^1Model changed to:^2 Makarov");
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is now ^3Makarov");
 
	self setModel("body_makarov");
}
zoey()
{
	self iprintlnbold("^1Initialize ^2Modelchange");
	wait 3;
	self iprintlnbold("^1Model changed to:^2 Zoey");
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is now ^3Zoey!");
 
	self setModel("body_zoey");
}
farmer()
{
	self iprintlnbold("^1Initialize ^2Modelchange");
	wait 3;
	self iprintlnbold("^1Model changed to:^2 Farmer");
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is now a ^3Farmer!");
 
	self setModel("body_complete_mp_russian_farmer");
}
zakhaev()
{
	self iprintlnbold("^1Initialize ^2Modelchange");
	wait 3;
	self iprintlnbold("^1Model changed to:^2 Zakhaev^7");
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is now a ^3Zakhaev!");
 
	self setModel("body_complete_mp_zakhaev");
}
velinda()
{
	self iprintlnbold("^1Initialize ^2Modelchange");
	wait 3;
	self iprintlnbold("^1Model changed to:^2 Velinda");
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is now a ^3Velinda!");
 
	self setModel("body_complete_mp_velinda_desert");
}
alasad()
{
	self iprintlnbold("^1Initialize ^2Modelchange");
	wait 3;
	self iprintlnbold("^1Model changed to:^2 Al-Asad");
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is now ^3Al-Asad!");
 
	self setModel("body_complete_mp_al_asad");
}
cent()
{
	self iprintlnbold("^1Initialize ^2Modelchange");
	wait 3;
	self iprintlnbold("^1Model changed to:^2 50Cent");
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is now ^350-Cent!");
 
	self setModel("body_50cent");
	self setViewModel("viewmodel_hands_50cent");
}
masterchief()
{
	self iprintlnbold("^1Initialize ^2Modelchange");
	wait 3;
	self iprintlnbold("^1Model changed to:^2 Masterchief");
	wait .1;
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Is now ^3Masterchief!");
 
	self setModel("body_masterchief");
}
fps125()
{
	self setClientDvar("com_maxfps",125);
	self iPrintlnbold( "^1FPS ^7set to ^1125"  );
}
fps250()
{
	self setClientDvar("com_maxfps",250);
	self iPrintlnbold( "^1FPS ^7set to ^1250" );
}
fps333()
{
	self setClientDvar("com_maxfps",333);
	self iPrintlnbold( "^1FPS ^7set to ^1333" );
}
fov65()
{
	self setClientDvar("cg_fov",65);
	self iPrintlnbold( "^7Fov set to ^165" );
}
fov70()
{
	self setClientDvar("cg_fov",70);
	self iPrintlnbold( "^7Fov set to ^170" );
}
fov75()
{
	self setClientDvar("cg_fov",75);
	self iPrintlnbold( "^7Fov set to ^175" );
}
fov80()
{
	self setClientDvar("cg_fov",80);
	self iPrintlnbold( "^7Fov set to ^180" );
}
fovscale_1()
{
	self setClientDvar("cg_fovscale",1);
	self setStat(3255,1);
	self iPrintlnbold( "^7Fov Scale set to ^11.00" );
}
fovscale_2()
{
	self setClientDvar("cg_fovscale",1.05);
	self setStat(3255,2);
	self iPrintlnbold( "^7Fov Scale set to ^11.05" );
}
fovscale_3()
{
	self setClientDvar("cg_fovscale",1.1);
	self setStat(3255,3);
	self iPrintlnbold( "^7Fov Scale set to ^11.10" );
}
fovscale_4()
{
	self setClientDvar("cg_fovscale",1.15);
	self setStat(3255,4);
	self iPrintlnbold( "^7Fov Scale set to ^11.15" );
}
fovscale_5()
{
	self setClientDvar("cg_fovscale",1.2);
	self setStat(3255,5);
	self iPrintlnbold( "^7Fov Scale set to ^11.20" );
}
fovscale_6()
{
	self setClientDvar("cg_fovscale",1.25);
	self setStat(3255,6);
	self iPrintlnbold( "^7Fov Scale set to ^11.25" );
}
fovscale_7()
{
	self setClientDvar("cg_fovscale",1.3);
	self setStat(3255,7);
	self iPrintlnbold( "^7Fov Scale set to ^11.30" );
}
superfov()
{
	self setClientDvar("cg_fov", "110");
	self setClientDvar("cg_gun_x", "6");
	self setclientdvar("cg_fovmin", "6");
	self setClientDvar("cg_fovscale", "3.15");
}
fpscounter()
{
	self setClientDvar( "cg_drawFPS" , "Simple" ); 
	self setClientDvar( "cg_drawFPSLabels" , "1" );
}

Thermal()
{
	self endon("disconnect");
 
	self iPrintln("^1Thermal ^7Vision: ^3[ON]");
	self setClientDvar("r_filmTweakLightTint", "1 1 1");
	self setClientDvar("r_filmTweakDarkTint", "1 1 1");
	self setClientDvar("r_FilmTweakInvert", "1");
	self setClientDvar("r_FilmTweakBrightness", "0.13");
	self setClientDvar("r_FilmTweakContrast", "1.55");
	self setClientDvar("r_FilmTweakDesaturation", "1");
	self setClientDvar("r_FilmTweakEnable", "1");
	self setClientDvar("r_FilmUseTweaks", "1");
}
Nightvision()
{
	self endon("disconnect");
 
	self iPrintln("^1Night ^7Vision: ^3[ON]");
	self setClientDvar("r_FilmTweakDarktint", "0 1.54321 0.000226783");
	self setClientDvar("r_FilmTweakLighttint", "1.5797 1.9992 2.0000");
	self setClientDvar("r_FilmTweakInvert", "0");
	self setClientDvar("r_FilmTweakContrast", "1.63");
	self setClientDvar("r_FilmTweakDesaturation", "1");
	self setClientDvar("r_FilmTweakEnable", "1");
	self setClientDvar("r_FilmUseTweaks", "1");
}
chrome()
{
	level endon( "endmap" );
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "joined_spectators" );
 
    self iPrintln("^1Chrome ^7Vision: ^3[ON]");
    self setClientDvar( "r_specularmap", 2);
}
promod_active()
{
	if(self.promod == false)
	{
		self.promod = true;
		self thread promod();
		self iPrintln("Promod Vision: ^3[ON]");
		wait .1;
		self iPrintln("^7Select Toggle ^2Promod Vision ^7again to disable it!");
	}
	else
	{
		self.promod = false;
		self notify( "stop_promod" );
		self iPrintln("Promod Vision: ^1[OFF]");
	}
}
promod()
{
	self endon("stop_promod");
    while (1) {
		self endon("disconnect");
		self setClientDvar("cg_fov", 110);
		self setClientDvar("cg_fovscale", 1.225);
		self setClientDvar("r_fullbright", 0);
		self setClientDvar( "r_specularmap", 0);
		self setClientDvar("r_debugShader", 0);
		self setClientDvar( "r_filmTweakEnable", "1" );
		self setClientDvar( "r_filmUseTweaks", "1" );
		self setClientDvar( "pr_filmtweakcontrast", "1.6" );
		self setClientDvar( "r_lighttweaksunlight", "1.57" );
		level waittill( "death" );
		self setClientDvar("cg_fov", 95);
		self setClientDvar("cg_fovscale", 1);
		self setClientDvar("r_fullbright", 0);
		self setClientDvar( "r_specularmap", 0);
		self setClientDvar("r_debugShader", 0);
		self setClientDvar( "r_filmTweakEnable", "0" );
		self setClientDvar( "r_filmUseTweaks", "0" );
		self setClientDvar( "r_lighttweaksunlight", "1" );
	}
}
ac130()
{
	self iPrintln("^1AC130 ^7Vision: ^3[ON]");
	self setClientDvar("r_filmwteakenable", 1);
	self setClientDvar("r_filmUseTweaks", 1);
	self setClientDvar("r_glow", 0);
	self setClientDvar("r_glowRadius0", 7);
	self setClientDvar("r_glowRadius1", 7);
	self setClientDvar("r_glowBloomCutoff", 0.99);
	self setClientDvar("r_glowBloomDesaturation", 0.65);
	self setClientDvar("r_glowBloomIntensity0", 0.36);
	self setClientDvar("r_glowBloomIntensity1", 0.36);
	self setClientDvar("r_glowSkyBleedIntensity0", 0.29);
	self setClientDvar("r_glowSkyBleedIntensity1", 0.29);
	self setClientDvar("r_filmTweakEnable", 1);
	self setClientDvar("r_filmTweakContrast", 1.55);
	self setClientDvar("r_filmTweakBrightness", 0.13);
	self setClientDvar("r_filmTweakDesaturation", 1);
	self setClientDvar("r_filmTweakInvert", 1);
	self setClientDvar("r_filmTweakLightTint", "1 1 1");
	self setClientDvar("r_filmTweakDarkTint", "1 1 1");
}
normal()
{
	self iPrintln("^1Normal ^7Vision: ^3[ON]");
	self setClientDvar("r_glow", 0);
	self setClientDvar("r_glowRadius0", 7);
	self setClientDvar("r_glowRadius1", 7);
	self setClientDvar("r_glowBloomCutoff", 0.99);
	self setClientDvar("r_glowBloomDesaturation", 0.65);
	self setClientDvar("r_glowBloomIntensity0", 0.36);
	self setClientDvar("r_glowBloomIntensity1", 0.36);
	self setClientDvar("r_glowSkyBleedIntensity0", 0.29);
	self setClientDvar("r_glowSkyBleedIntensity1", 0.29);
	self setClientDvar("r_filmTweakEnable", 0);
	self setClientDvar("r_filmUseTweaks", 0);
	self setClientDvar("r_filmTweakContrast", 1);
	self setClientDvar("r_filmTweakBrightness", 0);
	self setClientDvar("r_filmTweakDesaturation", 0.2);
	self setClientDvar("r_filmTweakInvert", 0);
	self setClientDvar("r_filmTweakLightTint", "1 1 1");
	self setClientDvar("r_filmTweakDarkTint", "1 1 1");
}
aftermath()
{
	self iPrintln("^1Aftermath ^7Vision: ^3[ON]");
	self setClientDvar("r_filmwteakenable", 1);
	self setClientDvar("r_filmUseTweaks", 1);
	self setClientDvar("r_glow", 1);
	self setClientDvar("r_glowRadius0", 6.07651);
	self setClientDvar("r_glowBloomCutoff", 0.65);
	self setClientDvar("r_glowBloomDesaturation", 0.65);
	self setClientDvar("r_glowBloomIntensity0", 0.45);
	self setClientDvar("r_filmTweakEnable", 1);
	self setClientDvar("r_filmTweakContrast", 1.8);
	self setClientDvar("r_filmTweakBrightness", 0.05);
	self setClientDvar("r_filmTweakDesaturation", 0.58);
	self setClientDvar("r_filmTweakInvert", 0);
	self setClientDvar("r_filmTweakLightTint", "1 0.969 0.9");
	self setClientDvar("r_filmTweakDarkTint", "0.7 0.3 0.2");
}
cobra_sun()
{
	self iPrintln("^1Cobra ^7Vision: ^3[ON]");
	self setClientDvar("r_filmwteakenable", 1);
	self setClientDvar("r_filmUseTweaks", 1);
	self setClientDvar("r_glow", 0);
	self setClientDvar("r_glowRadius0", 7);
	self setClientDvar("r_glowRadius1", 7);
	self setClientDvar("r_glowBloomCutoff", 0.99);
	self setClientDvar("r_glowBloomDesaturation", 0.65);
	self setClientDvar("r_glowBloomIntensity0", 0.36);
	self setClientDvar("r_glowBloomIntensity1", 0.36);
	self setClientDvar("r_glowSkyBleedIntensity0", 0.29);
	self setClientDvar("r_glowSkyBleedIntensity1", 0.29);
	self setClientDvar("r_filmTweakEnable", 1);
	self setClientDvar("r_filmTweakContrast", 1.2);
	self setClientDvar("r_filmTweakBrightness", 0);
	self setClientDvar("r_filmTweakDesaturation", 0.48);
	self setClientDvar("r_filmTweakInvert", 0);
	self setClientDvar("r_filmTweakLightTint", "0.7 0.85 1");
	self setClientDvar("r_filmTweakDarkTint", "0.5 0.75 1.08");
}
sniper_glow()
{
	self iPrintln("^1Sniper Glow ^7Vision: ^3[ON]");
	self setClientDvar("r_filmwteakenable", 1);
	self setClientDvar("r_filmUseTweaks", 1);
	self setClientDvar("r_glow", 1);
	self setClientDvar("r_glowRadius0", 0);
	self setClientDvar("r_glowBloomCutoff", 0.231778);
	self setClientDvar("r_glowBloomDesaturation", 0);
	self setClientDvar("r_glowBloomIntensity0", 0);
	self setClientDvar("r_filmTweakEnable", 1);
	self setClientDvar("r_filmTweakContrast", 0.87104);
	self setClientDvar("r_filmTweakBrightness", 0);
	self setClientDvar("r_filmTweakDesaturation", 0.352396);
	self setClientDvar("r_filmTweakInvert", 0);
	self setClientDvar("r_filmTweakLightTint", "1.10838 1.10717 1.15409");
	self setClientDvar("r_filmTweakDarkTint", "0.7 0.928125 1");
}
greyscale()
{
	self iPrintln("^1Grey ^7Vision: ^3[ON]");
	self setClientDvar("r_filmwteakenable", 1);
	self setClientDvar("r_filmUseTweaks", 1);
	self setClientDvar("r_glow", 0);
	self setClientDvar("r_glowRadius0", 5);
	self setClientDvar("r_glowBloomCutoff", 0.9);
	self setClientDvar("r_glowBloomDesaturation", 0.75);
	self setClientDvar("r_glowBloomIntensity0", 1);
	self setClientDvar("r_filmTweakEnable", 1);
	self setClientDvar("r_filmTweakContrast", 1);
	self setClientDvar("r_filmTweakBrightness", 0);
	self setClientDvar("r_filmTweakDesaturation", 1);
	self setClientDvar("r_filmTweakInvert", 0);
	self setClientDvar("r_filmTweakLightTint", "1 1 1");
	self setClientDvar("r_filmTweakDarkTint", "1 1 1");
}
cargo_blast()
{
	self iPrintln("^1Explosion ^7Vision: ^3[ON]");
	self setClientDvar("r_filmwteakenable", 1);
	self setClientDvar("r_filmUseTweaks", 1);
	self setClientDvar("r_glow", 1);
	self setClientDvar("r_glowRadius0", 32);
	self setClientDvar("r_glowBloomCutoff", 0.1);
	self setClientDvar("r_glowBloomDesaturation", 0.822);
	self setClientDvar("r_glowBloomIntensity0", 8);
	self setClientDvar("r_filmTweakEnable", 1);
	self setClientDvar("r_filmTweakContrast", 1.45);
	self setClientDvar("r_filmTweakBrightness", 0.17);
	self setClientDvar("r_filmTweakDesaturation", 0.785);
	self setClientDvar("r_filmTweakInvert", 0);
	self setClientDvar("r_filmTweakLightTint", "1.99 0.798 0");
	self setClientDvar("r_filmTweakDarkTint", "1.99 1.32 0");
}
serpia()
{
	self iPrintln("^1Serpia ^7Vision: ^3[ON]");
	self setClientDvar("r_filmwteakenable", 1);
	self setClientDvar("r_filmUseTweaks", 1);
	self setClientDvar("r_glow", 1);
	self setClientDvar("r_glowRadius0", 0);
	self setClientDvar("r_glowRadius1", 0);
	self setClientDvar("r_glowBloomCutoff", 0.99);
	self setClientDvar("r_glowBloomDesaturation", 0.65);
	self setClientDvar("r_glowBloomIntensity0", 0.36);
	self setClientDvar("r_glowBloomIntensity1", 0.36);
	self setClientDvar("r_glowSkyBleedIntensity0", 0.29);
	self setClientDvar("r_glowSkyBleedIntensity1", 0.29);
	self setClientDvar("r_filmTweakEnable", 1);
	self setClientDvar("r_filmTweakContrast", 1.43801);
	self setClientDvar("r_filmTweakBrightness", 0.1443);
	self setClientDvar("r_filmTweakDesaturation", 0.9525);
	self setClientDvar("r_filmTweakInvert", 0);
	self setClientDvar("r_filmTweakLightTint", "1.0074 0.6901 0.3281");
	self setClientDvar("r_filmTweakDarkTint", "1.0707 1.0679 0.9181");
}
disco() {
    self endon("death");
    while (1) {
        SetExpFog(256, 512, 1, 0, 0, 0);
        wait .8;
        SetExpFog(256, 512, 0, 1, 0, 0);
        wait .8;
        SetExpFog(256, 512, 0, 0, 1, 0);
        wait .8;
        SetExpFog(256, 512, 0.4, 1, 0.8, 0);
        wait .8;
        SetExpFog(256, 512, 0.8, 0, 0.6, 0);
        wait .8;
        SetExpFog(256, 512, 1, 1, 0.6, 0);
        wait .8;
        SetExpFog(256, 512, 1, 1, 1, 0);
        wait .8;
        SetExpFog(256, 512, 0, 0, 0.8, 0);
        wait .8;
        SetExpFog(256, 512, 0.2, 1, 0.8, 0);
        wait .8;
        SetExpFog(256, 512, 0.4, 0.4, 1, 0);
        wait .8;
        SetExpFog(256, 512, 0, 0, 0, 0);
        wait .8;
        SetExpFog(256, 512, 0.4, 0.2, 0.2, 0);
        wait .8;
        SetExpFog(256, 512, 0.4, 1, 1, 0);
        wait .8;
        SetExpFog(256, 512, 0.6, 0, 0.4, 0);
        wait .8;
        SetExpFog(256, 512, 1, 0, 0.8, 0);
        wait .8;
        SetExpFog(256, 512, 1, 1, 0, 0);
        wait .8;
        SetExpFog(256, 512, 0.6, 1, 0.6, 0);
        wait .8;
        SetExpFog(256, 512, 1, 0, 0, 0);
        wait .8;
        SetExpFog(256, 512, 0, 1, 0, 0);
        wait .8;
        SetExpFog(256, 512, 0, 0, 1, 0);
        wait .8;
        SetExpFog(256, 512, 0.4, 1, 0.8, 0);
        wait .8;
        SetExpFog(256, 512, 0.8, 0, 0.6, 0);
        wait .8;
        SetExpFog(256, 512, 1, 1, 0.6, 0);
        wait .8;
        SetExpFog(256, 512, 1, 1, 1, 0);
        wait .8;
        SetExpFog(256, 512, 0, 0, 0.8, 0);
        wait .8;
        SetExpFog(256, 512, 0.2, 1, 0.8, 0);
        wait .8;
        SetExpFog(256, 512, 0.4, 0.4, 1, 0);
        wait .8;
        SetExpFog(256, 512, 0, 0, 0, 0);
        wait .8;
        SetExpFog(256, 512, 0.4, 0.2, 0.2, 0);
        wait .8;
        SetExpFog(256, 512, 0.4, 1, 1, 0);
        wait .8;
        SetExpFog(256, 512, 0.6, 0, 0.4, 0);
        wait .8;
        SetExpFog(256, 512, 1, 0, 0.8, 0);
        wait .8;
        SetExpFog(256, 512, 1, 1, 0, 0);
        wait .8;
        SetExpFog(256, 512, 0.6, 1, 0.6, 0);
    }
}

GlowColour()
{
	while(isdefined(self))
	{
		self FadeOverTime(.1);
		self.glowColor = (randomint(100)/100,randomint(100)/100,randomint(100)/100);
		wait .1;
	}
}
throw()
{
	iprintln("^3[^1ViP^3] ^5"+self.name+" ^7Got ^32 Throwing Knives!");
	wait .05;
  	self thread ThrowKnife();
	self.knifesleft = 2;
}
ThrowKnife()
{
	self notify("knife_fix");
	self endon("knife_fix");
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	self endon( "death" );
	for(;;)
	{
		while( !self SecondaryOffhandButtonPressed() )
			wait .05;
		if(self.knifesleft >= 1)
		{
			self GiveWeapon( "flash_grenade_mp" );
			self givemaxammo( "flash_grenade_mp" );
			self.knifesleft--;
			self braxi_common::clientCmd( "+frag;-frag" );
			self waittill("grenade_fire", knife, weaponName);
 
			if(weaponName == "flash_grenade_mp")
				knife thread DeleteAfterThrow();
 
			wait .2;
			self takeWeapon( "flash_grenade_mp" );
		}
		wait 0.8;
	}	
}
DeleteAfterThrow()
{
	self endon("death");
	waitTillNotMoving();
	thread AddGlobalKnife(self.origin,self.angels);
	if(isDefined(self))
		self delete();
}		
 
AddGlobalKnife(ori,angel)
{
	knife = spawn("script_model", ori); 
	knife.angels = angel;
	knife SetModel("weapon_parabolic_knife");
	trigger = spawn( "trigger_radius", ori + ( 0, 0, -40 ), 0, 35, 80 );
	trigger.killmsg = false;
	thread AddGlobalTriggerMsg(ori,trigger,"^7Press ^3[[{+usereload}]] ^7to pickup the Knife!");
	while(1)
	{
		trigger waittill("trigger", player);
 
		if(player usebuttonpressed())
		{
			player thread ThrowKnife();
			if(!isDefined(player.knifesleft))
				player.knifesleft = 0;
			player.knifesleft++;
			trigger.killmsg = true;
			wait .05;
			knife delete();
			trigger delete();
			break;
		}
	}
}
AddGlobalTriggerMsg(ori,owner,msg)
{
	while(isDefined(owner) && !owner.killmsg )
	{
		pl = getentarray("player", "classname");
		for(i=0;i<pl.size;i++)
		{	
			if(!isDefined(pl[i].notified))
				pl[i].notified = false;
			if(distance(pl[i].origin,ori) <= 30 && !pl[i].notified )
			{
				pl[i].notified = true;
				pl[i] mapsmp_utility::setLowerMessage(msg);
			}
			else if( isDefined(pl[i].notified) && pl[i].notified && distance(pl[i].origin,ori) >= 50)
			{
				pl[i].notified = false;
				pl[i] mapsmp_utility::clearLowerMessage();
			}
		}
		wait .05;
	}
	pl = getentarray("player", "classname");
	for(i=0;i<pl.size;i++)	
		pl[i] mapsmp_utility::clearLowerMessage();
}
waitTillNotMoving()
{
	prevorigin = self.origin;
	while(1)
	{
		wait .15;
		if ( self.origin == prevorigin )
			break;
		prevorigin = self.origin;
	}
}
namecolourred()
{
self setClientDvar( "cg_scoreboardMyColor", "0.8 0 0 1");
}
rules()
{
    self sayall("^1>>^5Rule 1: ^6Dont Cheat or Glitch");
	wait 1;
	self sayall("^1>>^5Rule 2: ^6Dont use Knife in Sniper Room");
	wait 1;
	self sayall("^1>>^5Rule 3: ^6Dont insult other Players");
	wait 1;
	self sayall("^1>>^5Rule 4: ^6Dont use RTD in Rooms");
	wait 1;
	self sayall("^1>>^5Rule 5: ^6Dont spam");
	wait 1;
	self sayall("^1>>^5Rule 6: ^6Dont activate in Free Run");
}
ip()
{
	self sayall("^7eQGamers SD PromodLive 2.20 - 185.4.149.17:28817!");
	wait 1;
}
click()
{
	iPrintlnBold("www.eQGamers.com");
}
text2()
{
		iprintlnbold("^1"+self.name+" ^0<3");
		wait 1;
		iprintlnbold("^2"+self.name+" ^9<3");
		wait 1;
		iprintlnbold("^3"+self.name+" ^8<3");
		wait 1;
		iprintlnbold("^4"+self.name+" ^7<3");
		wait 1;
		iprintlnbold("^5"+self.name+" ^6<3");
		wait 1;
		iprintlnbold("^6"+self.name+" ^5<3");
		wait 1;
		iprintlnbold("^7"+self.name+" ^4<3");
		wait 1;
		iprintlnbold("^8"+self.name+" ^3<3");
		wait 1;
		iprintlnbold("^9"+self.name+" ^2<3");
		wait 1;
		iprintlnbold("^0"+self.name+" ^1<3");
}
ts()
{
	self sayall("^7Join eQGamers TS3 ts.eQGamers.com!");
}
weappack()
{
	self takeallweapons();
		self giveWeapon ("m4_acog_mp");
		self givemaxammo ("m4_acog_mp");
		self giveWeapon ("g3_acog_mp");
		self givemaxammo ("g3_acog_mp");
		self giveWeapon("m40a3_acog_mp");
		self givemaxammo("m40a4_acog_mp");
		self giveWeapon("brick_blaster_mp");
		self givemaxammo("brick_blaster_mp");
		self giveWeapon("mp5_silcencer_mp");
		self givemaxammo("mp5_silencer_mp");
		self giveWeapon("remington700_acog_mp");
		self givemaxammo("remington700_acog_mp");
		self giveWeapon("m16_gl_mp");
		self givemaxammo("m16_gl_mp");
		self giveWeapon("g36c_acog_mp");
		self givemaxammo("g36c_acog_mp");
		self giveWeapon ("barrett_acog_mp");
		self givemaxammo ("barrett_acog_mp");
		self giveWeapon ("ak47_acog_mp");
		self givemaxammo ("ak47_acog_mp");
		self giveWeapon ("rpd_acog_mp");
		self givemaxammo ("rpd_acog_mp");
		self giveWeapon ("knife_mp");
		self giveWeapon ("rpg_mp");
		self givemaxammo ("rpg_mp");
		self giveWeapon ("m14_acog_mp");
		self givemaxammo ("m14_acog_mp");
		self giveWeapon ("mp44_mp");
		self givemaxammo ("mp44_mp");
		self giveWeapon ("skorpion_acog_mp");
		self givemaxammo ("skorpion_acog_mp");
		self giveWeapon ("p90_silencer_mp");
		self givemaxammo ("p90_silencer_mp");
		self giveWeapon ("uzi_silencer_mp");
		self givemaxammo ("uzi_silencer_mp");
		self giveWeapon ("beretta_silencer_mp");
		self givemaxammo ("beretta_silencer_mp");
		self giveWeapon ("c4_mp");
		self givemaxammo ("c4_mp");
		self giveWeapon ("colt45_silencer_mp");
		self givemaxammo ("colt45_silencer_mp");
		self giveWeapon ("dragunov_acog_mp");
		self givemaxammo ("dragunov_acog_mp");
		self giveWeapon ("m60e4_grip_mp");
		self givemaxammo ("m60e4_grip_mp");
		self giveWeapon ("usp_silencer_mp");
		self givemaxammo ("usp_silencer_mp");
		self giveWeapon ("deserteagle_mp");
		self givemaxammo ("deserteagle_mp");
	name = "^1Weapon Pack!";
	 self thread braxi_slider::unten2(self, name ,(0.0, 0, 1.0));
}