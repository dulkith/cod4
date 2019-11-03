#include crazy\_utility;

splashNotifyDelayed( splash )
{
	actionData = spawnStruct();
	
	actionData.name = splash;
	actionData.sound = getSplashSound(splash);
	actionData.duration = getSplashDuration(splash);

	self thread underScorePopup(getSplashTitle(splash));
	self thread splashNotify(actionData);
}

teamPlayerCardSplash( splash, owner, team )
{
	actionData = spawnStruct();
	
	actionData.name = splash;
	actionData.sound = getSplashSound(splash);
	actionData.duration = getSplashDuration(splash);

	for( i = 0; i < level.players.size; i++  )
	{
		if ( isDefined( team ) && level.players[i].team != team )
			continue;
			
		level.players[i] thread playerCardSplashNotify( actionData, owner );
	}
}
splashNotify(splash)
{
	self endon("disconnect");
	
	wait 0.05;
	if ( level.gameEnded )
		return;

	if ( tableLookup( "mp/splashTable.csv", 1, splash.name, 0 ) != "" )
	{
		while(isDefined(self.splashinprogress) && self.splashinprogress )
			wait 0.05;
		 
		self.splashinprogress = true;
		
		self destroySplash();
		
		if ( isDefined( splash.sound ) )
			self playLocalSound( splash.sound );

		self.splashNotify[0] = addTextHud( self, 0, -110, 0, "center", "middle", 2 ); 
		self.splashNotify[0].font = "default";
		self.splashNotify[0].horzAlign = "center";
		self.splashNotify[0].vertAlign = "middle"; 	
		self.splashNotify[0] setText( getSplashTitle(splash.name) );
		self.splashNotify[0].glowcolor = ( 0.3, 0.3, 2.0 );
		self.splashNotify[0].glowalpha = getSplashColorRGBA(splash.name,8);
		self.splashNotify[0].sort = 1001;
		self.splashNotify[0] maps\mp\gametypes\_hud::fontPulseInit();
		self.splashNotify[0].hideWhenInMenu = true;
		self.splashNotify[0].archived = false;
		
		self.splashNotify[1] = addTextHud( self, 0, -90, 0, "center", "middle", 1.6 );
		self.splashNotify[1].horzAlign = "center";
		self.splashNotify[1].vertAlign = "middle"; 
		self.splashNotify[1] setText( getSplashDescription(splash.name) );
		self.splashNotify[1].sort = 1002;
		self.splashNotify[1] maps\mp\gametypes\_hud::fontPulseInit();
		self.splashNotify[1].hideWhenInMenu = true;
		self.splashNotify[1].archived = false;

		for( i = 0; i < self.splashNotify.size; i++ )
		{
			self.splashNotify[i] fadeOverTime( 0.15 );
			self.splashNotify[i].alpha = 1.0;
		}
		self.splashNotify[0] thread maps\mp\gametypes\_hud::fontPulse( self );
		self.splashNotify[1] thread maps\mp\gametypes\_hud::fontPulse( self );

		wait (splash.duration-0.05);
		
		for( i = 0; i < self.splashNotify.size; i++ )
		{
			self.splashNotify[i] fadeOverTime( 0.15 );
				self.splashNotify[i].alpha = 0;
		}

		self.splashNotify[0] scaleOverTime( 0.15, 480 , 480 );
		
		wait 0.1;
		self destroySplash();
		wait 0.05;
		self.splashinprogress = false;
	}
}

destroySplash()
{
	if( !isDefined( self.splashNotify ) || !self.splashNotify.size )
		return;

	for( i = 0; i < self.splashNotify.size; i++ )
		self.splashNotify[i] destroy();
	self.splashNotify = [];
}

playerCardSplashNotify(splash, owner)
{	
	self endon("disconnect");
	
	if ( level.gameEnded )
		return;
		
	if(!isDefined(owner))
			return;
		
	wait 0.05;

	if ( tableLookup( "mp/splashTable.csv", 1, splash.name, 0 ) != "" )
	{
		while(isDefined(self.leftnotifyinprogress) && self.leftnotifyinprogress )
			wait 0.05;
				
		self.leftnotifyinprogress = true;
		
		self destroyPlayerCard();
		self.leftnotify = [];
		self.leftnotify[0] = newClientHudElem( self );
		self.leftnotify[0].x = -150;
		self.leftnotify[0].y = 125;
		self.leftnotify[0].alignX = "left";
		self.leftnotify[0].horzAlign = "left";
		self.leftnotify[0].alignY = "top";
		self.leftnotify[0] setShader( "first_blood", 150, 55 );
		self.leftnotify[0].alpha = 0.9;
		self.leftnotify[0].sort = 900;
		self.leftnotify[0].hideWhenInMenu = true;
		self.leftnotify[0].archived = false;
		
		self.leftnotify[1] = newClientHudElem( self );
		self.leftnotify[1].x = -150;
		self.leftnotify[1].y = 155;
		self.leftnotify[1].alignX = "left";
		self.leftnotify[1].horzAlign = "left";
		self.leftnotify[1].alignY = "top";
		self.leftnotify[1] setShader( "gradient_bottom", 150, 25 );
		self.leftnotify[1].alpha = 0.2;
		self.leftnotify[1].sort = 901;
		self.leftnotify[1].hideWhenInMenu = true;
		self.leftnotify[1].archived = false;
		
		self.leftnotify[2] = newClientHudElem( self );
		self.leftnotify[2].x = -150;
		self.leftnotify[2].y = 130;
		self.leftnotify[2].alignX = "left";
		self.leftnotify[2].horzAlign = "left";
		self.leftnotify[2].alignY = "top";
		self.leftnotify[2].alpha = 1;
		self.leftnotify[2] setShader( maps\mp\gametypes\_rank::getRankInfoIcon(owner.pers["rank"],owner.pers["prestige"]), 40, 40 );
		self.leftnotify[2].sort = 902;
		self.leftnotify[2].hideWhenInMenu = true;
		self.leftnotify[2].archived = false;

		self.leftnotify[3] = addTextHud( self, -100, 130, 1, "left", "top", 1.4 ); 
		self.leftnotify[3].horzAlign = "left";
		self.leftnotify[3] setText( owner.name );
		self.leftnotify[3].sort = 903;
		self.leftnotify[3].color = (1, 1, 1);
		self.leftnotify[3].hideWhenInMenu = true;
		self.leftnotify[3].archived = false;
		self.leftnotify[3].glowcolor = (1, 1, 1);
		self.leftnotify[3].glowalpha = 2;
		
		self.leftnotify[4] = addTextHud( self, -100, 145, 1, "left", "top", 1.4 );
		self.leftnotify[4].horzAlign = "left";
		self.leftnotify[4] setText( getSplashTitle(splash.name) );
		self.leftnotify[4].sort = 904;
		self.leftnotify[4].hideWhenInMenu = true;
		self.leftnotify[4].archived = false;
		self.leftnotify[3].glowcolor = (0, 0, 1);
		self.leftnotify[3].glowalpha = 3;
	
		self.leftnotify[5] = newClientHudElem( self );
		self.leftnotify[5].x = -150;
		self.leftnotify[5].y = 125;
		self.leftnotify[5].alignX = "left";
		self.leftnotify[5].horzAlign = "left";
		self.leftnotify[5].alignY = "top";
		self.leftnotify[5] setShader( "line_horizontal", 150, 1 );
		self.leftnotify[5].alpha = 0.3;
		self.leftnotify[5].sort = 905;
		self.leftnotify[5].hideWhenInMenu = true;
		self.leftnotify[5].archived = false;
		
		self.leftnotify[6] = newClientHudElem( self );
		self.leftnotify[6].x = -150;
		self.leftnotify[6].y = 174;
		self.leftnotify[6].alignX = "left";
		self.leftnotify[6].horzAlign = "left";
		self.leftnotify[6].alignY = "top";
		self.leftnotify[6] setShader( "line_horizontal", 150, 1 );
		self.leftnotify[6].alpha = 0.3;
		self.leftnotify[6].sort = 906;
		self.leftnotify[6].hideWhenInMenu = true;
		self.leftnotify[6].archived = false;
		
		for(i = 0 ; i < self.leftnotify.size && isDefined(self.leftnotify[i]); i++)
			self.leftnotify[i] moveOverTime(0.15);
			
		self.leftnotify[0].x = 5;
		self.leftnotify[1].x = 5;
		self.leftnotify[2].x = 5;
		self.leftnotify[3].x = 55;
		self.leftnotify[4].x = 55;
		self.leftnotify[5].x = 5;
		self.leftnotify[6].x = 5;
		
		wait 0.15;
		wait (splash.duration-0.05);
		
		for(i=0;i<self.leftnotify.size;i++)
			self.leftnotify[i] moveOverTime(0.15);
		
		self.leftnotify[0].x = -150;
		self.leftnotify[1].x = -150;
		self.leftnotify[2].x = -150;
		self.leftnotify[3].x = -100;
		self.leftnotify[4].x = -100;	
		self.leftnotify[5].x = -150;
		self.leftnotify[6].x = -150;
		
		wait 5;
		self destroyPlayerCard();
		self.leftnotifyinprogress = false;
		wait 0.05;
	}
}
getColorByTeam(owner)
{
	if(owner.team == self.team)
	return (0, 0.54, 1);
	return (1,0.55,0);
}
destroyPlayerCard()
{
	if( !isDefined( self.leftnotify ) || !self.leftnotify.size )
		return;

	for( i = 0; i < self.leftnotify.size; i++ )
		self.leftnotify[i] destroy();
	self.leftnotify = [];
}
getSplashTitle(splash)
{
	return tableLookupIString( "mp/splashTable.csv" , 1 , splash , 2 );
}

getSplashDescription(splash)
{
	return tableLookupIString( "mp/splashTable.csv" , 1 , splash , 3 );
}

getSplashMaterial(splash)
{
	return tableLookup( "mp/splashTable.csv" , 1 , splash , 4 );
}

getSplashColorRGBA(splash,i)
{
	return stringToFloat(tableLookup( "mp/splashTable.csv" , 1 , splash , i ));
}

getSplashDuration(splash)
{
	return stringToFloat(tableLookup( "mp/splashTable.csv" , 1 , splash , 5 ));
}

getSplashSound(splash)
{
	return tableLookup( "mp/splashTable.csv" , 1 , splash , 10 );
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

stringToFloat( stringVal )
{
	if(isDefined(stringVal))
	{
		floatElements = strtok( stringVal, "." );
	
		floatVal = int( floatElements[0] );
		if ( isDefined( floatElements[1] ) )
		{
			modifier = 1;
			for ( i = 0; i < floatElements[1].size; i++ )
				modifier *= 0.1;
		
			floatVal += int ( floatElements[1] ) * modifier;
		}
		return floatVal;
	}
	return 1.5;
}

strip_suffix( lookupString, stripString )
{
	if ( lookupString.size <= stripString.size )
		return lookupString;

	if ( getSubStr( lookupString, lookupString.size - stripString.size, lookupString.size ) == stripString )
		return getSubStr( lookupString, 0, lookupString.size - stripString.size );

	return lookupString;
}
waittill_notify_ent_or_timeout( ent, msg, timer )
{
	if(isDefined(ent) && isDefined(msg))
		ent endon( msg );

	wait( timer );
}