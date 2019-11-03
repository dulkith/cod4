#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
//#include duffman\_common;

do_reaper()
{
	self endon("disconnect");
	self endon("game_ended");
	self thread countdowntimer();
	self.reaper = true;
	level.reaper = true;
	self.oldPos = self getOrigin();
	thread reaperHud();
	self.rLoc = getPosition();
	self setHealth(99999999999);
	thread reaperLink();
	thread reaperWeapon();
	self playLocalSound("item_nightvision_on");
	team = self.pers["team"];
	otherTeam = level.otherTeam[team];
	self maps\mp\gametypes\_globallogic::leaderDialog("helicopter_inbound", team);
	self maps\mp\gametypes\_globallogic::leaderDialog("enemy_helicopter_inbound", otherTeam);
}
reaperLink()
{
	self endon("game_ended");
	level endon ("vote started");
	thread reaperDeath();
	self.noclip = false;
	self.reap["veh"] = spawn("script_model",(self.rLoc[0]+(1150*cos(0)),self.rLoc[1]+(1150*sin(0)),self.rLoc[2]));
	self.reap["veh"] setModel("vehicle_mi24p_hind_desert");
	thread reaperMove();
	self linkTo(self.reap["veh"],"tag_player",(0,100,-120),(0,0,0));
	self hide();
	thread reaperExit();
	self disableWeapons();
}
reaperExit()
{
	self endon("disconnect");
	while(self.reaper)
	{
		angles = self getPlayerAngles();
		if(angles[0] <= 30)
			self setPlayerAngles((30,angles[1],angles[2]));
			
		wait 60;
		self playLocalSound("item_nightvision_off");
		self unlink();
		self setOrigin(self.oldPos);
		if(isDefined(self.r[0])) for(k = 0; k < self.r.size; k++) if(isDefined(self.r[k])) self.r[k] destroy();
		self enableWeapons();
		self show();
		self setHealth(100);
		thread reaperExitFunctons();
		self notify("exitReaper");
		level.reaper = false;
	}
	wait .05;
}

reaperDeath()
{
	self endon("exitReaper");
	self waittill("death");
	thread reaperExitFunctons();
}
reaperExitFunctons()
{
	level.reaper = false;
	self show();
	self.reap["veh"] delete();
	self.reaper = false;
	if(isDefined(self.reap["bullet"]))
		self.reap["bullet"] delete();
}
reaperMove()
{
	self endon("disconnect");
	  self endon("game_ended");
	level endon ("vote started");
	while(self.reaper)
	{
		for(k = 0; k < 360; k+=.5)
		{
			if(!self.reaper)
				break;
				
			location = (self.rLoc[0]+(1150*cos(k)),self.rLoc[1]+(1150*sin(k)),self.rLoc[2]);
			angles = vectorToAngles(location - self.reap["veh"].origin);
			self.reap["veh"] moveTo(location,.1);
			self.reap["veh"].angles = (angles[0],angles[1],angles[2]-40);
			wait .1;
		}
	}
}
reaperWeapon()
{
	self endon("disconnect");
	self endon("exitReaper");
	self endon("game_ended");
	level endon ("vote started");
	while(self.reaper)
	{
		if(self attackButtonPressed())
		{
			self.reap["bullet"] = spawn("script_model",self getTagOrigin("tag_weapon_left"));
			self.reap["bullet"] setModel("projectile_cbu97_clusterbomb");
			self.reap["bullet"] playSound("weap_hind_missile_fire");
			for(time = 0; time < 200; time++)
			{
				if(!self.reaper)
					break;
					
				vector = anglesToForward(self.reap["bullet"].angles);
				forward = self.reap["bullet"].origin+(vector[0]*45,vector[1]*45,vector[2]*49);
				collision = bulletTrace(self.reap["bullet"].origin,forward,false,self);
				
				self.reap["bullet"].angles = (vectorToAngles((getCursorPos()-(0,0,130)) - self.reap["bullet"].origin));
				self.reap["bullet"] moveTo(forward,.05);
				playFxOnTag(level.chopper_fx["fire"]["trail"]["medium"],self.reap["bullet"],"tag_origin");
				if(collision["surfacetype"] != "default" && collision["fraction"] < 1 && level.collisions)
				{
					expPos = self.reap["bullet"].origin;
					for(k = 0; k < 360; k+=80)
						playFx(level.chopper_fx["explode"]["large"],(expPos[0]+(150*cos(k)),expPos[1]+(150*sin(k)),expPos[2]+100));
						
					earthquake(3,1.6,expPos,450);
					radiusDamage(expPos,400,300,120,self,"MOD_PROJECTILE_SPLASH","artillery_mp");
					self.reap["bullet"] playSound("cobra_helicopter_hit");
					break;
				}
				wait .05;
			}
			self.reap["bullet"] delete();
			wait 2;
		}
		wait .05;
	}
}
reaperAIDetect(hudElem)
{
	self endon("disconnect");
	while(self.reaper)
	{
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
}
reaperHud()
{
	coord = strTok("21,0,2,24;-20,0,2,24;0,-11,40,2;0,11,40,2;0,-39,2,57;0,39,2,57;-48,0,57,2;49,0,57,2;-155,-122,2,21;-154,122,2,21;155,122,2,21;155,-122,2,21;-145,132,21,2;145,-132,21,2;-145,-132,21,2;146,132,21,2",";");
	for(k = 0; k < coord.size; k++)
	{
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
	thread reaperAIDetect(self.r);
}
isMap(map)
{
	if(map == getDvar("mapname"))
		return true;
		
	return false;
}
destroyAc130Huds(player)
{
	player waittill("death");
	if(isDefined(self))
		self destroyElem();
}
getPosition()
{
	location = (0,0,2000);
	if(isMap("mp_bloc"))
		location = (1100,-5836,2500);
	else if(isMap("mp_crossfire"))
		location = (4566,-3162,2300);
	else if(isMap("mp_citystreets"))
		location = (4384,-469,2100);
	else if(isMap("mp_creek"))
		location = (-1595,6528,2500);
	else if(isMap("mp_bog"))
		location = (3767,1332,2300);
	else if(isMap("mp_overgrown"))
		location = (267,-2799,2600);
	else
		location = (0,0,2300);
		
	return location;
}
getCursorPos()
{
	return bulletTrace(self getTagOrigin("tag_weapon_right"),vector_scale(anglesToForward(self getPlayerAngles()),1000000),false,self)["position"];
}
setHealth(health)
{
	self.maxhealth = health;
	self.health = self.maxhealth;
}

countdowntimer()
{
	self endon( "disconnect" );
	self.countdowntext = newClientHudElem(self);
	self.countdowntext.elemType = "font";
	self.countdowntext.x = -25;
	self.countdowntext.y = -56;
	self.countdowntext.alignX = "center";
	self.countdowntext.alignY = "bottom";
	self.countdowntext.horzAlign = "center";
	self.countdowntext.vertAlign = "bottom";
	self.countdowntext setText("^2Time Left");
	self.countdowntext.color = (0.0, 0.8, 0.0);
	self.countdowntext.fontscale = 1.4;
	self.countdowntext.foreground = false;
	self.countdowntext.hidewheninmenu = false;
	self.countdowntext.sort = 1002;
			
	self.countdowntime = newClientHudElem(self);
	self.countdowntime.elemType = "font";
	self.countdowntime.x = 27;
	self.countdowntime.y = -56;
	self.countdowntime.alignX = "center";
	self.countdowntime.alignY = "bottom";
	self.countdowntime.horzAlign = "center";
	self.countdowntime.vertAlign = "bottom";
	self.countdowntime setTimer(60);
	self.countdowntime.color = (1.0, 0.0, 0.0);
	self.countdowntime.fontscale = 1.4;
	self.countdowntime.foreground = false;
	self.countdowntime.hideWhenInMenu = false;
	self.countdowntime.sort = 1002;
		
	self.countdownshader = newClientHudElem(self);
	self.countdownshader.x = -6;
	self.countdownshader.y = -50;
	self.countdownshader.alignX = "center";
	self.countdownshader.alignY = "bottom";
	self.countdownshader.horzAlign = "center";
	self.countdownshader.vertAlign = "bottom";
	self.countdownshader setShader("line_vertical", 120, 30);
	self.countdownshader.alpha = 0.9;
	self.countdownshader.color = (0,.5,1);
	self.countdownshader.foreground = false;
	self.countdownshader.hidewheninmenu = false;
		
	wait 60;
		
	self.countdowntext destroy();	
	self.countdowntime destroy();
	self.countdownshader destroy();
}