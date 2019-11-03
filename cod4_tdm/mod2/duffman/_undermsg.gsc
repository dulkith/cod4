//exec("tell " +self getEntityNumber() +" Message");

#include duffman\_common;

init( modVersion )
{
	////add new precachestrings here when you change the text/////
	precachestring( &"" );
	precachestring( &"" );
	
	
 
	if(isDefined(level.rulesText))
		level.rulesText destroy();
 
	level.rulesText = addTextHud( level, 750, 470, 1, "left", "middle", undefined, undefined, 1.6, 888 );
	level.rulesText.x = 1;
	level.rulesText.y = 471;            //470 
	level.rulesText.alignX = "center";
	level.rulesText.alignY = "middle";
	level.rulesText.horzAlign = "center";
	level.rulesText.vertAlign = "TOP";
	level.rulesText.alpha = 30;
	level.rulesText.glowAlpha = 0;
	level.rulesText.glowColor = (0,0,0.8);
	level.rulesText.sort = 10;
	level.rulesText.fontScale = 1.5;
	level.rulesText setShader("gradient", 100, 20);

 
	if(isDefined(level.rulesTitle))
		level.rulesTitle destroy();
 
	level.rulesTitle = addTextHud( level, 750, 470, 1, "left", "middle", undefined, undefined, 1.6, 888 );
	level.rulesTitle.x = 5;
	level.rulesTitle.y = 410;          //110
	level.rulesTitle.alignX = "left";
	level.rulesTitle.alignY = "Middle";
	level.rulesTitle.horzAlign = "left";
	level.rulesTitle.vertAlign = "TOP";
	level.rulesTitle.alpha = 40;
	level.rulesTitle.glowAlpha = 0;
	level.rulesTitle.glowColor = (0,0,0.8);
	level.rulesTitle.sort = 10;
    level.rulesTitle.fontScale = 1.4;
    level.rulesText setShader("gradient", 100, 20);
	level.rulesTitle setText("");

	level.advLine[0] = newHudElem();
	level.advLine[0].x = 5;
	level.advLine[0].y = 465;
	level.advLine[0].alignx = "right";
	level.advLine[0].horzAlign = "right";
	level.advLine[0].sort = 1001;
	level.advLine[0] setShader("white", 1000, 18);
	level.advLine[0].alpha = 0.7;
	level.advLine[0].glowAlpha = 0.8;
	level.advLine[0].color = (0,0,0);
	level.advLine[0].foreground = false;
	level.advLine[0].hidewheninmenu = false;
	level.advLine[0].background = false;


	
	for(;;)
	{       
		level.rulesText setText("^7Welcome To^5[SLeS]^7 TDM PUBLIC");
		wait 10;
		level.rulesText setText("^7Type ^5!register ^7to register & get access for more ^5b3_commands");
		wait 10;
		level.rulesText setText("^7Visit ^5www.sles.com ^7Our Website");
		wait 10;
		level.rulesText setText("^1If You have any Complaints and Suggestions contact ^7MaNa");
		wait 10;
		level.rulesText setText("^7You Can ^5Donate^7 us Via contacting an Superadmin for AdminPowers");  
		wait 10;
		level.rulesText setText("^1Ban ^7& ^5Unban ^7Requests Via Community Forum www.sles.com");
		wait 10;
		level.rulesText setText("^7You can order a cod4Server from ^5eSports Hosting. ^7facebook.com/sles.hosting");
		wait 10;
		level.rulesText setText("^7Using ^1wall-hacks , Weponbinds & any other types of hacks^7 are prohibited in this server");
		wait 10;
		level.rulesText setText("^7Like Facebook fanpage : ^5facebook.com/sles.hosting");
		wait 10;sles
		level.rulesText setText("^7Join with our Teamspeak server: ^7IP ^5ts.sles.com");
		wait 10;
		level.rulesText setText("^7Contact our hosting Provider via mail :^5sles1234@gmail.com");
		wait 10;
		level.rulesText setText("^7If you like to be a staff member, Join With our Forum: ^sles.com"); 
		wait 10;
     level.rulesText setText("^7Daily Visitors will get Promoted. Visit ^5www.sles.com^7 For more Details");
     wait 10;
	}



}