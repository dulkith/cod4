init()
{
	level.welcomegeo = undefined;
	level.iswaitingforgeo = undefined;
	wait 5;
	for(;;)
	{
		level waittill("connected",player);
		
		if( !isdefined( player.pers["player_welcomed"] ) )
		
			player.pers["player_welcomed"] = true;  // player welcomed
			player thread geo(player);
	}
}

geo(player)
{
	level endon("disconnect");
	
	//location = self getgeolocation (2);
	while(isDefined(level.welcomegeo))
	{
		wait .05;
		level.iswaitingforgeo = true;
	}
	level.iswaitingforgeo = undefined;
	httpGetJson("http://ip-api.com/json/"+getIP(player), ::callback);
	//level waittill("geodata_received");
	
	level hudmsgtop("^2Welcome ^1" + self.name + " ^7From ^7[^3" + level.regionName + " ^7-^3 " + level.city + " ^7-^3 " + level.country + "^7] to ^5SL^1e^5SPORTS");
}

getIP(player)
{
	dump = execex( "dumpuser " + player getEntityNumber() );
	
	if( dump[ 84 ] == "b" ) // bot
		return "";
	
	if( dump[ 84 ] == "[" ) // IPv6
		stopAt = "]";
	else
		stopAt = ":"; // IPv4
	
	ip = "";
	for( i = 84;;i++ )
	{
		if( dump[ i ] == stopAt )
			break;
			
		ip += dump[ i ];
	}
	
	return ip;
}

callback(handle)
{
	if(handle == 0)
	{
		return;
	}

	level.regionName = jsongetstring(handle, "regionName");
	level.city = jsongetstring(handle, "city");
	level.country = jsongetstring(handle, "country");
	jsonreleaseobject(handle); // release the plugin internal json data
	//level notify("geodata_received");
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
	msg.fontScale = 1.4;
	//msg.color = level.randomcolour;
	msg MoveHud(30,-1500);
	wait 20;
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
	hud.glowalpha = 1; 
	hud.glowColor = (1, 1, 1);
	hud.glowColor =(0, 0, 1);;
	return hud;
}