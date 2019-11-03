///////////////////////////////////////////////////////////////
////|         |///|        |///|       |/\  \/////  ///|  |////
////|  |////  |///|  |//|  |///|  |/|  |//\  \///  ////|__|////
////|  |////  |///|  |//|  |///|  |/|  |///\  \/  /////////////
////|          |//|  |//|  |///|       |////\    //////|  |////
////|  |////|  |//|         |//|  |/|  |/////    \/////|  |////
////|  |////|  |//|  |///|  |//|  |/|  |////  /\  \////|  |////
////|  |////|  |//|  | //|  |//|  |/|  |///  ///\  \///|  |////
////|__________|//|__|///|__|//|__|/|__|//__/////\__\//|__|////
///////////////////////////////////////////////////////////////
/*
	BraXi's Death Run Mod
	
	Website: www.braxi.org
	E-mail: paulina1295@o2.pl

	[DO NOT COPY WITHOUT PERMISSION]

	showCredit() written by Bipo.
*/

#include duffman\_common;

main()
{
	level thread maps\mp\gametypes\_endroundmusic::playSoundOnAllPlayersX( "HGW_Gameshell_v10" );
	blackscreen = addTextHud( level, 0, 0, 0.5, "center", "middle", "center", "middle", 3, 0 );
	blackscreen thread fadeIn(2);
	blackscreen setShader("white",1000,1000);
	blackscreen.color = (0,0,0);
	
	level.creditTime = 8;
	freezeall();
	duffman\_common::cleanScreen();
	wait 2;
	thread showCredit( "^7We are ^1SLeSPORTS ^2GaMinG ^0- ^7Sri Lanka", 2.7 );
	wait 0.5;
	thread showCredit( "^5Thank you for playing.", 2.4 );
	wait 0.5;
	thread showCredit( "", 1.4 );
	wait 0.5;
	thread showCredit( "^5<<<<<<^1 SERVER ADMINS ^5>>>>>>", 2.7 );
	wait 0.47;
	thread showCredit( "^5<<<<<<^2 FOUNDERS ^5>>>>>>", 2.7 );
	wait 0.42;
	thread showCredit( "^7|SLeS|^0_^1DunHill<3 ^7- Owner/Head Admin", 1.8 );
	wait 0.3;
	thread showCredit( "^7|SLeS|^0_^1Ru[S]ty ^7- Owner/Head Admin", 1.8 );
	wait 0.45;
	thread showCredit( "^5<<<<<<^2 CO-FOUNDERS ^5>>>>>>", 2.7 );
	wait 0.42;
	thread showCredit( "^7|SLeS|^0_^1Asi ^7- Head Admin", 1.8 );
	wait 0.3;
	thread showCredit( "^7|SLeS|^0_^1he[A]!er ^7- Head Admin", 1.8 );
	wait 0.3;
	thread showCredit( "^7|SLeS|^0_^1GooD|Knight ^7- Head Admin", 1.8 );
	wait 0.3;
	thread showCredit( "^7|SLeS|^0_^1LoneWolf ^7- Head Admin", 1.8 );
	wait 0.5;
	thread showCredit( "", 1.4 );
	wait 0.5;
	thread showCredit( "^5<<<<<<^1 Join Our Teamspeak 3 ^5>>>>>>", 2.7 );
	wait 0.5;
	thread showCredit( "^1IP : ^7slescod4.tk", 1.8 );
	wait 0.5;
	thread showCredit( "^2Server Moded ^3By ^5Team SL^1e^5SPORTS", 2.0 );
	wait 0.5;
	thread showCredit( "^4Facebook Group ^0: ^3www.fb.com/groups/slesport/", 1.6 );
	wait 0.5;
	thread showCredit( "^5Visit For More details ^0: ^7www.slescod4.tk", 1.6 );

	self thread addDisplay();
	wait 4;
	
	wait level.creditTime;
}

addDisplay(){
	
	creditAdd = newHudElem();
	creditAdd.font = "objective";
	creditAdd.alignX = "center";
	creditAdd.alignY = "top";
	creditAdd.horzAlign = "center";
	creditAdd.vertAlign = "top";
	creditAdd setShader( "sles_add", 400, 400 );
	creditAdd.x = 0;
	creditAdd.y = 540;
	creditAdd.sort = 2; //-3
	creditAdd.alpha = 1;
	creditAdd moveOverTime(level.creditTime);
	creditAdd.y = 30;
	creditAdd.foreground = true;
	wait level.creditTime;
	wait 5;
	creditAdd destroy();
}


showCredit( text, scale )
{
	end_text = newHudElem();
	end_text.font = "objective";
	end_text.fontScale = scale;
	end_text SetText(text);
	end_text.alignX = "center";
	end_text.alignY = "top";
	end_text.horzAlign = "center";
	end_text.vertAlign = "top";
	end_text.x = 0;
	end_text.y = 540;
	end_text.sort = 3; //-3
	end_text.alpha = 1;
	end_text.glowColor = (0.5,0.1,0.8);
	end_text.glowAlpha = 1;
	end_text moveOverTime(level.creditTime);
	end_text.y = -60;
	end_text.foreground = true;
	wait level.creditTime;
	end_text destroy();
}


neon()
{
	neon = addNeon( "^1www^0.slescod4^0.^1tk", 1.4 );
	while( 1 )
	{
		neon moveOverTime( 8 );
		neon.x = 800;
		wait 15;
		neon moveOverTime( 8 );
		neon.x = -800;
		wait 15;
	}
}

addNeon( text, scale )
{
	end_text = newHudElem();
	end_text.font = "objective";
	end_text.fontScale = scale;
	end_text SetText(text);
	end_text.alignX = "center";
	end_text.alignY = "top";
	end_text.horzAlign = "center";
	end_text.vertAlign = "top";
	end_text.x = -200;
	end_text.y = 8;
	end_text.sort = -1; //-3
	end_text.alpha = 1;
	//end_text.glowColor = (1,0,0.1);
	//end_text.glowAlpha = 1;
	end_text.foreground = true;
	return end_text;
}

freezeall()
{
	for(i=0;i<level.players.size;i++)
		level.players[i] freezecontrols(true);
}