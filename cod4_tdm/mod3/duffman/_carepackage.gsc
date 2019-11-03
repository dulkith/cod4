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
#include maps\mp\_helicopter;

main() {
	precacheModel( "com_plasticcase_beige_big" );
	PreCacheShader("hud_suitcase_bomb");
	level.fx[1]=loadfx("fire/tank_fire_engine");
	level.chopper_fx["explode"]["medium"] = loadfx("explosions/aerial_explosion");
}

canCallPackage() {
	if(isDefined(level.carpackageInUse))
		return false;
	location = 2000;
	if(getDvar("mapname") == "mp_bloc") location = 2400;
	else if(getDvar("mapname") == "mp_crossfire") location = 2200;
	else if(getDvar("mapname") == "mp_citystreets") location = 2000;
	else if(getDvar("mapname") == "mp_creek") location = 2100;
	else if(getDvar("mapname") == "mp_bog") location = 2200;
	else if(getDvar("mapname") == "mp_overgrown") location = 2500;	
	else if(getDvar("mapname") == "mp_nuketown") location = 1700;
	else if(getDvar("mapname") == "mp_strike") location = 2100;	
	else if(getDvar("mapname") == "mp_crash") location = 2100;	
	heliorigin = (self.origin[0],self.origin[1],location);
	playerorigin = self.origin;
	surface = BulletTrace(playerorigin + (0,0,50), playerorigin - (0,0,50), false, self)["surfacetype"];
	for(i=0;i<360;i+=36) {
		add = ((50*cos(i)),(50*sin(i)),30);
		if(!BulletTracePassed(heliorigin+add,playerorigin+add,true,self)) {
			//self iPrintlnbold("You cant call a Care Package at this position");
			self iPrintBig("PACKAGE_POSITION");
			return false;
		}
	}
	level.carpackageInUse = true;
	self thread CarePackage(heliorigin,playerorigin,surface);
	return true;
}

CarePackage(heliorigin,playerorigin,surface) {
	self endon("disconnect");
	vector = anglesToForward((0,randomint(360) ,0));
	start = heliorigin+(vector[0]*10600,vector[1]*10600,0);

	model = "vehicle_mi24p_hind_desert";
	sound = "mp_hind_helicopter";
	if ( self.pers["team"] == "allies" ) {
		model = "vehicle_cobra_helicopter_fly";
		sound = "mp_cobra_helicopter";
	}

	chopper = spawnHelicopter( self, start, (0,0,-10), "cobra_mp", model );
	chopper playLoopSound( sound );
	chopper.currentstate = "ok";
	chopper.laststate = "ok";
	chopper setdamagestage( 3 );
	chopper setspeed(1000, 25, 10);
	chopper setvehgoalpos( heliorigin, 1);

	box = spawn( "script_model", heliorigin );

	box setmodel("com_plasticcase_beige_big");
	box LinkTo( chopper, "tag_ground" , (0,0,-10) , (0,0,0) );
	while(distance(chopper.origin,heliorigin) >= 50) wait .05;
	box Unlink();
	box.angles = (0,box.angles[1],0);
	box MoveTo(playerorigin,distance(playerorigin,box.origin) / 900);
	chopper setvehgoalpos( start, 1);
	chopper thread deleteChopper(start);
	box waittill ("movedone");
	if(isDefined(surface))
		box thread Bounce(surface);

	players = getAllPlayers();
	for(k=0;k<10;k++) {
		for(i=0;i<players.size;i++)
			if(distance(players[i].origin,box.origin) < 65)
				players[i] suicide();
		wait .05;
	}
	solid = spawn("trigger_radius",box.origin,0,64,50);
	solid setContents(1);
	solid.targetname = "script_collision";
	level thread endOnDc(self,box,solid,chopper);
	box thread AddTriggerMsg();
	box thread AddTrigger(self);
	content = newHudElem();
	content.x = box.origin[0];
	content.y = box.origin[1];
	content.z = box.origin[2]+55;
	content.alpha = .75;
	content.archived = true;
	content setShader("hud_suitcase_bomb", 25, 25);
	content setWaypoint(true, "hud_suitcase_bomb");//waypoint_bombsquad

	box waittill("death");
	
	solid notify("deleted");
	solid delete();

	content destroy();
}

// ** Made by Viking
Bounce(type) {
	self endon("death");
	
	BounceTargets[0][0] = 32;
	BounceTargets[0][1] = 0.4;
	BounceTargets[0][2] = 0;
	BounceTargets[0][3] = 0.4;

	BounceTargets[1][0] = -32;
	BounceTargets[1][1] = 0.425;
	BounceTargets[1][2] = 0.425;
	BounceTargets[1][3] = 0;

	BounceTargets[2][0] = 0.16;
	BounceTargets[2][1] = 0.25;
	BounceTargets[2][2] = 0;
	BounceTargets[2][3] = 0.25;

	BounceTargets[3][0] = -0.16;
	BounceTargets[3][1] = 0.275;
	BounceTargets[3][2] = 0.275;
	BounceTargets[3][3] = 0;
	
	for(i=0;i<BounceTargets.size;i++)
	{
		self PlaySound("grenade_bounce_" + type);
		self MoveZ(BounceTargets[i][0], BounceTargets[i][1], BounceTargets[i][2], BounceTargets[i][3]);
		wait BounceTargets[i][1];
	}
}

endOnDc(player,box,solid,chopper) {
	solid endon("deleted");
	player waittill("disconnect");
	if(isDefined(box))
		box delete();
	if(isDefined(solid))
		solid delete();
	if(isDefined(chopper))
		chopper delete();		
	level.carpackageInUse = undefined;
}

deleteChopper(start) {
	self endon("death");
	while(distance(self.origin,start) >= 200) wait .05;
	level.carpackageInUse = undefined;
	self delete();
}

AddTrigger(owner) {
	owner endon("disconnect");
	num = level.carepackage.size;
	triggerrange = 80;
	while(isDefined(self)) {
		wait .05;
		players = getAllPlayers();
		for(i=0;i<players.size;i++) {
			player = players[i];
			if(player isRealyAlive() && distance(player.origin,self.origin) < triggerrange) {
				if(player UseButtonPressed()) {
					level.carepackage[num] = true;
					timer = 2.5;
					if(player.pers["team"] != owner.pers["team"])
						timer = 6;
					else if(player != owner)
						timer = 4.5;
					player DisableWeapons();
					player freezeControls( true );
					player.entschaerfen = player maps\mp\gametypes\_hud_util::createBar((1,1,1), 128, 8);
					player.entschaerfen maps\mp\gametypes\_hud_util::setPoint("CENTER", 0, 0, 0);
					player.entschaerfen maps\mp\gametypes\_hud_util::updateBar(0, 1/timer );
					for(i=0;i<(timer*20+1);i++) {
						if(!isDefined(player)) {
							level.carepackage[num] = false;
							i = 999999;
						}
						if(!player UseButtonPressed() || !player isRealyAlive() || distance(player.origin,self.origin) > (triggerrange + 10)) {
							if(isDefined(player.entschaerfen))
								player.entschaerfen maps\mp\gametypes\_hud_util::destroyElem();	
							player EnableWeapons();
							player freezeControls( false );
							level.carepackage[num] = false;
							i = 999999;
						}
						wait .05;
						if(i == (timer*20)) {
							if(isDefined(player.entschaerfen))
								player.entschaerfen maps\mp\gametypes\_hud_util::destroyElem();	
							player EnableWeapons();
							player freezeControls( false );
							if(player.pers["team"] != owner.pers["team"] && randomint(1) == 0) {
								player thread Explode();
							}
							else
								player thread Rewards();
							self delete();
							return;
						}
					}
				}
			}
		}
	}
}

AddTriggerMsg() {
	if(!isDefined(level.carepackage)) {
		level.carepackage = [];
	}
	num = level.carepackage.size;
	wait .05;
	level.carepackage[num] = false;

	triggerrange = 80;
	while(isDefined(self)) {
		players = getAllPlayers();
		for(i=0;i<players.size;i++) {
			player = players[i];
			if(player isRealyAlive() && distance(player.origin,self.origin) < triggerrange && !level.carepackage[num]) {
				player.carepackagemsg = true;
				//player maps\mp\_utility::setLowerMessage( "Press ^3[[{+usereload}]] ^7to pickup Carepackage" );
				player maps\mp\_utility::setLowerMessage(player getLangString("PICKUP"));
			}
			else if(isDefined(player.carepackagemsg) && player.carepackagemsg && (level.carepackage[num] || distance(player.origin,self.origin) > triggerrange)) {
				player.carepackagemsg = false;
				player maps\mp\_utility::clearLowerMessage( .3 );
			}
		}
		wait .05;
	}
	players = getAllPlayers();
	for(i=0;i<players.size;i++)
		if(isDefined(players[i].carepackagemsg) && players[i].carepackagemsg)
			players[i] maps\mp\_utility::clearLowerMessage( .3 );
}

NukeBullets() {
	self endon("death");
	self endon("disconnect");
	self endon("spawned");
    for(i=0;i<20;i++) {
        self waittill ( "weapon_fired" );
		self playsound("rocket_explode_default");
		vec = anglestoforward(self getPlayerAngles());
		end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
		SPLOSIONlocation = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+end, 0, self)[ "position" ];
		playfx(level.chopper_fx["explode"]["medium"], SPLOSIONlocation); 
		RadiusDamage( SPLOSIONlocation, 200, 500, 60, self ); 
		duffman\_common::TriggerEarthquake(0.3, 1, SPLOSIONlocation, 400); 
		wait 1;
	}
}

Rewards() {
	self endon("disconnect");
	random = randomint(9);
	switch(random) {
		case 0:
			//self NotifyMsg("You got Nuke bullets!");
			self NotifyMsg(self getLangString("NUKE_BULLETS"));
			self thread NukeBullets();
			break;
		case 1:
			//self NotifyMsg("You got ability Rusher!");
			self NotifyMsg(self getLangString("RUSHER"));
			self SetMoveSpeedScale(2);
			wait 30;
			if(self isRealyAlive())
				self SetMoveSpeedScale(1);
			break;
		case 2:	
			self NotifyMsg(self getLangString("NINJA"));
			self hide();
			self.visible = false;
			for(i=0;i<40;i++) {
				if(self getStance() == "stand")
					playfx(level.fx[1], self.origin); 
				if(!self isRealyAlive())
					i = 50;
				wait .5;			
			}
			self.visible = true;
			self show();
			break;
		case 3:
			self NotifyMsg(self getLangString("strafe_mp"));
			self maps\mp\gametypes\_hardpoints::giveHardpointItem( "strafe_mp" );
			break;	
			//self getLangString	
		case 4:
			self NotifyMsg(level.hardpointHints["helicopter_mp"]);
			self maps\mp\gametypes\_hardpoints::giveHardpointItem( "helicopter_mp" );
			break;								
		case 5:
			self NotifyMsg(level.hardpointHints["airstrike_mp"]);
			self maps\mp\gametypes\_hardpoints::giveHardpointItem( "airstrike_mp" );
			break;			
		case 6:
			self NotifyMsg(self getLangString("predator_mp"));
			self maps\mp\gametypes\_hardpoints::giveHardpointItem( "predator_mp" );
			break;			
		case 7:
			self NotifyMsg(level.hardpointHints["radar_mp"]);
			self maps\mp\gametypes\_hardpoints::giveHardpointItem( "radar_mp" );
			break;	
		case 8:
			self NotifyMsg(self getLangString("artillery_mp"));
			self maps\mp\gametypes\_hardpoints::giveHardpointItem( "artillery_mp" );
			break;	
		case 9:
			self NotifyMsg(self getLangString("nuke_mp"));
			self maps\mp\gametypes\_hardpoints::giveHardpointItem( "nuke_mp" );
			break;								
		default: return;
	}
}

NotifyMsg(text) {
	notifyData = spawnStruct();
	notifyData.notifyText = text;
	self maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}