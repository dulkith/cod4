
main()
{
	level.creditTime = 6;

	braxi\_common::cleanScreen();

	thread showCredit( "Server Owner:", 2.4 );
	wait 0.5;
	thread showCredit( "eQuilibrium-Gamers Community", 1.8 );
	wait 2.2;
	thread showCredit( "Do you want to be an administrator?", 2.4 );
	wait 0.5;
	thread showCredit( "Leave your comment at www^1.^7eQGamers^1.^7com", 2.4 );
	
	if( level.dvar["lastmessage"] != "" )
	{
		wait 0.8;
		thread showCredit( level.dvar["lastmessage"], 2.4 );
	}

	wait level.creditTime + 2;
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
	end_text.glowColor = (0.0, 0.0, 1.0);
	end_text.glowAlpha = 1;
	end_text moveOverTime(level.creditTime);
	end_text.y = -60;
	end_text.foreground = true;
	wait level.creditTime;
	end_text destroy();
}


neon()
{
	neon = addNeon( "You're playing Braxis Death Run, ^5v 1.2a ^7- Moded by Blabla, leave comment at www^1.^7eQGamers^1.^7com", 1.4 );
	while( 1 )
	{
		neon moveOverTime( 12 );
		neon.x = 800;
		wait 10;
		neon moveOverTime( 12 );
		neon.x = -800;
		wait 10;
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