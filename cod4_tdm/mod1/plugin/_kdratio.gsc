init()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread ShowKDRatio();
	}

}


ShowKDRatio()
{
	self notify( "new_KDRRatio" );
	self endon( "new_KDRRatio" );
	self endon( "disconnect" );
	wait 1;
/*	if(!isDefined(self.pers["welcome"]))
	{
		self.pers["welcome"] = true;
		self thread msg( 800, 1, -1, "Welcome " + self.name );
		self thread msg( 800, 1, 1, "Welcome " + self.name );
	}*/
	
	if( IsDefined( self.mc_kdratio ) )	self.mc_kdratio Destroy();
	
	self.mc_kdratio = NewClientHudElem(self);
	self.mc_kdratio.x = 7;
	self.mc_kdratio.y = 137;
	self.mc_kdratio.horzAlign = "left";
	self.mc_kdratio.vertAlign = "top";
	self.mc_kdratio.alignX = "left";
	self.mc_kdratio.alignY = "middle";
	self.mc_kdratio.alpha = 0;
	self.mc_kdratio.fontScale = 1.4;
	self.mc_kdratio.hidewheninmenu = true;
	self.mc_kdratio.label = &"^3K/D Ratio:^1 &&1";
	self.mc_kdratio FadeOverTime(.5);
	self.mc_kdratio.alpha = 1;
	self.mc_kdratio.glowcolor = (0.3, 0.3, 0.3);
	self.mc_kdratio.glowalpha = 1;

	for(;;)
	{
		ratio = 1;	
		h = self.pers[ "headshots" ];
		k = self.pers[ "kills" ];
		d = self.pers[ "deaths" ];
		if( IsDefined( k ) && IsDefined( d ) )
		{
			if( d < 1 )
			{
				d = 1;
			}
			if( k < 1 )
			{
				self.mc_kdratio setText("^1-");
			}

			if( k > 0 )
			{
				ratio1 = k / d * 100;
				ratio2 = int( ratio1 );
				ratio = ratio2 / 100;
				red = 0;
				green = 0;
				if(ratio <= 1)
				{
					green = ratio / 2;
					red = 1;
				}
				if(ratio >= 1)
				{
					red = 1.7 - ratio;
					green = 1;
				}
				if(ratio == 1)
				{
					green = ratio;
					red = 1;
				}	
				if(green >= 1)	green = 1;
				if(green <= 0 )	green = 0;		
				if( red <= 0 )	red = 0;
				if( red >= 1 )	red = 1;					
				self.mc_kdratio FadeOverTime(1);
				self.mc_kdratio.color = ( red , green , 0);
				self.mc_kdratio setValue(ratio);
			}
		}
		
		wait .05;
		while(k == self.pers[ "kills" ] && d == self.pers[ "deaths" ] || self.pers[ "kills" ] == 0 )
			wait .05;
	}
}

msg( start_offset, movetime, mult, text )
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
