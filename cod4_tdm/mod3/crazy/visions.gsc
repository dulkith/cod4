//  ________/\\\\\\\\\__________________________________________________________        
//   _____/\\\////////___________________________________________________________       
//    ___/\\\/_________________________________________________________/\\\__/\\\_      
//     __/\\\______________/\\/\\\\\\\___/\\\\\\\\\_____/\\\\\\\\\\\___\//\\\/\\\__     
//      _\/\\\_____________\/\\\/////\\\_\////////\\\___\///////\\\/_____\//\\\\\___    
//       _\//\\\____________\/\\\___\///____/\\\\\\\\\\_______/\\\/________\//\\\____   
//        __\///\\\__________\/\\\__________/\\\/////\\\_____/\\\/_______/\\_/\\\_____  
//         ____\////\\\\\\\\\_\/\\\_________\//\\\\\\\\/\\__/\\\\\\\\\\\_\//\\\\/______ 
//          _______\/////////__\///___________\////////\//__\///////////___\////________

Default()
{
	self endon("disconnect");
	
	self setClientDvar( "r_filmTweakEnable", "0" );
	self setClientDvar( "r_filmUseTweaks", "0" );
	self setClientDvar( "r_filmtweakcontrast", "1.4" );
	self setClientDvar( "r_lighttweaksunlight", "1" );
	self setClientDvar( "r_filmTweakInvert", "");
	self setClientDvar( "r_filmTweakbrightness", "0");
	self setClientDvar( "r_filmtweakLighttint", "1.1 1.05 0.85");
	self setClientDvar( "r_filmtweakdarktint", "0.7 0.85 1");
}

Thermal()
{
	self endon("disconnect");
	
	self Default();

	self setClientDvars("r_FilmTweakDarktint", "1 1 1",
						"r_FilmTweakLighttint", "1 1 1", 
						"r_FilmTweakInvert", "1", 
						"r_FilmTweakBrightness", "0.13", 
						"r_FilmTweakContrast", "1.55", 
						"r_FilmTweakDesaturation", "1",
						"r_FilmTweakEnable", "1",
						"r_FilmUseTweaks", "1");
}

Nightvision()
{
	self endon("disconnect");
	
	self Default();

	self setClientDvars("r_FilmTweakDarktint", "0 1.54321 0.000226783",
						"r_FilmTweakLighttint", "1.5797 1.9992 2.0000", 
						"r_FilmTweakInvert", "0", 
						"r_FilmTweakBrightness", "0.26", 
						"r_FilmTweakContrast", "1.63", 
						"r_FilmTweakDesaturation", "1",
						"r_FilmTweakEnable", "1",
						"r_FilmUseTweaks", "1");
}