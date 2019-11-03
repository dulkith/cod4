init()
{
  // We're in the server init routine. Do stuff before the game starts.
  SetupDvars();
  Precache();

  // The server may move on now so we thread the rest.
  thread StartThreads();
}

SetupDvars()
{
  if (getdvar("b3_tracers") == "")
    setdvar("b3_tracers", "5");
  level.b3_tracers = getdvarint("b3_tracers");

  if (getdvar("b3_flakfx") == "")
    setdvar("b3_flakfx", "10");
  level.b3_flakfx = getdvarint("b3_flakfx");

  if (getdvar("b3_tracersdelaymin") == "")
    setdvar("b3_tracersdelaymin", "10");
  level.b3_tracersdelaymin = getdvarint("b3_tracersdelaymin");

  if (getdvar("b3_tracersdelaymax") == "")
    setdvar("b3_tracersdelaymax", "15");
  level.b3_tracersdelaymax = getdvarint("b3_tracersdelaymax");

  if (getdvar("b3_tracers_sound") == "")
    setdvar("b3_tracers_sound", "1");
  level.b3_tracers_sound = getdvarint("b3_tracers_sound");

  if (getdvar("b3_flakfxdelaymin") == "")
    setdvar("b3_flakfxdelaymin", "120");
  level.b3_flakfxdelaymin = getdvarint("b3_flakfxdelaymin");

  if (getdvar("b3_flakfxdelaymax") == "")
    setdvar("b3_flakfxdelaymax", "130");
  level.b3_flakfxdelaymax = getdvarint("b3_flakfxdelaymax");
}

PreCache()
{
	if(level.b3_flakfx >=1)
	{
		// flak fx
		level.b3_effect["flak_smoke"]	= loadfx("fx/explosions/flak_puff.efx");
		level.b3_effect["flak_flash"]	= loadfx("fx/explosions/default_explosion.efx");
		level.b3_effect["flak_dust"]	= loadfx("fx/dust/flak_dust_blowback.efx");
	}

	if(level.b3_tracers >= 1)
    level.b3_effect["tracer"] = loadfx("fx/misc/antiair_tracers.efx");
}

StartThreads()
{
  wait .05;
  level endon("trm_killthreads");
  
  GetMapDim();
  GetFieldDim();

  // tracers
	if(level.b3_tracers >= 1)
    for(tracers=0;tracers<level.b3_tracers;tracers++)
      level thread tracers();

	// flak fx	
	if(level.b3_flakfx >=1)
    for(flak=0;flak<level.b3_flakfx;flak++)
      level thread flakfx();
}

//------Threads and Functions---------------------------------------------------


tracers()
{
	level endon("trm_killthreads");

	ix = 0;
	iy = 0;
	iz = 0;

	wait randomInt(20) + 5;

	while(1)
	{
		delay = level.b3_tracersdelaymin + randomint(level.b3_tracersdelaymax - level.b3_tracersdelaymin);
		if(level.b3_flakison) delay = randomInt(2) + 1;
		wait delay;

		iSide = randomInt(4);
		switch (iSide)
		{
			case 0:
				ix = level.b3_mapArea_Min[0];
				iy = level.b3_mapArea_Min[1] + randomInt(int(level.b3_mapArea_Max[1] - level.b3_mapArea_Min[1]));
				break;
			case 1:
				ix = level.b3_mapArea_Max[0];
				iy = level.b3_mapArea_Min[1] + randomInt(int(level.b3_mapArea_Max[1] - level.b3_mapArea_Min[1]));
				break;
			case 2:
				ix = level.b3_mapArea_Min[0] + randomInt(int(level.b3_mapArea_Max[0] - level.b3_mapArea_Min[0]));
				iy = level.b3_mapArea_Min[1];
				break;
			case 3:
				ix = level.b3_mapArea_Min[0] + randomInt(int(level.b3_mapArea_Max[0] - level.b3_mapArea_Min[0]));
				iy = level.b3_mapArea_Max[1];
				break;
		}
			
		//set the height as the spawnpoint level - 100
		spawnpoints = getentarray("mp_dm_spawn", "classname");
		if(!spawnpoints.size) spawnpoints = getentarray("mp_tdm_spawn", "classname");
		if(!spawnpoints.size) spawnpoints = getentarray("mp_ctf_spawn_allied", "classname");
		if(!spawnpoints.size) spawnpoints = getentarray("mp_ctf_spawn_axis", "classname");
		if(!spawnpoints.size) spawnpoints = getentarray("mp_sd_spawn_attacker", "classname");
		if(!spawnpoints.size) spawnpoints = getentarray("mp_sd_spawn_defender", "classname");
		iz = spawnpoints[0].origin[2] - 100;

		pos = (ix, iy, iz);

		if(level.b3_tracers_sound)
		{
			tracer = spawn( "script_model", pos);
			wait 0.05;
			tracer playSound("tracer_fire");
			wait 0.5;
			playfx(level.b3_effect["tracer"], pos);
			wait 3;
			tracer delete();
		}
		else playfx(level.b3_effect["tracer"], pos);
	}
}

flakfx()
{
	level endon("trm_killthreads");
	level endon("stop_flak");
	level.b3_flakison = true;

	while(level.b3_flakison)
	{
		// wait a random delay
		delay = level.b3_flakfxdelaymin + randomint(level.b3_flakfxdelaymax - level.b3_flakfxdelaymin);
		wait delay;

		// spawn object that is used to play sound
		flak = spawn ( "script_model", ( 0, 0, 0) );

		//get a random position
		xpos = level.b3_playArea_Min[0] + randomInt(level.b3_playArea_Width);
		ypos = level.b3_playArea_Min[1] + randomInt(level.b3_playArea_Length);
		zpos = level.b3_mapArea_Max[2] - randomInt(100);	

		position = ( xpos, ypos, zpos);

		flak.origin = position;
		wait .05;
		
		// play effect
		flak playsound("flak_explosion");

		playfx(level.b3_effect["flak_flash"], position);
		wait 0.25;
		playfx(level.b3_effect["flak_smoke"], position);
		wait 0.25;
		playfx(level.b3_effect["flak_dust"], position);
		wait 0.25;

		flak delete();
	}
}

GetMapDim()
{
	entitytypes = getentarray();

	xMax = -30000;
	xMin = 30000;

	yMax = -30000;
	yMin = 30000;

	zMax = -30000;
	zMin = 30000;

	xMin_e[0] = xMax;
	yMin_e[1] = yMax;
	zMin_e[2] = zMax;

	xMax_e[0] = xMin;
	yMax_e[1] = yMin;
	zMax_e[2] = zMin;       

	for(i = 1; i < entitytypes.size; i++)
	{
		trace = bulletTrace(entitytypes[i].origin, entitytypes[i].origin - (30000,0,0),false,undefined);
		if(trace["fraction"] != 1)  xMin_e  = trace["position"];

		trace = bulletTrace(entitytypes[i].origin, entitytypes[i].origin + (30000,0,0),false,undefined);
		if(trace["fraction"] != 1)  xMax_e  = trace["position"];

		trace = bulletTrace(entitytypes[i].origin, entitytypes[i].origin - (0,30000,0),false,undefined);
		if(trace["fraction"] != 1)  yMin_e  = trace["position"];

		trace = bulletTrace(entitytypes[i].origin, entitytypes[i].origin + (0,30000,0),false,undefined);
		if(trace["fraction"] != 1)  yMax_e  = trace["position"];

		trace = bulletTrace(entitytypes[i].origin, entitytypes[i].origin - (0,0,30000),false,undefined);
		if(trace["fraction"] != 1)  zMin_e  = trace["position"];

		trace = bulletTrace(entitytypes[i].origin, entitytypes[i].origin + (0,0,30000),false,undefined);
		if(trace["fraction"] != 1)  zMax_e  = trace["position"];

		if (xMin_e[0] < xMin)   xMin = xMin_e[0];
		if (yMin_e[1] < yMin)   yMin = yMin_e[1];
		if (zMin_e[2] < zMin)   zMin = zMin_e[2];

		if (xMax_e[0] > xMax)   xMax = xMax_e[0];
		if (yMax_e[1] > yMax)   yMax = yMax_e[1];
		if (zMax_e[2] > zMax)   zMax = zMax_e[2];       

		wait 0.05;
	}

	level.b3_mapArea_CentreX = int(xMax + xMin)/2;
	level.b3_mapArea_CentreY = int(yMax + yMin)/2;
	level.b3_mapArea_CentreZ = int(zMax + zMin)/2;
	level.b3_mapArea_Centre = (level.b3_mapArea_CentreX, level.b3_mapArea_CentreY, level.b3_mapArea_CentreZ);

	level.b3_mapArea_Max = (xMax, yMax, zMax);
	level.b3_mapArea_Min = (xMin, yMin, zMin);

	level.b3_mapArea_Width = int(distance((xMin,yMin,zMax),(xMax,yMin,zMax)));
	level.b3_mapArea_Length = int(distance((xMin,yMin,zMax),(xMin,yMax,zMax)));

	// Special Z coords for mp_carentan, mp_decoy, mp_railyard, mp_toujane
	level.b3_mapArea_PlaneZ = int(zMax + zMin)/1.35;

	entitytypes = [];
	entitytypes = undefined;
}

GetFieldDim()
{
	spawnpoints = [];

	spawnpoints_s1 = getentarray("mp_dm_spawn", "classname");
	spawnpoints_s2 = getentarray("mp_tdm_spawn", "classname");
	spawnpoints_s3 = getentarray("mp_ctf_spawn_allied", "classname");
	spawnpoints_s4 = getentarray("mp_ctf_spawn_axis", "classname");
	spawnpoints_s5 = getentarray("mp_sd_spawn_attacker", "classname");
	spawnpoints_s6 = getentarray("mp_sd_spawn_defender", "classname");

	for(i=0;i<spawnpoints_s1.size;i++) spawnpoints = maps\mp\gametypes\_spawnlogic::add_to_array(spawnpoints, spawnpoints_s1[i]);
	for(i=0;i<spawnpoints_s2.size;i++) spawnpoints = maps\mp\gametypes\_spawnlogic::add_to_array(spawnpoints, spawnpoints_s2[i]);
	for(i=0;i<spawnpoints_s3.size;i++) spawnpoints = maps\mp\gametypes\_spawnlogic::add_to_array(spawnpoints, spawnpoints_s3[i]);
	for(i=0;i<spawnpoints_s4.size;i++) spawnpoints = maps\mp\gametypes\_spawnlogic::add_to_array(spawnpoints, spawnpoints_s4[i]);
	for(i=0;i<spawnpoints_s5.size;i++) spawnpoints = maps\mp\gametypes\_spawnlogic::add_to_array(spawnpoints, spawnpoints_s5[i]);
	for(i=0;i<spawnpoints_s6.size;i++) spawnpoints = maps\mp\gametypes\_spawnlogic::add_to_array(spawnpoints, spawnpoints_s6[i]);

	xMax = spawnpoints[0].origin[0];
	xMin = spawnpoints[0].origin[0];

	yMax = spawnpoints[0].origin[1];
	yMin = spawnpoints[0].origin[1];

	zMax = spawnpoints[0].origin[2];
	zMin = spawnpoints[0].origin[2];

	for(i=1;i<spawnpoints.size;i++)
	{
		if (spawnpoints[i].origin[0] > xMax)     xMax = spawnpoints[i].origin[0];
		if (spawnpoints[i].origin[1] > yMax)     yMax = spawnpoints[i].origin[1];
		if (spawnpoints[i].origin[2] > zMax)     zMax = spawnpoints[i].origin[2];
		if (spawnpoints[i].origin[0] < xMin)     xMin = spawnpoints[i].origin[0];
		if (spawnpoints[i].origin[1] < yMin)     yMin = spawnpoints[i].origin[1];
		if (spawnpoints[i].origin[2] < zMin)     zMin = spawnpoints[i].origin[2];
	}

	level.b3_playArea_CentreX = int(int(xMax + xMin)/2);
	level.b3_playArea_CentreY = int(int(yMax + yMin)/2);
	level.b3_playArea_CentreZ = int(int(zMax + zMin)/2);
	level.b3_playArea_Centre = (level.b3_playArea_CentreX, level.b3_playArea_CentreY, level.b3_playArea_CentreZ);

	level.b3_playArea_Min = (xMin, yMin, zMin);
	level.b3_playArea_Max = (xMax, yMax, zMax);

	level.b3_playArea_Width = int(distance((xMin, yMin, 800),(xMax, yMin, 800)));
	level.b3_playArea_Length = int(distance((xMin, yMin, 800),(xMin, yMax, 800)));
}

