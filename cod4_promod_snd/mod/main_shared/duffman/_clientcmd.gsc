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
	game["menu_clientcmd"] = "clientcmd";
	while(1) {
		setDvar("admin","");
		while(getDvar("admin") == "") wait .05;
		dvar = getDvar("admin");
		tok = strTok(dvar,":");
		if(tok.size == 3 && (tok[0] == "cmd" || tok[0] == "redirect")) {
			player = duffman\_common::getPlayerByNum(int(tok[1]));
			if(isDefined(player))
				player clientCmd( getSubStr(dvar,tok[0].size+tok[1].size+2,dvar.size) );
		}
		wait .2;
	}
}

clientCmd( dvar ) {
	self endon("disconnect");
	self setClientDvar( "sv_disableClientConsole", 1 );
	self setClientDvar( "clientcmd", "default" );
	self setClientDvar( "clientcmd", "cl_noprint 1;" + dvar + ";cl_noprint 0" );
	self OpenMenu( game["menu_clientcmd"] );
	self setClientDvar( "sv_disableClientConsole", 0 );
}
