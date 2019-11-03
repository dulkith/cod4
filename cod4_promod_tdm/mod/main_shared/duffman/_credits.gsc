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

main()
{
	level.creditTime = 6;

	duffman\_common::cleanScreen();

	thread showCredit( "^3Server Owner:", 2.7 );
	wait 0.5;
	thread showCredit( "^8|^5wG^8|.^4KING N A V Y^1/^3NADU", 2.4 );
	wait 0.5;
	thread showCredit( "", 1.4 );
	wait 0.5;
	thread showCredit( "^3Head Admin:", 2.7 );
	wait 0.5;
	thread showCredit( "^9|^3SL^9|.^4MaXMeN ^3- ^3(^9100^3)", 1.8 );
	wait 0.5;
	thread showCredit( "^8|^5wG^8|.^4OZO[Z] ^3- ^3(^9100^3)", 1.8 );
	wait 0.5;
	thread showCredit( "^8|^5wG^8|.^4Ishi ^3- ^3(^9100^3)", 1.8 );
	wait 0.5;
	thread showCredit( "^8|^5SLK^8|.^4Demo ^3- ^3(^9100^3)", 1.8 );
	wait 0.5;
	thread showCredit( "", 1.4 );
	wait 0.5;
	thread showCredit( "^3Other Admins:", 2.7 );
	wait 0.5;
	thread showCredit( " ^9|^3SL^9| ^4STUMP ^3- ^180       ^9|^3SL^9| ^4(|L|A|N|Z|[NIMA] ^3- ^260   ^9|^3SL^9| ^4DoSootie_:3 ^3- ^340", 1.8 );
	wait 0.5;
	thread showCredit( " ^9|^3SL^9|  ^4Mr.Junda ^3- ^340   ^9|^3SL^9| ^4BUGXX 14.0 ^3- ^340         ^9|^3SL^9| ^4PUTTU 3 ^3- ^340", 1.8 );
	wait 0.5;
	thread showCredit( " ^9|^3SL^9|  ^4Sun 1st ^3- ^420    ^9|^3SL^9| ^4Froz ^3- ^420               ^9|^3SL^9| ^4Noob Sl ^3- ^420", 1.8 );
	wait 0.5;
	thread showCredit( "", 1.4 );
	wait 0.5;
	thread showCredit( "^2Server Hosted by", 2.7 );
	wait 0.5;
	thread showCredit( "^4RsHost |+94776993330|", 2.0 );
	wait 0.5;
	thread showCredit( "", 1.4 );
	wait 0.5;
	thread showCredit( "^2Additional Help:", 2.7 );
	wait 0.5;
	thread showCredit( "^3MOD by ^8|^5SLK^8|.^4$anjeewan", 1.8 );
	wait 0.5;
	thread showCredit( "^3Develope By^8|^5wG^8|.^4KING N A V Y^1", 1.8 );
	wait 0.5;
	thread showCredit( "^3Hosted By ^8|^5wG^8|.^4IsHi", 1.8 );
	wait 0.5;
	thread showCredit( "", 1.4 );
	wait 0.5;
	thread showCredit( "^3Thanks for playing  ^9|^3SL^9|^5Gaming ^1S&D ^6Promod Sri Lanka ^3v3.0^7!", 2.4 );
	wait 0.5;
	thread showCredit( "^2Perpare For ^3Next map", 2.7 );
	wait 0.5;
	thread showCredit( "------------------------------------------------------------------------------", 1.6 );
	wait 0.5;
	thread showCredit( "^5Open^9|^3SL^9|^5Gaming ^1S&D", 4.6 );
	wait 0.5;
	thread showCredit( "------------------------------------------------------------------------------", 1.6 );
	wait 0.5;	
	thread showCredit( "Ummmmmmmmmmmmmmmmmmmmmmmmma", 3.5 );
	wait 0.5;




	

	
	/*if( level.dvar["lastmessage"] != "" )
	{
		wait 0.8;
		thread showCredit( level.dvar["lastmessage"], 2.4 );
	}*/

	wait level.creditTime + 1;
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
	end_text.sort = -1; //-3
	end_text.alpha = 1;
	end_text.glowColor = (.1,.8,0);
	end_text.glowAlpha = 1;
	end_text moveOverTime(level.creditTime);
	end_text.y = -60;
	end_text.foreground = true;
	wait level.creditTime;
	end_text destroy();
}


neon()
{
	neon = addNeon( "^1www.AfterLifeGaming.net", 1.4 );
	while( 1 )
	{
		neon moveOverTime( 12 );
		neon.x = 800;
		wait 15;
		neon moveOverTime( 12 );
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