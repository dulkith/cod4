#include duffman\_common;

init()
{
	level.vipList = [];
	//level.vipList[ level.vipList.size ] = "21120127"; // |SLeS|_Rama

	addConnectThread(::onPlayerConnected);
}

onPlayerConnected(){
    if(self isVip() ){
		//self setRank( 54 );
		precacheStatusIcon("hudicon_opfor");
		self.statusIcon = "hudicon_opfor";
		self thread testRank(); // Otherwise it does not work after a spawn.
		self iPrintln("^5"+self.name+ ", ^7YOU'RE ^1CLAN MEMBER ^7OF THIS SERVER.");
		// hudicon_opfor - sles clan badge
	}
	//thread crazy\_sles_notify_center::init();
}

testRank()
{
	self endon("disconnect");
    self waittill("spawned_player");
    
	//self setRank( 54 );
	precacheStatusIcon("hudicon_opfor");
	self.statusIcon = "hudicon_opfor";
}

isVip() {
	playerId = GetSubStr(self getGuid(), self getGuid().size - 8, self getGuid().size);
	for( i = 0; i < level.vipList.size; i++ ) {
		if( playerId == level.vipList[i] )
			return true;
	}
	return false;
}
