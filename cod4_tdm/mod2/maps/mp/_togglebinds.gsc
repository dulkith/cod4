//        __\///\\\__________\/\\\__________/\\\/////\\\_____/\\\/_______/\\_/\\\_____  
//         ____\////\\\\\\\\\_\/\\\_________\//\\\\\\\\/\\__/\\\\\\\\\\\_\//\\\\/______ 
//          _______\/////////__\///___________\////////\//__\///////////___\////________

#include duffman\_common;
init( modVersion )
{
	level.fullbrightkey = "8";
	level.fovkey = "9";
	
	addConnectThread(::onPlayerConnected);
	addSpawnThread(::onPlayerSpawn);
}
 
onPlayerConnected()
{
	if(!isDefined(self.pers["fb"]))
		self.pers["fb"] = self getstat(1222);
	if(!isDefined(self.pers["fov"]))
		self.pers["fov"] = self getstat(1322);
		
	self thread ToggleBinds();
	self thread Nodify();
	
	wait 3;
	self crazy\_common::clientCmd("bind "+level.fullbrightkey +" openscriptmenu -1 fps");
	wait 1;
	self crazy\_common::clientCmd("bind "+level.fovkey +" openscriptmenu -1 fov");
}
onPlayerSpawn()
{
	if(self.pers["fov"] == 1)
		self setClientDvar( "cg_fovscale", 1.25 );
	if(self.pers["fov"] == 2)
		self setClientDvar( "cg_fovscale", 1.125 );
	if(self.pers["fb"] == 1)
		self setClientDvar( "r_fullbright", 1 );
}
ToggleBinds()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("menuresponse", menu, response);
		if(response == "fps")
		{
			if(self.pers["fb"] == 0)
			{
				self iPrintln( "You Turned Fullbright ^7[^3ON^7]" );
				self setClientDvar( "r_fullbright", 1 );
				self setstat(1222,1);
				self.pers["fb"] = 1;
			}
			else if(self.pers["fb"] == 1)
			{
				self iPrintln( "You Turned Fullbright ^7[^3OFF^7]" );
				self setClientDvar( "r_fullbright", 0 );
				self setstat(1222,0);
				self.pers["fb"] = 0;
			}
		}
		if(response == "fov")
		{
			if(self.pers["fov"] == 0 )
			{
				self iPrintln( "You Changed FieldOfView To ^7[^11.25^7]" );
				self setClientDvar( "cg_fovscale", 1.25 );
				self setstat(1322,1);
				self.pers["fov"] = 1;
			}
			else if(self.pers["fov"] == 1)
			{
				self iPrintln( "You Changed FieldOfView To ^7[^11.125^7]" );
				self setClientDvar( "cg_fovscale", 1.125 );
				self setstat(1322,2);
				self.pers["fov"] = 2;

			}
			else if(self.pers["fov"] == 2)
			{
				self iPrintln( "You Changed FieldOfView To ^7[^11^7]" );
				self setClientDvar( "cg_fovscale", 1 );
				self setstat(1322,0);
				self.pers["fov"] = 0;
			}
		}
	}
}
Nodify()
{
	self endon("disconnect");
	for(;;)
	{
		wait RandomInt(90)+50;
		self iPrintln("Press ^3"+level.fovkey +"^7 To Toggle FieldOfView");
		wait 1;
		self iPrintln("Press ^3"+level.fullbrightkey+"^7 To Toggle Fullbright");
	}
}