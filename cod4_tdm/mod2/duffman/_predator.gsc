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

#include maps\mp\_utility;

init() {
	PreCacheModel("prop_suitcase_bomb");
	PreCacheModel( "projectile_cbu97_clusterbomb" );
	PreCacheShellShock("frag_grenade_mp");
	level.chopper_fx["explode"]["large"] = loadfx ("explosions/aerial_explosion_large");	
	level.chopper_fx["fire"]["trail"]["medium"] = loadfx ("smoke/smoke_trail_black_heli");	
}

Predator() {
	self endon("exitReaper");
	self endon("disconnect");
	level.predatorInProgress = true;	
	//self.isGod = true;
	self duffman\_common::setHealth(9999);
	self.inPredator = true;
	while(self GetCurrentWeapon() == "radar_mp" || self GetCurrentWeapon() == "none") wait .05;
	self.starwep = self GetCurrentWeapon();
	if(isDefined(self.reaper) && self.reaper) { self switchtoweapon(self.starwep); return; }
	level thread EndOnDc(self);
	self hide();
	self.visible = false;
	self.reaper = true;
	self giveWeapon( "briefcase_bomb_mp" );
	self setWeaponAmmoStock( "briefcase_bomb_mp", 0 );
	self setWeaponAmmoClip( "briefcase_bomb_mp", 0 );
	for(i=0;i<6;i++) {
		self switchToWeapon( "briefcase_bomb_mp" );
		wait .5;
	}
	self.bs = newClientHudElem( self );
	self.bs.alpha = 0;
	self.bs.alignX = "left";
	self.bs.alignY = "top";	
	self.bs.horzAlign = "fullscreen";
	self.bs.vertAlign = "fullscreen";
	self.bs setShader("black", 640, 480);
	self.bs fadeovertime(.5);
	self.bs.alpha = 1;
	wait .5;
	angles = self getPlayerAngles();
	self takeweapon("briefcase_bomb_mp");
	self switchToWeapon( self.starwep );
	self disableWeapons();
	self.bs fadeovertime(.5);
	self.bs.alpha = 0;
	self.oldPos = self getOrigin();
	coord = strTok("21,0,2,24;-20,0,2,24;0,-11,40,2;0,11,40,2;0,-39,2,57;0,39,2,57;-48,0,57,2;49,0,57,2",";");
	for(k = 0; k < coord.size; k++) {
		tCoord = strTok(coord[k],",");
		self.r[k] = newClientHudElem(self);
		self.r[k].sort = 100;
		self.r[k].alpha = .8;
		self.r[k] setShader("white",int(tCoord[2]),int(tCoord[3]));
		self.r[k].x = int(tCoord[0]);
		self.r[k].y = int(tCoord[1]);
		self.r[k].hideWhenInMenu = true;
		self.r[k].alignX = "center";
		self.r[k].alignY = "middle";
		self.r[k].horzAlign = "center";
		self.r[k].vertAlign = "middle";
	}
	location = (0,0,2300);
	if(getDvar("mapname") == "mp_bloc") location = (1100,-5836,2500);
	else if(getDvar("mapname") == "mp_crossfire") location = (4566,-3162,2300);
	else if(getDvar("mapname") == "mp_citystreets") location = (4384,-469,2100);
	else if(getDvar("mapname") == "mp_creek") location = (-1595,6528,2500);
	else if(getDvar("mapname") == "mp_bog") location = (3767,1332,2300);
	else if(getDvar("mapname") == "mp_overgrown") location = (267,-2799,2600);	
	else if(getDvar("mapname") == "mp_nuketown") location = (84,-31,1800);
	else if(getDvar("mapname") == "mp_strike") location = (-100,-120,2170);	
	self setOrigin((location[0]+(300*cos(20)),location[1]+(300*sin(20)),location[2]));
	self setPlayerAngles((60,vectorToAngles(self.origin - location)[1],0));
	self playLocalSound("item_nightvision_on");
	self.bs destroy();		
	if(!self.pers["filmtweak"])
		self setClientDvars("r_filmTweakDesaturation",1,"r_filmUseTweaks",1,"r_filmTweaksEnable",1,"r_filmTweakBrightness",.005,"cg_fovscale",1.2);
	else
		self setClientDvar("cg_fovscale",1.2);
	p = getEntArray("player","classname");
	z=999999;
	for(i=0;i<p.size;i++) {
		if(isDefined(p[i]) && p[i].sessionstate == "playing" && p[i] != self && z > p[i].origin[2])
			z = p[i].origin[2];
	}
	if(z==999999) z = -100;
	vector = anglesToForward(self getPlayerAngles());
	forward = self getEye()+(vector[0]*70,vector[1]*70,vector[2]*70);
	self.reap["bullet"] = spawn("script_model",forward);
	self LinkTo(self.reap["bullet"]);
	duffman\_common::TriggerEarthquake(2,1.6,self.origin,450);
	//self.reap["bullet"] setModel("projectile_cbu97_clusterbomb");
	level.bulletmodel = self.reap["bullet"];
	fov = 1.2;
	hudElem = self.r;
	speed = 10;
	speedlimit = 0;
	for(time = 0; time < 300; time++) {
		if(!self.reaper || !isDefined( self) || !isDefined(self.reaper))
			return;

		if(self AttackButtonPressed() && speed == 10 || speedlimit == 80) {
			speed = 70;
			speedlimit = 0;
			self.reap["bullet"] setModel("projectile_cbu97_clusterbomb");
			self playSound("weap_hind_missile_fire");
		}
		self setClientDvar("cg_fovscale",fov);
		if(speed == 70) {
			self ShellShock( "frag_grenade_mp", .2 );
			playFxOnTag(level.chopper_fx["fire"]["trail"]["medium"],self.reap["bullet"],"tag_origin");	
			duffman\_common::TriggerEarthquake(.15,1.6,forward,450);
		}
		else
			speedlimit++;
		fov-=(.015/70*speed);	
		angles = self getPlayerAngles();
		if(angles[0] <= 30)
			self setPlayerAngles((30,angles[1],angles[2]));
		vector = anglesToForward(self.reap["bullet"].angles);
		forward = self.reap["bullet"].origin+(vector[0]*speed,vector[1]*speed,vector[2]*speed);
		collision = bulletTrace(self.reap["bullet"].origin,forward,false,self);
		self.reap["bullet"].angles = self getPlayerAngles();
		if(self.sessionteam == "spectator") {
			level thread reaperExitFunctons(self);
			return;
		}
		if(collision["surfacetype"] != "default" && collision["fraction"] < 1 || (z-100) > self.origin[2]) {
			if(speed == 10) {
				level thread reaperExitFunctons(self);
				return;
			}
			vector = anglesToForward(self.reap["bullet"].angles);
			self.reap["bullet"].origin = self.reap["bullet"].origin-(vector[0]*100,vector[1]*100,vector[2]*100);
			expPos = self.reap["bullet"].origin;
			playFx(level.chopper_fx["explode"]["large"],expPos);
			duffman\_common::TriggerEarthquake(3,1.6,expPos,450);
		//	radiusDamage(expPos,400,300,120,self,"MOD_PROJECTILE_SPLASH","artillery_mp");
			players = duffman\_common::getAllPlayers();
			for(i=0;i<players.size;i++) {
				if(players[i] duffman\_common::isRealyAlive() && players[i] != self && (players[i].pers["team"] != self.pers["team"] || !level.teambased) && distance(players[i].origin,self.origin) < 300) {
					players[i] thread [[level.callbackPlayerDamage]](self,self,int(300 - distance(players[i].origin,self.origin)),8,"MOD_PROJECTILE_SPLASH","artillery_mp",(0,0,0),(0,0,0),"torso_upper",0);
				}
			}				
			self.reap["bullet"] playSound("cobra_helicopter_hit");
			level thread reaperExitFunctons(self);
			return;
		}
		self.reap["bullet"] moveTo(forward,.05);
		target["enemyTeam"] = false;
		target["myTeam"] = false;
		for(k = 0; k < level.players.size; k++) {
			if(isDefined(level.players[k]) && isAlive(level.players[k]) && level.players[k] != self) {
				if(distance(bulletTrace(self getTagOrigin("tag_weapon_right"),vector_scale(anglesToForward(self getPlayerAngles()),1000000),false,self)["position"],level.players[k].origin) < 200)
					if((level.teamBased && self.team != level.players[k].team) || (!level.teamBased && level.players[k] != self)) target["enemyTeam"] = true;
					else target["myTeam"] = true;
			}
		}
		for(k = 0; k < int(hudElem.size/2); k++) {
			if(isDefined(hudElem[k])) {
				if(target["myTeam"] && target["enemyTeam"])	hudElem[k].color = (1,(188/255),(43/255));
				else if(target["myTeam"] && !target["enemyTeam"]) hudElem[k].color = (0,.7,0);
				else if(!target["myTeam"] && target["enemyTeam"]) hudElem[k].color = (.7,0,0);
			}
		}
		wait 1/20; //
		for(k = 0; k < hudElem.size; k++) hudElem[k].color = (1,1,1);
	}
	level thread reaperExitFunctons(self);
}

EndOnDc(player) {
	player endon("exitReaper");
	player waittill("disconnect");
	thread reaperExitFunctons(undefined);
}

reaperExitFunctons(player) {
	if(isDefined(player)) {
		player playLocalSound("item_nightvision_off");
		player unlink();
		player setOrigin(player.oldPos);
		if(isDefined(player.r[0])) for(k = 0; k < player.r.size; k++) if(isDefined(player.r[k])) player.r[k] destroy();
		//player.isGod = false;
		if ( level.hardcoreMode )
			player duffman\_common::setHealth(30);
		else if ( level.oldschool )
			player duffman\_common::setHealth(200);
		else
			player duffman\_common::setHealth(100);
		player.visible = true;
		player show();
		player.reaper = false;
		player.inPredator = false;
		player enableWeapons();
		if(isDefined(player.reap["bullet"])) player.reap["bullet"] delete();
		if(!player.pers["filmtweak"])
			player setClientDvars("r_filmTweakDesaturation",.2,"r_filmUseTweaks",0,"r_filmTweaksEnable",1,"r_filmTweakBrightness",0,"cg_fovscale",1);
		else
			player setClientDvar("cg_fovscale",1);
		player notify("exitReaper");
	}
	level.predatorInProgress = undefined; 
	if(isDefined(level.bulletmodel)) level.bulletmodel delete();
	level.bulletmodel = undefined;
}