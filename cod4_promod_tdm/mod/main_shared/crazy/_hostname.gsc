init()
{
	if (getDvarInt("hostname_score_enable") > 0)
		thread enabled();
	else
	{
		thread disabled();
	}
}
enabled()
{
	if(level.TeamBased)
	{
		level.hostname = getdvar("promod_hostname");
		setdvar("sv_hostname", level.hostname + "^1SLeSPORTS ^5SnD ^3Promod ^2|REMASTERED|" + "^0 - " + "^1Attack" + "^5: ^7" + game["teamScores"]["allies"] + " " + "^0" + "^4Defence" + "^5: ^7" + game["teamScores"]["axis"] );
	}
	else
	{
		level.hostname = getdvar("promod_hostname");
		setdvar("sv_hostname", level.hostname  + "^1SLeSPORTS ^5SnD ^3Promod ^2|REMASTERED|" + "^0 - " + "^1Attack" + "^5: ^7" + game["teamScores"]["allies"] + " " + "^0" + "^4Defence" + "^5: ^7" + game["teamScores"]["axis"]  );
	}
}
disabled()
{
	level.hostname = getdvar("promod_hostname");
	setdvar("sv_hostname", level.hostname  + "^1SLeSPORTS ^5SnD ^3Promod ^2|REMASTERED|" + "^0 - " + "^1Attack" + "^5: ^7" + game["teamScores"]["allies"] + " " + "^0" + "^4Defence" + "^5: ^7" + game["teamScores"]["axis"]  );
}

//setdvar("sv_hostname", level.hostname  + "GameTrackerClaimServer" );