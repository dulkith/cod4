#include crazy\_utility;

init()
{
	if(self.pers["sles_advertisement"] == 1)
		return;
		
    level.notifyCards = [];
	level.notifyCards[0] = "sles_notify_clan";
	level.notifyCards[1] = "sles_notify_facebook";
	level.notifyCards[2] = "sles_notify_new";
	level.notifyCards[3] = "sles_notify_screenshots";
	level.notifyCards[4] = "sles_notify_warn";
	level.notifyCards[5] = "sles_notify_instagram";
	level.notifyCards[6] = "sles_notify_music";
	level.notifyCards[7] = "sles_notify_teamspeak";
	level.notifyCards[8] = "sles_notify_youtube";
	level.notifyCards[9] = "sles_notify_donates";

	self thread NotifyCard();
	
	//create card array
	// get random index from array.
}

NotifyCard()
{
	self endon("disconnect");
	wait 0.5;
	
	for(;;){
	
		if ( level.gameEnded )
			return;
	
		card = (randomInt(10));
		
		self.Notify = newClientHudElem( self );
		self.Notify.x = 220;
		self.Notify.y = 64;
		self.Notify.alignX = "right";
		self.Notify.horzAlign = "right";
		self.Notify.alignY = "top";
		self.Notify setShader( level.notifyCards[card], 220, 55 );
		self.Notify.alpha = 0.9;
		self.Notify.sort = 901;
		self.Notify.hideWhenInMenu = true;
		self.Notify.archived = false;
		
		wait 1;
		self.Notify moveOverTime(0.15);
		self.Notify.x = 30;
		wait 7;
		self.Notify fadeOverTime( 0.50 );
		self.Notify.alpha = 0;
		//self.Notify moveOverTime(0.15);
		//self.Notify.x = 220;
		wait 55;
		self.Notify destroy();
		
	}
		
}

destroyPlayerCard()
{
	if( !isDefined( self.Notify ) || !self.Notify.size )
		return;

	for( i = 0; i < self.Notify.size; i++ )
		self.Notify[i] destroy();
	self.Notify = [];
}