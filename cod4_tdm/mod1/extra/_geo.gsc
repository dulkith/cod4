init()
{
	level.welcomegeo = undefined;
	level.iswaitingforgeo = undefined;
	
	for(;;)
	{
		level waittill("connected",player);
		
		if( !isdefined( player.pers["player_welcomed"] ) )
		{
			if( !isdefined( player.pers["isBot"] ) )
			{
				player.pers["player_welcomed"] = true;  // player welcomed
				player thread geo();
			}
		}
	}
}

geo()
{
	level endon("disconnect");
	
	location = self getgeolocation (2);
	while(isDefined(level.welcomegeo))
	{
		wait .05;
		level.iswaitingforgeo = true;
	}
	level.iswaitingforgeo = undefined;
	level hudmsgtop("^1Welcome ^2" + self.name  + " ^1From ^2" + location);
}

hudmsgtop(text)
{
	level.welcomegeo = true;
	msg = addTextHud( level, 750, 5, 1, "left", "middle", undefined, undefined, 1.4, 888 );
	msg SetText(text);
	msg.sort = 102;
	msg.foreground = 1;
	msg.archived = true;
	msg.alpha = 1;
	msg.fontScale = 1.5;
	msg.color = level.randomcolour;
	msg MoveHud(30,-1300);
	wait 15;
	msg destroy();
	level.welcomegeo = undefined;
}

MoveHud(time,x,y) {
    self moveOverTime(time);
    if(isDefined(x))
        self.x = x;
       
    if(isDefined(y))
        self.y = y;
}

addTextHud( who, x, y, alpha, alignX, alignY, horiz, vert, fontScale, sort ) {
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.alignX = alignX;
	hud.alignY = alignY;
	if(isdefined(vert))
		hud.vertAlign = vert;
	if(isdefined(horiz))
		hud.horzAlign = horiz;		
	if(fontScale != 0)
		hud.fontScale = fontScale;
	hud.foreground = 1;
	hud.archived = 0;
	return hud;
}