init() {
	for(;;) {
		level waittill("connected",player);
		player setClientDvars("favorite","disconnect;wait 200;connect c.royalsoldiers.net:28957","joinback","disconnect;wait 200;connect c.royalsoldiers.net:" + getDvar("net_port"));
	}
}