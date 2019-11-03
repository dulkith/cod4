//******************************************************************************
//  _____                  _    _             __
// |  _  |                | |  | |           / _|
// | | | |_ __   ___ _ __ | |  | | __ _ _ __| |_ __ _ _ __ ___
// | | | | '_ \ / _ \ '_ \| |/\| |/ _` | '__|  _/ _` | '__/ _ \
// \ \_/ / |_) |  __/ | | \  /\  / (_| | |  | || (_| | | |  __/
//  \___/| .__/ \___|_| |_|\/  \/ \__,_|_|  |_| \__,_|_|  \___|
//       | |               We don't make the game you play.
//       |_|                 We make the game you play BETTER.
//
//            Website: http://openwarfaremod.com/
//******************************************************************************

init()
{

	precacheShader("damage_feedback");
	precacheShader("hit_icon_1");
	precacheShader("hit_icon_2");
	precacheShader("hit_icon_3");
	
	precacheShader("damage_feedback_j");

	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connected", player);

		player.hud_damagefeedback = newClientHudElem(player);
		player.hud_damagefeedback.horzAlign = "center";
		player.hud_damagefeedback.vertAlign = "middle";
		player.hud_damagefeedback.x = -12;
		player.hud_damagefeedback.y = -12;
		player.hud_damagefeedback.alpha = 0;
		player.hud_damagefeedback.archived = true;
		
		if(!isDefined(player getstat(3152)))
			hudDamageFeedBack = player getstat(3152);
		else
			hudDamageFeedBack = 3; // set default icon
		
		// Set damage feedBack icon
		if(hudDamageFeedBack == 0){
			player.hud_damagefeedback setShader("damage_feedback", 24, 48);
		}
		else if(hudDamageFeedBack == 1){
			player.hud_damagefeedback setShader("hit_icon_1", 24, 48);
		}
		else if(hudDamageFeedBack == 2){
			player.hud_damagefeedback setShader("hit_icon_2", 24, 48);
		}
		else if(hudDamageFeedBack == 3){
			player.hud_damagefeedback setShader("hit_icon_3", 24, 48);
		}else{
			player.hud_damagefeedback setShader("damage_feedback", 24, 48);
		}
	}
}

updateDamageFeedback( hitBodyArmor )
{
	if ( !isPlayer( self ) )
		return;
		
		hudDamageFeedBack = self getstat(3152);
			
		if(hudDamageFeedBack == 0){
			self.hud_damagefeedback setShader("damage_feedback", 24, 48);
		}
		else if(hudDamageFeedBack == 1){
			self.hud_damagefeedback setShader("hit_icon_1", 24, 48);
		}
		else if(hudDamageFeedBack == 2){
			self.hud_damagefeedback setShader("hit_icon_2", 24, 48);
		}
		else if(hudDamageFeedBack == 3){
			self.hud_damagefeedback setShader("hit_icon_3", 24, 48);
		}else{
			self.hud_damagefeedback setShader("damage_feedback", 24, 48);
		}
		self playlocalsound("MP_hit_alert");

	self.hud_damagefeedback.alpha = 1;
	self.hud_damagefeedback fadeOverTime(1);
	self.hud_damagefeedback.alpha = 0;
}