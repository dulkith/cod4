#include duffman\_common;

map()
{
	level thread onPlayerConnect();
}

onPlayerConnect(){

	if(level.players.size > 10)
		exitLevel( false );

	level.votetime = 20;
	level.isVoted = 0;
	tmpmaps=strTok("map mp_backlot map mp_crash map mp_crossfire map mp_strike map mp_citystreets map mp_killhouse", " ");
	maps = [];
	
	for(i=0;i<tmpmaps.size;i++)
	{
		if(tmpmaps[i] != "map")
			maps[maps.size] = tmpmaps[i];
	}
	
	if(maps.size >= 6)
	{
		level.map["map1"] = "";
		level.map["map2"] = "";
		level.map["map3"] = "";
		level.map["map4"] = "";
		level.map["map5"] = "";
		level.map["map6"] = "";
		
		for(i=1;i<7;i++)
		{
			level.map["map" + i] = getSubStr(maps[i-1], 3);
		}
		
		level.map["map0_votes"] = 0;
		level.map["map1_votes"] = 0;
		level.map["map2_votes"] = 0;
		level.map["map3_votes"] = 0;
		level.map["map4_votes"] = 0;
		level.map["map5_votes"] = 0;
		level.map["map6_votes"] = 0;
		level.voting = true;
		level.roundStarted = undefined;

		for(i=0;i<level.players.size;i++)
		{
			player = level.players[i];
			player setClientDvar(("hud_ShowWinner"), 0);
			player setClientDvar("selected_map", 1337);
			player thread updateVotes();
			
			thread VoteTimerAndText("^3Vote for next map",level.votetime);
			
			//player thread animVoteMap();
			player thread votemap();
			player closeMenu();
			player closeInGameMenu();
			player.lastvoted = 0;
			player.specate = undefined;
			if(player.sessionstate != "playing")
				player notify("menuresponse", game["menu_team"], "autoassign");
			wait 0.05;
			player openMenu("votemap");
			}
		
		time = level.votetime;
		for(i=0;i<time;i++)
		{
			wait 1;
			level.votetime -= 1;
		}
		level.voting = undefined;
		
		if(level.isVoted == 1){
			result = level getMostVotedForMap();
			name = getRealMapName(result);
			
			NextMapAndText(name, result);
			setDvar("cl_bypassmouseinput", 0);
			//freezeall();
			//changelevel(result, 3, false);

			setDvar("timescale",1);
			
			
			//if (result=="mp_killhouse"){
			//	setDvar( "sv_maprotationcurrent", "gametype war"  + " map " + result );
			//}else{
				setDvar( "sv_maprotationcurrent", "gametype sd"  + " map " + result );
			//}
		}
	}
	maps=strTok(getDvar("sv_mapRotation"), " ");
	currentmap=getDvar("mapname");
	nextMap="Unknown/Same map";
	for(i=1; i < maps.size && maps[i] !=currentmap; i+=2)
	{
		wait 0.05;
	}
	if(isDefined(maps[i+2]))
		nextmap=maps[i+2];
	exitLevel( false );
}

VoteTimerAndText(text, countDown)
{
	level notify("newVoteText");
	level endon("newVoteText");
	
	while(countDown)
	{
		for(i=0;i<level.players.size;i++)
		{
			player = level.players[i];
			player setClientDvar("votetime", (text+" (^1" + countDown + "s^3)"));
			player PlaySoundToPlayer( "ui_mp_timer_countdown", player );
		}
		wait 1;
		countDown--;
	}
}

NextMapAndText(mapName ,result)
{
	level notify("newVoteText");
	level endon("newVoteText");
	x= 5;
	
	while(x)
	{
		for(i=0;i<level.players.size;i++)
		{
			player = level.players[i];
			player setClientDvar(("hud_WinningName"), result);
			player setClientDvar(("hud_WinningMap"), mapName);
			player setClientDvar(("hud_ShowWinner"), 1);
		}
		wait 1;
		x--;
	}
}

votemap() {

    level endon("restarting");
	self endon("disconnect");
	for (;;) {
		self waittill("menuresponse", menu, response);
		if(menu == game["votemap"]){
			switch (response) {
				case "map1":
					self thread castMap(1);
					level.isVoted = 1;
					break;
				case "map2":
					self thread castMap(2);
					level.isVoted = 1;
					break;
				  case "map3":
					self thread castMap(3);
					level.isVoted = 1;
					break;
				  case "map4":
					self thread castMap(4);
					level.isVoted = 1;
					break;
				  case "map5":
					self thread castMap(5);
					level.isVoted = 1;
					break;
				  case "map6":
					self thread castMap(6);
					level.isVoted = 1;
					break;
			}
		}
	}
}

castMap(number) {
	if (self.lastvoted != number) {
	  self playLocalSound("mouse_click");
	  level.map["map" + self.lastvoted + "_votes"] -= 1;
	  level.map["map" + number + "_votes"] += 1;
	  self.lastvoted = number;
	  self setClientDvar("selected_map", number);
	}
}


allClientDvar(dvar, value)
{
	for(i=0;i<level.players.size;i++)
	{
		level.players[i] setClientDvar(dvar, value);
	}
}

getRealMapName(map)
{
	mapname = "";
	switch(map)
	{
		case "mp_backlot": 		mapname = "Backlot";		break;
		case "mp_bloc": 		mapname = "Bloc"; 			break;
		case "mp_bog": 			mapname = "Bog"; 			break;
		case "mp_broadcast": 	mapname = "Broadcast";		break;
		case "mp_cargoship": 	mapname = "Wetwork"; 		break;
		case "mp_citystreets": 	mapname = "District"; 		break;
		case "mp_convoy":		mapname = "Ambush"; 		break;
		case "mp_countdown": 	mapname = "Countdown"; 		break;
		case "mp_crash": 		mapname = "Crash"; 			break;
		case "mp_crossfire": 	mapname = "Crossfire"; 		break;
		case "mp_farm": 		mapname = "Downpour"; 		break;
		case "mp_overgrown": 	mapname = "Overgrown"; 		break;
		case "mp_pipeline": 	mapname = "Pipeline"; 		break;
		case "mp_shipment": 	mapname = "Shipment"; 		break;
		case "mp_showdown": 	mapname = "Showdown"; 		break;
		case "mp_strike": 		mapname = "Strike"; 		break;
		case "mp_vacant": 		mapname = "Vacant"; 		break;
		case "mp_crash_snow": 	mapname = "Winter Crash"; 	break;
		case "mp_creek": 		mapname = "Creek"; 			break;
		case "mp_carentan": 	mapname = "Chinatown"; 		break;
		case "mp_killhouse":	mapname = "Killhouse"; 		break;
		case "mp_marketcenter":	mapname = "Marketcenter"; 	break;
		case "mp_nuketown":		mapname = "Nuketown"; 		break;

	}
	if(mapname == "")
		mapname = getGoodName(map);
		
	//if(map=="mp_killhouse") return mapname + " - (TDM)";
	return mapname + " - (Search and Destroy)";
}

getGoodName(mapname)
{
	mapname = getSubStr(mapname, 3);
	mapname += " ";
	newname = "";
	switch(mapname[0])
	{
		case"a": newname += "A"; break;
		case"b": newname += "B"; break;
		case"c": newname += "C"; break;
		case"d": newname += "D"; break;
		case"e": newname += "E"; break;
		case"f": newname += "F"; break;
		case"g": newname += "G"; break;
		case"h": newname += "H"; break;
		case"i": newname += "I"; break;
		case"j": newname += "J"; break;
		case"k": newname += "K"; break;
		case"l": newname += "L"; break;
		case"m": newname += "M"; break;
		case"n": newname += "N"; break;
		case"o": newname += "O"; break;
		case"p": newname += "P"; break;
		case"q": newname += "Q"; break;
		case"r": newname += "R"; break;
		case"s": newname += "S"; break;
		case"t": newname += "T"; break;
		case"u": newname += "U"; break;
		case"v": newname += "V"; break;
		case"w": newname += "W"; break;
		case"x": newname += "X"; break;
		case"y": newname += "Y"; break;
		case"z": newname += "Z"; break;
	}
	for(i=1;i<mapname.size;i++)
	{
		if(mapname[i] == "_")
		{
			newname += " ";
			if(isDefined(mapname[i+1]))
			{
				switch(mapname[i+1])
				{
					case"a": newname += "A"; break;
					case"b": newname += "B"; break;
					case"c": newname += "C"; break;
					case"d": newname += "D"; break;
					case"e": newname += "E"; break;
					case"f": newname += "F"; break;
					case"g": newname += "G"; break;
					case"h": newname += "H"; break;
					case"i": newname += "I"; break;
					case"j": newname += "J"; break;
					case"k": newname += "K"; break;
					case"l": newname += "L"; break;
					case"m": newname += "M"; break;
					case"n": newname += "N"; break;
					case"o": newname += "O"; break;
					case"p": newname += "P"; break;
					case"q": newname += "Q"; break;
					case"r": newname += "R"; break;
					case"s": newname += "S"; break;
					case"t": newname += "T"; break;
					case"u": newname += "U"; break;
					case"v": newname += "V"; break;
					case"w": newname += "W"; break;
					case"x": newname += "X"; break;
					case"y": newname += "Y"; break;
					case"z": newname += "Z"; break;
				}
				i++;
			}
		}
		else if(mapname[i] != "_")
		{
			newname += mapname[i];
		}
	}
	return newname;
}

getMostVotedForMap()
{
	mapvotes_array = [];
	mapname_array = [];

	for(i = 1; i < 11; i++)
	{
		mapvotes_array[mapvotes_array.size] = level.map["map" + i + "_votes"];
		mapname_array[mapname_array.size] = level.map["map" + i];
	}

	n = mapvotes_array.size;

	for(i = 0; i < n; i++)
	{
		for(j = i + 1; j < n; j++)
		{
			if (mapvotes_array[i] > mapvotes_array[j])
			{
				a =  mapvotes_array[i];
				b = mapname_array[i];

				mapvotes_array[i] = mapvotes_array[j];
				mapname_array[i] = mapname_array[j];

				mapvotes_array[j] = a;
				mapname_array[j] = b;
			}
		}
	}
    return "mp_" + mapname_array[mapname_array.size - 1];
}

updateVotes()
{
	self endon("disconnect");
	for(;;)
	{
			for(i=0; i < level.map.size; i++) 
			{
				self setClientDvar("votes_map1", level.map["map1_votes"]);
				self setClientDvar("votes_map2", level.map["map2_votes"]);
				self setClientDvar("votes_map3", level.map["map3_votes"]);
				self setClientDvar("votes_map4", level.map["map4_votes"]);
				self setClientDvar("votes_map5", level.map["map5_votes"]);
				self setClientDvar("votes_map6", level.map["map6_votes"]);
				if(level.votetime == 1){
					wait 10;
				}
			}
		wait 0.25;
	}
	
	
	
	
}

changelevel(map, delay, persistence)
{
	if(!isDefined(persistence))
		persistence = false;
	old_rotation = strTok(getDvar("sv_mapRotation"), " ");
	new_rotation = "";
	new_rotation += "map " + map + " ";
	for(i=0;i<old_rotation.size;i++)
	{
		if(old_rotation[i] == map)
		{
			i+=2;
		}
		else
			new_rotation += old_rotation[i] + " ";
	}
	setDvar("sv_maprotationcurrent", "");
	setDvar("sv_maprotation", new_rotation);
	allClientDvar("cl_bypassmouseinput", 0);
	wait delay;
	exitlevel(persistence);
}