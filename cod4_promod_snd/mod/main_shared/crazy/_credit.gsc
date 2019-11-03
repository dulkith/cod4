#include crazy\_utils;
#include maps\mp\_utility;
#include common_scripts\utility;

settings()
{
	players = getPlayers();
	sLoc = getLoc();
	sAng = getAng();
	
	wait .25;
	
	for( i = 0; i < players.size; i++ )
	{
		player = players[i];
		
		player spawnSpec( sLoc, sAng );
		player freezeControls( true );
	}
	
	thread endFX(sLoc, sAng);
	
	main();
}

callStrike_planeSound_credit( plane, bombsite )
{
	plane thread maps\mp\gametypes\_hardpoints::play_loop_sound_on_entity( "veh_mig29_dist_loop" );
	while( !maps\mp\gametypes\_hardpoints::targetisclose( plane, bombsite ) )
		wait .01;
	plane notify ( "stop sound" + "veh_mig29_dist_loop" );
	plane thread maps\mp\gametypes\_hardpoints::play_loop_sound_on_entity( "veh_mig29_close_loop" );
	while( maps\mp\gametypes\_hardpoints::targetisinfront( plane, bombsite ) )
		wait .01;
	wait .25;
	plane thread playSoundinSpace( "veh_mig29_sonic_boom", bombsite );
	while( maps\mp\gametypes\_hardpoints::targetisclose( plane, bombsite ) )
		wait .01;
	plane notify ( "stop sound" + "veh_mig29_close_loop" );
	plane thread maps\mp\gametypes\_hardpoints::play_loop_sound_on_entity( "veh_mig29_dist_loop" );
	plane waittill("del");
	plane notify ( "stop sound" + "veh_mig29_dist_loop" );
}

endFX(sLoc, sAng)
{
	for(w=0;w<3;w++)
	{
		wait .01;
		for(i=0;i<4;i++)
		{
			level.airplane[w][i] = spawn("script_model", sLoc + vector_scale( anglesToForward( sAng ), 15000 ) + vector_scale( anglesToUp( sAng ), 500 ) + (i*600*pow(-1,i), 0, 0));
			level.airplane[w][i] setModel("vehicle_mig29_desert");
			angles = VectorToAngles(sLoc - level.airplane[w][i].origin);
			level.airplane[w][i].angles = angles;
			level.airplane[w][i] thread maps\mp\gametypes\_hardpoints::playPlaneFx();
			thread callStrike_planeSound_credit(level.airplane[w][i], sLoc);
		}
		
		wait .05;
		
		for(i=0;i<level.airplane.size;i++)
		{
			wait 0.01;
			level.airplane[w][i] moveto( sLoc + vector_scale( anglesToUp( sAng ), 300 ) - vector_scale( anglesToForward( sAng ), 5000 ) + (i*600*pow(-1,i), 0, 0), 4);
			level.airplane[w][i] thread finish();
		}
		
		wait 1.5;
	}
}


finish()
{
	wait 3.8;
	self notify("del");
	wait .2;
	self delete();
}

main()
{
	level.creditTime = 8;

	crazy\_utils::cleanScreen();

	thread showCredit( "Thank you for playing ^3SL^2e^3SPORT ^7softcore ^4V 1.5", 2.4 );
	wait 0.5;
    thread showCredit( "Powered by ^1Down South Gamers ^0- ^7Sri Lanka", 1.8 );
	wait 0.5;
    thread showCredit( "^0<<< ^1API DAKUNE ^0>>> ", 1.8 );
    wait 0.5;
    thread showCredit( "(C)2K16", 1.8 );

	thread fadeOut();
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
	end_text.glowColor = (0.88627, 0.40321, 0.16078);
	end_text.glowAlpha = 1;
	end_text moveOverTime(level.creditTime);
	end_text.y = -60;
	end_text.foreground = true;
	wait level.creditTime;
	end_text destroy();
}

fadeOut()
{
	wait level.creditTime + 0.5;
	level.outblack = newHudElem();
	level.outblack.x = 0;
	level.outblack.y = 0;
	level.outblack.horzAlign = "fullscreen";
	level.outblack.vertAlign = "fullscreen";
	level.outblack.foreground = false;
	level.outblack setShader("white", 640, 480);
	level.outblack.alpha = 0;
		
	level.outblack fadeOverTime(1.5);
	level.outblack.alpha = 1;
}
