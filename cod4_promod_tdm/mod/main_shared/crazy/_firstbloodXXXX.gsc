//  ________/\\\\\\\\\__________________________________________________________        
//   _____/\\\////////___________________________________________________________       
//    ___/\\\/_________________________________________________________/\\\__/\\\_      
//     __/\\\______________/\\/\\\\\\\___/\\\\\\\\\_____/\\\\\\\\\\\___\//\\\/\\\__     
//      _\/\\\_____________\/\\\/////\\\_\////////\\\___\///////\\\/_____\//\\\\\___    
//       _\//\\\____________\/\\\___\///____/\\\\\\\\\\_______/\\\/________\//\\\____   
//        __\///\\\__________\/\\\__________/\\\/////\\\_____/\\\/_______/\\_/\\\_____  
//         ____\////\\\\\\\\\_\/\\\_________\//\\\\\\\\/\\__/\\\\\\\\\\\_\//\\\\/______ 
//          _______\/////////__\///___________\////////\//__\///////////___\////________

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

//precache
//precacheShader( "gradient" );
//precacheShader( "gradient_fadein" );
//precacheShader("gradient_top");
//precacheShader("gradient_bottom");
//precacheShader("line_horizontal");
//define
//level.firstblood = true;
//self.firstbloodinprogress = true;
//level.numKills = 0;

Firstblood(attacker, victim)
{
	
	level.firstblood = true;
	level.numKills++;
	
	if(level.firstblood)
	{
		if ( level.numKills == 1 )
		{
			players = getentarray("player", "classname");
			if(isplayer(attacker))
			{
				for(i=0;i<players.size;i++)
				{
					players[i] playlocalsound("firstblood");
					players[i] thread FirstbloodCard(attacker);
				}
			}
			victim playlocalsound("whyami");
		}
	}
	level.firstblood = false;
}


FirstbloodCard(attacker)
{
	self endon("disconnect");
	
	wait 0.5;
	self.FirstbloodNotify = [];
	self.firstbloodinprogress = true;
	
	if( self.firstbloodinprogress )
	{
		self.FirstbloodNotify[0] = newclientHudElem(self);
		self.FirstbloodNotify[0].x = -150;
		self.FirstbloodNotify[0].y = 125;
		self.FirstbloodNotify[0].alignX = "left";
		self.FirstbloodNotify[0].horzAlign = "left";
		self.FirstbloodNotify[0].alignY = "top";
		self.FirstbloodNotify[0] setShader( "gradient_top", 150, 25 );
		self.FirstbloodNotify[0].alpha = 0.5;
		self.FirstbloodNotify[0].sort = 900;
		self.FirstbloodNotify[0].hideWhenInMenu = true;
		self.FirstbloodNotify[0].archived = false;
		
		self.FirstbloodNotify[1] = newclientHudElem(self);
		self.FirstbloodNotify[1].x = -150;
		self.FirstbloodNotify[1].y = 156;
		self.FirstbloodNotify[1].alignX = "left";
		self.FirstbloodNotify[1].horzAlign = "left";
		self.FirstbloodNotify[1].alignY = "top";
		self.FirstbloodNotify[1] setShader( "gradient_bottom", 150, 25 );
		self.FirstbloodNotify[1].alpha = 0.2;
		self.FirstbloodNotify[1].sort = 901;
		self.FirstbloodNotify[1].hideWhenInMenu = true;
		self.FirstbloodNotify[1].archived = false;
		
		self.FirstbloodNotify[2] = newClientHudElem( self );
		self.FirstbloodNotify[2].x = -150;
		self.FirstbloodNotify[2].y = 130;
		self.FirstbloodNotify[2].alignX = "left";
		self.FirstbloodNotify[2].horzAlign = "left";
		self.FirstbloodNotify[2].alignY = "top";
		self.FirstbloodNotify[2].alpha = 1;
		self.FirstbloodNotify[2] setShader( maps\mp\gametypes\_rank::getRankInfoIcon(attacker.pers["rank"],attacker.pers["prestige"]), 40, 40 );
		self.FirstbloodNotify[2].sort = 902;
		self.FirstbloodNotify[2].hideWhenInMenu = true;
		self.FirstbloodNotify[2].archived = false;

		self.FirstbloodNotify[3] = addTextHud( self, -100, 130, 1, "left", "top", 1.4 ); 
		self.FirstbloodNotify[3].horzAlign = "left";
		self.FirstbloodNotify[3] setText( attacker.name );
		self.FirstbloodNotify[3].sort = 903;
		self.FirstbloodNotify[3].color = self getColorByTeam(attacker);
		self.FirstbloodNotify[3].hideWhenInMenu = true;
		self.FirstbloodNotify[3].archived = false;
		
		self.FirstbloodNotify[4] = addTextHud( self, -100, 145, 1, "left", "top", 1.4 );
		self.FirstbloodNotify[4].horzAlign = "left";
		self.FirstbloodNotify[4] setText("First Blood");
		self.FirstbloodNotify[4].sort = 904;
		self.FirstbloodNotify[4].hideWhenInMenu = true;
		self.FirstbloodNotify[4].archived = false;
	
		self.FirstbloodNotify[5] = newclientHudElem(self);
		self.FirstbloodNotify[5].x = -150;
		self.FirstbloodNotify[5].y = 125;
		self.FirstbloodNotify[5].alignX = "left";
		self.FirstbloodNotify[5].horzAlign = "left";
		self.FirstbloodNotify[5].alignY = "top";
		self.FirstbloodNotify[5] setShader( "line_horizontal", 150, 1 );
		self.FirstbloodNotify[5].alpha = 0.3;
		self.FirstbloodNotify[5].sort = 905;
		self.FirstbloodNotify[5].hideWhenInMenu = true;
		self.FirstbloodNotify[5].archived = false;
		
		self.FirstbloodNotify[6] = newclientHudElem(self);
		self.FirstbloodNotify[6].x = -150;
		self.FirstbloodNotify[6].y = 164;
		self.FirstbloodNotify[6].alignX = "left";
		self.FirstbloodNotify[6].horzAlign = "left";
		self.FirstbloodNotify[6].alignY = "top";
		self.FirstbloodNotify[6] setShader( "line_horizontal", 150, 1 );
		self.FirstbloodNotify[6].alpha = 0.3;
		self.FirstbloodNotify[6].sort = 906;
		self.FirstbloodNotify[6].hideWhenInMenu = true;
		self.FirstbloodNotify[6].archived = false;
		
		
		for(i = 0 ; i < self.FirstbloodNotify.size && isDefined(self.FirstbloodNotify[i]); i++)
			self.FirstbloodNotify[i] moveOverTime(0.15);
			
		self.FirstbloodNotify[0].x = 5;
		self.FirstbloodNotify[1].x = 5;
		self.FirstbloodNotify[2].x = 5;
		self.FirstbloodNotify[3].x = 55;
		self.FirstbloodNotify[4].x = 55;
		self.FirstbloodNotify[5].x = 5;
		self.FirstbloodNotify[6].x = 5;
		
		wait 3.95;
	
		for(i=0;i<self.FirstbloodNotify.size;i++)
			self.FirstbloodNotify[i] moveOverTime(0.15);
		
		self.FirstbloodNotify[0].x = -150;
		self.FirstbloodNotify[1].x = -150;
		self.FirstbloodNotify[2].x = -150;
		self.FirstbloodNotify[3].x = -100;
		self.FirstbloodNotify[4].x = -100;	
		self.FirstbloodNotify[5].x = -150;
		self.FirstbloodNotify[6].x = -150;
		
		self.firstbloodinprogress = false;
	}
}

getColorByTeam(attacker)
{
	if(attacker.team == self.team)
	return (0, 0.54, 1);
	return (1,0.55,0);
}

addTextHud( who, x, y, alpha, alignX, alignY, fontScale )
{
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.alignX = alignX;
	hud.alignY = alignY;
	hud.fontScale = fontScale;
	return hud;
}