
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
 
init()
{
        level.chm_Torso = [];
        level.chm_Heads = [];
        level.chm_Accesories = [];
		
		
         // ====== bodies ======
 
        // american
        RegisterTorso( "body_mp_usmc_recon" );
        RegisterTorso( "body_mp_usmc_sniper" );
		RegisterTorso( "body_mp_opforce_sniper" );
		RegisterTorso( "body_mp_opforce_eningeer" );
        RegisterTorso( "body_mp_usmc_woodland_recon" );
        RegisterTorso( "body_mp_usmc_woodland_assault" );
 
        // ====== heads ======
		RegisterHead( "head_sp_opforce_3hole_ski_mask_body_b", true );
		RegisterHead( "head_sp_opforce_gas_mask_body_f", true );
		RegisterHead( "head_sp_usmc_sami_goggles_zach_body" , true );
        RegisterHead( "head_sp_spetsnaz_boris_borisbody", false );
        RegisterHead( "head_sp_sas_woodland_hugh", true );     
		
		
		
		
		
		
		
       
 
        for( i = 0; i < level.chm_Torso.size; i++ )             precacheModel( level.chm_Torso[i] );
        for( i = 0; i < level.chm_Heads.size; i++ )             precacheModel( level.chm_Heads[i].v["model"] );
}
SetCharacter( torso, head )
{	
        if( torso >= level.chm_Torso.size )
                torso = level.chm_Torso.size-1;
        else if( torso < 0 )
                torso = 0;
 
        if( head >= level.chm_Heads.size )
                head = level.chm_Heads.size-1;
        else if( head < 0 )
                head = 0;
 
        torso = level.chm_Torso[ torso ];
        head = level.chm_Heads[ head ];
 
        self detachAll();
        self setModel( torso );
        self attach( head.v["model"] );
}
 
 
RegisterHead( model, canWearHat )
{
        head = spawnStruct();
        head.v = [];
        head.v["model"] = model;
        head.v["hatAllowed"] = canWearHat;
 
        level.chm_Heads[level.chm_Heads.size] = head;
 
 
}
 
RegisterTorso( model )
{
        level.chm_Torso[level.chm_Torso.size] = model;
}
 
 
RegisterAccesory( model, tag )
{
        accesory = spawnStruct();
        accesory.v = [];
        accesory.v["model"] = model;
        accesory.v["tag"] = tag;
 
        level.chm_Accesories[level.chm_Accesories.size] = accesory;
}
 
 
RotatePreview()
{
        self endon( "disconnect" );
        self endon( "end customization" );
        self notify( "stop preview rotation" );
        self endon( "stop preview rotation" );
 
        wait 0.05;
        while( isDefined( self.previewModel ) )
        {
                self.previewModel rotateYaw( 360, 6 );
                wait 6;
        }
}
 
OnResponse( response )
{
        spawnAngles = (0,self.angles[1],0);
        self setPlayerAngles( spawnAngles );
 
        torsoChangePos = ( self.origin + (0,0,-20) + vector_scale(anglesToForward(spawnAngles), 100 ) );
        headChangePos = ( (self.origin - (0,0,55)) + vector_scale(anglesToForward(spawnAngles), 30 ) );
       
        headAngles = (0,158,0);
       
		if( !isDefined( self.previewModel ) && response == "character_open" )
        {      
                self.edit = "torso";
                self setPlayerAngles( spawnAngles );
                self setOrigin( self.origin );
 
                //self.previewModel = self clonePlayer(0);
                self.previewModel = spawn( "script_model", torsoChangePos );
                self.previewModel.angles = headAngles;
 
                self.previewModel hide();
                self.previewModel showToPlayer( self );
                self thread RotatePreview();
 
                self.previewModel SetCharacter( self.pers["torso"], self.pers["head"] );
 
        }
        if( response == "character_close" && isDefined( self.previewModel ) )
        {
                self notify( "end customization" );
                self.previewModel delete();
        }
        switch( response )
        {
        case "torso":
                self.edit = "torso";
 
                self.previewModel.origin = torsoChangePos;
                self.previewModel.angles = self.angles;
                self.previewModel SetCharacter( self.pers["torso"], self.pers["head"] );
 
                self thread RotatePreview();
                break;
 
        case "head":
                self.edit = "head";
 
                self notify( "stop preview rotation" );
       
                self.previewModel detachAll();
                self.previewModel.origin = headChangePos + (0,0,50);
                self.previewModel.angles = headAngles + (270,270,0);
                self.previewModel setModel( level.chm_Heads[self.pers["head"]].v["model"] );
				
				self thread RotatePreview();
                break;
 
        case "next":
                ChangeCharacter( self.edit, "+" );
                break;
        case "previous":
                ChangeCharacter( self.edit, "-" );
                break;
		case "done":
				self closeMenu();
				self closeInGameMenu();
				self openMenu(game["menu_team"]);
                break;
		case "custom_on":
				if(self.pers["custom_player"] == 0)
				{
					self iPrintln("^7You Have Enabled Custom Player Model On Next Spawn");
					self setstat(2354,1);
					self.pers["custom_player"] = 1;
					break;
				}
				else if(self.pers["custom_player"] == 1)
				{
					self iPrintln("^7You Have Disabled Custom Player Model On Next Spawn");
					self setstat(2354,0);
					self.pers["custom_player"] = 0;
					break;
				}
        }
 
}
 
 
ChangeCharacter( change, option )
{
        if( change == "torso" )
        {
                if( option == "+" )
                {
                        self.pers["torso"] ++;
                        if( self.pers["torso"] >= level.chm_Torso.size )
                                self.pers["torso"] = 0;
                }
                else if( option == "-" )
                {
                        self.pers["torso"] --;
                        if( self.pers["torso"] < 0 )
                                self.pers["torso"] = level.chm_Torso.size-1;
                }
 
                self setStat( 1010, self.pers["torso"] );
                self.previewModel SetCharacter( self.pers["torso"], self.pers["head"] );
        }
        else if( change == "head" )
        {
                if( option == "+" )
                {
                        self.pers["head"] ++;
                        if( self.pers["head"] >= level.chm_Heads.size )
                                self.pers["head"] = 0;
                }
                else if( option == "-" )
                {
                        self.pers["head"] --;
                        if( self.pers["head"] < 0 )
                                self.pers["head"] = level.chm_Torso.size-1;
                }
 
                self setStat( 1011, self.pers["head"] );
 
                self.previewModel SetCharacter( self.pers["torso"], self.pers["head"] );
                self.previewModel detachAll();
                self.previewModel setModel( level.chm_Heads[ self.pers["head"] ].v["model"] );
        }
}