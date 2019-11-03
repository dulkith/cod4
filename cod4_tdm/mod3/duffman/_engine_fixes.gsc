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
//#############################################################################################################################################################
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
//#############################################################################################################################################################
ElevatorFix() {
	self endon("disconnect");
	self endon("death");
	self endon("joined_spectators");
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
 						break;
 					}
 				}
			}
		}
	}
}
//#############################################################################################################################################################
// ** This is fixing unkickable clients on adminmod
GuidChangeFix() {
	if(self getGuid() == "BOT-Client")
		return;
	self endon("disconnect");
	self thread GuidCheck();
	while(1) {
		oldguid = self getGuid();
		wait 1;
		if(oldguid != self getGuid()) {
			logPrint("Q;" + oldguid + ";" + self getEntityNumber() + ";" + self.name + "\n");
  			logPrint("J;" + self getGuid() + ";" + self getEntityNumber() + ";" + self.name + "\n");
		}
	}
}

GuidCheck() {
	self endon( "disconnect" );
    while(1) {
		lpGuid = self getGuid();
		if(lpGuid == "" || !isRealGuid(lpGuid) || lpGuid.size != 32)
			self duffman\_common::dropPlayer("ban","Guidspoofer (" + lpGuid + ")");
        for(i = 0; i < 32; i++) {
            lpGuidChar = GetSubStr(lpGuid, i, i+1);
            if( lpGuidChar == " " || !isHex(lpGuidChar) )
				self duffman\_common::dropPlayer("ban","Guidspoofer");
            wait 0.05;
        }
        wait 10;
    }
}

isRealGuid(guid) {
	chars = [];
	for(i=0;i<16;i++)
		chars[i] = 0;
	for(i=0;i<32;i++)
	{
		char = GetSubStr(guid, i, i+1);
		if(char == "a")
			chars[0]++;
		else if(char == "b")
			chars[1]++;
		else if(char == "c")
			chars[2]++;	
		else if(char == "d")
			chars[3]++;	
		else if(char == "e")
			chars[4]++;	
		else if(char == "f")
			chars[5]++;	
		else if(char == "0")
			chars[6] = 0;// ** iceops files got 0000000 infront of guid	
		else if(char == "1")
			chars[7]++;	
		else if(char == "2")
			chars[8]++;	
		else if(char == "3")
			chars[9]++;	
		else if(char == "4")
			chars[10]++;	
		else if(char == "5")
			chars[11]++;
		else if(char == "6")
			chars[12]++;
		else if(char == "7")
			chars[13]++;
		else if(char == "8")
			chars[14]++;
		else if(char == "9")
			chars[15]++;
	}
	for(i=0;i<16;i++)
		if(chars[i] > 12)
			return false;
	return true;
}
//#############################################################################################################################################################