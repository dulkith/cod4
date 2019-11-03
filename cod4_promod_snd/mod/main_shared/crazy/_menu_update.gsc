#include duffman\_common;

init()
{
	addConnectThread(::initStats,"once");
	addConnectThread(::Accuracy);
	addConnectThread(::shootCounter);
}

initStats() {
	self.pers["shoots"] = 1;
	self.pers["hits"] = 1;
}



Accuracy()
{
	self notify( "new_accuracy" );
	self endon( "new_accuracy" );
	self endon( "disconnect" );
	
	wait 1;
	
	for(;;)
	{
		wait .5;//** let the code time till he MAY kill someone	
		//if(!isDefined(self) || !isDefined(self.pers) || !isDefined(self.pers[ "hits" ]) || !isDefined(self.pers[ "shoots" ]))
			//return;	
		
		//acu = int(self.pers[ "hits" ] / self.pers[ "shoots" ] * 10000)/100;
		//if(isDefined(acu)) self setClientDvar( "accuracy", acu );
		
		if(!isDefined(self) || !isDefined(self.pers[ "kills" ] ))
			return;	
			
		kills = int(self.pers[ "kills" ]);
		save = self setstat(2303,kills);
		if(isDefined(kills)) self setClientDvar( "kills", save );
		
		
		self common_scripts\utility::waittill_any("disconnect","death","weapon_fired","weapon_change","player_killed");
	}
}

shootCounter()
{
	self endon("disconnect");
	
	if(!isDefined(self.pers["shoots"]))
		self.pers["shoots"] = 0;
	for(;;)
	{
		self waittill( "weapon_fired" );
		if(!isDefined(self) || !isDefined(self.pers) || !isDefined(self.pers["shoots"]))
			return;
		self.pers["shoots"]++;
		self setClientDvar( "shots", self.pers["shoots"] );
	}
}