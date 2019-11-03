init()
{
	level.welcomegeo = undefined;
	level.iswaitingforgeo = undefined;
	level.sideChange = false;
	wait 5;
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
	level hudmsgtop("^3Welcome ^0" + self.name  + " ^3From ^0" + location + " ^3 to ^7SLeSPORTS");
}

hudmsgtop(text)
{
	level.welcomegeo = true;
	if(level.sideChange){
		msg = addTextHud( level, 750, 7, 1, "left", "middle", undefined, undefined, 1.4, 888 );
		msg SetText(text);
		msg.sort = 102;
		msg.foreground = 1;
		msg.archived = true;
		msg.alpha = 1;
		msg.fontScale = 1.4;
		msg MoveHud(30,-1400);
		level.sideChange=false;
	}else{
		msg = addTextHud( level, 0, 7, 1, "right", "middle", undefined, undefined, 1.4, 888 );
		msg SetText(text);
		msg.sort = 102;
		msg.foreground = 1;
		msg.archived = true;
		msg.alpha = 1;
		msg.fontScale = 1.4;
		msg MoveHud(30,2100);
		level.sideChange=true;
	}
	wait 16;
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
	hud.alpha = 0.8;
	//hud.color = (0.1,1,0.6);
	hud.glowcolor = (0.2,0,0.6);
	hud.glowalpha = 0.5;
	hud.foreground = 1;
	
	return hud;
}