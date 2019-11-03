/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\¯¯\/////¯¯//||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|__|/////////|__|/////////////|__|/////||
||===================================================================||
||     DO NOT USE, SHARE OR MODIFY THIS FILE WITHOUT PERMISSION      ||
||===================================================================*/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
	level thread AutoTeamsBalancer();
}

getTeamPlayers(team) {
	result = [];
	players = level.players;
	for(i = 0; i < players.size; i++) {
		if (isDefined(players[i]) && players[i].pers["team"] == team){
			result[result.size] = players[i];
		}
	}
	return result;
}

getLowScorePlayers(team, nPlayers) {
	result = [];
	if (team.size > 0 && nPlayers > 0 && team.size >= nPlayers) {
		//Sorting team by score (bubble sort algorithm @TODO optimize)
		for (x = 0; x < team.size; x++) {
			for (y = 0; y < team.size - 1; y++) {
				if (isDefined(team[y]) && isDefined(team[y+1]) && team[y].pers["score"] > team[y+1].pers["score"]) {
					temp = team[y+1];
					team[y+1] = team[y];
					team[y] = temp;
				}
			}
		}
		for (i = 0; i < nPlayers; i++) {
			if (isDefined(team[i])) {
				result[i] = team[i];
			}
		}
	}
	return result;
}

AutoTeamsBalancer() {
	if(level.gametype == "sd")
		return;
	pl_change_team = [];
	changeteam = "";
	offset = 0;
	while(1) {
		wait 20;
		if (isDefined(game["state"]) && game["state"] == "playing") {
			pl_change_team = [];
			changeteam = "";
			offset = 0;
			team["axis"] = getTeamPlayers("axis");
			team["allies"] = getTeamPlayers("allies");
			if(team["axis"].size == team["allies"].size)
				continue;
			
			if(team["axis"].size < team["allies"].size) {
				changeteam = "axis";
				offset = team["allies"].size - team["axis"].size;
			}
			else {
				changeteam = "allies";
				offset = team["axis"].size - team["allies"].size;
			}
			if (offset < 2)
				continue;
			iPrintln("^7Teams will be balanced in 5 sec...");
			wait 5;
			if (isDefined(game["state"]) && game["state"] == "playing") {
				team["axis"] = getTeamPlayers("axis");
				team["allies"] = getTeamPlayers("allies");
				if(team["axis"].size == team["allies"].size) {
					iPrintln("^7AutoBalance aborted: teams are already balanced!");
					continue;
				}
				if(team["axis"].size < team["allies"].size) {
					changeteam = "axis";
					offset = team["allies"].size - team["axis"].size;
				}
				else {
					changeteam = "allies";
					offset = team["axis"].size - team["allies"].size;
				}
				if (offset < 2) {
					iPrintln("^7AutoBalance aborted: teams are already balanced!");
					continue;
				}
				offset = offset / 2;
				pl_to_add = int(offset) - (int(offset) > offset);
				pl_change_team = [];
				bigger_team = [];
				if (changeteam == "allies"){
					bigger_team = team["axis"];
				}
				else {
					bigger_team = team["allies"];
				}
				pl_change_team = getLowScorePlayers(bigger_team, pl_to_add);
				for(i = 0; i < pl_change_team.size; i++) {
					if(changeteam == "axis")
						pl_change_team[i] [[level.axis]]();
					else 
						pl_change_team[i] [[level.allies]]();
				}
				iPrintln("^7Teams were balanced!");
				iPrintlnbold("^7Teams were balanced!");
			}
		}
	}
}