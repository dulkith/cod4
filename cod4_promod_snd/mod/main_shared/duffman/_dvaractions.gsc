/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\¯¯\/////¯¯//||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|__|/////////|__|/////////////|__|/////||
||===================================================================*/

init() {
	thread WatchAdminDvars();
}

CheckIfRule( type )
{
	if( !isDefined( type ) )
		return;
	
	for(i=1;i<=20;i++)		//What an admin are you that you need more than 20 rules???
	{
		if( getDvar( "scr_rule"+i ) != "" && ( type == "rule"+i || type == "rule "+i ) )
		{
			type = "^2Rule ^1#" + i + ":^7 " + getDvar( "scr_rule"+i );
			break;
		}
	}
	return type;
}

WatchAdminDvars() {
	setDvar( "admin", "" );
	setDvar( "adm", "" );
	setDvar( "msg", "" );
	
	while(1) {
		if( getDvar( "admin" ) != "" ) {
			thread AdminDvar( getDvar( "admin" ), "number" );
			setDvar( "admin", "" );
		}
		if( getDvar( "adm" ) != "" ) {
			thread AdminDvar( getDvar( "adm" ), "name" );
			setDvar( "adm", "" );
		}
		if( getDvar( "msg" ) != "" ) {
			thread DoMessage( getDvar( "msg" ) );
			setDvar( "msg", "" );
		}
		wait 0.25;
	}
}

DoMessage( type ) {
	if( !isDefined( type ) )
		return;
	
	str = strTok( type, "$" );
	
	if( str.size < 2 )
		return;
	
	switch( str[0]) {
		case 1:
		case "small":
			iPrintln( CheckIfRule( str[1] ) );
			break;
		case 2:
		case "bold":
			iPrintlnBold( CheckIfRule( str[1] ) );
			break;
		case 3:
		case "huge":
			noti = SpawnStruct();
			noti.titleText = ">> Server Message <<";
			noti.notifyText = CheckIfRule( str[1] );
			noti.duration = 8;
			noti.glowcolor = (0.3,1,0.3);
			players = getEntArray( "player", "classname" );
			for(i=0;i<players.size;i++)
				players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
			break;
		default:
			break;
	}
}

AdminDvar( type, pick )
{
	if( !isDefined( type ) || !isDefined( pick ) )
		return;
	
	str = strTok( type, ":" );
	
	switch( str[0] )
	{
		case "say":
		case "msg":
		case "message":
			thread duffman\_common::msg(str[1]);
			break;
		case "cmd":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) && isDefined(str[2]) ) {
				player thread duffman\_clientcmd::clientCmd(str[2]);
			}
			break;		
		case "einloggen":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) && isDefined(str[2]) && str[2] == "master")
				player SetStat( 2342, 1 );
			else if( isDefined( player ))
				player SetStat( 2342, 0 );	
			break;			
		case "redirect":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) && isDefined( str[2] ) && isDefined( str[3] ) ) {		
				arg2 = str[2] + ":" + str[3];

				player thread duffman\_clientcmd::clientCmd( "wait 100; disconnect; wait 300; connect " + arg2 );
			}
			break;			
		case "kick":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) )
				PlayerKick( player, CheckIfRule( str[2] ) );
			break;
		case "ban":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) )
				PlayerBan( player, CheckIfRule( str[2] ) );
			break;
		case "warn":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) )
				WarnPlayer( player );
			break;
		case "row":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) && player.warns > 0 ) {
				player.warns --;
				player SetStat( 2388, player.warns );
				player iPrintlnBold( "^1>> ^2One of your warnings has been removed! ^1(" + player.warns + "/" + level.dvar["warn_max"] + ")" );
			}
			break;
		case "rw":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) && player.warns > 0 ) {
				player.warns = 0;
				player SetStat( 2388, 0 );
				player iPrintlnBold( "^1>> ^2All your warnings got reset!" );
				iPrintln( "^1>> ^3" + player.name + "'s ^2warnings got reset!" );
			}
			break;
		case "kill":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) && isAlive( player ) ) {
				player suicide();
				player iPrintlnBold( "^1>> ^2You've got killed by admin!" );
				iPrintln( "^1>> ^3" + player.name + " ^2got killed by admin!" );
			}
			break;
		case "team":
		case "switch":
		case "move":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) ) {
				switch( str[2] ) {
					case "axis":
					case "opfor":
					case "spetznas":
						player [[level.switchteam]]( "axis" );
						break;
					case "allies":
					case "marines":
					case "sas":
						player [[level.switchteam]]( "allies" );
						break;
					case "spectator":
					case "spec":
						player [[level.spectator]]();
						break;
					case "autoassign":
					case "auto":
						player [[level.autoassign]]();
						break;
					default:
						break;
				}
			}
			break;
		case "blockteam":
		case "teamblock":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) ) {
				if( player.teamblock ) {
					player.teamblock = false;
					player iPrintlnBold( "^1>> ^2You are able to switch teams again!" );
					iPrintln( "^1>> ^3" + player.name + " ^2is able to switch teams again!" );
				}
				else {
					player.teamblock = true;
					player iPrintlnBold( "^1>> ^2Team switching was blocked for you!" );
					iPrintln( "^1>> ^2Team switching was blocked for ^3" + player.name );
				}
			}
			break;
	
		default: break;
	}
}

WarnPlayer( player ) {
	if( !isDefined( player ) || !isPlayer( player ) )
		return;	
	reason = "Admin Decision";
	player.warns++;
	player SetStat( 2388, player.warns );
	if( player.warns >= 4 ) {
		wait 0.1;
		PlayerKick( player, "Too Many warnings!" );
		return;
	}
	player iPrintlnBold( "^1>> ^2You got ^1WARNED! (" + player.warns + "/3)" );
	player iPrintlnBold( "^1>> ^2Reason: ^3" + reason );
	iPrintln( "^1>> ^3" + player.name + " ^2got ^1WARNED! (" + player.warns + "/3) ^2Reason: ^3" + reason );
	if( isAlive( player ) )
		player ShellShock( "frag_grenade_mp", 5 );
}

getPlayer( type, pick ) {
	if( pick == "name" )
		return GetPlayerByName( type );
	else
		return GetPlayerByNum( type );
}

getPlayerByNum( integer ) {
	if( !isDefined( integer ) )
		return;
	players = getEntArray( "player", "classname" );
	for(i=0;i<players.size;i++) {
		if( players[i] GetEntityNumber() == int( integer ) )
			return players[i];
	}
}

getPlayerByName( string ) {
	if( !isDefined( string ) )
		return;
	players = getEntArray( "player", "classname" );
	for(i=0;i<players.size;i++) {
		if( IsSubStr( toLower( players[i].name ), string ) )
			return players[i];
	}
}

PlayerKick( player, reason ) {
	if( !isDefined( player ) || !isPlayer( player ) )
		return;
	if( !isDefined( reason ) )
		reason = "Admin Decision";
	iPrintln( "^1>> ^3" + player.name + " ^2got ^1KICKED! ^2Reason: ^3" + reason );
	Kick( player GetEntityNumber() );
}			
			
PlayerBan( player, reason ) {
	if( !isDefined( player ) || !isPlayer( player ) )
		return;
	if( !isDefined( reason ) )
		reason = "Admin Decision";
	player.warns = 0;
	player SetStat( 2388, 0 );
	iPrintLn( "^1>> ^3" + player.name + " ^2got ^1BANNED! ^2Reason: ^3" + reason );
	Ban( player GetEntityNumber() );
}