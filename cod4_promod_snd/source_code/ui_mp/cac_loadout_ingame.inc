#define LOADOUT_WIDTH           270

#define ORIGIN_X				((-(LOADOUT_WIDTH - RIGHTITEM_OFFSET))-80)
#define ORIGIN_Y				25
#define ORIGIN_LOADOUT          ORIGIN_X ORIGIN_Y

#define VIS_WHEN_ONE_PRIME visible when( dvarstring("loadout_secondary") == "beretta" || dvarstring("loadout_secondary") == "colt45" || dvarstring("loadout_secondary") == "usp" || dvarstring("loadout_secondary") == "deserteagle" || dvarstring("loadout_secondary") == "deserteaglegold" || dvarstring("loadout_secondary") == "knife") 
#define VIS_WHEN_TWO_PRIME visible when( dvarstring("loadout_secondary") != "beretta" && dvarstring("loadout_secondary") != "colt45" && dvarstring("loadout_secondary") != "usp" && dvarstring("loadout_secondary") != "deserteagle" && dvarstring("loadout_secondary") != "deserteaglegold" && dvarstring("loadout_secondary") != "knife") 

/* ================================================================================= */
/* ================================ LOADOUT DISPLAY ================================ */
/* ================================================================================= */
// UI art: Julian version 2 - first pass

// CAC loadout main frame =================

    #define LOADOUT_ALIGN   RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP      
    
    #define LOADOUT_PLATING( py, ph, vis_gradient_top, vis_gradient_bottom ) \
            LOADOUT_PLATING_RAW( ORIGIN_LOADOUT, 0, py, (LOADOUT_WIDTH+8), ph, LOADOUT_ALIGN, vis_gradient_top, vis_gradient_bottom )
        
    // background frame --------

    PREPROC_SHADER_DRAW_ALIGNED( -24 8 -20 217 LOADOUT_ALIGN, ORIGIN_LOADOUT, "gradient", 1 1 1 0.65, 0, 0, 0 0 0 0 )
    PREPROC_SHADER_DRAW_ALIGNED( (LOADOUT_WIDTH+4) 8 20 217 LOADOUT_ALIGN, ORIGIN_LOADOUT, "gradient", 1 1 1 0.65, 0, 0, 0 0 0 0 )

    // primary weapon camo
    PREPROC_SHADER_DRAW_ALIGNED( -4 16 ((LOADOUT_WIDTH+8)/4) 80 LOADOUT_ALIGN, ORIGIN_LOADOUT, tablelookup( "mp/attachmenttable.csv", 11, STAT_CAC_CAMO, 6 ), 1 1 1 0.5, 0, 1, 1 1 1 1) 
    PREPROC_SHADER_DRAW_ALIGNED( (((LOADOUT_WIDTH+8)/4)-4) 16 ((LOADOUT_WIDTH+8)/4) 80 LOADOUT_ALIGN, ORIGIN_LOADOUT, tablelookup( "mp/attachmenttable.csv", 11, STAT_CAC_CAMO, 6 ), 1 1 1 0.5, 0, 1, 1 1 1 1) 
    PREPROC_SHADER_DRAW_ALIGNED( (((LOADOUT_WIDTH+8)/2)-4) 16 ((LOADOUT_WIDTH+8)/4) 80 LOADOUT_ALIGN, ORIGIN_LOADOUT, tablelookup( "mp/attachmenttable.csv", 11, STAT_CAC_CAMO, 6 ), 1 1 1 0.5, 0, 1, 1 1 1 1) 
    PREPROC_SHADER_DRAW_ALIGNED( ((((LOADOUT_WIDTH+8)/4)*3)-4) 16 ((LOADOUT_WIDTH+8)/4) 80 LOADOUT_ALIGN, ORIGIN_LOADOUT, tablelookup( "mp/attachmenttable.csv", 11, STAT_CAC_CAMO, 6 ), 1 1 1 0.5, 0, 1, 1 1 1 1) 

    /* top bar */           LOADOUT_PLATING( 16, 8, 0, 1 )
    /* bottom bar */        LOADOUT_PLATING( 225, 8, 1, 0 )
    /* weapon divider */    LOADOUT_PLATING( 104, 8, 1, 1 )
    /* perk plate */        LOADOUT_PLATING( 188, 8, 1, 1 )


// weapon loadout info display ============
    
    // primary weapon name
    PREPROC_TEXT_DRAW_ALIGNED_EXP( 0 20 (LOADOUT_WIDTH+8) 20 LOADOUT_ALIGN, ORIGIN_LOADOUT, "@"+tablelookup("mp/statstable.csv", 0, STAT_CAC_PRIMARY, 3), TEXTSIZE_DEFAULT, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE )
    // primary weapon attachment name
    PREPROC_TEXT_DRAW_ALIGNED_EXP( 0 74 (LOADOUT_WIDTH+8) 20 LOADOUT_ALIGN, ORIGIN_LOADOUT, "@"+tablelookup("mp/attachmenttable.csv", 9, STAT_CAC_PRIMARY_ATTACHMENT, 3), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, CHOICE_TEXTCOLOR )
    // primary weapon image
    PREPROC_SHADER_DRAW_ALIGNED( 74 10 180 90 LOADOUT_ALIGN, ORIGIN_LOADOUT, tablelookup( "mp/statstable.csv", 0, STAT_CAC_PRIMARY, 6 ), 1 1 1 1, 0, 1, 1 1 1 1) 
    // primary weapon attachment image
    PREPROC_SHADER_DRAW_ALIGNED( 2 42 32 32 LOADOUT_ALIGN, ORIGIN_LOADOUT, tablelookup( "mp/attachmenttable.csv", 9, STAT_CAC_PRIMARY_ATTACHMENT, 6 ), 1 1 1 1, 0, 1, 1 1 1 1)  
    
    // second weapon name
    PREPROC_TEXT_DRAW_ALIGNED_EXP( 0 (20+88) (LOADOUT_WIDTH+8) 20 LOADOUT_ALIGN, ORIGIN_LOADOUT, "@" + tablelookup("mp/statstable.csv", 0, STAT_CAC_SECONDARY, 3), TEXTSIZE_DEFAULT, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE )
    // second weapon attachment name
    PREPROC_TEXT_DRAW_ALIGNED_EXP( 0 (74+88) (LOADOUT_WIDTH+8) 20 LOADOUT_ALIGN, ORIGIN_LOADOUT, "@"+tablelookup("mp/attachmenttable.csv", 9, STAT_CAC_SECONDARY_ATTACHMENT, 3), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, CHOICE_TEXTCOLOR )
    // second weapon image
    PREPROC_SHADER_DRAW_ALIGNED( 74 (6+92) 180 90 LOADOUT_ALIGN, ORIGIN_LOADOUT, tablelookup( "mp/statstable.csv", 0, STAT_CAC_SECONDARY, 6 ), 1 1 1 1, 0, 1, 1 1 1 1 VIS_WHEN_TWO_PRIME ) 
    PREPROC_SHADER_DRAW_ALIGNED( 160 (6+92) 90 90 LOADOUT_ALIGN, ORIGIN_LOADOUT, tablelookup( "mp/statstable.csv", 0, STAT_CAC_SECONDARY, 6 ), 1 1 1 1, 0, 1, 1 1 1 1 VIS_WHEN_ONE_PRIME ) 
    // second weapon attachment image
    PREPROC_SHADER_DRAW_ALIGNED( 2 130 32 32 LOADOUT_ALIGN, ORIGIN_LOADOUT, tablelookup( "mp/attachmenttable.csv", 9, STAT_CAC_SECONDARY_ATTACHMENT, 6 ), 1 1 1 1, 0, 1, 1 1 1 1)   
   
    #define PERK_Y_OFFSET   150
    #define PERK_Y_SPACING  38

    // grenade icons ------------
    PREPROC_SHADER_DRAW_ALIGNED( 0 (PERK_Y_OFFSET-2+(PERK_Y_SPACING)) 32 32 LOADOUT_ALIGN, ((-(LOADOUT_WIDTH - RIGHTITEM_OFFSET))-77) ORIGIN_Y, "weapon_fraggrenade", 1 1 1 1, 0, 1, 1 1 1 1 visible when(  dvarInt( weap_allow_frag_grenade ) ) ) 
    PREPROC_SHADER_DRAW_ALIGNED( 30 (PERK_Y_OFFSET-2+(PERK_Y_SPACING*1)) 32 32 LOADOUT_ALIGN, ORIGIN_LOADOUT, "weapon_smokegrenade", 1 1 1 1, 0, 1, 1 1 1 1 visible when( dvarString( loadout_grenade ) == "smoke_grenade" ) ) 
    PREPROC_SHADER_DRAW_ALIGNED( 30 (PERK_Y_OFFSET-2+(PERK_Y_SPACING*1)) 32 32 LOADOUT_ALIGN, ORIGIN_LOADOUT, "weapon_flashbang", 1 1 1 1, 0, 1, 1 1 1 1 visible when( dvarString( loadout_grenade ) == "flash_grenade" ) ) 
    PREPROC_SHADER_DRAW_ALIGNED( 30 (PERK_Y_OFFSET-2+(PERK_Y_SPACING*1)) 32 32 LOADOUT_ALIGN, ORIGIN_LOADOUT, "hud_throwingknife", 1 1 1 1, 0, 1, 1 1 1 1 visible when( dvarString( loadout_grenade ) == "throwingknife" ) ) 

	
    // grenade counts ------------
    PREPROC_TEXT_DRAW_ALIGNED_EXP( 0 (PERK_Y_OFFSET+4+(PERK_Y_SPACING)) (LOADOUT_WIDTH+8) 20 LOADOUT_ALIGN, ORIGIN_LOADOUT, dvarInt( weap_allow_frag_grenade ), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE visible when( dvarInt( weap_allow_frag_grenade ) ) )

    PREPROC_TEXT_DRAW_ALIGNED_EXP( 30 (PERK_Y_OFFSET+4+(PERK_Y_SPACING)) (LOADOUT_WIDTH+8) 20 LOADOUT_ALIGN, ORIGIN_LOADOUT, dvarInt( weap_allow_flash_grenade ), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE visible when( dvarString( loadout_grenade ) == "flash_grenade" ) )
	
	PREPROC_TEXT_DRAW_ALIGNED_EXP( 30 (PERK_Y_OFFSET+4+(PERK_Y_SPACING)) (LOADOUT_WIDTH+8) 20 LOADOUT_ALIGN, ORIGIN_LOADOUT, dvarInt( weap_allow_smoke_grenade ), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE visible when( dvarString( loadout_grenade ) == "smoke_grenade" ) )	
	
	PREPROC_TEXT_DRAW_ALIGNED_EXP( 30 (PERK_Y_OFFSET+4+(PERK_Y_SPACING)) (LOADOUT_WIDTH+8) 20 LOADOUT_ALIGN, ORIGIN_LOADOUT, dvarInt( weap_allow_throwingknife ), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE visible when( dvarString( loadout_grenade ) == "throwingknife" ) )	