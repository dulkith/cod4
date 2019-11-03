init()
{
  // We're in the server init routine. Do stuff before the game starts.
  Precache();

  // The server may move on now so we thread the rest.
  thread SetupDvars();
  thread StartThreads();
}

PreCache()
{
  PrecacheHeadIcon("talkingicon");
}

SetupDvars()
{
  if (getdvar("b3_warns") == "")
    setdvar("b3_warns", "1");
  level.b3_warns = getdvarint("b3_warns");
  
  //Check for Amok Nade Delay Mod!
  if (getdvar("amok_nadedelay") == "")
    level.wait_amok_nadedelay = .01;
  else
    level.wait_amok_nadedelay = getdvarint("amok_nadedelay");
}

StartThreads()
{
	if (level.b3_warns < 1)
		return;

  wait .05;
  level endon("trm_killthreads");

  thread onPlayerConnect();
}

//------Threads and Functions---------------------------------------------------
onPlayerConnect()
{
  level endon("trm_killthreads");

  for(;;)
  {
    level waittill("connecting", player);
    if(level.b3_debug == true)
      iprintln("Debug (WARNS): Player Connected...");
    player thread onPlayerSpawned();
  }
}

onPlayerSpawned()
{
  self endon("disconnect");

  for(;;)
  {
    self waittill("spawned_player");
    
    if(level.b3_debug == true)
      iprintln("Debug (WARNS): Player Spawned...");

    // Enable the voicecommand/taunts
    self.spamdelay = undefined;
    
    // Wait for the Amok Nadedelay Mod!
    wait level.wait_amok_nadedelay;

    // Give us time to deploy the nades
    wait .5;

    // Since we've been waiting, lets see if we're still alive
    if(isPlayer(self) && self.sessionstate == "playing")
    {
      // What nades are we talking about here?
      self defGrenades();
      // Start the monitorthread
      self thread grenademonitor();
    }
  }
}

//------Warnings----------------------------------------------------------------
grenadeMonitor()
{
	self endon("disconnect");
	self endon("killed_player");
  level endon("intermission");
  level endon("trm_killthreads");

	for(;;)
	{
		grenadetype = undefined;

		// how many of each grenade do they have?
		frags = self getammocount(self.pers["fragtype"]) + self getammocount(self.pers["enemy_fragtype"]);
		smokes = self getammocount(self.pers["smoketype"]) + self getammocount(self.pers["enemy_smoketype"]);

		while(isPlayer(self) && self.sessionstate == "playing")
		{
			wait 0.05;
	
			// how many of each grenade do they have now?
			frags_check = self getammocount(self.pers["fragtype"]) + self getammocount(self.pers["enemy_fragtype"]);
			smokes_check = self getammocount(self.pers["smoketype"]) + self getammocount(self.pers["enemy_smoketype"]);				
	
			// player may have thrown both!, so no else here....
			if(frags_check < frags)
			{
				self thread quickwarning("frag", 480, true, true);
				frags = frags_check;
			}
			else frags = frags_check;
	
			if(smokes_check < smokes)
			{
				self thread quickwarning("smoke", 480, true, true);
				smokes = smokes_check;
			}
			else smokes = smokes_check;
		}
		
		wait 0.05;
	}
}

quickwarning(warning, range, selfteam, enemyteam)
{
	self endon("disconnect");

	if(!isDefined(self.pers["team"]) || self.pers["team"] == "spectator" || isDefined(self.spamdelay) || !isDefined(warning))
		return;

	prefix1 = undefined;
	prefix2 = undefined;
	soundalias1 = undefined;
	soundalias2 = undefined;
	enemy = undefined;

	if(selfteam)
	{
		if(!isDefined(range)) range = 240; // 20ft
	
		// team mate near?
		inrange1 = self friendlyInRange(range);
		inrange2 = self friendlyInRangeView(range);
	
		if(self.pers["team"] == "allies")
		{
			switch(game["allies"])
			{
				case "american":
				prefix1 = "US_";
				break;
		
				case "british":
				prefix1 = "UK_";
				break;

				default:
				prefix1 = "RU_";
				break;
			}
		}
		else prefix1 = "GE_";

		rand = randomInt(3);

		if(inrange1 || isPlayer(inrange2))
		{
			if(warning == "frag") soundalias1 = prefix1 + rand + "_inform_attacking_grenade";

			self.spamdelay = true;
			self doQuickMessage(soundalias1, undefined, false);
			wait 1;
			self.spamdelay = undefined;
		}
	}
	else wait 1;

	if(isPlayer(self) && enemyteam)
	{
		rand = randomInt(3);

		// enemy near?
		inrange3 = self enemyInRangeView(range);
	
		if(randomInt(100) < 50) // 50% chance that enemy will warn their team
		{
			if(isPlayer(inrange3) || isDefined(self.b3_targetwarn))
			{
				if(isDefined(self.b3_targetwarn)) enemy = self.b3_targetwarn;
				else enemy = inrange3;
		
				if(isPlayer(enemy) && enemy.pers["team"] == "allies")
				{
					switch(game["allies"])
					{
						case "american":
						prefix2 = "US_";
						break;
			
						case "british":
						prefix2 = "UK_";
						break;
			
						default:
						prefix2 = "RU_";
						break;
					}
				}
				else prefix2 = "GE_";
		
				if(warning == "frag") soundalias2 = prefix2 + rand + "_inform_incoming_grenade";
				if(warning == "smoke") soundalias2 = prefix2 + rand + "_inform_incoming_smokegrenade";

				if(isPlayer(enemy))
				{		
					enemy.spamdelay = true;
					enemy doQuickMessage(soundalias2, undefined, false);
					wait 1;
					enemy.spamdelay = undefined;
				}
				else wait 1;
			}
		}
	}
	else wait 1;

  //if(isPlayer(self)) self.spamdelay = undefined;
	//if(isDefined(enemy) && !isPlayer(enemy)) enemy.spamdelay = undefined;
}

doQuickMessage(soundalias, saytext, changeicon)
{
	if(!isDefined(changeicon)) changeicon = true;

	if(self.sessionstate != "playing") return;

	if(isDefined(level.QuickMessageToAll) && level.QuickMessageToAll)
	{
		if(changeicon)
		{
			self.headiconteam = "none";
			self.headicon = "talkingicon";
		}

		if(isDefined(soundalias)) self playSound(soundalias);
		if(isDefined(saytext)) self sayAll(saytext);
	}
	else
	{
		if(changeicon)
		{
			if(self.sessionteam == "allies") self.headiconteam = "allies";
			else if(self.sessionteam == "axis") self.headiconteam = "axis";
		
			self.headicon = "talkingicon";
		}

		if(isDefined(soundalias)) self playSound(soundalias);
		if(isDefined(saytext)) self sayTeam(saytext);
		self pingPlayer();
	}
}

friendlyInRange(range)
{
	if(!range) return true;

	// Get all players and pick out the ones that are playing and are in the same team
	players = [];
	aplayers = getentarray("player", "classname");
	for(i = 0; i < aplayers.size; i++)
	{
		if(isDefined(aplayers[i]) && aplayers[i].sessionstate == "playing" && aplayers[i].pers["team"] == self.pers["team"])
				players[players.size] = aplayers[i];
	}

	// Get the players that are in range
	sortedplayers = sortByDist(players, self);

	// Need at least 2 players (myself + one team mate)
	if(sortedplayers.size<2) return false;

	// First player will be myself so check against second player
	distance = distance(self.origin, sortedplayers[1].origin);

	if(distance <= range) return true;
	else return false;
}

friendlyInRangeView(range)
{
	if(!range) return false;

	targetpos = self getTargetPos(range);

	if(!isDefined(targetpos)) return false;

	// Get all players and pick out the ones that are playing and are in the same team
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if(isPlayer(self) && isPlayer(players[i]))
		{
			if(players[i].sessionstate == "playing" && players[i].pers["team"] == self.pers["team"])
			{
				if(distance(targetPos, players[i].origin) <= range * 4)
					return players[i];
			}
		}
	}

	return false;
}

enemyInRange(range)
{
	if(!range) return true;

	// Get all players and pick out the ones that are playing and are in the same team
	players = [];
	aplayers = getentarray("player", "classname");
	for(i = 0; i < aplayers.size; i++)
	{
		if(isDefined(aplayers[i]))
			if(aplayers[i].sessionstate == "playing" && aplayers[i].pers["team"] != self.pers["team"])
				players[players.size] = aplayers[i];
	}

	// Get the players that are in range
	sortedplayers = sortByDist(players, self);

	// Need at least 2 players (myself + one team mate)
	if(sortedplayers.size<2) return false;

	// First player will be myself so check against second player
	distance = distance(self.origin, sortedplayers[1].origin);

	self.b3_targetwarn = sortedplayers[1];

	if(distance <= range) return true;
	else return false;
}

enemyInRangeView(range)
{
	if(!range) return false;

	targetpos = self getTargetPos(range);

	if(!isDefined(targetpos)) return false;

	// Get all players and pick out the ones that are playing and are in the same team
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if(isPlayer(self) && isPlayer(players[i]))
		{
			if(players[i].sessionstate == "playing" && players[i].pers["team"] != self.pers["team"])
			{
				if(distance(targetPos, players[i].origin) <= range * 4)
					return players[i];
			}
		}
	}

	return false;
}

getTargetPos(range)
{
	startOrigin = self.origin;
	forward = anglesToForward( self getplayerangles() );
	forward = vectorScale( forward, range * 5);
	endOrigin = startOrigin + forward;
	return endOrigin;
}

sortByDist(points, startpoint, maxdist, mindist)
{
	if(!isDefined(points)) return undefined;
	if(!isDefined(startpoint)) return undefined;

	if(!isDefined(mindist)) mindist = -1000000;
	if(!isDefined(maxdist)) maxdist = 1000000; // almost 16 miles, should cover everything.

	sortedpoints = [];

	max = points.size-1;
	for(i = 0; i < max; i++)
	{
		nextdist = 1000000;
		next = undefined;

		for(j = 0; j < points.size; j++)
		{
			thisdist = distance(startpoint.origin, points[j].origin);
			if(thisdist <= nextdist && thisdist <= maxdist && thisdist >= mindist)
			{
				next = j;
				nextdist = thisdist;
			}
		}

		// didn't find one that fit the range, stop trying
		if(!isDefined(next)) break;

		sortedpoints[i] = points[next];

		// shorten the list, fewer compares
		points[next] = points[points.size-1]; // replace the closest point with the end of the list
		points[points.size-1] = undefined; // cut off the end of the list
	}

	sortedpoints[sortedpoints.size] = points[0]; // the last point in the list

	return sortedpoints;
}

vectorScale (vec, scale)
{
	vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
	return vec;
}

defGrenades()
{
	if(self.pers["team"] == "allies")
	{
		switch(game["allies"])
		{
		case "american":
			grenadetype = "frag_grenade_american_mp";
			smokegrenadetype = "smoke_grenade_american_mp";
			break;

		case "british":
			grenadetype = "frag_grenade_british_mp";
			smokegrenadetype = "smoke_grenade_british_mp";
			break;

		default:
			assert(game["allies"] == "russian");
			grenadetype = "frag_grenade_russian_mp";
			smokegrenadetype = "smoke_grenade_russian_mp";
			break;
		}
	}
	else
	{
		assert(self.pers["team"] == "axis");
		switch(game["axis"])
		{
		default:
			assert(game["axis"] == "german");
			grenadetype = "frag_grenade_german_mp";
			smokegrenadetype = "smoke_grenade_german_mp";
			break;
		}
	}
	self.pers["fragtype"] = grenadetype;
	self.pers["smoketype"] = smokegrenadetype;
  
  if(isPlayer(self))
	{
		switch(game["allies"])
		{
			case "american":
				allies_frag = "frag_grenade_american_mp";
				allies_smoke = "smoke_grenade_american_mp";
				break;
	
			case "british":
				allies_frag = "frag_grenade_british_mp";
				allies_smoke = "smoke_grenade_british_mp";
				break;
	
			default:
				allies_frag = "frag_grenade_russian_mp";
				allies_smoke = "smoke_grenade_russian_mp";
				break;
		}
	
		if(self.pers["team"] == "allies")
		{
			self.pers["enemy_fragtype"] = "frag_grenade_german_mp";
			self.pers["enemy_smoketype"] = "smoke_grenade_german_mp";
		}
		else
		{
			self.pers["enemy_fragtype"] = allies_frag;
			self.pers["enemy_smoketype"] = allies_smoke;
		}
	}
}
