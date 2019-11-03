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
	//**********************
	self thread gogo1( 800, 1, -1, "^7Hi ^1" + self.name );
	self thread gogo1( 800, 1, 1, "^7Hi ^1" + self.name );
	//**********************
	self thread gogo2( 800, 1, -1, "^1Do not use Hack - Kick/Ban !" );
	self thread gogo2( 800, 1, 1, "^1Do not use Hack - Kick/Ban !" );
	//**********************
	self thread gogo3( 800, 1, -1, "^7Give us some suggestions for the server!!" );
	self thread gogo3( 800, 1, 1, "^7Give us some suggestions for the server!!" );
	//**********************
	self thread gogo4( 800, 1, -1, "^7Temaspeak : ^7ts^1.^7ducoder^1.^7com" );
	self thread gogo4( 800, 1, 1, "^7Temaspeak : ^7ts^1.^7ducoder^1.^7com" );
	//**********************
	self thread gogo5( 800, 1, -1, "^7Hosted & Moded by : ^7www^1.^7ducoder^1.^7com" );
	self thread gogo5( 800, 1, 1, "^7Hosted & Moded by : ^7www^1.^7ducoder^1.^7com" );

}


gogo1( start_offset, movetime, mult, text )
{
	start_offset *= mult;
	hud = gogoslide( "center", 0.1, start_offset, -130 );
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
	
	gogo2( start_offset, movetime, mult, text )
	{
	wait 4;
	start_offset *= mult;
	hud = gogoslide( "center", 0.1, start_offset, -130 );
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
	
	gogo3( start_offset, movetime, mult, text )
	{
	wait 8;
	start_offset *= mult;
	hud = gogoslide( "center", 0.1, start_offset, -130 );
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
	
	gogo4( start_offset, movetime, mult, text )
	{
	wait 12;
	start_offset *= mult;
	hud = gogoslide( "center", 0.1, start_offset, -130 );
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
	
	gogo5( start_offset, movetime, mult, text )
	{
	wait 16;
	start_offset *= mult;
	hud = gogoslide( "center", 0.1, start_offset, -130 );
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
	
	gogoslide( align, fade_in_time, x_off, y_off )
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
	hud.glowColor = ( 0, 0, 0 );
	hud.glowAlpha = 1;
	hud.alpha = 1;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
}
