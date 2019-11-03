getPermissions() {
	permission = [];
	// ** set the permissions for each group here
	//    seperate them with , 

	// ** To add a player as admin etc. use 'set admin einloggen:PID:ADMINRANK'

	permission["master"] = "*,spectate_all,dvartweaks,founder,Member,balance,vip,only,dev";
	permission["leader"] = "*,spectate_all,dvartweaks,leader,Member,balance,vip,only";
	permission["headadmin"] = "spectate_all,dvartweaks,headadmin,Member,balance";
	permission["fulladmin"] = "spectate_all,dvartweaks,fulladmin,Member,balance";
	permission["rookie"] = "spectate_all,dvartweaks,rookie,Member,balance";
	permission["member"] = "spectate_all,dvartweaks,member,Member,balance";
	permission["default"] = "";
	return permission;
}