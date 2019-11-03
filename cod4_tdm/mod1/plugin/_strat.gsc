/*
	Maybe add some *fancy* animation for strat timer?
*/
#include maps\mp\gametypes\_hud_util;
#include plugin\_utils;

init()
{
	level.strat_over = false;
}

stratTime()
{
	level endon("game_ended");
	level endon("strat_over");
	
	if ( level.inPrematchPeriod )
		level waittill( "prematch_over" );

	level.strat_over = false;
	thread maps\mp\gametypes\_globallogic::pauseTimer();

	thread stratTimer();
	
	wait 5;
	
	level.strat_over = true;
	thread maps\mp\gametypes\_globallogic::resumeTimer();
	level notify("strat_over");
}

stratTimer()
{
	level endon("game_ended");

	matchStartText = createServerFontString("objective",1.5);
	matchStartText setPoint("CENTER","CENTER",0,-60);
	matchStartText.sort=1001;
	matchStartText setText("^3[SL^2e^3SPORT] ^1Gaming Starting ^3WaiT");
	matchStartText.foreground=false;
	matchStartText.hidewheninmenu=false;

	matchStartTimer = createServerTimer("objective",1.4);
	matchStartTimer setPoint("CENTER","CENTER",0,-45);
	matchStartTimer setTimer(5);
	matchStartTimer.sort=1001;
	matchStartTimer.foreground=false;
	matchStartTimer.hideWhenInMenu=false;
	
	level waittill("strat_over");
	
	if(isDefined(matchStartText))
		matchStartText destroy();
	if(isDefined(matchStartTimer))
		matchStartTimer destroy();
}

freezePlayer()
{
	self endon("game_ended");
	self endon("disconnect");
	self endon("freeze_over");
	
	if ( level.inPrematchPeriod )
		level waittill( "prematch_over" );
	
	if(getDvar("g_gametype") != "sd")
		return;
		
	reset = false;
	
	if(!level.strat_over)
	{
		self disableWeapons();
		self AllowSprint(false);
		self SetMoveSpeedScale( 0 );
		self AllowJump(false);
		reset = true;
	}
	
	
	level waittill("strat_over");
	
	if(level.strat_over && reset)
	{
		self enableWeapons();
		self AllowSprint(true);
		self makeSpeed();
		self AllowJump(true);
		reset = false;
	}
	else  // TDM will have different move speed so we need to adjust for SD
	{
		self makeSpeed();
	}
	
	self notify("freeze_over");
}