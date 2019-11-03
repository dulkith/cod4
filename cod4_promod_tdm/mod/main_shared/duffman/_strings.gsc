getGameTypeString( type )
{
	switch( toLower( type ) )
	{
		case "deathrun":	
			type = "Deathrun";
			break;
		case "ktk":	
			type = "Kill The King";
			break;
		case "sd":	
			type = "Search & Destroy";
			break;
		case "war":	
			type = "Team-Deathmatch";
			break;
		case "dm":	
			type = "Deathmatch";
			break;
		case "cj":	
			type = "CoDJumper";
			break;
		case "hns":	
			type = "Hide 'n Seek";
			break;		
		case "dom":	
			type = "Domination";
			break;	
		case "sab":	
			type = "Sabotage";
			break;	
		case "koth":	
			type = "Headquarters";
			break;				
	}
	return type;
}

getMapNameString( mapName ) 
{
	switch( toLower( mapName ) )
	{
		case "mp_deathrun_darkness":
			mapName = "Darkness";
			break;
		case "mp_deathrun_cookie":
			mapName = "Cookie";
			break;		
		case "mp_deathrun_long":
			mapName = "Long";
			break;
		case "mp_deathrun_watchit":
		case "mp_deathrun_watchit_v2":
		case "mp_deathrun_watchit_v3":
			mapName = "Watch It";
			break;
		case "mp_deathrun_takecare":
			mapName = "Take Care";
			break;
		case "mp_deathrun_glass":
			mapName = "Glass";
			break;
		case "mp_deathrun_supermario":
		case "mp_deathrun_supermario_v2":
		case "mp_deathrun_sm_v2":
			mapName = "Super Mario";
			break;
		case "mp_deathrun_short":
		case "mp_deathrun_short_v2":
		case "mp_deathrun_short_v3":
		case "mp_deathrun_short_v4":
			mapName = "Short";
			break;
		case "mp_deathrun_grassy":
		case "mp_deathrun_grassy_v4":
			mapName = "Grassy";
			break;
		case "mp_deathrun_portal":
		case "mp_deathrun_portal_v2":
		case "mp_deathrun_portal_v3":
		case "mp_deathrun_portal_v4":
			mapName = "Portal";
			break;
		case "mp_dr_sm_world":
			mapName = "Mario World";
			break;	
		case "mp_deathrun_framey_v2":
			mapName = "Framey";
			break;
		case "mp_deathrun_annihilation":
			mapName = "Annihilation";
			break;			
		case "mp_deathrun_arbase":
			mapName = "Arbase";
			break;			
		case "mp_deathrun_azteca":
			mapName = "Azteca";
			break;			
		case "mp_deathrun_cave":
			mapName = "Cave";
			break;			
		case "mp_deathrun_city":
			mapName = "City";
			break;			
		case "mp_deathrun_clear":
			mapName = "Clear";
			break;					
		case "mp_deathrun_crazy":
			mapName = "Crazy";
			break;			
		case "mp_deathrun_destroyed":
			mapName = "Destroyed";
			break;			
		case "mp_deathrun_diehard":
			mapName = "Die Hard";
			break;		
		case "mp_deathrun_ruin":
			mapName = "Ruin";
			break;				
		case "mp_deathrun_dirt":
			mapName = "Dirt";
			break;			
		case "mp_deathrun_dungeon":
			mapName = "Dungeon";
			break;			
		case "mp_deathrun_easy":
			mapName = "Easy";
			break;			
		case "mp_deathrun_epicfail":
			mapName = "Epic Fail";
			break;			
		case "mp_deathrun_escape":
			mapName = "Escape";
			break;	
		case "mp_deathrun_farm":
			mapName = "Farm";
			break;	
		case "mp_deathrun_greenland":
			mapName = "Greenland";
			break;	
		case "mp_deathrun_highrise":
			mapName = "Highrise";
			break;	
		case "mp_deathrun_jailhouse":
			mapName = "Jailhouse";
			break;	
		case "mp_deathrun_lalamx":
			mapName = "Lalamx";
			break;	
		case "mp_deathrun_liferun":
			mapName = "Liferun";
			break;	
		case "mp_deathrun_maratoon":
			mapName = "Maratoon";
			break;	
		case "mp_deathrun_max":
			mapName = "Max";
			break;	
		case "mp_deathrun_metal":
		case "mp_deathrun_metal2":
			mapName = "Metal";
			break;	
		case "mp_deathrun_minecraft":
			mapName = "Minecraft";
			break;	
		case "mp_deathrun_moustache":
			mapName = "Moustache";
			break;		
		case "mp_deathrun_palm":
			mapName = "Palm";
			break;	
		case "mp_deathrun_rainy_v2":
		case "mp_deathrun_rainy":		
			mapName = "Rainy";
			break;	
		case "mp_deathrun_sg1":
			mapName = "SG1";
			break;	
		case "mp_deathrun_skypillar":
			mapName = "Skypillar";
			break;	
		case "mp_deathrun_speed":
			mapName = "Speed";
			break;	
		case "mp_deathrun_stone":
			mapName = "Stone";
			break;	
		case "mp_deathrun_wood_v3":
		case "mp_deathrun_wood":
			mapName = "Wood";
			break;	
		case "mp_deathrun_zero":
			mapName = "Zero";
			break;	
		case "mp_dr_bananaphone":
		case "mp_dr_bananaphone_v2":
			mapName = "Banana Phone";
			break;	
		case "mp_dr_boxroom":
			mapName = "Boxroom";
			break;	
		case "mp_dr_crazyrun":
			mapName = "Crazy Run";
			break;	
		case "mp_fnrp_iceland_v2":
			mapName = "Ice Land";
			break;		
		case "mp_dr_finalshuttle":
			mapName = "Finalshuttle";
			break;			
		case "mp_dr_frost":
			mapName = "Frost";
			break;		
		case "mp_dr_glass2":
			mapName = "Glass";
			break;		
		case "mp_dr_gohome":
			mapName = "Go Home";
			break;		
		case "mp_dr_hazard":
			mapName = "Hazard";
			break;		
		case "mp_dr_indipyramid":
			mapName = "Indi Pyramid";
			break;		
		case "mp_dr_jurapark":
			mapName = "Jurassic Park";
			break;		
		case "mp_dr_minerun":
			mapName = "Mine Run";
			break;		
		case "mp_dr_pacman":
			mapName = "Pacman";
			break;		
		case "mp_dr_pool":
			mapName = "Pool";
			break;		
		case "mp_dr_prisonv2":
			mapName = "Prison";
			break;		
		case "mp_dr_simpl":
			mapName = "Simpli";
			break;		
		case "mp_dr_simpsons":
			mapName = "Simpsons";
			break;		
		case "mp_dr_snip":
			mapName = "Sniper";
			break;
		case "mp_dr_spider":
			mapName = "Spider";
			break;		
		case "mp_dr_ssc_nothing":
			mapName = "Nothing";
			break;		
		case "mp_dr_terror":
			mapName = "Terror";
			break;
		case "mp_dr_wipeout":
			mapName = "Wipeout";
			break;		
		case "mp_crash":
			mapName = "Crash";
			break;	
		case "mp_crossfire":
			mapName = "Crossfire";
			break;	
		case "mp_shipment":
			mapName = "Shipment";
			break;	
		case "mp_convoy":
			mapName = "Ambush";
			break;	
		case "mp_bloc":
			mapName = "Bloc";
			break;	
		case "mp_bog":
			mapName = "Bog";
			break;	
		case "mp_broadcast":
			mapName = "Broadcast";
			break;	
		case "mp_carentan":
			mapName = "Chinatown";
			break;			
		case "mp_countdown":
			mapName = "Countdown";
			break;	
		case "mp_crash_snow":
			mapName = "Crash Snow";
			break;	
		case "mp_creek":
			mapName = "Creek";
			break;		
		case "mp_citystreets":
			mapName = "District";
			break;
		case "mp_farm":
			mapName = "Downpour";
			break;
		case "mp_killhouse":
			mapName = "Killhouse";
			break;
		case "mp_overgrown":
			mapName = "Overgrown";
			break;
		case "mp_pipeline":
			mapName = "Pipeline";
			break;
		case "mp_showdown":
			mapName = "Showdown";
			break;
		case "mp_strike":
			mapName = "Strike";
			break;
		case "mp_vacant":
			mapName = "Vacant";
			break;	
		case "mp_cargoship":
			mapName = "Wetwork";
			break;		
		case "mp_backlot":
			mapName = "Backlot";
			break;		
		case "mp_nuketown":
			mapName = "Nuketown";
			break;	
		case "mp_waldcamp":
			mapName = "Waldcamp";
			break;			
		case "mp_deathrun_sapphire":
			mapName = "Sapphire";
			break;	
		case "mp_dr_darmuhv2":
			mapName = "Darmuh";
			break;	
		case "mp_deathrun_godfather":
			mapName = "Godfather";
			break;	
		default:
			toks = strTok(mapName,"_");
			endtok = toks.size;
			starttok = 1;
			if(toks[1] == "deathrun" || toks[1] == "dr" || toks[1] == "cj" || toks[1] == "codjumper" || toks[1] == "surv" || toks[1] == "fnrp" || toks[1] == "pb")
				starttok = 2;
			if(isDefined(toks[toks.size - 1]) && (isSubStr(toks[toks.size - 1],"v1") || isSubStr(toks[toks.size - 1],"v2") || isSubStr(toks[toks.size - 1],"v3") || isSubStr(toks[toks.size - 1],"v4") || isSubStr(toks[toks.size - 1],"v5") || isSubStr(toks[toks.size - 1],"v6") || toks[toks.size - 1] == "1"  || toks[toks.size - 1] == "2"  || toks[toks.size - 1] == "3"  || toks[toks.size - 1] == "4"  || toks[toks.size - 1] == "5"  || toks[toks.size - 1] == "6")) //to be sure ;)
				endtok = toks.size - 1;
			toks[1] = replaceName(toks[1]);
			toks[2] = replaceName(toks[2]);		
			toks[3] = replaceName(toks[3]);		
			toks[4] = replaceName(toks[4]);			
			mapName = "";
			for(i=starttok;i<endtok;i++)
			{
				mapName = mapName + toks[i] + " ";
			}
			break;
	}
	return mapName;
}

replaceName(string)
{
	if(!isDefined(string))
		return;
	abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	abcklein = "abcdefghijklmnopqrstuvwxyz";
	for(i=0;i<abc.size;i++)
	{
		if(string[0] == abcklein[i])
		{
			string = abc[i] + getSubStr(string,1,string.size);
			return string;
		}
	}
	return string;
}