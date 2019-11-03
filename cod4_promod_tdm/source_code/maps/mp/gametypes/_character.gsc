///////////////////////////////////////////////////////////////
////|         |///|        |///|       |/\  \/////  ///|  |////
////|  |////  |///|  |//|  |///|  |/|  |//\  \///  ////|__|////
////|  |////  |///|  |//|  |///|  |/|  |///\  \/  /////////////
////|          |//|  |//|  |///|       |////\    //////|  |////
////|  |////|  |//|         |//|  |/|  |/////    \/////|  |////
////|  |////|  |//|  |///|  |//|  |/|  |////  /\  \////|  |////
////|  |////|  |//|  | //|  |//|  |/|  |///  ///\  \///|  |////
////|__________|//|__|///|__|//|__|/|__|//__/////\__\//|__|////
///////////////////////////////////////////////////////////////
/*
        BraXi's Death Run Mod
       
        E-mail: paulina1295@o2.pl
 
        [DO NOT COPY WITHOUT PERMISSION]
 
// CHARACTER CUSTOMIZATION
 
// bodies
xmodel,body_mp_usmc_recon
xmodel,body_mp_usmc_sniper
 
xmodel,body_mp_arab_regular_assault
xmodel,body_mp_arab_regular_sniper
 
xmodel,body_mp_usmc_woodland_recon
xmodel,body_mp_usmc_woodland_assault
 
// heads
xmodel,head_sp_arab_regular_asad
xmodel,head_sp_arab_regular_ski_mask
 
xmodel,head_sp_opforce_david_beanie_body_c
xmodel,head_sp_spetsnaz_boris_borisbody
xmodel,head_sp_spetsnaz_collins_vladbody
xmodel,head_sp_spetsnaz_yuri_yuribody
 
xmodel,head_sp_sas_woodland_hugh
xmodel,head_sp_usmc_ryan_ryan_body_nod
 
*/
 
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
 
//#include braxi\_common;
//#include braxi\_dvar;
 
init()
{
        level.chm_Torso = [];
        level.chm_Heads = [];
        level.chm_Accesories = [];
 
        // ====== bodies ======
		
        // american
        RegisterTorso( "body_mp_usmc_recon" );
        RegisterTorso( "body_mp_usmc_sniper" );
 
        // arab
        RegisterTorso( "body_mp_arab_regular_assault" );
        RegisterTorso( "body_mp_arab_regular_sniper" );
 
        // english
        RegisterTorso( "body_mp_usmc_woodland_recon" );
        RegisterTorso( "body_mp_usmc_woodland_assault" );
		
		//RegisterTorso( "body_mp_opforce_sniper" );
        //RegisterTorso( "body_mp_opforce_eningeer" );
		
		
        // ====== heads ======
 
        // russian
		RegisterHead( "head_sp_opforce_ski_mask_body_a", true );
		RegisterHead( "head_sp_opforce_gas_mask_body_f", true );
		RegisterHead( "head_sp_opforce_geoff_headset_body_c", true );
		RegisterHead( "head_sp_opforce_fullwrap_body_d", true );
		RegisterHead( "head_sp_opforce_collins_headset_body_d", true );
		RegisterHead( "head_sp_opforce_3hole_ski_mask_body_b", true );
		
        RegisterHead( "head_sp_spetsnaz_yuri_yuribody", true );
		RegisterHead( "head_sp_spetsnaz_demetry_demetrybody", true );
		
        // american
        RegisterHead( "head_sp_sas_woodland_hugh", true );
		RegisterHead( "head_sp_sas_woodland_zied", true );

        RegisterHead( "head_sp_usmc_ryan_ryan_body_nod", true );
		RegisterHead( "head_sp_usmc_james_james_body" , true );
		RegisterHead( "head_sp_usmc_james_james_body_nod" , true );
		RegisterHead( "head_sp_usmc_ryan_ryan_body_nod" , true );
		RegisterHead( "head_sp_usmc_sami_goggles_zach_body" , true );
		
		// arab
		RegisterHead( "head_sp_arab_regular_asad", false );
		RegisterHead( "head_sp_arab_regular_ski_mask", false );
		
		
       
 
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
        spawnAngles = (0,level.spawn["spectator"].angles[1],0);
        self setPlayerAngles( spawnAngles );
 
        torsoChangePos = ( level.spawn["spectator"].origin + (0,0,-20) + vector_scale(anglesToForward(spawnAngles), 100 ) );
        headChangePos = ( (level.spawn["spectator"].origin - (0,0,55)) + vector_scale(anglesToForward(spawnAngles), 30 ) );
       
        headAngles = (0,158,0);
       
        if( !isDefined( self.previewModel ) && response == "character_open" )
        {      
                self.edit = "torso";
                self setPlayerAngles( spawnAngles );
                self setOrigin( level.spawn["spectator"].origin );
 
                //self.previewModel = self clonePlayer(0);
                self.previewModel = spawn( "script_model", torsoChangePos );
                self.previewModel.angles = headAngles;
 
                self.previewModel hide();
                self.previewModel showToPlayer( self );
                self thread RotatePreview();
 
                self.previewModel SetCharacter( self.pers["torso"], self.pers["head"] );
 
        }
        else if( response == "character_close" && isDefined( self.previewModel ) )
        {
                self notify( "end customization" );
                self.previewModel delete();
        }
        switch( response )
        {
        case "torso":
                self.edit = "torso";
 
                self.previewModel.origin = torsoChangePos;
                self.previewModel.angles = level.spawn["spectator"].angles;
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