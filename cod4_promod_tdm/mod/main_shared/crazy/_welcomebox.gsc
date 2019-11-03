#include duffman\_common;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
	addConnectThread(::Protocols);
}

Protocols(){
//`wait 2;
	self endon ( "disconnect" );
	//self waittill( "spawned_player" );

	guid = self getGuid();
	
	self thread getPData(guid);	
}
	
getPData(guid){

	httpgetjson("159.65.140.193/api/playerData.php?id="+guid, ::callback);
	level waittill("playerdata_received");

	shader = [];

	for(i=0;i<16;i++) 
	{
		shader[i] = newClientHudElem( self ); 
		shader[i].x = 0;
		shader[i].y = 0;
		shader[i].alpha=.6;
		shader[i].alignX ="center";
		shader[i].alignY = "middle";
		shader[i].fontscale = 1.4;
		shader[i].sort= 999+i;
		shader[i].horzalign = "center";
		shader[i].vertAlign = "middle";
		shader[i] thread FadeIn(.5);
	}
	shader[0] SetShader("black",304,269);  //better shader combination (+ hud.color + alpha ) can make it more attractive 
	shader[0].y = 12;
	shader[1] SetShader("black",300,265);
	shader[1].y = 12;
	
	//shader[1].alpha = 0.7;
	//shader[1].color = (0.1,1,0.6);
	//shader[1].glowcolor = (0,0,0.6);
	//shader[1].glowalpha = 0.5;
	//shader[1].foreground = 1;

	shader[2].alpha = 1;
	shader[2].y = -105;
	shader[2].alignX = "center"; 
	shader[2].x = 0;
	shader[2].fontscale = 1.6;
	shader[2] setText("^5SL^1e^5SPORTS ^6PROMOD SnD ^2GAMING ^3PROFILE");

	shader[3].x = 142;
	shader[3].y = 132;
	shader[3].alignX = "right";
	shader[3] settext("^1Auto ^7hide after ^16seconds."); //Press ^1[melee]^7 to close
	
	shader[4].alpha = 1;
	shader[4].y = -75;
	shader[4].alignX = "left";
	shader[4].x = -75;
	shader[4].fontscale = 1.4;
	shader[4] setText("IGN (In Game Name): ^1"+self.name);
	
	shader[5].alpha = 1;
	shader[5].y = -60;
	shader[5].alignX = "left";
	shader[5].x = -75;
	shader[5].fontscale = 1.4;
	shader[5] setText("GAME ID: ^1"+GetSubStr(self getGuid(), self getGuid().size - 8, self getGuid().size) +"         "+"^7B3 ID: ^3@"+level.b3id );
	
	shader[6].alpha = 1;
	shader[6].y = -45;
	shader[6].alignX = "left";
	shader[6].x = -75;
	shader[6].fontscale = 1.4;
	shader[6] setText("LEVEL: ^1"+level.b3level);
	
	shader[7].alpha = 1;
	shader[7].y = -30;
	shader[7].alignX = "left";
	shader[7].x = -75;
	shader[7].fontscale = 1.4;
	shader[7] setText("FIRST SEEN: ^2" + level.time_add);
	
	shader[8].alpha = 1;
	shader[8].y = -15;
	shader[8].alignX = "left";
	shader[8].x = -75;
	shader[8].fontscale = 1.4;
	shader[8] setText("LAST SEEN: ^2" + level.time_edit);
	
	shader[9].alpha = 1;
	shader[9].y = 0;
	shader[9].alignX = "left";
	shader[9].x = -75;
	shader[9].fontscale = 1.4;
	shader[9] setText("Connections: ^1"+level.connections +"       ^7IP: ^1"+level.ip );
	
	shader[10] = newClientHudElem(self);
	shader[10].x = -110;
	shader[10].y = -57;
	shader[10].alignX = "center";
	shader[10].alignY = "middle";
	shader[10].horzAlign = "center";
	shader[10].vertAlign = "middle";
	shader[10].sort = 1003;
	shader[10] setShader("profile", 50, 50);
	shader[10].alpha = 1;
	shader[10].hideWhenInMenu = false;
	shader[10].archived = false;
	
	shader[11].alpha = 1;
	shader[11].y = 25;
	shader[11].alignX = "center"; 
	shader[11].x = 0;
	shader[11].fontscale = 1.5;
	shader[11] setText("^1..............:::::: ^2YOUR PERSONAL XLR-STATS ^1::::::..............");
	
	shader[12].alpha = 1;
	shader[12].y = 50;
	shader[12].alignX = "left";
	shader[12].x = -110;
	shader[12] setText("Kills: "+level.kills+" \nDeaths: "+level.deaths+" \nTeam Kills: "+level.teamkills+" \nTeam DEATHS: "+level.teamdeaths+" \nSuicides: "+level.suicides+"");
	
	shader[14].alpha = 1;
	shader[14].y = 50;
	shader[14].alignX = "left";
	shader[14].x = 20;
	shader[14] setText("Ratio: "+level.ratio+" \nSkill: "+level.skill+" \nAssists: "+level.assists+" \nRounds: "+level.rounds+"");
	
	shader[15].alpha = 1;
	shader[15].y = -55;
	shader[15].alignX = "left";
	shader[15].x = -75;
	shader[15].fontscale = 1.4;
	shader[15] setText("");
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	


	//while(!self MeleeButtonPressed()) wait .05;    //waiting for melee button press
	wait 6;
	for(i=0;i<16;i++)
				shader[i] thread FadeOut(1,true,"right");
	//wait 10;


} 
/*
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
*/
callback(handle)
{
	if(handle == 0)
	{
		return;
	}
	
	level.b3id = jsongetstring(handle, "id");
	level.ip = jsongetstring(handle, "ip");
	level.connections = jsongetstring(handle, "connections");
	level.time_add = jsongetstring(handle, "time_add");
	level.time_edit = jsongetstring(handle, "time_edit");
	level.b3level = jsongetstring(handle, "level");
	level.kills = jsongetstring(handle, "kills");
	level.deaths = jsongetstring(handle, "deaths");
	level.teamdeaths = jsongetstring(handle, "teamdeaths");
	level.teamkills = jsongetstring(handle, "teamkills");
	level.suicides = jsongetstring(handle, "suicides");
	level.ratio = jsongetstring(handle, "ratio");
	level.skill = jsongetstring(handle, "skill");
	level.assists = jsongetstring(handle, "assists");
	level.rounds = jsongetstring(handle, "rounds");

	jsonreleaseobject(handle); // release the plugin internal json data
	
	level notify("playerdata_received");

}
