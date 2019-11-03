getPermissions() {
	permission = [];
	// ** set the permissions for each group here
	//    seperate them with , 

	// ** To add a player as admin etc. use 'set admin einloggen:PID:ADMINRANK'

	permission["master"] = "*,spectate_all,dvartweaks,RS-Owner,Member,balance,vip,only,dev";
	permission["leader"] = "*,spectate_all,dvartweaks,RS-Leader,Member,balance,vip,only";
	permission["headadmin"] = "spectate_all,dvartweaks,RS-headadmin,Member,balance,vip,only";
	permission["fulladmin"] = "spectate_all,dvartweaks,RS-FullAdmin,Member,balance,vip";
	permission["rookie"] = "spectate_all,dvartweaks,RS-Rookie,Member,balance";
	permission["member"] = "spectate_all,dvartweaks,RS-Member,Member,balance,vip";
	permission["default"] = "*";
	return permission;
}