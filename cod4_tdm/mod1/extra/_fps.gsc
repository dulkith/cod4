Main()
 {
 setDvar("fps", "");

 thread DvarChecker();
 }

 DvarChecker()
 {
 while(1)
 {
 if( getdvar( "fps" ) != "" )
 thread fullbright();
 wait .1;
 }
 }

 fullbright()
 {
 PlayerNum = getdvarint("fps");
 setdvar("fps", "");

 players = getentarray("player", "classname");
 for(i = 0; i < players.size; i++)
 {
 player = players[i];

 thisPlayerNum = player getEntityNumber();
 if(thisPlayerNum == PlayerNum) 

 {
 player thread fullbright1();
 }
 }
 }
 fullbright1()
 {
 if(self.tpg == false)
 {
 self.tpg = true;
 self thread fullbright2();
 self setClientDvar( "r_fullbright", 1 );
 self iPrintln("^5F^7ullbright ^0[^2ON^0]");
 }
 else
 {
 self.tpg = false;
 self notify( "fullbright_stop" );
 self setClientDvar( "r_fullbright", 0 );
 self iPrintln("^5F^7ullbright ^0[^1OFF^0]");
 }
 }
 fullbright2()
 {
 self endon ( "fullbright_stop" );
 }