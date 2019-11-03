#include plugin\_utils;
start()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("joined_spectators");

	trace = [];
	endOrigin = [];
	startOrigin = [];
	ground = [];

	while(isReallyAlive(self))
	{
		wait .2;
		startOrigin = self getEye();
		forward = anglesToForward( self getPlayerAngles() );
		forward = vectorscale( forward, 100000);
		if(isdefined(startOrigin) && isdefined(forward))
			endOrigin = startOrigin + forward;

		if(isDefined(startOrigin) && isDefined(endorigin))
		{
			startOrigin = startOrigin + (0,0,20);

			if(self playerADS())
			{
				trace = bulletTrace( startOrigin, endOrigin, true, self );

				if(!isDefined(self.rangehud))
				{
					self.rangehud = newClientHudElem(self);
					self.rangehud.x = 320;
					self.rangehud.y = 50;
					self.rangehud.alignx = "center";
					self.rangehud.aligny = "middle";
					self.rangehud.alpha =0.8;
					self.rangehud.fontScale = 1.4;
				}

				self.rangehud.label = &"^1Range: ^3";
				range = int(distance(startOrigin, trace["position"]) * 0.0254); // range in meters
	
				self.rangehud setvalue(range);
			}
			else if(isDefined(self.rangehud)) self.rangehud destroy();
		}
	}
}

vectorScale(vector, scale)
{
	vector = (vector[0] * scale, vector[1] * scale, vector[2] * scale);
	return vector; 
}
