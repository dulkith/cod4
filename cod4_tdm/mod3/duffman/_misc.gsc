/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\¯¯\/////¯¯//||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|__|/////////|__|/////////////|__|/////||
||===================================================================||
||     DO NOT USE, SHARE OR MODIFY THIS FILE WITHOUT PERMISSION      ||
||===================================================================*/

#include duffman\_common;

init()
{
	level thread adminBounce();
	level thread stratTime();
	addConnectThread(::IntroduceThisServer,"once");
	//addConnectThread(::FavoriteDvars,"once");
	//if((level.gametype != "sd" && level.gametype != "sab"))
		addSpawnThread(::SpawnProtection);
	//if(getDvar("g_gametype") == "sd")
	addSpawnThread(::SpawnAnimation);
	addConnectThread(::WelcomeMessage);
	addSpawnThread(::SpawnDvars);
	addConnectThread(::toggleFilmTweaks);
	addConnectThread(::FilmTweaks);
}
//#############################################################################################################################################################
//#############################################################################################################################################################
//#############################################################################################################################################################
IntroduceThisServer() {
	if(self getStat(752) == 0) { // ** Display this intro at the 2nd connect so that they wont get raged
		self setStat(752,1);
	}
	else if(self getStat(752) == 1) {
		self setStat(752,2);
		self endon("disconnect");
		for(k=0;k<3;k++) {
			self closeMenu();
			self closeInGameMenu();
			wait .05;
		}
		shader = [];
		for(i=0;i<5;i++) {
			shader[i] = createHud( self, 0, 0, .6, "center", "middle", "center",1.6, 9999 + i );	
		  	shader[i].vertAlign = "middle";
		  	shader[i] thread FadeIn1(.5);
		}
		shader[0] SetShader("black",402,252);
		shader[1] SetShader("black",400,250);
		shader[2].alpha = 1;
		shader[2].y = -100;
		shader[2].alignX = "left";
		shader[2].x = -185;
		shader[2] setText(self getLangString("HELP_1"));
		shader[3].alpha = 1;
		shader[3].y = -4;
		shader[3].alignX = "left";
		shader[3].x = -185;
		shader[3] setText(self getLangString("HELP_2"));
		shader[4].x = 180;
		shader[4].y = 110;
		shader[4].label = self getLangString("HELP_TIME_LEFT");
		shader[4] SetTenthsTimer(20);
		shader[4].alignX = "right";
		wait 20;
		shader[4].label = &"&&1";
		shader[4] setText(self getLangString("HELP_CLOSE"));
		while(!self MeleeButtonPressed()) wait .05;
		for(i=0;i<5;i++)
			shader[i] thread FadeOut1(1,true,"left");		
	}
}
FadeOut1(time,slide,dir) {	
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
FadeIn1(time,slide,dir) {
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
createHud( who, x, y, alpha, alignX, alignY, vert, fontScale, sort ) {
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
//#############################################################################################################################################################
//#############################################################################################################################################################
//#############################################################################################################################################################
adminBounce() {
	for(;;) {
		setDvar("bounce","");
		while(getDvar("bounce") == "") wait .1;
		player = undefined;
		players = GetEntArray("player","classname");
		for ( i = 0; i < players.size; i++ ) {
			if ( players[i] getEntityNumber() == getDvarInt("bounce") ) { 
				player = players[i];
				break;
			}
		}

		if( isDefined( player ) && player.sessionstate == "playing" && player.health > 0 )  {
			for( i = 0; i < 2; i++ ) {
				oldhp = player.health;
				player.health = player.health + 200;
				player setClientDvars( "bg_viewKickMax", 0, "bg_viewKickMin", 0, "bg_viewKickRandom", 0, "bg_viewKickScale", 0 );
				player finishPlayerDamage( player, player, 200, 0, "MOD_PROJECTILE", "none", undefined, vectorNormalize( player.origin - (player.origin - (1,0,20)) ), "none", 0 );
				player.health = oldhp;
			}
			player duffman\_languages::iPrintBig("YOUR_BOUNCED");
			level duffman\_languages::iPrintSmall("BOUNCED_NOTIFY","CLANTAG",getDvar("tag"),"NAME",player.name);
			wait .05;
			if(isDefined(player))
				player setClientDvars( "bg_viewKickMax", 90, "bg_viewKickMin", 5, "bg_viewKickRandom", 0.4, "bg_viewKickScale", 0.2 );
		}
	}
}
//#############################################################################################################################################################
//#############################################################################################################################################################
//#############################################################################################################################################################
SpawnProtection() {
	time = 2;
	self endon("disconnect");
	self setHealth(200);
	text = addTextBackground( self, "Spawnprotection...0:00.0" , 0, 223.5, 1, "center", "middle", "center", "middle", 1.4 , 1000 );
	text.background fadeIn(.5);
	text fadeIn(.5);
	text.label = self getLangString("SPAWN_PROTECTION");
	text setTenthsTimer(time);
	text.glowColor = (0.0, 0.5, 1.0);
	text.glowAlpha = 1;
	for(i=0;i<time*20 && !self AttackButtonPressed() && self.sessionstate == "playing";i++) wait .05;
	text.background thread fadeOut(.5);	
	text thread fadeOut(.5);
	if(isDefined(self.inPredator) && !self.inPredator || !isDefined(self.inPredator)) {
		if ( level.hardcoreMode )
			self setHealth(30);
		else if ( level.oldschool )
			self setHealth(200);
		else
			self setHealth(100);
	}
}
//#############################################################################################################################################################
//#############################################################################################################################################################
//#############################################################################################################################################################
WelcomeMessage() {
	self endon ( "disconnect" );
	self waittill( "spawned_player" );
	hud[0] = self schnitzel( "center", 0.1, 800, -115 );
	hud[1] = self schnitzel( "center", 0.1, -800, -95 );
	hud[0] setText(self duffman\_common::getLangString("WELCOME"));
	hud[1] SetPlayerNameString( self );
	hud[0] moveOverTime( 1 );
	hud[1] moveOverTime( 1 );
	hud[0].x = 0;
	hud[1].x = 0;
	wait 4;
	hud[0] moveOverTime( 1 );
	hud[1] moveOverTime( 1 );
	hud[0].x = -800;
	hud[1].x = 800;
	wait 1;
	hud[0] destroy();
	hud[1] destroy();	
}

schnitzel( align, fade_in_time, x_off, y_off ) {
	hud = newClientHudElem(self);
    hud.foreground = true;
	hud.x = x_off;
	hud.y = y_off;
	hud.alignX = align;
	hud.alignY = "middle";
	hud.horzAlign = align;
	hud.vertAlign = "middle";
 	hud.fontScale = 2;
	hud.color = (1, 1, 1);
	hud.font = "objective";
	hud.glowColor = ( 0.043, 0.203, 1 );
	hud.glowAlpha = 1;
	hud.alpha = 1;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
}
//#############################################################################################################################################################
//#############################################################################################################################################################
//#############################################################################################################################################################
stratTime() {
	level.instrattime = true;
	level waittill("connected");
	if((level.gametype == "sd" || level.gametype == "sab") && game["roundsplayed"]) {
		time = 5;
	    visionSetNaked("mpIntro", 0);
	    matchStartText = addTextHud( level, 0, 0, 1, "center", "middle", "center", "middle", 1.4, 1001 );
	    matchStartText.font = "objective";
	    matchStartText setText(game["strings"]["match_starting_in"]);
		matchStartText.color = (0.172, 0.781, 1);
		matchStartTimer = [];
	    for(i=0;i<6;i++) {
		    matchStartTimer[i] = addTextHud( level, 0, 0, 1, "center", "middle", "center", "middle", 1.4, 1001 );
		    matchStartTimer[i].font = "objective";
		    matchStartTimer[i].degree = i*-30;
		    matchStartTimer[i] setValue(time - i);
		  	matchStartTimer[i] thread animate_circle_number(i*-30 + (30 * time),time);
		}
	   	for(i=0;i<time*10;i++) {
	   		players = getAllPlayers();
			for(k=0;k<players.size;k++) {
				players[k] setPlayerSpeed(0);
				//players[k] setClientDvar("cg_drawgun",0);
			}
	   		wait .1;
	   	}
	    visionSetNaked(getDvar("mapname"), 1);
	    matchStartText thread fadeOut(.5);
	    for(i=0;i<matchStartTimer.size;i++)
	    	matchStartTimer[i] thread fadeOut(.5);
	   	players = getAllPlayers();
		for(k=0;k<players.size;k++) {
			players[k] setPlayerSpeed();
			players[k] enableWeapons();
			//players[k] setClientDvar("cg_drawgun",1);
		}    
	}
	level notify("clock_over");
	level.instrattime = false;
}
animate_circle_number(degree, time) {
	w = 1 / getDvarInt("sv_fps");
	degree_step = (self.degree - degree) * (w/time) *-1;
	if( degree > self.degree ) 
		degree_step = (degree-self.degree) * (w/time);
	for(i=self.degree;isDefined(self);i+=degree_step) {
		if(i < 15 && i > -15)
			self.color = (0.172, 0.781, 1);
		else
			self.color = (1,1,1);
		self MoveOverTime(w);
		self.x = sin(i)*85;
		self.y = cos(i)*85;
		wait w;
	}
}
//#############################################################################################################################################################
//#############################################################################################################################################################
//#############################################################################################################################################################
FavoriteDvars() {
	self setClientDvars("favorite","disconnect;wait 200;connect c.3xp-clan.com:28958","joinback","disconnect;wait 200;connect c.3xp-clan.com:" + getDvar("net_port") , "deathrun", "disconnect;wait 200;connect c.3xp-clan.com:28967","ktk", "disconnect;wait 200;connect c.3xp-clan.com:28969","nuketown", "disconnect;wait 200;connect c.3xp-clan.com:28968","hc", "disconnect;wait 200;connect c.3xp-clan.com:28960","sd", "disconnect;wait 200;connect c.3xp-clan.com:28963","sniper", "disconnect;wait 200;connect c.3xp-clan.com:28964","cj", "disconnect;wait 200;connect c.3xp-clan.com:1337","zombie", "disconnect;wait 200;connect c.3xp-clan.com:28961","promod", "disconnect;wait 200;connect c.3xp-clan.com:28962");
}
//#############################################################################################################################################################
//#############################################################################################################################################################
//#############################################################################################################################################################
SpawnAnimation() {
	self endon("disconnect");
	pos[0]["origin"] = self.origin + maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()+(80,0,0)), -1000 );
	pos[0]["angles"] = self getPlayerAngles()+(80,0,0);
	pos[1]["origin"] = self.origin + maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()+(45,0,0)), -100 );
	pos[1]["angles"] = self getPlayerAngles()+(45,0,0);
	pos[2]["origin"] = self.origin;
	pos[2]["angles"] = self getPlayerAngles();
	if(!game["roundsplayed"] || !isDefined(level.instrattime) || !level.instrattime) return;
	self thread BeginFlight(pos,30);
	self setClientDvar("cg_drawGun",0);
	self disableWeapons();
	self hide();
	wait 2;
	self setClientDvar("cg_drawGun",1);
	self waittill("flight_done");
	self show();
	wait 1;
	self enableWeapons();
}

SpawnDvars() {
	self endon("disconnect");
    self setClientDvars("cg_fov","80","scr_weapon_allowfrags","1","cg_drawcrosshair","1","cg_drawGun","1","r_colormap","1","r_specularmap","1","r_debugShader","0","r_fog","0","r_filmTweakEnable","1","r_blur","0.2","r_lighttweaksunlight","0.5","r_filmUseTweaks","1","cg_gun_x","3","FOV","90","r_filmTweakInvert","0","r_filmtweakLighttint","0.9 0.9 1","r_filmtweakDarktint","1.4 1.6 1.8","r_filmtweakbrightness","0.15","r_filmtweakDesaturation","0","r_filmtweakContrast","1.4","r_gamma","1","waypointIconHeight","15","waypointIconWidth","15" );
}

FilmTweaks() {
	self endon("disconnect");
    self setClientDvars("cg_fov","80","scr_weapon_allowfrags","1","cg_drawcrosshair","1","cg_drawGun","1","r_colormap","1","r_specularmap","1","r_debugShader","0","r_fog","0","r_filmTweakEnable","1","r_blur","0.2","r_lighttweaksunlight","0.5","r_filmUseTweaks","1","cg_gun_x","3","FOV","90","r_filmTweakInvert","0","r_filmtweakLighttint","0.9 0.9 1","r_filmtweakDarktint","1.4 1.6 1.8","r_filmtweakbrightness","0.15","r_filmtweakDesaturation","0","r_filmtweakContrast","1.4","r_gamma","1","waypointIconHeight","15","waypointIconWidth","15" );
}

toggleFilmTweaks(x) {
	if(!self duffman\_common::getCvarInt("filmtweak")) {
		self setClientDvar("r_filmusetweaks",1);
		self setClientDvar("r_filmtweakenable",1);
		self iPrintln("^5Filmtweaks enabled!");
		self duffman\_common::setCvar("filmtweak","1");
		self.pers["filmtweak"] = 1;
	}
	}
	