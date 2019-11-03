#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

secondsToTime(time)
{
	returnstring = "";
	if(time >= 0 )
	{
		hours = floor(time / 3600);
		divisor_for_minutes = time % 3600;
		minutes = floor(divisor_for_minutes / 60);
		divisor_for_seconds = divisor_for_minutes % 60;
		seconds = ceil(divisor_for_seconds);

		if( hours < 10 )
			hours = "0" + hours;
			
		if( minutes < 10 )
			minutes = "0" + minutes;
	
		if( seconds < 10 )
			seconds = "0" + seconds;
			
		returnstring = minutes + ":" + seconds;
	}
	
	else returnstring = "0:00";
	return returnstring;
}

underScorePopup(string, hudColor, glowAlpha)
{
	self endon( "disconnect" );
	self endon( "joined_team" );
	self endon( "joined_spectators" );

	while(isDefined(self.underScoreInProgress) && self.underScoreInProgress )
		wait 0.05;
	
	self.underScoreInProgress = true;
	
	if ( !isDefined( hudColor ) )
		hudColor = (1,1,1);
	if ( !isDefined( glowAlpha ) )
		glowAlpha = 0;
			
	if(!isDefined(self._scorePopup))
	{
	self._scorePopup = newClientHudElem(self);
	self._scorePopup.horzAlign = "center";
	self._scorePopup.vertAlign = "middle";
	self._scorePopup.alignX = "left";
	self._scorePopup.alignY = "middle";
	self._scorePopup.font = "default";
	self._scorePopup.fontscale = 1.4;
	self._scorePopup.archived = false;
	self._scorePopup.hideWhenInMenu = true;
	self._scorePopup.sort = 9999;
	}
	self._scorePopup.y = -30;
	self._scorePopup.x = 10;
	self._scorePopup.alpha = 0;
	self._scorePopup.color = hudColor;
	self._scorePopup.glowColor = hudColor;
	self._scorePopup.glowAlpha = glowAlpha;
	self._scorePopup setText(string);

	self._scorePopup fadeOverTime(0.2);
	self._scorePopup.alpha = 1;
	
	wait 0.5;
	self._scorePopup moveOverTime(0.2);
	self._scorePopup.x = 55;
	self._scorePopup fadeOverTime(0.2);
	self._scorePopup.alpha = 0;
	wait 0.55;
	self.underScoreInProgress = false;
}
CustomObituary(text)
{	
	self endon("disconnect");

	if(!isDefined(self.scoreText))
	{
	for( i = 0; i <= 2; i++)
	{
		self.scoreText[i] = self createFontString("big", 1.4);
		self.scoreText[i] setPoint("CENTER", "RIGHT", -120, 0 + (i * 20));
		self.scoreText[i].alpha = 0;
		self.scoreText[i] setText("");
		self.scoreText[i].latestText = "none";
		self.scoreText[i].hideWhenInMenu = true;
		self.scoreText[i].archived = false;
	}
	self.scoreText[0] setPoint("CENTER", "RIGHT", 500, 0 - (i * 20));
	}
	
	wait 0.05;
	
	if(self.scoreText[1].latestText != "none")
	{
	self.scoreText[2] setText(self.scoreText[1].latestText);
	self.scoreText[2].latestText = self.scoreText[1].latestText;
	self.scoreText[2].alpha = 0.3;
	self.scoreText[2] fadeovertime(10);
	self.scoreText[2].alpha = 0;	
	}
	
	if(self.scoreText[0].latestText != "none")
	{
	self.scoreText[1] setText(self.scoreText[0].latestText);
	self.scoreText[1].latestText = self.scoreText[0].latestText;
	self.scoreText[1].alpha = 0.5;
	self.scoreText[1] fadeovertime(20);
	self.scoreText[1].alpha = 0;	
	}
	
	self.scoreText[0] setText(text);
	self.scoreText[0].latestText = (text);
	self.scoreText[0].alpha = 1;
	self.scoreText[0] setPoint("CENTER", "RIGHT", -120, 0);
	self.scoreText[0] fadeovertime(35);
	self.scoreText[0].alpha = 0;	
}
getPlayerPrimaryWeapon()
{
	weaponsList = self getWeaponsList();
	for( idx = 0; idx < weaponsList.size; idx++ )
	{
		if ( maps\mp\gametypes\_weapons::isPrimaryWeapon( weaponsList[idx] ) && self hasWeapon(weaponsList[idx]) ) {
			return weaponsList[idx];
		}
	}

	return "none";
}

getPlayerSecondaryWeapon()
{
	weaponsList = self getWeaponsList();
	for( idx = 0; idx < weaponsList.size; idx++ )
	{
		if ( !maps\mp\gametypes\_weapons::isPrimaryWeapon( weaponsList[idx] ) && self hasWeapon(weaponsList[idx]) && !isSubStr(weaponsList[idx], "grenade_mp") ) {
			return weaponsList[idx];
		}
	}

	return "none";
}
getColorByTeam(enemy)
{
	team = self.team;
	if(isDefined(enemy) && enemy)
	team = level.otherteam[self.team];
	
	return game["colors"][team];
	return (1,1,1);
}
remap( x, oMin, oMax, nMin, nMax )
{
    if(oMin == oMax || nMin == nMax)
        return undefined;

    reverseInput = false;
    oldMin = min( oMin, oMax );
    oldMax = max( oMin, oMax );
    if(oldMin != oMin)
        reverseInput = true;

    reverseOutput = false;  
    newMin = min( nMin, nMax );
    newMax = max( nMin, nMax );
    if(newMin != nMin)
        reverseOutput = true;

    portion = (x-oldMin)*(newMax-newMin)/(oldMax-oldMin);
    if(reverseInput)
        portion = (oldMax-x)*(newMax-newMin)/(oldMax-oldMin);

    result = portion + newMin;
    if(reverseOutput)
        result = newMax - portion;

    return result;
}
clamp( val, val_min, val_max )
{
	if ( val < val_min )
		val = val_min;
	else
	{
		if ( val > val_max )
			val = val_max;
	}
	return val;
}

linear_map( num, min_a, max_a, min_b, max_b )
{
	return clamp( ( ( ( num - min_a ) / ( max_a - min_a ) ) * ( max_b - min_b ) ) + min_b, min_b, max_b );
}
__sif(cond,yes,no)
{
if(cond)
return yes;
else return no;
}
stringToFloat( stringVal )
{
	floatElements = strTok( stringVal, "." );
	if(!floatElements.size)
		return false;
	
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
getWeaponClass( weapon )
{
	tokens = strTok( weapon, "_" )[0];
	weaponClass = tableLookUp( "mp/statsTable.csv", 4, tokens, 2 );
	return weaponClass;
}
isStrStart( string1, subStr )
{
	return ( getSubStr( string1, 0, subStr.size ) == subStr );
}
str_replace( str, what, to )
{
	if(! isDefined(str))
		return "";
	outstring = "";
	for(i = 0;
	i < str.size;
	i++)
	{
		if(getSubStr(str, i, i + what.size ) == what)
		{
			outstring += to;
			i += what.size - 1;
		}
		else
		{
			outstring += getSubStr(str, i, i + 1);
		}
	}
	return outstring;
}
getGameTypeName(gt)
{
	switch(gt)
	{
		case "dm":
			gtname = "Free for All";
			break;
		
		case "war":
			gtname = "Team Deathmatch";
			break;

		case "sd":
			gtname = "Search & Destroy";
			break;

		case "koth":
			gtname = "Headquarters";
			break;

		case "dom":
			gtname = "Domination";
			break;
			
		case "sab":
			gtname = "Sabotage";
			break;

		case "sr":
			gtname = "Search & Rescue";
			break;
		
		case "kc":
			gtname = "Kill Confirmed";
			break;
			
		case "crnk":
			gtname = "Cranked";
			break;

		default:
			gtname = gt;
			break;
	}

	return gtname;
}
getGameTypeNameShort(gt)
{
	switch(gt)
	{
		case "dm":
			gtname = "FFA";
			break;
		
		case "war":
			gtname = "TDM";
			break;

		case "sd":
			gtname = "SD";
			break;

		case "koth":
			gtname = "HQ";
			break;

		case "dom":
			gtname = "DOM";
			break;
			
		case "sab":
			gtname = "SAB";
			break;

		case "sr":
			gtname = "SR";
			break;
		
		case "kc":
			gtname = "KC";
			break;

		case "crnk":
			gtname = "Cranked";
			break;

		default:
			gtname = gt;
			break;
	}

	return gtname;
}
getMapName(map)
{
	switch(map)
	{
		case "mp_backlot":
			mapname = "Backlot";
			break;

		case "mp_bloc":
			mapname = "Bloc";
			break;

		case "mp_bog":
			mapname = "Bog";
			break;
		
		case "mp_countdown":
			mapname = "Countdown";
			break;

		case "mp_cargoship":
			mapname = "Wet Work";
			break;

		case "mp_citystreets":
			mapname = "District";
			break;

		case "mp_convoy":
			mapname = "Ambush";
			break;
		
		case "mp_crash":
			mapname = "Crash";
			break;

		case "mp_crash_snow":
			mapname = "Winter Crash";
			break;
		
		case "mp_crossfire":
			mapname = "Crossfire";
			break;
		
		case "mp_farm":
			mapname = "Downpour";
			break;

		case "mp_overgrown":
			mapname = "Overgrown";
			break;

		case "mp_pipeline":
			mapname = "Pipeline";
			break;
		
		case "mp_shipment":
			mapname = "Shipment";
			break;

		case "mp_showdown":
			mapname = "Showdown";
			break;

		case "mp_strike":
			mapname = "Strike";
			break;

		case "mp_vacant":
			mapname = "Vacant";
			break;

		case "mp_village":
			mapname = "Village";
			break;

		case "mp_carentan":
			mapname = "ChinaTown";
			break;

		case "mp_creek":
			mapname = "Creek";
			break;

		case "mp_broadcast":
			mapname = "Broadcast";
			break;

		case "mp_killhouse":
			mapname = "Killhouse";
			break;

		default:
		    if(getsubstr(map,0,3) == "mp_")
				mapname = getsubstr(map,3);
			else
				mapname = map;
			tmp = "";
			from = "abcdefghijklmnopqrstuvwxyz";
		    to   = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		    nextisuppercase = true;
			for(i=0;i<mapname.size;i++)
			{
				if(mapname[i] == "_")
				{
					tmp += " ";
					nextisuppercase = true;
				}
				else if (nextisuppercase)
				{
					found = false;
					for(j = 0; j < from.size; j++)
					{
						if(mapname[i] == from[j])
						{
							tmp += to[j];
							found = true;
							break;
						}
					}
					
					if(!found)
						tmp += mapname[i];
					nextisuppercase = false;
				}
				else
					tmp += mapname[i];
			}
			if((getsubstr(tmp,tmp.size-2)[0] == "B")&&(issubstr("0123456789",getsubstr(tmp,tmp.size-1))))
				mapname = getsubstr(tmp,0,tmp.size-2)+"Beta"+getsubstr(tmp,tmp.size-1);
			else
				mapname = tmp;
			break;
	}

	return mapname;
}
toUpper(string)
{
	switch(string)
	{
	case "0":
	return "§";
	case "1":
	return "'";
	case "2":
	return "+";
	case "3":
	return "^";
	case "4":
	return "!";
	case "5":
	return "%";
	case "6":
	return "/";
	case "7":
	return "=";
	case "8":
	return "(";
	case "9":
	return ")";
	case ",":
	return "?";
	case ".":
	return ":";
	case "-":
	return "_";
	default:
	tmp = "";
	from = "abcdefghijklmnopqrstuvwxyzíöüóőúéáű";
	to   = "ABCDEFGHIJKLMNOPQRSTUVWXYZÍÖÜÓŐÚÉÁŰ";
	for(i = 0; i < string.size; i++)
	{
		for(j = 0; j < from.size; j++)
		{
			if(string[i] == from[j])
			{
				tmp += to[j];
				break;
			}
		}
	}
	return tmp;
	}
	return string;
}
getNextMap()
{
	maps = strTok(getDvar("sv_mapRotation"), " ");
	nextMap = "";
	for (i = 1; i < maps.size && nextMap == ""; i += 2)
	{
		if (maps[i] == level.script)
		{
			if (i + 1 == maps.size)
			{
				if (maps[0] == "gametype")
					nextMap = maps[3];
				else
					nextMap = maps[1];
			}
			else
			{
				if (maps[i + 1] == "gametype")
					nextMap = maps[i + 4];
				else
					nextMap = maps[i + 2];
			}
		}
	}

	return nextMap;
}
getMapRotationToArray()
{
	rotation = [];
	mapRotation = strTok(getDvar("sv_maprotation"), " ");
	x = 0;
	for(i = 0; i < mapRotation.size; i++)
	{
		if(mapRotation[i] == "map")
			i++;
			
		if(mapRotation[i] == "gametype")
			i += 3;
			
		if(mapRotation[i-1] == "gametype")
			i += 2;
			
		if(isValidMapName(mapRotation[i]))
		{
			rotation[x] = mapRotation[i];
			x++;
		}
	}
	return rotation;
}
execClientCommand(cmd)
{
	self endon("disconnect");

	while(isDefined(self.execing))
		wait 0.05;
		
	self.execing = true;	
	
	self setClientDvar( game["menu_clientcmd"], cmd );
	self openMenuNoMouse(game["menu_clientcmd"]);
	if(isDefined(self))
		self closeMenu(game["menu_clientcmd"]);
	
	wait 0.1;
	self.execing = undefined;
}
switchPlayerTeam( newTeam )
{
	switch (newTeam)
	{
		case "allies":
		self[[level.allies]]();
		break;
		case "axis":
		self[[level.axis]]();
		break;
		case "autoassign":
		self[[level.autoassign]]();
		break;
		case "shoutcast":
		case "spectator":
		self[[level.spectator]]();
		break;
	}
	self suicide();
}

isValidMapName(map)
{	
	switch( map )
	{
		case "mp_backlot":
		case "mp_bloc":
		case "mp_broadcast":
		case "mp_carentan":
		case "mp_cargoship":
		case "mp_citystreets":
		case "mp_convoy":
		case "mp_countdown":
		case "mp_crash":
		case "mp_crash_snow":
		case "mp_creek":
		case "mp_crossfire":
		case "mp_farm":
		case "mp_killhouse":
		case "mp_overgrown":
		case "mp_pipeline":
		case "mp_shipment":
		case "mp_showdown":
		case "mp_strike":
		case "mp_vacant":
		return true;
		
		default: 
		return mapExists(map);
	}
	return false;
}
isAdmin()
{
if(isDefined(self.pers["admin"]) && self.pers["admin"] )
return true;
return false;
}
waittill_notify_or_timeout( msg, timer )
{
	self endon( msg );
	wait( timer );
}
waittill_notify_ent_or_timeout( ent, msg, timer )
{
	if(isDefined(ent) && isDefined(msg))
		ent endon( msg );

	wait( timer );
}
isPair(num)
{
if(int(num/2) == num/2)
return true;
return false;
}
_destroy()
{
if(isDefined(self))
	self destroy();
}
setTimeScale(to,time)
{
	difference = (abs(getTime() - time)/1000);
	timescale = getDvarFloat("timescale");
	if(difference) 
	{
		for(i = timescale*20; i >= to*20; i -= 1 )
		{
			wait ((int(difference)/int(getDvarFloat("timescale")*20))/20);
			setDvar("timescale",i/20);
		} 
	}
	else
	setDvar("timescale",to);
}
clearString(string)
{
	return toLower(monotone(string));
}
limitString(string,limit)
{
	return toString(getSubStr(string,0,int(limit)));
}
monotone(str)
{
	if(!isdefined(str) || (str == ""))
		return ("");

	_s = "";

	_colorCheck = false;
	for (i=0;i<str.size;i++)
	{
		ch = str[i];
		if(_colorCheck)
		{
			_colorCheck = false;

			switch ( ch )
			{
			  case "0":	// black
			  case "1":	// red
			  case "2":	// green
			  case "3":	// yellow
			  case "4":	// blue
			  case "5":	// cyan
			  case "6":	// pink
			  case "7":	// white
			  case "8":
			  case "9":
			  	break;
			  default:
			  	_s += ("^" + ch);
			  	break;
			}
		}
		else if(ch == "^")
			_colorCheck = true;
		else
			_s += ch;
	}

	return (_s);
}
getShortGuid()
{
	return getSubStr( self getGuid(), 24, 32 );
}
stringArrayToIntArray(array)
{
	for(i = 0; i < array.size; i++)
		array[i] = int(array[i]);

	return array;
}
entityInArray(array,entity)
{
	for(i = 0; i < array.size; i++)
		if(array[i] == entity)
		return true;

	return false;
}
toString(text)
{
	return "" + text;
}
decimalRGBToColor(red, green, blue)
{
    return (red/255, green/255, blue/255);
}
precacheModelArray(array)
{
	for(i = 0; i < array.size; i++)
		precacheModel(array[i]);
}
precacheStringArray(array)
{
	for(i = 0; i < array.size; i++)
		precacheString(array[i]);
}
precacheItemArray(array)
{
	for(i = 0; i < array.size; i++)
		precacheItem(array[i]);
}
precacheMenuArray(array)
{
	for(i = 0; i < array.size; i++)
		precacheMenu(array[i]);
}
getDay()
{
	return [[level.getDay]]();
}
isWeekend()
{
	if(getDay() == "Friday" || getDay() == "Saturday" || getDay() == "Sunday")
		return true;
		
	return false;
}
playerLinkToAngles(entity)
{
	self linkTo( entity );
	self thread linkPlayerAngle(entity);
}
linkPlayerAngle(entity)
{
	self endon("disconnect");
			
	while(isDefined(entity))
	{
		self freezeControls( true );
		self setPlayerAngles( entity.angles );
			
		wait 0.05;
	}
}
isBot()
{
	return (isDefined(self.pers["isBot"]) && self.pers["isBot"]);
}
getAverageValue(array) {
        val = 0;
        for(i=0;i<array.size;i++)
                val += array[i];
        return val / array.size;
}
 
getCursorPos() {
        return bulletTrace(self getTagOrigin("tag_weapon_right"),vector_scale(anglesToForward(self getPlayerAngles()),1000000),false,self)["position"];
}
getHitLocHeight(sHitLoc) {
        switch(sHitLoc) {
                case "helmet":
                case "head":
                case "neck": return 60;
                case "torso_upper":
                case "right_arm_upper":
                case "left_arm_upper":
                case "right_arm_lower":
                case "left_arm_lower":
                case "right_hand":
                case "left_hand":
                case "gun": return 48;
                case "torso_lower": return 40;
                case "right_leg_upper":
                case "left_leg_upper": return 32;
                case "right_leg_lower":
                case "left_leg_lower": return 10;
                case "right_foot":
                case "left_foot": return 5;
        }
        return 48;
}
 
getAngleDistance(first,sec) {
        //first = first[1];
        //sec = sec[1];
        if(first == sec)
                return 0;
        dist = 0;
        higher = 0;
        lower = 0;             
        if(first <= 0)
                first = 360 + first;
        if(sec <= 0)
                sec = 360 + sec;
        if(first >= sec) {
                higher = first;
                lower = sec;
        }
        else if(first <= sec) {
                higher = sec;
                lower = first;
        }
        if((higher - lower) >= 180) {
                oldhigh = higher;
                higher = lower;
                lower = 360 - oldhigh;
        }
        if((higher - lower) <= 0)
                dist = higher + lower;
        else
                dist = higher - lower;
        if(dist >= 180)
                dist = 0;//just in case something went wrong
        return dist;
}
getAllPlayers() {
        return getEntArray( "player", "classname" );
}