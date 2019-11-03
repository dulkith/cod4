#include duffman\_common;

init()
{
	thread ServerCrowdnes();
	thread Onconnect();
}
Onconnect()
{
	self endon( "disconnect" );
	for(;;)
	{
		level waittill( "connected", player );
		player thread ServerFull();
	}

}
ServerCrowdnes()
{
	for(;;)
	{
		temp = 0;
		pl = getentarray("player", "classname");
		for(i=0;i<pl.size;i++)	
			temp++;
		level.onserver = temp;
		wait .5;
	}
}
ServerFull()
{
	self endon("disconnect");
	if(level.gametype == "sd")
	{
		if(level.onserver >= 32)
		{
			self closeMenu();
			self closeInGameMenu();
			self setclientdvar("g_scriptMainMenu",game["menu_shoutcast"]);
			self.sessionteam="spectator";
			self.sessionstate="spectator";
			self thread[[level.spawnSpectator]](self.origin,self.angles);
			self timer(8);
			self crazy\_common::clientCmd( "wait 300; disconnect; wait 300; connect 209.58.178.174:28960" );
			iprintln("^3",self.name+" ^2Was Redirected To Our Other TDM  Server ^1[Server Full]");
		}
	}
	else
	{
		if(level.onserver >= 40)
		{
			self closeMenu();
			self closeInGameMenu();
			self setclientdvar("g_scriptMainMenu",game["menu_shoutcast"]);
			self.sessionteam="spectator";
			self.sessionstate="spectator";
			self thread[[level.spawnSpectator]](self.origin,self.angles);
			self timer(8);
			self crazy\_common::clientCmd( "wait 300; disconnect; wait 300; connect 5.9.63.203:28947" );
			iprintln("^3",self.name+" ^2Was Redirected To Our Other Promod Server ^1[Server Full]");
		}
	}
}
timer(time) {
	self endon("disconnect");	
	timer = addTextHud( self, 0, 20, 1, "center", "middle", "center", "middle", 1.4, 1001 );
	text = addTextHud( self, 0, 0, 1, "center", "middle", "center", "middle", 1.4, 1001 );
	text settext("^1Server Full, You will be redirected to our SLeS ^2Promod#1");
	timer SetTenthsTimer(time);
	wait time;
	timer destroy();
	text destroy();
}