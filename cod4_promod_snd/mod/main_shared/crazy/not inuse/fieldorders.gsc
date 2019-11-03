#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include crazy\_utility;


init()
{ 
	precacheModel("field_orders_suitcase");

	for ( ID = 1; ID <= 11; ID++ )
		precacheString( tableLookupIString( "mp/intelchallenges.csv", 0, ID, 2 ) );
		
	precacheString(&"INTEL_RULES_INTEL");
	precacheString(&"INTEL_COMPLETED");
	precacheString(&"INTEL_CHALLENGE_CAPS");
	precacheString(&"INTEL_ACQUIRING_INTEL");
	
} 
onKill( victim )
{	
	self endon("disconnect");
	
	if(level.numKills > 1 && (!isDefined(level.fieldowner) || level.fieldowner != victim))
		return;
	
	level.fieldowner = undefined;
	
	basePosition = playerPhysicsTrace( victim.origin, victim.origin + ( 0, 0, -99999 ) );
	
	visuals[0] = spawn( "script_model", basePosition + ( 0, 0, 20 ));
	visuals[0] setModel( "field_orders_suitcase" );			
	trigger = spawn( "trigger_radius", basePosition, 0, 20, 50 );
		
	level.fieldorders = maps\mp\gametypes\_gameobjects::createDogTag( "any", trigger, visuals, (0,0,16) );
	level.fieldorders maps\mp\gametypes\_gameobjects::setUseTime( 0.2 );
	level.fieldorders maps\mp\gametypes\_gameobjects::setUseText(&"INTEL_ACQUIRING_INTEL");
	level.fieldorders.onUse = ::onUseFieldOrders;
					
	level.fieldorders maps\mp\gametypes\_gameobjects::allowUse( "any" );	
								
	level.fieldorders.visuals[0] thread bounce();
}
onUseFieldOrders( player )
{					
	self maps\mp\gametypes\_gameobjects::allowUse( "none" );
	wait 0.05;
	if(isDefined(level.fieldorders))
	{
		self.visuals[0] notify("deleted");
		self.visuals[0] delete();	
		level.fieldorders = undefined;	
	}
	player thread crazy\_missions::createChallenge();
}

bounce()
{	
	self endon("deleted");
	while( isDefined(level.fieldorders) )
	{
		self rotateYaw( 360, 3, 0.3, 0.3 );

		self moveZ( 20, 1.5, 0.3, 0.3 );
		wait 1.5;
		self moveZ( -20, 1.5, 0.3, 0.3 );
		wait 1.5;	
	}
}

fieldOrdersSplashNotify()
{	
	self endon("disconnect");
	wait 0.05;
	if ( level.gameEnded )
	return;
		
	self destroyFieldOrders();
		
	wait 0.05;
	
	self.ui_fieldorders[0] = newClientHudElem( self );
	self.ui_fieldorders[0].x = -150;
	self.ui_fieldorders[0].y = -60;
	self.ui_fieldorders[0].alignX = "left";
	self.ui_fieldorders[0].horzAlign = "left";
	self.ui_fieldorders[0].vertAlign = "bottom";
	self.ui_fieldorders[0].alignY = "bottom";
	self.ui_fieldorders[0] setShader( "gradient_top", 150, 15 );
	self.ui_fieldorders[0].alpha = 0.5;
	self.ui_fieldorders[0].sort = 900;
	self.ui_fieldorders[0].hideWhenInMenu = true;
	self.ui_fieldorders[0].archived = false;
	
	self.ui_fieldorders[1] = newClientHudElem( self );
	self.ui_fieldorders[1].x = -150;
	self.ui_fieldorders[1].y = -25;
	self.ui_fieldorders[1].alignX = "left";
	self.ui_fieldorders[1].horzAlign = "left";
	self.ui_fieldorders[1].vertAlign = "bottom";
	self.ui_fieldorders[1].alignY = "bottom";
	self.ui_fieldorders[1] setShader( "gradient_bottom", 150, 15 );
	self.ui_fieldorders[1].alpha = 0.2;
	self.ui_fieldorders[1].sort = 901;
	self.ui_fieldorders[1].hideWhenInMenu = true;
	self.ui_fieldorders[1].archived = false;
		
	self.ui_fieldorders[2] = addTextHud( self, -100, -58, 1, "left", "bottom", 1.4 ); 
	self.ui_fieldorders[2].horzAlign = "left";
	self.ui_fieldorders[2].vertAlign = "bottom";
	self.ui_fieldorders[2] setText( &"INTEL_CHALLENGE_CAPS" );
	self.ui_fieldorders[2].sort = 903;
	self.ui_fieldorders[2].color = game["colors"]["blue"];
	self.ui_fieldorders[2].hideWhenInMenu = true;
	self.ui_fieldorders[2].archived = false;
		
	self.ui_fieldorders[3] = addTextHud( self, -100, -43, 1, "left", "bottom", 1.4 );
	self.ui_fieldorders[3].horzAlign = "left";
	self.ui_fieldorders[3].vertAlign = "bottom";
	self.ui_fieldorders[3] setText( getFieldText(self.fieldOrders) );
	self.ui_fieldorders[3].font = "big";
	self.ui_fieldorders[3].sort = 904;
	self.ui_fieldorders[3].hideWhenInMenu = true;
	self.ui_fieldorders[3].archived = false;
	
	self.ui_fieldorders[4] = newClientHudElem( self );
	self.ui_fieldorders[4].x = -150;
	self.ui_fieldorders[4].y = -79;
	self.ui_fieldorders[4].alignX = "left";
	self.ui_fieldorders[4].horzAlign = "left";
	self.ui_fieldorders[4].vertAlign = "bottom";
	self.ui_fieldorders[4].alignY = "bottom";
	self.ui_fieldorders[4] setShader( "line_horizontal", 150, 1 );
	self.ui_fieldorders[4].alpha = 0.3;
	self.ui_fieldorders[4].sort = 905;
	self.ui_fieldorders[4].hideWhenInMenu = true;
	self.ui_fieldorders[4].archived = false;
		
	self.ui_fieldorders[5] = newClientHudElem( self );
	self.ui_fieldorders[5].x = -150;
	self.ui_fieldorders[5].y = -25;
	self.ui_fieldorders[5].alignX = "left";
	self.ui_fieldorders[5].horzAlign = "left";
	self.ui_fieldorders[5].vertAlign = "bottom";
	self.ui_fieldorders[5].alignY = "bottom";
	self.ui_fieldorders[5] setShader( "line_horizontal", 150, 1 );
	self.ui_fieldorders[5].alpha = 0.3;
	self.ui_fieldorders[5].sort = 906;
	self.ui_fieldorders[5].hideWhenInMenu = true;
	self.ui_fieldorders[5].archived = false;
		
	for(i = 0 ; i < self.ui_fieldorders.size && isDefined(self.ui_fieldorders[i]); i++)
		self.ui_fieldorders[i] moveOverTime(0.15);
				
	self.ui_fieldorders[0].x = 5;
	self.ui_fieldorders[1].x = 5;
	self.ui_fieldorders[2].x = 10;
	self.ui_fieldorders[3].x = 10;
	self.ui_fieldorders[4].x = 5;
	self.ui_fieldorders[5].x = 5;
	
	wait 0.15;

	waittill_any_ents(self,"fieldordersdone",level,"_game_ended");
		
	for(i = 0; i < self.ui_fieldorders.size && isDefined(self.ui_fieldorders[i]); i++)
		self.ui_fieldorders[i] moveOverTime(0.15);
			
	self.ui_fieldorders[0].x = -150;
	self.ui_fieldorders[1].x = -150;
	self.ui_fieldorders[2].x = -100;
	self.ui_fieldorders[3].x = -100;	
	self.ui_fieldorders[4].x = -150;
	self.ui_fieldorders[5].x = -150;		

	wait 0.15;
	self destroyFieldOrders();
}
destroyFieldOrders()
{
	if( !isDefined( self.ui_fieldorders ) || !self.ui_fieldorders.size )
		return;

	for( i = 0; i < self.ui_fieldorders.size; i++ )
		self.ui_fieldorders[i] destroy();
	self.ui_fieldorders = [];
}

addTextHud( who, x, y, alpha, alignX, alignY, fontScale )
{
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.alignX = alignX;
	hud.alignY = alignY;
	hud.fontScale = fontScale;
	return hud;
}
getFieldText(orders,num)
{
	if(!isDefined(num))
		num = self.fieldOrdersDifficulty;
	
	switch(orders)
	{
		case "ch_intel_headshots": return str_replace("Earn ^3&&1^7 kill with a headshot","&&1",num);		
		case "ch_intel_kills": return str_replace("Earn ^3&&1^7 kill(s)","&&1",num);		
		case "ch_intel_knifekill": return str_replace("Earn ^3&&1^7 kill with melee","&&1",num);	
		case "ch_intel_explosivekill": return str_replace("Earn ^3&&1^7 kill with explosive","&&1", num);
		case "ch_intel_tbag": return "Humiliate the next enemy\n you kill";
		case "ch_intel_crouchkills": return str_replace("Earn ^3&&1^7 kill(s) while crouch","&&1", num);
		case "ch_intel_pronekills": return str_replace("Earn ^3&&1^7 kill while prone","&&1", num);
		case "ch_intel_backshots": return str_replace("Earn ^3&&1^7 kill from behind","&&1", num);
		case "ch_intel_jumpshot": return str_replace("Earn ^3&&1^7 kill while\njumping","&&1", num);
		case "ch_intel_secondarykills": return str_replace("Earn ^3&&1^7 kill with your\nsecondary weapon","&&1",num);
		case "ch_intel_foundshot": return str_replace("Earn ^3&&1^7 kill(s) with a picked\nup weapon","&&1",num);
		default: return "";
	}
}