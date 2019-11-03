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
	addConnectThread(::IntroduceThisServer,"once");
}
//#############################################################################################################################################################
//#############################################################################################################################################################
//#############################################################################################################################################################
IntroduceThisServer() {
	//if(self getStat(752) == 1) { // ** Display this intro at the 2nd connect so that they wont get raged
	//	self setStat(752,1);
	//}
	//else if(self getStat(752) == 0) {
		self setStat(752,2);
		self endon("disconnect");
	//	for(k=0;k<3;k++) {
			//self closeMenu();
			//self closeInGameMenu();
	//		wait .05;
	//	}
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
//	}
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