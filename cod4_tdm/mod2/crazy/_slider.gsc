/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\  \/////  //||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|  |/////////|  |/////////////|  |/////||
||===================================================================*/

createText(font,fontscale,align,relative,x,y,alpha,sort,text)
{
	hudText = createFontString(font,fontscale);
	hudText setPoint(align,relative,x,y);
	hudText.alpha = alpha;
	hudText.sort = sort;
	hudText setText(text);
	hudText.hideWhenInMenu = true;
	thread destroyElemOnDeath(hudText);
	return hudText;
}
destroyElemOnDeath( elem )
{
	self waittill( "death" );
	//if( isDefined( elem.bar ) )
		//elem destroyElem();
	//else
	if( isDefined( elem ) )
		elem destroy();
}

welcomeText(player,textOne,textTwo,glowColor)
{
	player endon("death");
	player endon("disconnect");
	line[0] = createText("default",2,"","",-1000,200,1,10,textOne);
	line[1] = createText("default",2,"","",1000,180,1,10,textTwo);
	for(k = 0; k < line.size; k++)
	{
		line[k].glowAlpha = 0;
		line[k].glowColor = glowColor;
	}
	line[0] welcomeMove(1.5,-90);
	line[1] welcomeMove(1.5,90);
	wait 1.5;
	line[0] welcomeMove(4,90);
	line[1] welcomeMove(4,-90);
	wait 4;
	line[0] welcomeMove(3,1000);
	line[1] welcomeMove(3,-1000);
	wait 3;
	for(k = 0; k < 2; k++)
		line[k] destroy();
}
welcomeMove(time,x)
{
	self setPoint("","",x,self.y,time);
}
createIcon( shader, width, height )
{
	iconElem = newHudElem();
	iconElem.elemType = "icon";
	iconElem.x = 250;
	iconElem.y = 220;
	iconElem.width = width;
	iconElem.height = height;
	iconElem.xOffset = 250;
	iconElem.yOffset = 220;
	iconElem.children = [];
	iconElem setParent( level.uiParent );
	iconElem.hidden = false;
	
	if( isDefined( shader ) )
		iconElem setShader( shader, width, height );
	
	return iconElem;
}

setParent( element )
{
	if( isDefined( self.parent ) && self.parent == element )
		return;
		
	if( isDefined( self.parent ) )
		self.parent removeChild( self );

	self.parent = element;
	self.parent addChild( self );

	if( isDefined( self.point ) )
		self setPoint( self.point, self.relativePoint, self.xOffset, self.yOffset );
	else
		self setPoint( "TOPLEFT" );
}

addChild( element )
{
	element.index = self.children.size;
	self.children[self.children.size] = element;
}

removeChild( element )
{
	element.parent = undefined;

	if( self.children[self.children.size-1] != element )
	{
		self.children[element.index] = self.children[self.children.size-1];
		self.children[element.index].index = element.index;
	}
	self.children[self.children.size-1] = undefined;
	
	element.index = undefined;
}

setPoint( point, relativePoint, xOffset, yOffset, moveTime )
{
	if( !isDefined( moveTime ) )
		moveTime = 0;

	element = self getParent();

	if( moveTime )
		self moveOverTime( moveTime );
	
	if( !isDefined( xOffset ) )
		xOffset = 0;
	self.xOffset = xOffset;

	if( !isDefined( yOffset ) )
		yOffset = 0;
	self.yOffset = yOffset;
		
	self.point = point;

	self.alignX = "center";
	self.alignY = "middle";

	if( isSubStr( point, "TOP" ) )
		self.alignY = "top";
	if( isSubStr( point, "BOTTOM" ) )
		self.alignY = "bottom";
	if( isSubStr( point, "LEFT" ) )
		self.alignX = "left";
	if( isSubStr( point, "RIGHT" ) )
		self.alignX = "right";

	if( !isDefined( relativePoint ) )
		relativePoint = point;

	self.relativePoint = relativePoint;

	relativeX = "center";
	relativeY = "middle";

	if( isSubStr( relativePoint, "TOP" ) )
		relativeY = "top";
	if( isSubStr( relativePoint, "BOTTOM" ) )
		relativeY = "bottom";
	if( isSubStr( relativePoint, "LEFT" ) )
		relativeX = "left";
	if( isSubStr( relativePoint, "RIGHT" ) )
		relativeX = "right";

	if( element == level.uiParent )
	{
		self.horzAlign = relativeX;
		self.vertAlign = relativeY;
	}
	else
	{
		self.horzAlign = element.horzAlign;
		self.vertAlign = element.vertAlign;
	}


	if( relativeX == element.alignX )
	{
		offsetX = 0;
		xFactor = 0;
	}
	else if( relativeX == "center" || element.alignX == "center" )
	{
		offsetX = int( element.width / 2 );
		if( relativeX == "left" || element.alignX == "right" )
			xFactor = -1;
		else
			xFactor = 1;	
	}
	else
	{
		offsetX = element.width;
		if( relativeX == "left" )
			xFactor = -1;
		else
			xFactor = 1;
	}
	self.x = element.x + (offsetX * xFactor);

	if( relativeY == element.alignY )
	{
		offsetY = 0;
		yFactor = 0;
	}
	else if( relativeY == "middle" || element.alignY == "middle" )
	{
		offsetY = int( element.height / 2 );
		if( relativeY == "top" || element.alignY == "bottom" )
			yFactor = -1;
		else
			yFactor = 1;	
	}
	else
	{
		offsetY = element.height;
		if( relativeY == "top" )
			yFactor = -1;
		else
			yFactor = 1;
	}
	self.y = element.y + (offsetY * yFactor);
	
	self.x += self.xOffset;
	self.y += self.yOffset;
	
	switch ( self.elemType )
	{
		case "bar":
			setPointBar( point, relativePoint, xOffset, yOffset );
			//self.bar setPoint( point, relativePoint, xOffset, yOffset );
			self.barFrame setParent( self getParent() );
			self.barFrame setPoint( point, relativePoint, xOffset, yOffset );
			break;
	}
	
	self updateChildren();
}


setPointBar( point, relativePoint, xOffset, yOffset )
{
	self.bar.horzAlign = self.horzAlign;
	self.bar.vertAlign = self.vertAlign;
	
	self.bar.alignX = "left";
	self.bar.alignY = self.alignY;
	self.bar.y = self.y;
	
	if( self.alignX == "left" )
		self.bar.x = self.x;
	else if( self.alignX == "right" )
		self.bar.x = self.x - self.width;
	else
		self.bar.x = self.x - int(self.width / 2);
	
	if( self.alignY == "top" )
		self.bar.y = self.y;
	else if( self.alignY == "bottom" )
		self.bar.y = self.y;

	self updateBar( self.bar.frac );
}


updateBar( barFrac, rateOfChange )
{
	if( self.elemType == "bar" )
		updateBarScale( barFrac, rateOfChange );
}


updateBarScale( barFrac, rateOfChange ) // rateOfChange is optional and is in "(entire bar lengths) per second"
{
	barWidth = int(self.width * barFrac + 0.5); // (+ 0.5 rounds)
	
	if ( !barWidth )
		barWidth = 1;
	
	self.bar.frac = barFrac;
	self.bar setShader( self.bar.shader, barWidth, self.height );
	
	assertEx( barWidth <= self.width, "barWidth <= self.width: " + barWidth + " <= " + self.width + " - barFrac was " + barFrac );
	
	//if barWidth is bigger than self.width then we are drawing more than 100%
	if( isDefined( rateOfChange ) && barWidth < self.width ) 
	{
		if( rateOfChange > 0 )
		{
			//printLn( "scaling from: " + barWidth + " to " + self.width + " at " + ((1 - barFrac) / rateOfChange) );
			assertex( ((1 - barFrac) / rateOfChange) > 0, "barFrac: " + barFrac + "rateOfChange: " + rateOfChange );
			self.bar scaleOverTime( (1 - barFrac) / rateOfChange, self.width, self.height );
		}
		else if( rateOfChange < 0 )
		{
			//printLn( "scaling from: " + barWidth + " to " + 0 + " at " + (barFrac / (-1 * rateOfChange)) );
			assertex(  (barFrac / (-1 * rateOfChange)) > 0, "barFrac: " + barFrac + "rateOfChange: " + rateOfChange );
			self.bar scaleOverTime( barFrac / (-1 * rateOfChange), 1, self.height );
		}
	}
	self.bar.rateOfChange = rateOfChange;
	self.bar.lastUpdateTime = getTime();
}


createFontString( font, fontScale )
{
	fontElem = newClientHudElem( self );
	fontElem.elemType = "font";
	fontElem.font = font;
	fontElem.fontscale = fontScale;
	fontElem.x = 0;
	fontElem.y = 0;
	fontElem.width = 0;
	fontElem.height = int(level.fontHeight * fontScale);
	fontElem.xOffset = 0;
	fontElem.yOffset = 0;
	fontElem.children = [];
	fontElem setParent( level.uiParent );
	fontElem.hidden = false;
	return fontElem;
}

createServerFontString( font, fontScale, team )
{
	if( isDefined( team ) )
		fontElem = newTeamHudElem( team );
	else
		fontElem = newHudElem( self );
	
	fontElem.elemType = "font";
	fontElem.font = font;
	fontElem.fontscale = fontScale;
	fontElem.x = 0;
	fontElem.y = 0;
	fontElem.width = 0;
	fontElem.height = int(level.fontHeight * fontScale);
	fontElem.xOffset = 0;
	fontElem.yOffset = 0;
	fontElem.children = [];
	fontElem setParent( level.uiParent );
	fontElem.hidden = false;
	
	return fontElem;
}

createServerTimer( font, fontScale, team )
{	
	if( isDefined( team ) )
		timerElem = newTeamHudElem( team );
	else
		timerElem = newHudElem( self );
	timerElem.elemType = "timer";
	timerElem.font = font;
	timerElem.fontscale = fontScale;
	timerElem.x = 0;
	timerElem.y = 0;
	timerElem.width = 0;
	timerElem.height = int(level.fontHeight * fontScale);
	timerElem.xOffset = 0;
	timerElem.yOffset = 0;
	timerElem.children = [];
	timerElem setParent( level.uiParent );
	timerElem.hidden = false;
	
	return timerElem;
}

createTeamProgressBarText( team )
{
	text = createServerFontString( "default", level.teamProgressBarFontSize, team );
	text setPoint("TOP", undefined, 0, level.teamProgressBarTextY);
	return text;
}

hideElem()
{
	if ( self.hidden )
		return;
		
	self.hidden = true;

	if ( self.alpha != 0 )
		self.alpha = 0;
	
	if ( self.elemType == "bar" || self.elemType == "bar_shader" )
	{
		self.bar.hidden = true;
		if ( self.bar.alpha != 0 )
			self.bar.alpha = 0;

		self.barFrame.hidden = true;
		if ( self.barFrame.alpha != 0 )
			self.barFrame.alpha = 0;
	}
}

showElem()
{
	if ( !self.hidden )
		return;
		
	self.hidden = false;

	if ( self.alpha != 1 )
		self.alpha = 1;
	
	if ( self.elemType == "bar" || self.elemType == "bar_shader" )
	{
		self.bar.hidden = false;
		if ( self.bar.alpha != 1 )
			self.bar.alpha = 1;

		self.barFrame.hidden = false;
		if ( self.barFrame.alpha != 1 )
			self.barFrame.alpha = 1;
	}
}


flashThread()
{
	self endon ( "death" );

	if ( !self.hidden )
		self.alpha = 1;
		
	while(1)
	{
		if ( self.frac >= self.flashFrac )
		{
			if ( !self.hidden )
			{
				self fadeOverTime(0.3);
				self.alpha = .2;
				wait(0.35);
				self fadeOverTime(0.3);
				self.alpha = 1;
			}
			wait(0.7);
		}
		else
		{
			if ( !self.hidden && self.alpha != 1 )
				self.alpha = 1;

			wait ( 0.5 );
		}
	}
}


destroyElem()
{
	tempChildren = [];

	for ( index = 0; index < self.children.size; index++ )
	{
		if ( isDefined( self.children[index] ) )
			tempChildren[tempChildren.size] = self.children[index];
	}

	for ( index = 0; index < tempChildren.size; index++ )
		tempChildren[index] setParent( self getParent() );
		
	if ( self.elemType == "bar" || self.elemType == "bar_shader" )
	{
		self.bar destroy();
		self.barFrame destroy();
	}
		
	self destroy();
}

getParent()
{
	return self.parent;
}

updateChildren()
{
	for ( index = 0; index < self.children.size; index++ )
	{
		child = self.children[index];
		child setPoint( child.point, child.relativePoint, child.xOffset, child.yOffset );
	}
}