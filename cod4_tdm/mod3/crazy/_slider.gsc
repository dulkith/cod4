/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\  \/////  //||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|  |/////////|  |/////////////|  |/////||
||===================================================================*/

#include maps\mp\gametypes\_hud_util;

oben1(player,text1,text2,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	links = createText("default",2,"","",-600,-70,1,10,text1);
	links.glowAlpha = 1;
	links.glowColor = glowColor;
	//links setPulseFX(150,4900,1500);
	links welcomeMove(1,-90);
	wait 1.1;
	links welcomeMove(6,90);
	wait 6;
	links welcomeMove(3,1000);
	wait 3;
	links destroy();
}

oben(player,text1,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	links = createText("default",2,"","",-600,-70,1,10,text1);
	links.glowAlpha = 1;
	links.glowColor = glowColor;
	//links setPulseFX(150,4900,1500);
	links welcomeMove(1,-90);
	wait 1.1;
	links welcomeMove(6,90);
	wait 6;
	links welcomeMove(3,1000);
	wait 3;
	links destroy();
}

unten(player,text2,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	rechts = createText("default",2,"","",600,-50,1,10,text2);
	rechts.alignX = "right";
	rechts.glowAlpha = 1;
	rechts.glowColor = glowColor;
	//rechts setPulseFX(140,4900,1500);
	rechts welcomeMove(1,90);
	wait 1.1;
	rechts welcomeMove(4,-90);
	wait 4;
	rechts welcomeMove(3,-1000);
	wait 3;
	rechts destroy();
}

unten2(player,text2,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	rechts = createText("default",2,"","",100,-50,1,10,text2);
	rechts.alignX = "left";
	rechts.glowAlpha = 1;
	rechts.glowColor = glowColor;
	rechts setPulseFX(200,4900,600);
	rechts welcomeMove(4,-80);
	wait 4;
	rechts welcomeMove(3,-990);
	wait 3;
	rechts welcomeMove(3,-1293.33);
	wait 1;
	rechts setPulseFX(0,0,0);
	rechts destroy();
}

welcomeMove(time,x,y)
{
	self moveOverTime(time);
	if(isDefined(x))
		self.x = x;
		
	if(isDefined(y))
		self.y = y;
}

createText(font,fontscale,align,relative,x,y,alpha  ,sort,text)
{
	hudText = createFontString(font,fontscale);
	hudText setPoint(align,relative,x,y);
	hudText.alpha = alpha;
	hudText.sort = sort;
	hudText setText(text);
	return hudText;
}