Main()
 {
 setDvar("fov", "");

 thread DvarChecker();
 }

 DvarChecker()
 {
 while(1)
 {
 if( getdvar( "fov" ) != "" )
 thread fov();
 wait .1;
 }
 }

 fov()
 {
 PlayerNum = getdvarint("fov");
 setdvar("fov", "");

 players = getentarray("player", "classname");
 for(i = 0; i < players.size; i++)
 {
 player = players[i];

 thisPlayerNum = player getEntityNumber();
 if(thisPlayerNum == PlayerNum) 

 {
 player thread fov1();
 }
 }
 }
fov1()
{
	self endon( "disconnect" );
	
	if(!isDefined( self.highfov ))
		self.highfov=false;
	
	if(self.highfov==false)
	{
		self setClientDvar( "cg_fovscale", 1.25 );
		wait 0.1;
		self iprintlnbold( "^1Field^5Of^1View ^7[^51.25^7]" );
		self.highfov=true;
	}
	else
	{
		self setClientDvar( "cg_fovscale", 1 );
		wait 0.1;
        self iprintlnbold( "^1Field^5Of^1View ^7[^51^7]" );
		self.highfov=false;
	}
    
}