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
#include common_scripts\utility;
#include crazy\_common;

init()
{
	self notify("endthisbs");
	[[level.on]]( "spawned", ::doKillstreaks );
}
 
doKillstreaks()  
{
	self endon ("death");
	self endon ("endthisbs");
	self endon("disconnect");
	
	self.startscore = self.kills;
	self.killcount = 0;
       
    while(1)
	{
		if(self.killcount != self.pers["kills"] - self.startscore)
		{
            self.killcount = self.pers["kills"] - self.startscore;
            switch(self.killcount)
			{
				case 2:
					self notify("newstreak");
					self thread streak3();
						break;
						
				case 4:
					self notify("newstreak");
					self thread streak5();
						break;
				case 6:
					self notify("newstreak");
					self thread streak5();
						break;
			}
		}
		wait 0.05;
	}
}

spree2()
{
	//players[i] thread maps\mp\gametypes\_hud_message::oldNotifyMessage(msg1, attacker.name); 
	//players[i] thread maps\mp\gametypes\_hud_message::oldNotifyMessage(msg2, victim.name); 
	players[i] playlocalsound("firstblood");
}

spree4()
{
	//players[i] thread maps\mp\gametypes\_hud_message::oldNotifyMessage(msg1, attacker.name); 
	//players[i] thread maps\mp\gametypes\_hud_message::oldNotifyMessage(msg2, victim.name); 
	players[i] playlocalsound("firstblood");
}

spree6()
{
	//players[i] thread maps\mp\gametypes\_hud_message::oldNotifyMessage(msg1, attacker.name); 
	//players[i] thread maps\mp\gametypes\_hud_message::oldNotifyMessage(msg2, victim.name); 
	players[i] playlocalsound("firstblood");
}

