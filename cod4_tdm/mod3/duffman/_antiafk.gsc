//
// ########   #######  ######## ##     ##         ########  ######## ##     ##  #######  ##       ##     ## ######## ####  #######  ##    ## 
// ##     ## ##     ##    ##    ##     ##         ##     ## ##       ##     ## ##     ## ##       ##     ##    ##     ##  ##     ## ###   ## 
// ##     ## ##     ##    ##    ##     ##         ##     ## ##       ##     ## ##     ## ##       ##     ##    ##     ##  ##     ## ####  ## 
// ########  ##     ##    ##    ##     ## ####### ########  ######   ##     ## ##     ## ##       ##     ##    ##     ##  ##     ## ## ## ## 
// ##   ##   ##     ##    ##    ##     ##         ##   ##   ##        ##   ##  ##     ## ##       ##     ##    ##     ##  ##     ## ##  #### 
// ##    ##  ##     ##    ##    ##     ##         ##    ##  ##         ## ##   ##     ## ##       ##     ##    ##     ##  ##     ## ##   ### 
// ##     ##  #######     ##     #######          ##     ## ########    ###     #######  ########  #######     ##    ####  #######  ##    ## 
//
// Reign of the Undead - Revolution ALPHA 0.7 by Luk and 3aGl3
// Code contains parts made by Luk, Bipo, Etheross, Brax, Viking, Rycoon and Activision (no shit)
// (Please keep in mind that I'm not the best coder and some stuff might be really dirty)
// If you consider yourself more skilled at coding and would enjoy further developing this, contact me and we could improve this mod even further! (Xfire: lukluk1992 or at http://puffyforum.com)
//
// You may modify this code to your liking (since I - Luk - learned scripting the same way)
// You may also reuse code you find here, as long as you give credit to those who wrote it (5 lines above)
//
// Based on Reign of the Undead 2.1 created by Bipo and Etheross
//

#include scripts\include\useful;

init(){
	if( level.dvar["game_afk_enabled"] )
		thread onPlayerSpawn();
}

onPlayerSpawn(){
	while(1){
		level waittill("spawned", player);
		player.antiAFK = 0;
		player thread antiAFK();
	}
}

antiAFK(){

	self endon("death");
	self endon("disconnect");
	self endon("join_spectator");
	
	if( level.dvar["game_afk_type"] == 0 )
		handleTypeText = "KICKED";
	else
		handleTypeText = "PUT TO SPECTATOR";
		
	oldpos = self getOrigin();
	
	while(1){		
		oldweapon = self getCurrentWeapon();
		
		wait 0.05;
		
		if( self.isDown || self.isZombie ){ wait 0.05; continue; }
		
		if( self pressesAnyButton() || oldweapon != self getCurrentWeapon() ||  ( self.antiAFK % 100 == 0 && self.antiAFK && distance(oldpos, self getOrigin()) > 200 ) ){
			oldpos = self getOrigin();
			self.antiAFK = 0;
			continue;
		}
		else
			self.antiAFK++;
			
		if( self.antiAFK >= (level.dvar["game_afk_time_warn"] * 20) && 
		self.antiAFK % 20 == 0 && 
		self.antiAFK < ( (level.dvar["game_afk_time_warn"] + level.dvar["game_afk_warn_amount"]) * 20) )
			self iprintlnbold("^1WARNING: ^7DO NOT BE AFK OR YOU WILL BE " + handleTypeText + "!");
		
		
		if( self.antiAFK >= (level.dvar["game_afk_time"] * 20) )
			switch( level.dvar["game_afk_type"] ){
				case 0: kick( self getEntityNumber() ); break;
				case 1: self thread scripts\players\_players::joinSpectator(); break;
			}
	}

}