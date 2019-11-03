init()
{
	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for( ;; )
	{
		level waittill( "connecting", player );

		if( isdefined( player.pers["player_welcomed"] ) )
			return;
		player.pers["player_welcomed"] = true;

		player thread onSpawnPlayer();
		
	}
}

onSpawnPlayer()
{
	self endon ( "disconnect" );
	self waittill( "spawned_player" );
	self.msgactive = 1;
	self thread madebyduff( 800, 1, -1, "WELCOME ^5" + self.name );	
	wait( 2 );
	self thread madebyduff( 800, 1, -1, "^7TO" );	
	wait( 2 );
	self thread madebyduff( 800, 1, -1, "^1GLADIATORS ^3SERVER");
	

}


madebyduff( start_offset, movetime, mult, text )
{
	self endon ( "disconnect" );
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