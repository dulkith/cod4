init( modVersion ) {

	thread Rules();
}

Rules()
{
level endon("disconnect");

	//rules...
	rules = [];
	rules[0] = "^5>>^7We are ^3SL^1e^3SPORT ^2Sri Lanka^5<<";
	rules[1] = "";
	rules[2] = "^5>>^7^2If you feel ^1abused ^7by any admins ^3conntact ^1GT ^2or ^1Duka .^5<";
	rules[5] = "";
	rules[4] = "^5>>^7TeamSpeak3 IP ^1127.128.274.100^5<<";
	rules[5] = "";
	rules[6] = "^5>>^1Camp ^7is ^1allowed ^7only with ^1sniper, ^3max camp time without ^2sniper 5-10 sec^5<";
	rules[7] = "";
	rules[8] = "^5>>^7No insulting^5<<";
	rules[9] = "";
	rules[10] = "^5>>^7No cheating^5<<";
	rules[11] = "";
	rules[12] = "^5>>^7Don't ask for Admin!^5<<";
	rules[13] = "";
	rules[14] = "^5>>^1No advertising ^7or ^2spamming ^7of ^3websites or servers.^5<";
	rules[15] = "";
	rules[16] = "^5>>^7No arguing with ^1admins ^3(listen and learn or ^2leave^3).^5<<";
	rules[17] = "";
	rules[18] = "^5>>^7No recruiting for ^1your clan, ^3your server, ^7or ^2anything else.^5<<";
	rules[19] = "";
	rules[20] = "^5>>^4Facebook ^3Group ^0: ^2www.fb.com/groups/callofdoggy/^5<<";
	rules[21] = "";
	rules[22] = "^5>>^3Visit for more details ^1or ^3Buy server ^0: ^1www.slesport.com^5<<";
	rules[23] = "";
	rules[24] = "^5>>^7English and Singlish Only^5<<";
	rules[25] = "";
	rules[26] = "^5>>^7Hosted & Moded by : ^7www^1.^7ducoder^1.^7com5<<";
	rules[27] = "";
	rules[28] = "^5>>^7Respect Admins and Players^5<<";
	rules[29] = "";
	rules[30] = "^5>>^3Using ^1cheats ^3and ^1scripts ^3will get an instant ^1ban.^5<<";
	rules[31] = "";
	rules[32] = "^5>>^7SL^1e^7SPORT ^1TDM ^0: ^6127.128.274.100:28961^5<<";
	rules[33] = "";
	rules[34] = "^5>>^7SL^1e^7SPORT ^2SnD ^0: ^6127.128.274.100:28962^5<<";
	rules[35] = "";
	rules[36] = "^5>>^3Now On ^1High XP. ^2Have Fun ;-)<<";
	rules[37] = "";
	rules[38] = "^5>>^3Rule #1: ^1No ^3Martyrdom^5<<";
	rules[39] = "";
	rules[40] = "^5>>^3Rule #2: ^1No ^3Last Stand^5<<";
	rules[41] = "";
	rules[42] = "^5>>^3Rule #3: ^1No ^3Juggernaut Perk^5<<";
	rules[43] = "";
	rules[44] = "^5>>^3Rule #4: ^1No ^3Granade Launcher^5<<";
	rules[45] = "";
	rules[46] = "^5>>^3Rule #5: ^1Only ^3use ^1RPG ^3for Helicopter^5<<";
	rules[47] = "";
	rules[48] = "^5>>^3Rule #6: ^1Respect ^3All Players^5<<";
	rules[49] = "";
	rules[50] = "^5>>^3Rule #7: ^1No ^3arguing with admins^5<<";
	rules[51] = "";

	if( isDefined( level.logoText ) )
		level.logoText destroy();

	level.logoText = newHudElem();
	level.logoText.y = 0;
	level.logoText.alignX = "CENTER";
	level.logoText.alignY = "BOTTOM";
	level.logoText.horzAlign = "CENTER";
	level.logoText.vertAlign = "BOTTOM";
	level.logoText.color = (1,1,1);
	level.logoText.glowColor = (1.0, 0.0, 0.0);

	level.logoText.alpha = 0;
	level.logoText.sort = -3;
	level.logoText.fontScale = 1.4;
	level.logoText.archieved = true;

	i = 0;
	
	for(;;)
	{
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText(rules[i]);
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		if(i == rules.size) {
			i = 0;
		} else {
			i++;
		}
	}
}