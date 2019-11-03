init() {

    switch(game["allies"]) {
    case"sas":
        precacheShader("faction_128_sas");
        setdvar("g_TeamIcon_Allies", "faction_128_sas");
        /*setdvar("g_TeamColor_Allies", "0.5 0.5 0.5");
        setdvar("g_ScoresColor_Allies", "0 0 0");*/
        break;
    default:
        precacheShader("faction_128_usmc");
        setdvar("g_TeamIcon_Allies", "faction_128_usmc");
        /*setdvar("g_TeamColor_Allies", "0.6 0.64 0.69");
        setdvar("g_ScoresColor_Allies", "0.6 0.64 0.69");*/
        break;
    }
    switch(game["axis"]) {
    case"russian":
        precacheShader("faction_128_ussr");
        setdvar("g_TeamIcon_Axis", "faction_128_ussr");
        /*setdvar("g_TeamColor_Axis", "0.52 0.28 0.28");
        setdvar("g_ScoresColor_Axis", "0.52 0.28 0.28");*/
        break;
    default:
        precacheShader("faction_128_arab");
        setdvar("g_TeamIcon_Axis", "faction_128_arab");
        /*setdvar("g_TeamColor_Axis", "0.65 0.57 0.41");
        setdvar("g_ScoresColor_Axis", "0.65 0.57 0.41");*/
        break;
    }

    setdvar("g_TeamColor_Allies", "0 0.26 0.9");
    setdvar("g_ScoresColor_Allies", "0.020 0.211 0.293");

    setdvar("g_TeamColor_Axis", "1 0.26 0.26");
    setdvar("g_ScoresColor_Axis", "0.480 0.363 0.039");

    if(game["attackers"] == "allies" && game["defenders"] == "axis") {
        setdvar("g_TeamName_Allies", "^2[^7SLeS2] ^7Legends");
        setdvar("g_TeamName_Axis", "^2[^7SLeS2^2] ^7Epics");
    }
    else {
        setdvar("g_TeamName_Allies", "^2[^7SLeS2^2] ^7Legends");
        setdvar("g_TeamName_Axis", "^2[^7SLeS2s^2] ^7Epics");
    }
    setdvar("g_ScoresColor_Spectator", "0.25 0.25 0.25");
    setdvar("g_ScoresColor_Free", "0.76 0.78 0.1");
    setdvar("g_teamColor_MyTeam", "0.6 0.8 0.6");
    setdvar("g_teamColor_EnemyTeam", "1 0.45 0.5");
	setdvar("g_scoreboardPingGraph", "1"); 

}