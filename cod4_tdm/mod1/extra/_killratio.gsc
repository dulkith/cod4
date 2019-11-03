main()
{
	self endon( "disconnect" );
	for(;;)
	{
		level waittill( "connected", player );

		player thread Setup_KillRatio();
	}

}

Setup_KillRatio()
{
	self.ratio = 0.00;
	while(1)
	{
		self waittill( "spawned_player" );
		self thread CheckKillsDeaths();
	}
}

CheckKillsDeaths()
{
	self endon( "disconnect" );
	self endon( "joined_spectators" );
	self endon( "death" );

	self thread HUD_Ratio();
	
	self.notrunnedyet = 1;
	
	if(self.deaths != 0 && self.notrunnedyet == 1)
	{
		while(1)
		{
			if(self.ratio != (self.kills / self.deaths))
			{
				self.ratio = (self.kills / self.deaths);
				self notify( "Score_changed" );
			}
			self.notrunnedyet = 0;
			wait .05;
		}
	}
	else if(self.deaths == 0)
		self thread firstkills();
}

firstkills()
{
	self endon( "disconnect" );
	self endon( "joined_spectators" );
	self endon( "death" );

	while(1)
	{
		if(self.ratio != self.kills)
		{
			self.ratio = self.kills;
			self notify( "Score_changed" );
		}
		wait .05;
	}
}

HUD_Ratio()
{
	if( isdefined( self.HUD_Ratio ))
		self.HUD_Ratio destroy();

	wait .05;

	self.HUD_Ratio = newClientHudElem( self );
	self.HUD_Ratio.x = 7;
	self.HUD_Ratio.y = 130;
	self.HUD_Ratio.horzAlign = "left";
	self.HUD_Ratio.vertAlign = "top";
	self.HUD_Ratio.alignX = "left";
	self.HUD_Ratio.alignY = "middle";
	self.HUD_Ratio.alpha = 1;
	self.HUD_Ratio.fontScale = 1.4;
	self.HUD_Ratio.hidewheninmenu = true;
	self.HUD_Ratio.label = ( &"K^0/^7D Ratio: " );
	self.HUD_Ratio.color = (.99, .99, .75);

	while(1)
	{
		self.HUD_Ratio SetValue( alternative(self.ratio) );
		self color(self.ratio); 
		self waittill( "Score_changed" );
	}

}

twodecimals(integer)
{
	integerstring = integer;
	if(IsSubStr( integerstring, "."))
	{
		twodecimals = 0;
		for(integerdot = integerstring.size;isNumber(integerstring[ integerdot ]) && integerdot > 0;integerdot--)
			twodecimals = integerdot + 2;
		if(integerstring.size > twodecimals)
		{
			newVal = GetSubStr( integerstring, 0, twodecimals);
			return newVal;
		}
		else
			return integer;
	}
	else
		return integer;
}

isNumber(string)
{
	if(string == "1" || string == "2" || string == "3" || string == "4" || string == "5" || string == "6" || string == "7" || string == "8" || string == "9" || string == "0" )
		return true;
	else
		return false;
}

alternative(integer)
{
	if(IsSubStr( integer, "."))
	{
		twodecimals = integer * 100;
		newVal = int(twodecimals) * 0.01;
		return newVal;
	}
	else
		return integer;
}

color(value)
{
	if(value < 1.00)  //make red
		self.HUD_Ratio.color = (.99, .0, .0);
	else
		self.HUD_Ratio.color = (0, .99, .0);
}