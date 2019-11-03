ClearScreen() // entfernt iPrint's damit man leeren bildschirm hat -> sieht schöner aus
{
	for( i = 0; i < 10; i++ )
	{
		iPrintlnBold( " " );
		iPrintln( " " );
	}
}

addLoopFire(origin)
{
	level endon( "stopfire" );
	while(game["state"] != "postgame")
	{
		playfx(level.feuerkleinfx, origin); 
		wait .5;
	}
}

playFxonAll(fx)
{
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		playFx(fx,players[i].origin);
	}
}

MoveToSpot(endcoors,time)
{
	self endon("disconnect");
	link = spawn("script_model", self.origin);
	self LinkTo(link);
	link moveto((self.origin[0], self.origin[1],endcoors[2] + 200) , time / 3);
	link waittill("movedone");
	link moveto((endcoors[0], endcoors[1],endcoors[2] + 200) , time / 3);
	link waittill("movedone");
	link moveto(endcoors, time / 3);
	link waittill("movedone");
	wait 1;
	self unlink();
	link delete();
}

dvarOnPlayer(dvar,number)
{
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		players[i] setClientDvar(dvar,number);
	}
}

endRoundTimer(time)
{
	level.roundendzeit = newHudElem();
	level.roundendzeit.elemType = "font";
	level.roundendzeit.font = "default";
	level.roundendzeit.fontscale = 1.6;
	level.roundendzeit.x = 0;
	level.roundendzeit.y = -10;
	level.roundendzeit.glowAlpha = 1;
	level.roundendzeit.hideWhenInMenu = true;
	level.roundendzeit.archived = false;
	level.roundendzeit.alignX = "right";
	level.roundendzeit.alignY = "middle";
	level.roundendzeit.horzAlign = "center";
	level.roundendzeit.vertAlign = "bottom";
	level.roundendzeit.alpha = 1;
	level.roundendzeit.glowAlpha = 1;
	level.roundendzeit.glowColor = level.randomcolour;
	level.roundendzeit SetTimer( time );
	level waittill("duff_killtimer");
	level.roundendzeit fadeOverTime(1);
	level.roundendzeit.alpha = 0;
}

UhrZeit()
{	
	level.timehud = newHudElem();
	level.timehud.elemType = "font";
	level.timehud.font = "default";
	level.timehud.fontscale = 1.4;
	level.timehud.x = -5;
	level.timehud.y = 30;
	level.timehud.glowAlpha = 1;
	level.timehud.hideWhenInMenu = true;
	level.timehud.archived = false;
	level.timehud.alignX = "right";
	level.timehud.alignY = "middle";
	level.timehud.horzAlign = "right";
	level.timehud.vertAlign = "top";
	level.timehud.alpha = 1;
	level.timehud.glowAlpha = 1;
	level.timehud.glowColor = (0.602, 0, 0.563);
	for(;;)
	{
		zeit = getDvar("time");
		level.timehud setText( "Time: ^3" +getDvar("time") );
		while(getDvar("time") == zeit)
			wait 1;
	}
}

getBestPlayerFromScore()
{
	deaths = 100;
	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
	{
		if(isDefined(players[i]) && isDefined(players[i].pers["score"]))
		{
			if(!isDefined(level.bestscore1))
			{
				level.bestscore1 = players[i].pers["score"];
				level.bestplayer1 = players[i];
			}
			else
			{
				if(level.bestscore1 <= players[i].pers["score"])
				{
					level.bestscore1 = players[i].pers["score"];
					level.bestplayer1 = players[i];	
				}
			}
		}
	}
}

getBestPlayerFromOITC()
{
	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
	{
		if(isDefined(players[i]) && level.bestplayer1 != players[i] && isDefined(players[i].oitckills) )
		{
			if(!isDefined(level.bestscore2))
			{
				level.bestscore2 = players[i].oitckills;
				level.bestplayer2 = players[i];
			}
			else
			{
				if(level.bestscore2 <= players[i].oitckills)
				{
					level.bestscore2 = players[i].oitckills;
					level.bestplayer2 = players[i];	
				}
			}
		}
	}
}

getAllPlayers()
{
	return getEntArray( "player", "classname" );
}

playSoundOnAllPlayers( soundAlias )
{
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		players[i] playLocalSound( soundAlias );
	}
}

RandomColour()
{
	colour = randomInt(20);
	switch(colour)
	{
		case 0:
			level.randomcolour = (1, 0, 0);
			break;
		case 1:
			level.randomcolour = (0.3, 0.6, 0.3);
			break;
		case 2:
			level.randomcolour = (0.602, 0, 0.563);
			break;
		case 3:
			level.randomcolour = (0.055, 0.746, 1);
			break;
		case 4:
			level.randomcolour = (0, 1, 0);
			break;
		case 5:
			level.randomcolour = (0.043, 0.203, 1);
			break;
		case 6:
			level.randomcolour = (0.5, 0.0, 0.8);
			break;
		case 7:
			level.randomcolour = (1.0, 0.0, 0.0);
			break;
		case 8:
			level.randomcolour = (0.9, 1.0, 0.0);
			break;
		case 9:
			level.randomcolour = (1.0, 0.0, 0.0);
			break;			
		case 10:
			level.randomcolour = (1.0, 0.0, 0.4);
			break;
		case 11:
			level.randomcolour = (1.0, 0.5, 0.0);
			break;
		case 12:
			level.randomcolour = (0.0, 0.5, 1.0);
			break;
		case 13:
			level.randomcolour = (0.5, 0.0, 0.8);
			break;
		case 14:
			level.randomcolour = (1.0, 0.0, 0.4);
			break;
		case 15:
			level.randomcolour = (0.0, 0.5, 1.0);
			break;
		case 16:
			level.randomcolour = (0.3, 0.0, 0.3);
			break;
		case 17:
			level.randomcolour = (0.0, 0.5, 1.0);
			break;	
		case 18:
			level.randomcolour = (0.5, 0.0, 0.2);
			break;
		case 19:
			level.randomcolour = (0.0, 1.0, 1.0);
			break;
		case 20:
			level.randomcolour = (0.0, 0.0, 1.0);
			break;
		case 21:
			level.randomcolour = (0.0, 1.0, 1.0);
			break;
		default: 
			level.randomcolour = (0.0, 0.0, 1.0);
			break;
	}
}