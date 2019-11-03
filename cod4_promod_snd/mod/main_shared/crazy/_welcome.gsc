init()
{
	[[level.on]]( "spawned", ::onPlayerConnect );
}

onPlayerConnect()
{
	if( isdefined( self.pers["player_welcomed"] ) )
	{
		return;
	}
	self.pers["player_welcomed"] = true;
	self thread WelcomeMessage();
}

WelcomeMessage()
{
	self endon ( "disconnect" );
	
	if(!isDefined(self.pers["wlced"]))
	{
		self.pers["wlced"] = true;
		hud[0] = self schnitzel( "center", 0.1, 800, -115 );
		hud[1] = self schnitzel( "center", 0.1, -800, -95 );
		hud[0] setText("Welcome");
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
}


madebyduff( start_offset, movetime, mult, text )
{
	
	start_offset *= mult;
	hud = schnitzel( "center", 0.1, start_offset, -130 );
	hud setText( text );
	hud moveOverTime( movetime );
	hud.x = 0;
	wait( movetime );
	wait( 3 );
	self.msgactive = 0;
	hud moveOverTime( movetime );
	hud.x = start_offset * -1;
	wait movetime;
	hud destroy();
}

schnitzel( align, fade_in_time, x_off, y_off )
{
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