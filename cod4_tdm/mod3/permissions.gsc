getPermissions() {
	permission = [];
	// ** set the permissions for each group here
	//    seperate them with , 

	// ** To add a player as admin etc. use 'set admin einloggen:PID:ADMINRANK'

	permission["master"] = "fea90b03,spectate_all,dvartweaks,{G}-Owner,Member,balance,vip,only,dev";
	permission["leader"] = "*,spectate_all,dvartweaks,{G}-Leader,Member,balance,vip,only";
	permission["headadmin"] = "spectate_all,dvartweaks,{G}-headadmin,Member,balance,vip,only";
	permission["fulladmin"] = "spectate_all,dvartweaks,{G}-FullAdmin,Member,balance,vip";
	permission["rookie"] = "spectate_all,dvartweaks,{G}-Rookie,Member,balance";
	permission["member"] = "fea90b03,spectate_all,dvartweaks,{G}-Member,Member,balance,vip";
	permission["default"] = "";
	return permission;
}