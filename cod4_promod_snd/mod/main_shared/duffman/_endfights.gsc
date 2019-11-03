#include duffman\_common;
fire(mapcoors) {
	if(mapcoors.size >= 3) {
		linkfire = spawn("script_model", mapcoors[0]);
 		for(i=1;i<mapcoors.size;i++) {
			movespeed = distance(linkfire.origin, mapcoors[i]) / 400;
			linkfire moveto(mapcoors[i],movespeed);
			for(k=0;k<movespeed*10;k++) {
				thread addLoopFire(linkfire.origin);
				thread AddBlocker(linkfire.origin,12,100);
				wait .1;
			}
			wait .1;
		}
		movespeed = distance(linkfire.origin, mapcoors[0]) / 400;
		linkfire moveto(mapcoors[0],movespeed);
		for(k=0;k<movespeed*10;k++) {
			thread addLoopFire(linkfire.origin);
			thread AddBlocker(linkfire.origin,12,100);
			wait .1;
		}
		thread addLoopFire(linkfire.origin);
		linkfire delete();
	}
}

bugfix() { // dat dirt
	wait 1;
	for(i=0;isDefined(level.bestpl1) && isDefined(level.bestpl2) && isAlive(level.bestpl1) && isAlive(level.bestpl2) && i<700;i++) wait .05;
	level notify("bug_detected");
}

startEndFight() {
	level endon("bug_detected");
	level notify("startfighted");
	thread bugfix();
	mapcoors = [];
	origin = [];
	angles = [];
	sep1 = strTok(GetDvar(strTok(getDvar("mapname"),"_")[1] + "_spawns"),"&");
	for(i=0;i<sep1.size;i++){
		origin[i] = (int(strTok(sep1[i],",")[0]), int(strTok(sep1[i],",")[1]), int(strTok(sep1[i],",")[2]));
		angles[i] = int(strTok(sep1[i],",")[3]);
	}
	ecken = strTok(GetDvar(strTok(getDvar("mapname"),"_")[1] + "_flames"),"&");
	for(i=0;i<ecken.size;i++)
		mapcoors[i] = (int(strTok(ecken[i],",")[0]), int(strTok(ecken[i],",")[1]), int(strTok(ecken[i],",")[2]));	

	if(!isDefined(origin[0]) || !isDefined(origin[1])) 
		return;

	axis = getBestPlayerFromScore("axis");
	allies = getBestPlayerFromScore("allies");
	level.bestpl1 = allies;
	level.bestpl2 = axis;
	if(!isdefined(axis) || !isdefined(allies)) 
		return;	
	noti = SpawnStruct();
	noti.titleText = "1 vs. 1";
	noti.notifyText = axis.name + " ^1VS ^7" + allies.name;
	noti.duration = 5;
	noti.glowcolor = (1,0,0);
	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );

	thread StopSpawnPlayers(axis,allies);
	thread Spec(axis,allies);
	winner = undefined;		
	axis suicide();
	allies suicide();
	wait .05;
	axis thread [[level.spawnPlayer]]();
	allies thread [[level.spawnPlayer]]();
	wait .05;
	//thread slideText("1 vs 1 Knife Fight!","Don't go out of the fire!",(1,0,0));
	axis takeAllWeapons();
	allies takeAllWeapons();
	wait .05;
	axis giveWeapon("deserteaglegold_mp");
	allies giveWeapon("deserteaglegold_mp");
	axis setWeaponAmmoStock("deserteaglegold_mp",0);
	axis setWeaponAmmoClip("deserteaglegold_mp",0);
	allies setWeaponAmmoStock("deserteaglegold_mp",0);
	allies setWeaponAmmoClip("deserteaglegold_mp",0);
	wait .05;
	axis SwitchToWeapon("deserteaglegold_mp");
	allies SwitchToWeapon("deserteaglegold_mp");

	axis.inTrainingArea = false;
	allies.inTrainingArea = false;
	
	axis SetPlayerAngles((0,angles[0],0));
	allies SetPlayerAngles((0,angles[1],0));
	axis thread MoveToSpot( origin[0] , 3);
	allies thread MoveToSpot( origin[1] , 3);

	thread Countdown();

	thread fire(mapcoors);
		
	axis waittill("startfight");

	setDvar( "bg_fallDamageMinHeight", 50 );
	setDvar( "bg_fallDamageMaxHeight", 51 );

	level.roundendzeit = newHudElem();
	level.roundendzeit.elemType = "font";
	level.roundendzeit.font = "default";
	level.roundendzeit.fontscale = 1.6;
	level.roundendzeit.x = 0;
	level.roundendzeit.y = -10;
	level.roundendzeit.glowAlpha = 1;
	level.roundendzeit.hideWhenInMenu = true;
	level.roundendzeit.archived = false;
	level.roundendzeit.alignX = "right";
	level.roundendzeit.alignY = "middle";
	level.roundendzeit.horzAlign = "center";
	level.roundendzeit.vertAlign = "bottom";
	level.roundendzeit.alpha = 1;
	level.roundendzeit.glowAlpha = 1;
	level.roundendzeit.glowColor = level.randomcolour;
	level.roundendzeit SetTimer( 30 );

	axis.sessionstate = "playing";
	axis.pers["team"] = "axis";
	axis.team = "axis";
	axis.sessionteam = "axis";	
	allies.sessionstate = "playing";
	allies.pers["team"] = "allies";
	allies.team = "allies";
	allies.sessionteam = "allies";
	game["state"] = "playing";
	level.bombExploded = undefined;
	i = 0;
	while(isDefined(axis) && isDefined(allies) && isAlive( axis ) && isAlive( allies ) && i < 600 && allies.sessionteam != "spectator" && axis.sessionteam != "spectator") {
		wait .05;
		i++;
	}
	noti = SpawnStruct();
	if(i>599)
		noti.titleText = "Time Limit Reached!";
	else {	
		if(!isDefined(axis) || !isAlive( axis ) || axis.sessionteam == "spectator" )
			winner = allies;
		else if(!isDefined(allies) || !isAlive( allies ) || allies.sessionteam == "spectator" )
			winner = axis;
		if(isdefined(winner))						
			noti.titleText = "^1" + winner.name + "^7 is the last man standing!";
	}	
	game["state"] = "postgame";	
	level.roundendzeit FadeOverTime(1);
	level.roundendzeit.alpha = 0;
	noti.duration = 5;
	noti.glowcolor = (1,0,0);
	players = getAllPlayers();
	for(k=0;k<players.size;k++) {
		players[k] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		players[k] notify( "new_KDRRatio" );
	}	
}

getBestPlayerFromScore(team) {
	score = -1;
	bester = undefined;
	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
	{
		if(isDefined(players[i]) && isDefined(players[i].pers["score"]) && players[i].pers["team"] == team)
		{
			if(score < players[i].pers["score"])
			{
				score = players[i].pers["score"];
				bester = players[i];	
			}
		}
	}
	if(isDefined(bester) && isPlayer(bester))
		return bester;
}

StopSpawnPlayers(player1,player2) {
	for(;;)
	{
		players = getentarray("player", "classname");
		for(i=0;i<players.size;i++)
		{
			if(isDefined(players[i]) && players[i].pers["team"] != "spectator" && players[i] != player1 && players[i] != player2 )
			{
				players[i] [[level.spawnSpectator]]();
			}
		}
		wait .05;
	}
}

Spec(player1,player2) {
	pid[0] = player1 GetEntityNumber();
	pid[1] = player2 GetEntityNumber();
	wait .05;
	for(;;) {
		for(k=0;k<1;k++) {
			players = getentarray("player", "classname");
			for(i=0;i<players.size;i++)
			{
				if(isDefined(players[i]) && players[i] != player1 && players[i] != player2 )
				{
					players[i].spectatorclient = pid[k];
				}
			}
			wait 5;
		}
	}
}

MoveToSpot(endcoors,time) {
	self endon("disconnect");
	link = spawn("script_model", self.origin);
	self LinkTo(link);
	wait .05;
	self FreezeControls(1);
	link moveto((self.origin, self.origin,530) , time / 3);
	link waittill("movedone");
	link moveto((endcoors, endcoors,530) , time / 3);
	link waittill("movedone");
	link moveto(endcoors, time / 3);
	link waittill("movedone");
	self unlink();
	link delete();
	level notify("start_countdown");
	wait 3;
	self FreezeControls(0);
	self notify("startfight");
}

Countdown() {
	level waittill("start_countdown");
	hud = addTextHud( level, 0, 0, 1, "center", "middle", "center", "middle", 2.4, 1999 );
	hud.font = "bold";
	hud setValue(3);
	hud ScaleOverTime(1);
	hud.fontscale = 1.8;
	wait 1;
	hud setValue(2);
	hud.fontscale = 2.4;
	hud ScaleOverTime(1);
	hud.fontscale = 1.8;
	wait 1;
	hud setValue(1);
	hud.fontscale = 2.4;
	hud ScaleOverTime(1);
	hud.fontscale = 1.8;
	wait 1;
	hud setText("!!! GO !!");
	hud.fontscale = 2.4;
	hud ScaleOverTime(1);
	hud.fontscale = 1.8;	
	hud fadeOverTime(1);
	hud.alpha = 0;
	wait 1;
	hud	destroy();
}

addLoopFire(origin) {
	//level endon( "stopfire" );
	while(1)
	{
		playfx(level.fx["smallfire"], origin); 
		wait .5;
	}
}