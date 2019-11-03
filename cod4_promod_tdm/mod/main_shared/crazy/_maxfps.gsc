//  ________/\\\\\\\\\__________________________________________________________        
//   _____/\\\////////___________________________________________________________       
//    ___/\\\/_________________________________________________________/\\\__/\\\_      
//     __/\\\______________/\\/\\\\\\\___/\\\\\\\\\_____/\\\\\\\\\\\___\//\\\/\\\__     
//      _\/\\\_____________\/\\\/////\\\_\////////\\\___\///////\\\/_____\//\\\\\___    
//       _\//\\\____________\/\\\___\///____/\\\\\\\\\\_______/\\\/________\//\\\____   
//        __\///\\\__________\/\\\__________/\\\/////\\\_____/\\\/_______/\\_/\\\_____  
//         ____\////\\\\\\\\\_\/\\\_________\//\\\\\\\\/\\__/\\\\\\\\\\\_\//\\\\/______ 
//          _______\/////////__\///___________\////////\//__\///////////___\////________

#include duffman\_common;

init( modVersion )
{
	addSpawnThread(::maxfps);
}

maxfps() 
{
	self endon("disconnect");
	
	if ( isDefined(self.pers["isBot"]) )
		return;
	
	for(;;)
	{
		//self.currentfps = self getfps();
		if( self.currentfps>320)
		{
			self iPrintlnbold("^1Fps Warn. Max ^1[250]^7 Your Current Fps "+ self.currentfps );
			self iprintln("detected fps: "+ self.currentfps);
			self iPrintlnbold("^1 change Fps below 250");
			self freezecontrols(true);
			//while(self.currentfps>320)
			{
				wait 1;
				//self.currentfps = self getfps();
				self iPrintlnbold("^1 change Fps below 250");
			}
			self freezecontrols(false);
			self iPrintlnbold("^1Thank you");
		}
		wait 0.05;
	}
	wait 5;
}