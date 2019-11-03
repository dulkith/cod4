#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

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
		
	if(! isDefined(self._scorePopup)) 
	{
	self._scorePopup = newClientHudElem(self);
	self._scorePopup.horzAlign = "center";
	self._scorePopup.vertAlign = "middle";
	self._scorePopup.alignX = "left";
	self._scorePopup.alignY = "middle";
	self._scorePopup.y = -30;
	self._scorePopup.font = "default";
	self._scorePopup.fontscale = 1.4;
	self._scorePopup.archived = false;
	self._scorePopup.hideWhenInMenu = true;
	self._scorePopup.sort = 9999;
	}
	self._scorePopup.x = -50;
	self._scorePopup.alpha = 0;
	self._scorePopup.color = hudColor;
	self._scorePopup.glowColor = hudColor;
	self._scorePopup.glowAlpha = glowAlpha;
	self._scorePopup setText(string);
	
	self._scorePopup fadeOverTime(0.5);
	self._scorePopup.alpha = 1;
	self._scorePopup moveOverTime(0.75);
	self._scorePopup.x = 35;

	wait 1.5;

	self._scorePopup fadeOverTime( 0.75 );
	self._scorePopup.alpha = 0;
	wait 0.2;
	self.underScoreInProgress = false;
}
isWeekend()
{
	if(getDay() == "Friday" || getDay() == "Saturday" || getDay() == "Sunday")
		return true;
		
	return false;
}
getDay()
{
	return [[level.getDay]]();
}
getWeaponClass( weapon )
{
	tokens = strTok( weapon, "_" )[0];
	weaponClass = tableLookUp( "mp/statsTable.csv", 4, tokens, 2 );
	return weaponClass;
}
CustomObituary(text)
{	
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