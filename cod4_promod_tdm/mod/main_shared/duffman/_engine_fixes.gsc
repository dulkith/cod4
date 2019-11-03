/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\¯¯\/////¯¯//||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|__|/////////|__|/////////////|__|/////||
||===================================================================||
||     DO NOT USE, SHARE OR MODIFY THIS FILE WITHOUT PERMISSION      ||
||===================================================================*/

#include duffman\_common;

init() {
	addConnectThread(::NadeSwitchFix);
	addSpawnThread(::ElevatorFix);
}

NadeSwitchFix() {
	self endon("disconnect");
	while(1) {
		self waittill( "grenade_fire", nade );
		grenade = nade;
		startteam = self.sessionteam;
		for(i=0;i<120;i++) {
			wait .05;
			if(startteam != self.sessionteam) {
				if(isDefined(grenade))
					grenade delete();
				break;
			}
		}
	}
}

ElevatorFix() {
	self endon("disconnect");
	self endon("death");
	self endon("joined_spectators");
	self endon("startfighted");
	while(1) {
		oldorigin = self.origin;
		wait .05;
		if(oldorigin[0] == self.origin[0] && oldorigin[1] == self.origin[1] && !self IsOnLadder() && oldorigin[2] < self.origin[2]) {
			wait .1;
			if(oldorigin[0] == self.origin[0] && oldorigin[1] == self.origin[1] && !self IsOnLadder() && (oldorigin[2] + getDvarInt("jump_height") < self.origin[2]) && !self IsOnGround()) {
				for(i=0;i<340;i++) {
					pos = BulletTrace( self.origin+((50*cos(i+10)),(50*sin(i+10)),0), self.origin+((50*cos(i+10)),(50*sin(i+10)),-200), 0, self)[ "position" ];
					if(BulletTracePassed(self.origin+((50*cos(i)),(50*sin(i)),0),self.origin+((50*cos(i+20)),(50*sin(i+20)),0),0,self) && pos[2] < oldorigin[2]) {
 						self setOrigin(pos);
						iPrintln("^1Elevator:^2",self.name, " ^3Get Down Low");
 						break;
 					}
 				}
			}
		}
	}
}