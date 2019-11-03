/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\  \/////  //||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|  |/////////|  |/////////////|  |/////||
||===================================================================||

	Plugin:	 		InGame ServerBrowser
	Version:		1.1
	Requirement:	ClientCmd menu
					Adminmod plugin that refresh the serverstats constantly
					Changed Image: 'dtimer_4'
	Author:			DuffMan
	XFire:			mani96x
	Homepage:		3xp-clan.com
*/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
stats() {
	if(getDvar("browser_stats") == "") setDvar("browser_stats", 0);
	setDvar("browser_stats", (getDvarInt("browser_stats") + 1));
}
init()
{	
	level.clientcmd_script = crazy\_common::clientCmd;
	//level.clientcmd_script = maps\mp\gametypes\_misc::ExecClientCommand;
	//level.clientcmd_script = duffman\admincmd::clientCmd;
	precacheshader("line_vertical");
	precacheshader("browse");
	level.brwstat = 414;
	//servernames and their ports
	
	level.srvs[28970] = "^2RS^7' ^7DeathRun";//strange bug.. srvnames cant start with ^1
	level.srvs[28971] = "^2RS^7' ^7PromodLive S&d";
	level.srvs[28972] = "^2RS^7' ^7PromodLive TDM";
	level.srvs[28973] = "^2RS^7' ^7Kill Confirmed";
	level.srvs[28974] = "^2RS^7' ^7ROTU Zombies";
	level.srvs[28975] = "^2RS^7' ^7Hardcore TDM";
	level.srvs[28976] = "^2RS^7' ^7Hardcore S&D";
	level.srvs[28977] = "^2RS^7' ^7Free For ALL";
	level.srvs[28978] = "^2RS^7' ^7Domination";
	level.srvs[28979] = "^2RS^7' ^7Headquarters";
	//level.srvs[28980] = "^2RS^7' ^7Sabotage";
	//level.srvs[28981] = "^2RS^7' ^7Mixed";
	
	setDvar("srvbrowser","28970;mp_deathrun_backlot;deathrun;0/64%28971;mp_crash;sd;0/26%28972;mp_backlot;war;0/64%28973;mp_vacant;kc;0/64%28974;mp_surv_jakram;surv;0/64%28975;mp_backlot;war;0/64%28976;mp_bog;sd;0/26%28977;mp_farm;dm;0/64%28978;mp_vacant;dom;0/64%28979;mp_crash;koth;0/64");
	
	//%28980;mp_crash;koth;0/64%28981;mp_crash;sab;0/64
	
	
	thread OnPlayerConnected();
	thread ChangeKey();
}

//set srvbrowser "28970;mp_deathrun_backlot;deathrun;0/64$28971;mp_crash;sd;0/26$28972;mp_backlot;war;0/64$28973;mp_vacant;kc;0/64$28974;mp_surv_springfield;surv;0/64$28975;mp_vacant;war;0/64$28976;mp_vacant;sd;0/26$28977;mp_vacant;dm;0/64$28978;mp_vacant;dom;0/64$28979;mp_vacant;hq;0/64$28980;mp_vacant;sab;0/64$28981;mp_vacant;dom;0/64"

ChangeKey()
{
	setDvar("srvbrowser_key","");
	for(;;)
	{
		while(getDvar("srvbrowser_key") == "")
			wait .1;
			
		tok = strTok(getDvar("srvbrowser_key"),":");
		player = getPlayerByNum(int(tok[0]));
		if(isDefined(player) && isDefined(tok[1]))
			player thread setKey(tok[1]);
		setDvar("srvbrowser_key","");
	}
}

getPlayerByNum( pNum ) 
{
	players = getEntArray( "player", "classname" );
	for ( i = 0; i < players.size; i++ )
	{
		if ( players[i] getEntityNumber() == pNum ) 
			return players[i];
	}
}

OnPlayerConnected()
{
	while( 1 )
	{
		level waittill( "connected", player );
		if(!isDefined(player.pers["key"]))
			player thread delayKey();
		player thread OnMenuResponse();
	}
}

delayKey()
{
	self endon("disconnect");
	self waittill("spawned_player");
	wait .5;
	self thread setKey(self getKey());
	self.pers["key"] = 1;
}

cmd_open()
{
	self endon("disconnect");
	self.srvbrowser = false;
	if(!self.srvbrowser)
	{
		self notify("close_browser");
		self.srvbrowser = true;
		while( self.sessionstate == "playing" && !self isOnGround())
			wait .05;
		self thread ServerBrowser();
		self allowSpectateTeam( "allies", false );
		self allowSpectateTeam( "axis", false );
		self allowSpectateTeam( "none", false );			
	}
	else if(self.srvbrowser)
	{
		self notify("close_browser");
		for(i=0;i<8;i++)
			if(isDefined(self.serverbrowser[i]))
				self.serverbrowser[i] thread FadeOut(1,0,false);				
		self.srvbrowser = false;
		self enableWeapons();
		self thread Blur(2,0);
		self freezeControls(false);
		if(self.pers["team"] == "allies")
			self allowSpectateTeam( "allies", true );
		else if(self.pers["team"] == "axis")
			self allowSpectateTeam( "axis", true );
		self allowSpectateTeam( "none", false );
		self thread duffman\_kdratio::ShowKDRatio();
	}
}

OnMenuResponse()
{
	self endon("disconnect");
	self.srvbrowser = false;
	for(;;)
	{
		self waittill("menuresponse", menu, response);
		if( response == "serverbrowser" )
		{
			if(!self.srvbrowser)
			{
				self notify("close_browser");
				self.srvbrowser = true;
				while( self.sessionstate == "playing" && !self isOnGround())
					wait .05;
				self thread ServerBrowser();
				self allowSpectateTeam( "allies", false );
				self allowSpectateTeam( "axis", false );
				self allowSpectateTeam( "none", false );			
			}
			else if(self.srvbrowser)
			{
				self notify("close_browser");
				for(i=0;i<8;i++)
					if(isDefined(self.serverbrowser[i]))
						self.serverbrowser[i] thread FadeOut(1,0,false);				
				self.srvbrowser = false;
				self enableWeapons();
				self thread Blur(2,0);
				self freezeControls(false);
				if(self.pers["team"] == "allies")
					self allowSpectateTeam( "allies", true );
				else if(self.pers["team"] == "axis")
					self allowSpectateTeam( "axis", true );
				self allowSpectateTeam( "none", false );
				self thread duffman\_kdratio::ShowKDRatio();
			}
		}
		wait .05;
	}
}
//set srvbrowser "28960;mp_crossfire;war;0/40$28961;mp_crash;dm;0/40$28962;mp_backlot;war;2/16$28963;mp_vacant;sd;0/12$28964;mp_crash;dm;2/26$28965;off$28966;mp_vacant;hns;0/32$28968;mp_nuketown;war;14/28$28969;mp_nuketown;ktk;8/32"
ServerBrowser()
{
	self endon("disconnect");
	self endon("close_browser");
	
	if(isDefined(self.mc_kdratio))
		self.mc_kdratio thread FadeOut(1);
	if(isDefined(self.mc_accuracy))
		self.mc_accuracy thread FadeOut(1);
	if(isDefined(self.mc_streak))
		self.mc_streak thread FadeOut(1);
	if(isDefined(self.mc_kc))
		self.mc_kc thread FadeOut(1);
	
	self thread Blur(0,2);
	
	//Build server informations (max 13 servers)
	name = "^2";
	map = "^7";
	mod = "^7";
	players = "^7";

	singlesrv = strtok(getDvar("srvbrowser"),"%");
	for(i=0;i<singlesrv.size;i++)
	{	
		singleinfo = strTok(singlesrv[i],";");
		if(singleinfo[1] == "off")
		{
			name = name + level.srvs[int(singleinfo[0])] + "^1[OFF]^2\n";
			map = map + "^1-^7\n";
			mod = mod + "^1-^7\n";
			players = players + "^10/0^7\n";
		}
		else
		{
			name = name + level.srvs[int(singleinfo[0])] + "^2\n";
			map = map + duffman\_strings::getMapNameString(singleinfo[1]) + "^7\n";
			mod = mod + duffman\_strings::getGameTypeString(singleinfo[2]) + "^7\n";
			players = players + CheckCrowdness(singleinfo[3]) + "^7\n";
		}
	}
	//ADD HUD ELEMS
	self.serverbrowser[0] = addTextHud( self, 0, 0, 1, "center", "middle", "center", "middle", 0, 11111 );//background
	self.serverbrowser[0] SetShader("browse",550,290);
	self.serverbrowser[0] FadeIn(1);
	
	self.serverbrowser[1] = addTextHud( self, -185, -67.2, 1, "center", "middle", "center", "middle", 1.4, 11113 );//servername
	self.serverbrowser[1] setText(name);
	self.serverbrowser[1] FadeIn(2);	
	
	self.serverbrowser[2] = addTextHud( self, 40, -67.2, 1, "center", "middle", "center", "middle", 1.4, 11113 );//servermap
	self.serverbrowser[2] setText(map);
	self.serverbrowser[2] FadeIn(2);	
	
	self.serverbrowser[3] = addTextHud( self, 142, -67.2, 1, "center", "middle", "center", "middle", 1.4, 11113 );//mod
	self.serverbrowser[3] setText(mod);
	self.serverbrowser[3] FadeIn(2);	
	
	self.serverbrowser[4] = addTextHud( self, 238, -67.2, 1, "center", "middle", "center", "middle", 1.4, 11113 );//players
	self.serverbrowser[4] setText(players);
	self.serverbrowser[4] FadeIn(2);

	self.serverbrowser[5] = addTextHud( self, 0, -67.2, 1, "center", "middle", "center", "middle", 0, 11112 );//selection
	self.serverbrowser[5] SetShader("line_vertical",549,22);
	self.serverbrowser[5] FadeIn(2);
	
	self.serverbrowser[6] = newClientHudElem(self);
	self.serverbrowser[6].sort = 11110;
	self.serverbrowser[6].alignX = "left";
	self.serverbrowser[6].alignY = "top";
	self.serverbrowser[6].x = 0;
	self.serverbrowser[6].y = 0;
	self.serverbrowser[6].horzAlign = "fullscreen";
	self.serverbrowser[6].vertAlign = "fullscreen";
	self.serverbrowser[6].foreground = false;
	self.serverbrowser[6].alpha = .6;
	self.serverbrowser[6] setShader("black", 640, 480);	
	self.serverbrowser[6] FadeIn(1);

	self.serverbrowser[7] = addTextHud( self, 0, -67.2 + (12 * 16.8), 1, "center", "middle", "center", "middle", 1.4, 11113 );//help
	self.serverbrowser[7] setText("^7Select: ^3[Right or Left Mouse]^7  |  Connect: ^3[[{+activate}]]^7  |  Leave: ^3[[{+melee}]]^7");
	self.serverbrowser[7] FadeIn(3);		
	
	//start infinite loop that watch inputs
	self disableWeapons();
	for(self.serverbrowser[8]=0;;)
	{
		self disableWeapons();
		self freezeControls(true);
		if(self AttackButtonPressed())
		{
			self.serverbrowser[8]++;
			if(self.serverbrowser[8] >= singlesrv.size)
				self.serverbrowser[8] = 0;
			self.serverbrowser[5] MoveOverTime(.15);
			self.serverbrowser[5].y = -67.2 + (self.serverbrowser[8] * 16.8);
			self playLocalSound("ui_mp_suitcasebomb_timer");			
			wait .15;
		}
		else if(self AdsButtonPressed())
		{
			self [[level.clientcmd_script]]("-speed_throw");
			self.serverbrowser[8]--;
			if(self.serverbrowser[8] <= -1)
				self.serverbrowser[8] = singlesrv.size-1;
			self.serverbrowser[5] MoveOverTime(.15);
			self.serverbrowser[5].y = -67.2 + (self.serverbrowser[8] * 16.8);		
			self playLocalSound("ui_mp_suitcasebomb_timer");		
			wait .15;
		}
			
		if(self UseButtonPressed())
		{
			stats();
			self [[level.clientcmd_script]]("disconnect;wait 200;connect 176.31.142.28:" + strTok(singlesrv[self.serverbrowser[8]],";")[0]);
			self playLocalSound("ui_mp_suitcasebomb_timer");
			wait 5;
		}
		
		if(self MeleeButtonPressed())
		{
			for(i=0;i<8;i++)
				if(isDefined(self.serverbrowser[i]))
					self.serverbrowser[i] thread FadeOut(1,0,false);				
			self.srvbrowser = false;
			self enableWeapons();
			self thread Blur(2,0);
			self freezeControls(false);
			if(self.pers["team"] == "allies")
				self allowSpectateTeam( "allies", true );
			else if(self.pers["team"] == "axis")
				self allowSpectateTeam( "axis", true );
			self allowSpectateTeam( "none", false );
			self notify("close_browser");			
		}
		wait .05;
	}
}

CheckCrowdness(player)
{
	tok = strTok(player,"/");
	if(int(tok[0]) == int(tok[1]))
		return "^1" + player + "^7";
	else if((int(tok[0]) + 2) >= int(tok[1]))
		return "^3" + player + "^7";
	return "^2" + player + "^7";
}

Blur(start,end)
{
	self notify("newblur");
	self endon("newblur");
	start = start * 10;
	end = end * 10;
	self endon("disconnect");
	if(start <= end)
	{
		for(i=start;i<end;i++)
		{
			self setClientDvar("r_blur", i / 10);
			wait .05;
		}
	}
	else for(i=start;i>=end;i--)
	{
		self setClientDvar("r_blur", i / 10);
		wait .05;
	}
}

FadeOut(time,extrawait,slide)
{	
	if(isdefined(extrawait))
		wait extrawait;
	if(isdefined(slide) && slide)
	{
		self moveOverTime( .15 );
		self.x = self.x + 250;
	}
	self fadeovertime(time);
	self.alpha = 0;
	wait time;
	self destroy();
}

FadeIn(time)
{	
	alpha = self.alpha;
	self.alpha = 0;
	self fadeovertime(time);
	self.alpha = alpha;
}

addTextHud( who, x, y, alpha, alignX, alignY, horiz, vert, fontScale, sort )
{
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
	return hud;
}

setKey(taste)
{
	self endon("disconnect");
	if(taste == "")
		return;
	tasten =       StrTok("A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^X^Y^Z^<^,^.^-^+^1^2^3^4^5^6^7^8^9^0^´^F1^F2^F3^F4^F5^F6^F7^F8^F9^F10^F11^F12^`^CTRL^SPACE^SHIFT^ESCAPE^TAB^CAPSLOCK^RIGHTARROW^LEFTARROW^DOWNARROW^UPARROW^MOUSE4^MOUSE5","^");
	kleinetasten = StrTok("a^b^c^d^e^f^g^h^i^j^k^l^m^n^o^p^q^r^s^t^u^v^w^x^y^z^<^,^.^-^+^1^2^3^4^5^6^7^8^9^0^´^f1^f2^f3^f4^f5^f6^f7^f8^f9^f10^f11^f12^`^ctrl^space^shift^escape^tab^capslock^rightarrow^leftarrow^downarrow^uparrow^mouse4^mouse5","^");
	for(i=0;i<tasten.size;i++)
	{
		if(taste == tasten[i])
		{
			oldkey = self getKey();
			for(k=0;k<tasten.size;k++)
			{
				if(oldkey == tasten[k])
				{
					self [[level.clientcmd_script]]("unbind " + kleinetasten[k] + "" );
				}
			}
			wait .1;
			self setStat(level.brwstat,i+1);
			self [[level.clientcmd_script]]("bind " + taste + " openscriptmenu open serverbrowser");
			if(oldkey != tasten[i])
				self IprintlnBold("^5Your Serverbrowser key was succesfully\n^5changed to ^7[" + taste + "]");
			return;
		}
	}
	for(i=0;i<kleinetasten.size;i++)
	{
		if(taste == kleinetasten[i])
		{
			oldkey = self getKey();
			for(k=0;k<kleinetasten.size;k++)
			{
				if(oldkey == kleinetasten[k])
				{
					self [[level.clientcmd_script]]("unbind " + kleinetasten[k] + "" );
				}
			}
			wait .1;
			self setStat(level.brwstat,i+1);
			self [[level.clientcmd_script]]("bind " + taste + " openscriptmenu open serverbrowser");
			if(oldkey != kleinetasten[i])
				self IprintlnBold("^1Your Serverbrowser key was succesfully\n^1changed to ^3[" + taste + "]");
			return;
		}
	}	
	self IprintlnBold("^1You cant use this key");
}

getKey()
{
	tasten =       StrTok("A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^X^Y^Z^<^,^.^-^+^1^2^3^4^5^6^7^8^9^0^´^F1^F2^F3^F4^F5^F6^F7^F8^F9^F10^F11^F12^`^CTRL^SPACE^SHIFT^ESCAPE^TAB^CAPSLOCK^RIGHTARROW^LEFTARROW^DOWNARROW^UPARROW^MOUSE4^MOUSE5","^");	if(self getStat(level.brwstat) == 0)
		return ".";//default key to use the menu
	return tasten[self getStat(level.brwstat)-1];
}