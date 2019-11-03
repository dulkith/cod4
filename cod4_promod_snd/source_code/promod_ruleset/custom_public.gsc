main()
{
	// custom_public ruleset, promod live v2
	// boolean logic, 0 = false, 1 or higher = true
	
		//------------Spawn points------------
	//x, y , z , degree & x, y , z , degree
	//do just use the 2nd sting of the map ex: mp_ich_muss_kacken then use ich_spawns
	setDvar( "crash_spawns",		"49, 1732, 660, 246&-156, 1522, 720, 65");
	setDvar( "crash_snow_spawns",	"49, 1732, 660, 246&-156, 1244, 660, 65");
	setDvar( "backlot_spawns",		"-804, 108, 420, 239&-1210, -509, 420, 59");
	setDvar( "strike_spawns",		"108, 398, 410, 89&106, 792, 410, 271");
	setDvar( "shipment_spawns",		"-3109, 1196, 427, 39&-2844, 1412, 427, 218");
	setDvar( "crossfire_spawns",	"5100, -3813, 1043, 159&4765, -3678, 1043, 341");
	setDvar( "citystreets_spawns",	"3695, 343, 20, 270&3695, 2, 10, 90");
	setDvar( "nuketown_spawns",		"87, 934, 190, 87&103, 1326, 190, 267");
	setDvar( "killhouse_spawns",	"652, 2601, 790, 270&652, 184, 790, 90");
	setDvar( "dome_spawns",			"-3182, -5225, 1030, 276&-3114, -5842, 1030, 96");
	setDvar( "terminal_spawns",		"1636, 411, 679, 50&1999, 854, 655, 230");
	//-------------Flames-----------------
	//seperate every cor with &
	//seperate every x, y, z with , (z immer -65 rechnen!!!)
	setDvar( "crash_flames", 		"-174, 1223, 635&72, 1223, 635&72, 1753, 635&-177, 1752, 635" );
	setDvar( "crash_snow_flames", 		"-174, 1223, 635&72, 1223, 635&72, 1753, 635&-177, 1752, 635" );
	setDvar( "backlot_flames", 		"-725, -580, 405&-1280, -580, 405&-1280, 224, 405&-725, 224, 405" );
	setDvar( "strike_flames", 		"301, 846, 400&300, 337, 400&-80, 339, 400&-79, 843, 400" );
	setDvar( "shipment_flames",		"-2850, 1204, 402&-3101, 1204, 402&-3100, 1404, 402&-2851, 1405, 402");
	setDvar( "crossfire_flames", 	"5100, -3965, 1020&4683, -3828, 1020&4778, -3531, 1020&5196, -3668, 1020" );
	setDvar( "citystreets_flames", 	"-174, 1223, 630&72, 1223, 630&72, 1753, 635&-177, 1752, 635" );//no flames needed here but dvar must be used so i set this to use flames somewhere outside map
	setDvar( "nuketown_flames", 	"103, 872, 170&-170, 774, 170&-325, 1200, 170&104, 1354, 170&660, 1099, 170&473, 701, 170");
	setDvar( "killhouse_flames", 	"653, 101, 765&323, 102, 725&327, 2678, 725&651, 2679, 765&982, 2678, 725&979, 101, 725");
	setDvar( "dome_flames", 		"-2770, -5478, 1030&-3193, -5162, 1030&-3536, -5634, 1030&-3103, -5945, 1030");

	// sd
	setDvar( "scr_sd_bombtimer", 45 ); // [1->] (seconds)
	setDvar( "scr_sd_defusetime", 7 ); // [1->] (seconds)
	setDvar( "scr_sd_multibomb", 0 ); // [0-1] (everyone can plant)
	setDvar( "scr_sd_numlives", 1 ); // [0->] (amount of lives)
	setDvar( "scr_sd_planttime", 5 ); // [1->] (seconds)
	setDvar( "scr_sd_playerrespawndelay", 0 ); // [0->] (seconds)
	setDvar( "scr_sd_roundlimit", 20 ); // [0->] (points)
	setDvar( "scr_sd_roundswitch", 10 ); // [0->] (points)
	setDvar( "scr_sd_scorelimit", 0 ); // [0->] (points)
	setDvar( "scr_sd_timelimit", 1.75 ); // [0->] (minutes)
	setDvar( "scr_sd_waverespawndelay", 0 ); // [0->] (seconds)

	// dom
	setDvar( "scr_dom_numlives", 0 ); // [0->] (amount of lives)
	setDvar( "scr_dom_playerrespawndelay", 7 ); // [0->] (seconds)
	setDvar( "scr_dom_roundlimit", 2 ); // [0->] (points)
	setDvar( "scr_dom_roundswitch", 1 ); // [0->] (points)
	setDvar( "scr_dom_scorelimit", 0 ); // [0->] (points)
	setDvar( "scr_dom_timelimit", 15 ); // [0->] (minutes)
	setDvar( "scr_dom_waverespawndelay", 0 ); // [0->] (seconds)

	// koth
	setDvar( "koth_autodestroytime", 120 ); // [1->] (hq online time in seconds)
	setDvar( "koth_capturetime", 20 ); // [1->] (time to capture hq in seconds)
	setDvar( "koth_delayPlayer", 0 ); // [0-1] (override default respawn delay in seconds)
	setDvar( "koth_destroytime", 10 ); // [1->] (time to destroy hq in seconds)
	setDvar( "koth_kothmode", 0 ); // [0-1] (classic mode, non-classic)
	setDvar( "koth_spawnDelay", 45 ); // [0->] (default respawn delay in seconds)
	setDvar( "koth_spawntime", 10 ); // [0->] (hq spawn time in seconds)
	setDvar( "scr_koth_numlives", 0 ); // [0->] (amount of lives)
	setDvar( "scr_koth_playerrespawndelay", 0 ); // [0->] (seconds)
	setDvar( "scr_koth_roundlimit", 2 ); // [0->] (points)
	setDvar( "scr_koth_roundswitch", 1 ); // [0->] (points)
	setDvar( "scr_koth_scorelimit", 0 ); // [0->] (points)
	setDvar( "scr_koth_timelimit", 15 ); // [0->] (minutes)
	setDvar( "scr_koth_waverespawndelay", 0 ); // [0->] (seconds)

	// sab
	setDvar( "scr_sab_bombtimer", 45 ); // [1->] (seconds)
	setDvar( "scr_sab_defusetime", 5 ); // [1->] (seconds)
	setDvar( "scr_sab_hotpotato", 0 ); // [0-1] (shared bomb timer)
	setDvar( "scr_sab_numlives", 0 ); // [0->] (amount of lives)
	setDvar( "scr_sab_planttime", 5 ); // [1->] (seconds)
	setDvar( "scr_sab_playerrespawndelay", 7 ); // [0->] (seconds)
	setDvar( "scr_sab_roundlimit", 4 ); // [0->] (points)
	setDvar( "scr_sab_roundswitch", 2 ); // [0->] (points)
	setDvar( "scr_sab_scorelimit", 0 ); // [0->] (points)
	setDvar( "scr_sab_timelimit", 10 ); // [0->] (minutes)
	setDvar( "scr_sab_waverespawndelay", 0 ); // [0->] (seconds)

	// tdm
	setDvar( "scr_war_numlives", 0 ); // [0->] (amount of lives)
	setDvar( "scr_war_playerrespawndelay", 0 ); // [0->] (seconds)
	setDvar( "scr_war_roundlimit", 2 ); // [0->] (points)
	setDvar( "scr_war_scorelimit", 0 ); // [0->] (points)
	setDvar( "scr_war_roundswitch", 1 ); // [0->] (points)
	setDvar( "scr_war_timelimit", 15 ); // [0->] (minutes)
	setDvar( "scr_war_waverespawndelay", 0 ); // [0->] (seconds)

	// dm
	setDvar( "scr_dm_numlives", 0 ); // [0->] (amount of lives)
	setDvar( "scr_dm_playerrespawndelay", 0 ); // [0->] (seconds)
	setDvar( "scr_dm_roundlimit", 1 ); // [0->] (points)
	setDvar( "scr_dm_scorelimit", 0 ); // [0->] (points)
	setDvar( "scr_dm_timelimit", 10 ); // [0->] (points)
	setDvar( "scr_dm_waverespawndelay", 0 ); // [0->] (seconds)
	
	// kill confirmed
	setDvar( "scr_kc_numlives", 0 ); // [0->] (amount of lives)
	setDvar( "scr_kc_playerrespawndelay", 0 ); // [0->] (seconds)
	setDvar( "scr_kc_roundlimit", 1 ); // [0->] (points)
	setDvar( "scr_kc_scorelimit", 1000 ); // [0->] (points)
	setDvar( "scr_kc_roundswitch", 1 ); // [0->] (points)
	setDvar( "scr_kc_timelimit", 10 ); // [0->] (minutes)
	setDvar( "scr_kc_waverespawndelay", 0 ); // [0->] (seconds)

	// class limits
	setDvar( "class_assault_limit", 64 );
	setDvar( "class_specops_limit", 2 );
	setDvar( "class_demolitions_limit", 1 );
	setDvar( "class_sniper_limit", 1 );

	setDvar( "class_assault_allowdrop", 1 );
	setDvar( "class_specops_allowdrop", 1 );
	setDvar( "class_demolitions_allowdrop", 0 );
	setDvar( "class_sniper_allowdrop", 0 );

	// assault
	setDvar( "weap_allow_m16", 1 );
	setDvar( "weap_allow_ak47", 1 );
	setDvar( "weap_allow_m4", 1 );
	setDvar( "weap_allow_g3", 1 );
	setDvar( "weap_allow_g36c", 1 );
	setDvar( "weap_allow_m14", 1 );
	setDvar( "weap_allow_mp44", 1 );

	// assault attachments
	setDvar( "attach_allow_assault_none", 1 );
	setDvar( "attach_allow_assault_silencer", 1 );

	// smg
	setDvar( "weap_allow_mp5", 1 );
	setDvar( "weap_allow_uzi", 1 );
	setDvar( "weap_allow_ak74u", 1 );

	// smg attachments
	setDvar( "attach_allow_specops_none", 1 );
	setDvar( "attach_allow_specops_silencer", 1 );

	// shotgun
	setDvar( "weap_allow_m1014", 1 );
	setDvar( "weap_allow_winchester1200", 1 );

	// sniper
	setDvar( "weap_allow_m40a3", 1 );
	setDvar( "weap_allow_remington700", 1 );

	// pistol
	setDvar( "weap_allow_beretta", 1 );
	setDvar( "weap_allow_colt45", 1 );
	setDvar( "weap_allow_usp", 1 );
	setDvar( "weap_allow_deserteagle", 1 );
	setDvar( "weap_allow_deserteaglegold", 1 );

	// pistol attachments
	setDvar( "attach_allow_pistol_none", 1 );
	setDvar( "attach_allow_pistol_silencer", 1 );

	// grenades
	setDvar( "weap_allow_flash_grenade", 1 );
	setDvar( "weap_allow_frag_grenade", 1 );
	setDvar( "weap_allow_smoke_grenade", 1 );

	// assault class default loadout (preserved)
	setDvar( "class_assault_primary", "ak47" );
	setDvar( "class_assault_primary_attachment", "none" );
	setDvar( "class_assault_secondary", "deserteagle" );
	setDvar( "class_assault_secondary_attachment", "none" );
	setDvar( "class_assault_grenade", "smoke_grenade" );
	setDvar( "class_assault_camo", "camo_none" );

	// specops class default loadout (preserved)
	setDvar( "class_specops_primary", "ak74u" );
	setDvar( "class_specops_primary_attachment", "none" );
	setDvar( "class_specops_secondary", "deserteagle" );
	setDvar( "class_specops_secondary_attachment", "none" );
	setDvar( "class_specops_grenade", "smoke_grenade" );
	setDvar( "class_specops_camo", "camo_none" );

	// demolitions class default loadout (preserved)
	setDvar( "class_demolitions_primary", "winchester1200" );
	setDvar( "class_demolitions_primary_attachment", "none" );
	setDvar( "class_demolitions_secondary", "deserteagle" );
	setDvar( "class_demolitions_secondary_attachment", "none" );
	setDvar( "class_demolitions_grenade", "smoke_grenade" );
	setDvar( "class_demolitions_camo", "camo_none" );

	// sniper class default loadout (preserved)
	setDvar( "class_sniper_primary", "m40a3" );
	setDvar( "class_sniper_primary_attachment", "none" );
	setDvar( "class_sniper_secondary", "deserteagle" );
	setDvar( "class_sniper_secondary_attachment", "none" );
	setDvar( "class_sniper_grenade", "smoke_grenade" );
	setDvar( "class_sniper_camo", "camo_none" );

	// team killing
	setDvar( "scr_team_fftype", 1 ); // [0-3] (disabled, enabled, reflect, shared)
	setDvar( "scr_team_teamkillpointloss", 5 ); // [0->] (points)

	// player death/respawn settings
	setDvar( "scr_player_forcerespawn", 1 ); // [0-1] (require player to press use key to spawn, do not require use key to spawn)
	setDvar( "scr_game_deathpointloss", 0 ); // [0->] (points)
	setDvar( "scr_game_suicidepointloss", 0 ); // [0->] (points)
	setDvar( "scr_player_suicidespawndelay", 0 ); // [0->] (points)

	// player fall damage
	setDvar( "bg_fallDamageMinHeight", 140 ); // [1->] (min height to inflict min fall damage)
	setDvar( "bg_fallDamageMaxHeight", 350 ); // [1->] (max height to inflict max fall damage)

	// logging (not likely to be changed)
	setDvar( "logfile", 1 );
	setDvar( "g_log", "games_mp.log" );
	setDvar( "g_logSync", 0 );

	// server issues (not likely to be changed)
	setDvar( "g_inactivity", 0 );
	setDvar( "g_no_script_spam", 1 );
	setDvar( "g_antilag", 1 );
	setDvar( "g_smoothClients", 1 );
	setDvar( "sv_allowDownload", 1 );
	setDvar( "sv_maxPing", 0 );
	setDvar( "sv_minPing", 0 );
	setDvar( "sv_reconnectlimit", 3 );
	setDvar( "sv_timeout", 240 );
	setDvar( "sv_zombietime", 2 );
	setDvar( "sv_floodprotect", 4 );
	setDvar( "sv_kickBanTime", 0 );
	setDvar( "sv_disableClientConsole", 0 );
	setDvar( "sv_voice", 0 );
	setDvar( "sv_clientarchive", 1 );
	setDvar( "timescale", 1 );

	// various
	setDvar( "g_allowVote", 0 ); // [0-1]
	setDvar( "g_deadChat", 1 ); // [0-1]
	setDvar( "scr_game_allowkillcam", 0 ); // [0-1]
	setDvar( "scr_game_spectatetype", 1 ); // [0-2] (disabled, team only, all)
	setDvar( "scr_game_matchstarttime", 10 ); // [0->] (seconds)
	setDvar( "scr_enable_hiticon", 2 ); // [0-2] (disabled, hit icon on, hit icon on but not through walls)
	setDvar( "scr_enable_scoretext", 1 ); // [0-1] (exp popups, +5 etc)
	setDvar( "promod_allow_strattime", 0 ); // [0-1] (sd only)
	setDvar( "promod_allow_readyup", 0 ); // [0-1]
	setDvar( "promod_kniferound", 0 ); // [0-1] (sd only)
	setDvar( "g_maxDroppedWeapons", 16 ); // [2-32] (maximum number of dropped weapons before recycling)
	setDvar( "scr_hardcore", 0 ); // [0-1]

	// website
	setDvar( "promod_hud_website", "         SL^1e^7SPORT GAMING COMMUNITY" ); // (avoid "//" here)

	// messagecenter
	setDvar( "promod_mc_enable", 0 ); // [0-1]
	setDvar( "promod_mc_rs_every_round", 0 ); // [0-1] (restarts messages on round-based gametypes)
	setDvar( "promod_mc_delay", 45 ); // [1->] (default delay in seconds between messages)
	setDvar( "promod_mc_loopdelay", 45 ); // [1->] (delay in seconds until it starting over)
	setDvar( "promod_mc_maxmessages", 3 ); // [1->] (set this equivalent to number of messages)
	setDvar( "promod_mc_message_1", "Message Center ON" );
	setDvar( "promod_mc_message_2", "Set Me Up Or Turn Me OFF" );
	setDvar( "promod_mc_message_3", "<*nextmap*>" );
	setDvar( "promod_mc_messagedelay_1", 0 ); // [1->] (overrides default delay in seconds between messages, e.g special messages)
	setDvar( "promod_mc_messagedelay_2", 0 );
	setDvar( "promod_mc_messagedelay_3", 0 );
}