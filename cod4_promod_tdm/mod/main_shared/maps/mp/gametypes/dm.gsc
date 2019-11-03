main()
{
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::SetupCallbacks();
	maps\mp\gametypes\_globallogic::SetupCallbacks();
	level.onStartGameType=::onStartGameType;
	level.onSpawnPlayer=::onSpawnPlayer;
}
onStartGameType()
{
	setClientNameMode("auto_change");
	maps\mp\gametypes\_globallogic::setObjectiveText("allies",&"OBJECTIVES_DM");
	maps\mp\gametypes\_globallogic::setObjectiveText("axis",&"OBJECTIVES_DM");
	maps\mp\gametypes\_globallogic::setObjectiveScoreText("allies",&"OBJECTIVES_DM_SCORE");
	maps\mp\gametypes\_globallogic::setObjectiveScoreText("axis",&"OBJECTIVES_DM_SCORE");
	maps\mp\gametypes\_globallogic::setObjectiveHintText("allies",&"OBJECTIVES_DM_HINT");
	maps\mp\gametypes\_globallogic::setObjectiveHintText("axis",&"OBJECTIVES_DM_HINT");
	level.spawnMins=(0,0,0);
	level.spawnMaxs=(0,0,0);
	maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies","mp_dm_spawn");
	maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis","mp_dm_spawn");
	level.mapCenter=maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins,level.spawnMaxs);
	setMapCenter(level.mapCenter);
	allowed[0]="dm";
	maps\mp\gametypes\_gameobjects::main(allowed);
	level.displayRoundEndText=false;
	level.QuickMessageToAll=true;
	if(level.roundLimit!=1&&level.numLives)
	{
		level.overridePlayerScore=true;
		level.displayRoundEndText=true;
		level.onEndGame=::onEndGame;
	}
}
onSpawnPlayer()
{
	spawnPoints=maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(self.pers["team"]);
	spawnPoint=maps\mp\gametypes\_spawnlogic::getSpawnpoint_DM(spawnPoints);
	self spawn(spawnPoint.origin,spawnPoint.angles);
	self thread intoSpawn(spawnpoint.origin, spawnpoint.angles);
}
onEndGame(winningPlayer)
{
	if(isDefined(winningPlayer))[[level._setPlayerScore]](winningPlayer,winningPlayer[[level._getPlayerScore]]()+1);
}

intoSpawn(originA, anglesA)
{
	roundspl = self getStat(3132);
	if(isDefined(self.pers["gotani"]))
		return;
	self.pers["gotani"] = true;
	self playLocalSound( "ui_camera_whoosh_in" );
	wait 0.1;
	self freezeControls( true );
	zoomHeight = 6500;
	slamzoom = true;
	self.origin = originA + ( 0, 0, zoomHeight );
	ent = spawn( "script_model", self.origin );
	self thread ispawnang(ent);
	ent.angles = anglesA;
	ent setmodel( "tag_origin" );
	self linkto( ent );
	ent.angles = ( ent.angles[ 0 ] + 89, ent.angles[ 1 ], ent.angles[ 2 ] );
	ent moveto ( originA + (0,0,0), 2, 0, 2 );
	wait ( 1.00 );
	wait( 0.6 );
	ent rotateto( ( ent.angles[ 0 ] - 89, ent.angles[ 1 ], ent.angles[ 2 ]  ), 0.5, 0.3, 0.2 );
	wait ( 0.5 );
	wait( 0.1 );
	self unlink();
	ent delete();
	self freezeControls( false );
	if (roundspl==0)
	{
		//self iPrintlnbold("^2Have Fun");
		//self playLocalSound("welcome");
	}
}

ispawnang(ent){
	//self setClientDvars ("ui_hud_hardcore", 1);
	while(isDefined(ent)){
	self SetPlayerAngles( ent.angles );
	wait 0.05;
	}
	//self setClientDvars ("ui_hud_hardcore", 0);
}