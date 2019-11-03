#define CHOICE_X_START          0
#define CHOICE_Y_START          34

#include "ui_mp/menustyle.inc"
#include "ui/choices_setup_common.menu"

#define ORIGIN_STATUS           390 64
#define MENU_FONT_COLOR2        1 1 1 0.5

    menuDef {
        name            CAC_MENU_NAME
        rect            0 0 640 480
        focuscolor      COLOR_FOCUSED
        style           WINDOW_STYLE_EMPTY
        blurWorld       7.0
        onOpen {
        }
        onEsc {
            scriptMenuResponse "back";
        }
		
		
		itemDef
        {
            rect                      -107 0 1708 480 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.7
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "animbg_fogscroll"
            textScale                 0.55
            exp                       rect X ( ( ( ( - 107 ) - ( ( float( milliseconds( ) % 60000 ) / 60000 ) * ( 854 ) ) ) ) );
            visible                   when ( ( dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -107 0 1708 480 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.7
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "animbg_fogscrollthin"
            textScale                 0.55
            exp                       rect X ( ( ( ( - 961 ) + ( ( float( milliseconds( ) % 100000 ) / 100000 ) * ( 854 ) ) ) ) );
            visible                   when ( ( dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      0 0 640 480 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_FULLSCREEN
            style                     WINDOW_STYLE_FILLED
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0.28
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            visible                   when ( ( dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      0 0 290 480 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_FULLSCREEN
            style                     WINDOW_STYLE_FILLED
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0.35
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            visible                   when ( ( dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
		itemDef
        {
            rect                      -40 0 1 480 HORIZONTAL_ALIGN_CENTER VERTICAL_ALIGN_TOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.8
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -40 0 8 480 HORIZONTAL_ALIGN_CENTER VERTICAL_ALIGN_TOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.75
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "gradient" ) ) );
            visible                   when ( ( dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
		
		//////////////////////////////////////// MENU ///////////////////////////////////////////
		
		        itemDef
        {
            rect                      -20 40 300 30 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.445 0.457 0.527 0.4
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "menu_button_backg"
            textScale                 0.55
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 67 300 6 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 40 300 30 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            borderSize                1
            foreColor                 0.95294 0.72156 0.21176 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textFont                  UI_FONT_OBJECTIVE
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -25
            textScale                 0.51
            textStyle                 ITEM_TEXTSTYLE_SHADOWED
            text                      "INVENTORY"
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
        }
        itemDef
        {
            rect                      -20 80 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.445 0.457 0.527 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "menu_button_backg"
            textScale                 0.55
            visible                   when ( ( ( localvarint( "ui_highlight_main" ) == 1 ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 80 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.445 0.457 0.527 0.4
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "menu_button_backg"
            textScale                 0.55
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 102 300 4 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.7
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ( localvarint( "ui_highlight_main" ) == 1 ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 102 300 4 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.2
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 80 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            type                      ITEM_TYPE_BUTTON
            textFont                  UI_FONT_OBJECTIVE
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -25
            textScale                 0.39
            textStyle                 ITEM_TEXTSTYLE_SHADOWED
            text                      "Primary Weapon ^7<"
            action                    { play mouse_click ; uiScript openMenuOnDvar loadout_class assault ocd_popup_cac_assault ; uiScript openMenuOnDvar loadout_class specops ocd_popup_cac_specops ; uiScript openMenuOnDvar loadout_class demolitions ocd_popup_cac_demolitions ; uiScript openMenuOnDvar loadout_class sniper ocd_popup_cac_sniper ; ;  }
            onFocus                   { play mouse_over ; setLocalVarString ui_choicegroup play_cac_ingame ; ; setLocalVarInt ui_highlight_main 1 ; ;  }
            leaveFocus                { setLocalVarInt ui_highlight_main 0 ;  }
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
        }
        itemDef
        {
            rect                      -20 105 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.445 0.457 0.527 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "menu_button_backg"
            textScale                 0.55
            visible                   when ( ( ( localvarint( "ui_highlight_main" ) == 2 ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 105 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.445 0.457 0.527 0.4
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "menu_button_backg"
            textScale                 0.55
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 127 300 4 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.7
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ( localvarint( "ui_highlight_main" ) == 2 ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 127 300 4 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.2
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 105 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            type                      ITEM_TYPE_BUTTON
            textFont                  UI_FONT_OBJECTIVE
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -25
            textScale                 0.39
            textStyle                 ITEM_TEXTSTYLE_SHADOWED
            text                      "Primary Attachment ^7<"
            action                    { play mouse_click ; uiScript openMenuOnDvar loadout_class assault ocd_attachment_popup_assault ; uiScript openMenuOnDvar loadout_class specops ocd_attachment_popup_specops ; ;  }
            onFocus                   { play mouse_over ; setLocalVarString ui_choicegroup play_cac_ingame ; setLocalVarInt ui_highlight_main 2 ; ;  }
            leaveFocus                { setLocalVarInt ui_highlight_main 0 ;  }
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
        }
        itemDef
        {
            rect                      -20 130 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.445 0.457 0.527 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "menu_button_backg"
            textScale                 0.55
            visible                   when ( ( ( localvarint( "ui_highlight_main" ) == 3 ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 130 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.445 0.457 0.527 0.4
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "menu_button_backg"
            textScale                 0.55
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 152 300 4 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.7
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ( localvarint( "ui_highlight_main" ) == 3 ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 152 300 4 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.2
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 130 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            type                      ITEM_TYPE_BUTTON
            textFont                  UI_FONT_OBJECTIVE
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -25
            textScale                 0.39
            textStyle                 ITEM_TEXTSTYLE_SHADOWED
            text                      "Side Arm ^7<"
            action                    { play mouse_click ; open ocd_popup_cac_secondary ; ;  }
            onFocus                   { play mouse_over ; setLocalVarString ui_choicegroup play_cac_ingame ; setLocalVarInt ui_highlight_main 3 ; ;  }
            leaveFocus                { setLocalVarInt ui_highlight_main 0 ;  }
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
        }
        itemDef
        {
            rect                      -20 155 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.445 0.457 0.527 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "menu_button_backg"
            textScale                 0.55
            visible                   when ( ( ( localvarint( "ui_highlight_main" ) == 4 ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 155 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.445 0.457 0.527 0.4
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "menu_button_backg"
            textScale                 0.55
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 177 300 4 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.7
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ( localvarint( "ui_highlight_main" ) == 4 ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 177 300 4 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.2
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 155 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            type                      ITEM_TYPE_BUTTON
            textFont                  UI_FONT_OBJECTIVE
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -25
            textScale                 0.39
            textStyle                 ITEM_TEXTSTYLE_SHADOWED
            text                      "Grenade ^7<"
            action                    { play mouse_click ; open ocd_popup_cac_extra ; ;  }
            onFocus                   { play mouse_over ; setLocalVarString ui_choicegroup play_cac_ingame ; setLocalVarInt ui_highlight_main 4 ; ;  }
            leaveFocus                { setLocalVarInt ui_highlight_main 0 ;  }
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
        }
        itemDef
        {
            rect                      -20 180 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.445 0.457 0.527 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "menu_button_backg"
            textScale                 0.55
            visible                   when ( ( ( localvarint( "ui_highlight_main" ) == 5 ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 180 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.445 0.457 0.527 0.4
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "menu_button_backg"
            textScale                 0.55
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 202 300 4 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.7
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ( localvarint( "ui_highlight_main" ) == 5 ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 202 300 4 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.2
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 180 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            type                      ITEM_TYPE_BUTTON
            textFont                  UI_FONT_OBJECTIVE
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -25
            textScale                 0.39
            textStyle                 ITEM_TEXTSTYLE_SHADOWED
            text                      "^1Special ^7Camo by #SLeS ^7<"
            action                    { play mouse_click ; open ocd_popup_cac_camo ; ;  }
            onFocus                   { play mouse_over ; setLocalVarString ui_choicegroup play_cac_ingame ; setLocalVarInt ui_highlight_main 5 ; ;  }
            leaveFocus                { setLocalVarInt ui_highlight_main 0 ;  }
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
        }
        itemDef
        {
            rect                      -20 205 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.445 0.457 0.527 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "menu_button_backg"
            textScale                 0.55
            visible                   when ( ( ( localvarint( "ui_highlight_main" ) == 6 ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 205 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.445 0.457 0.527 0.4
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "menu_button_backg"
            textScale                 0.55
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 227 300 4 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.7
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ( localvarint( "ui_highlight_main" ) == 6 ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 227 300 4 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.2
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 205 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            type                      ITEM_TYPE_BUTTON
            textFont                  UI_FONT_OBJECTIVE
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -25
            textScale                 0.39
            textStyle                 ITEM_TEXTSTYLE_SHADOWED
            text                      "Start ^7<"
            action                    { play mouse_click ; scriptMenuResponse go ; ;  }
            onFocus                   { play mouse_over ; setLocalVarString ui_choicegroup play_cac_ingame ; setLocalVarInt ui_highlight_main 6 ; ;  }
            leaveFocus                { setLocalVarInt ui_highlight_main 0 ;  }
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
        }
        itemDef
        {
            rect                      -20 265 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.445 0.457 0.527 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "menu_button_backg"
            textScale                 0.55
            visible                   when ( ( ( localvarint( "ui_highlight_main" ) == 7 ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 265 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.445 0.457 0.527 0.4
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "menu_button_backg"
            textScale                 0.55
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 287 300 4 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.7
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ( localvarint( "ui_highlight_main" ) == 7 ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 287 300 4 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 1 1 1 0.2
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -20 265 300 22 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            borderSize                1
            foreColor                 1 1 1 0.6
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            type                      ITEM_TYPE_BUTTON
            textFont                  UI_FONT_OBJECTIVE
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -25
            textScale                 0.39
            textStyle                 ITEM_TEXTSTYLE_SHADOWED
            text                      "Back ^7<"
            action                    { play mouse_click ; scriptMenuResponse "back" ; ; ;  }
            onFocus                   { play mouse_over ; setLocalVarInt ui_highlight_main 7 ; ;  }
            leaveFocus                { setLocalVarInt ui_highlight_main 0 ;  }
            exp                       material ( ( ( "menu_button_backg" ) ) );
            visible                   when ( ( ! localvarbool( "ui_hideBack" ) && dvarint( "sles_oldschool" ) != 1 ) )
        }
		
		///////////////////////////// Custom MSG /////////////////////////////////
		
		itemDef
        {
            rect                      300 385 300 18 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textFont                  UI_FONT_OBJECTIVE
            textAlign                 ITEM_ALIGN_TOP_LEFT
            textScale                 0.25
            textStyle                 ITEM_TEXTSTYLE_SHADOWED
            exp                       text ( "> ^3This server offered new features for improve your gaming experience."  );
            visible                   when ( ( ( dvarint( "sles_oldschool" ) != 1 ) ) )
            decoration                
        }
		
		itemDef
        {
            rect                      300 400 300 18 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textFont                  UI_FONT_OBJECTIVE
            textAlign                 ITEM_ALIGN_TOP_LEFT
            textScale                 0.25
            textStyle                 ITEM_TEXTSTYLE_SHADOWED
            exp                       text ( "> ^7Type ^1!reg ^7to register ^2then ^1^1!xlr ^7to view stats."  );
            visible                   when ( ( ( dvarint( "sles_oldschool" ) != 1 ) ) )
            decoration                
        }
		
		itemDef
        {
            rect                      300 415 300 18 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textFont                  UI_FONT_OBJECTIVE
            textAlign                 ITEM_ALIGN_TOP_LEFT
            textScale                 0.25
            textStyle                 ITEM_TEXTSTYLE_SHADOWED
            exp                       text ( "> ^7Type ^1!ss <player_name> ^7to take player's ^3screenshots."  );
            visible                   when ( ( ( dvarint( "sles_oldschool" ) != 1 ) ) )
            decoration                
        }
		
		itemDef
        {
            rect                      300 430 300 18 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textFont                  UI_FONT_OBJECTIVE
            textAlign                 ITEM_ALIGN_TOP_LEFT
            textScale                 0.25
            textStyle                 ITEM_TEXTSTYLE_SHADOWED
            exp                       text ( "> ^7Type ^1!h ^7to view your ^3commands."  );
            visible                   when ( ( ( dvarint( "sles_oldschool" ) != 1 ) ) )
            decoration                
        }
		
		itemDef
        {
            rect                      300 445 300 18 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textFont                  UI_FONT_OBJECTIVE
            textAlign                 ITEM_ALIGN_TOP_LEFT
            textScale                 0.25
            textStyle                 ITEM_TEXTSTYLE_SHADOWED
            exp                       text ( "> ^7Join our TeamSpeak3 ^1slescod4.tk"  );
            visible                   when ( ( ( dvarint( "sles_oldschool" ) != 1 ) ) )
            decoration                
        }
		
		
		/////////////////////////////// SLES OLD MENU //////////////////////////////////////////////
		
		itemDef
        {
            rect                      0 0 640 480 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_FULLSCREEN
            style                     WINDOW_STYLE_FILLED
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0.75
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textScale                 0.55
            visible                   when ( ( dvarint( "sles_oldschool" ) == 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      20 5 0 0 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            borderSize                1
            foreColor                 1 0.8 0.4 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textFont                  UI_FONT_NORMAL
            textAlign                 ITEM_ALIGN_TOP_LEFT
            textScale                 0.5833
            exp                       text ( ( "INVENTORY" ) );
            visible                   when ( ( dvarint( "sles_oldschool" ) == 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -120 -32 378 64 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.9 0.9 0.95 0.175
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "white"
            textScale                 0.55
            visible                   when ( ( dvarint( "sles_oldschool" ) == 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      258 -32 16 -64 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.9 0.9 0.95 0.175
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "button_highlight_end"
            textScale                 0.55
            visible                   when ( ( dvarint( "sles_oldschool" ) == 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      56 448 528 40 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.9 0.9 0.95 0.175
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "white"
            textScale                 0.55
            visible                   when ( ( dvarint( "sles_oldschool" ) == 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      584 448 16 64 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.9 0.9 0.95 0.175
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "button_highlight_end"
            textScale                 0.55
            visible                   when ( ( dvarint( "sles_oldschool" ) == 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      40 448 -16 64 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.9 0.9 0.95 0.175
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "button_highlight_end"
            textScale                 0.55
            visible                   when ( ( dvarint( "sles_oldschool" ) == 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      -120 464 160 32 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.9 0.9 0.95 0.175
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "white"
            textScale                 0.55
            visible                   when ( ( dvarint( "sles_oldschool" ) == 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      600 464 160 32 HORIZONTAL_ALIGN_SUBLEFT VERTICAL_ALIGN_SUBTOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.9 0.9 0.95 0.175
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "white"
            textScale                 0.55
            visible                   when ( ( dvarint( "sles_oldschool" ) == 1 ) )
            decoration                
        }
        itemDef
        {
            name                      "back"
            rect                      -250 -26 40 20 HORIZONTAL_ALIGN_CENTER VERTICAL_ALIGN_BOTTOM
            style                     WINDOW_STYLE_FILLED
            borderSize                1
            foreColor                 1 1 1 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            type                      ITEM_TYPE_BUTTON
            textFont                  UI_FONT_NORMAL
            textAlignY                18
            textScale                 0.375
            textStyle                 ITEM_TEXTSTYLE_SHADOWED
            text                      "@MENU_BACK"
            mouseEnter                { play mouse_over ;  }
            action                    { play mouse_click ; scriptMenuResponse "back" ; ; ;  }
            visible                   when ( ( 1 && dvarint( "sles_oldschool" ) == 1 ) )
        }
        itemDef
        {
            rect                      0 34 214.5 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            style                     WINDOW_STYLE_SHADER
            borderSize                2
            foreColor                 0.9 0.95 1 0.35
            backColor                 0 0 0 0
            borderColor               0.8 0.95 1 0.4
            outlineColor              0 0 0 0
            background                "gradient_fadein"
            textScale                 0.55
            visible                   when ( ( localvarint( "ui_highlight" ) == 1 && localvarstring( "ui_choicegroup" ) == "" && dvarint( "sles_oldschool" ) == 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      214.5 34 5.5 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.9 0.95 1 0.35
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "button_highlight_end"
            textScale                 0.55
            visible                   when ( ( localvarint( "ui_highlight" ) == 1 && localvarstring( "ui_choicegroup" ) == "" && dvarint( "sles_oldschool" ) == 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      0 34 220 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            borderSize                1
            foreColor                 0.69 0.69 0.69 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            type                      ITEM_TYPE_BUTTON
            textFont                  UI_FONT_NORMAL
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -10
            textScale                 0.4
            textStyle                 ITEM_TEXTSTYLE_SHADOWEDMORE
            action                    { play mouse_click ; play mouse_click ; execOnDvarStringValue loadout_class assault "set selected_weapon_class assault;set ui_weapon_class_selected @MPUI_ASSAULT_RIFLES" ; execOnDvarStringValue loadout_class specops "set selected_weapon_class specops;set ui_weapon_class_selected @MPUI_SUB_MACHINE_GUNS" ; execOnDvarStringValue loadout_class demolitions "set selected_weapon_class demolitions;set ui_weapon_class_selected @MPUI_SHOTGUNS" ; execOnDvarStringValue loadout_class sniper "set selected_weapon_class sniper;set ui_weapon_class_selected @MPUI_SNIPER_RIFLES" ; uiScript openMenuOnDvar loadout_class assault ocd_popup_cac_assault ; uiScript openMenuOnDvar loadout_class specops ocd_popup_cac_SMG ; uiScript openMenuOnDvar loadout_class demolitions ocd_popup_cac_shotgun ; uiScript openMenuOnDvar loadout_class sniper ocd_popup_cac_sniper ; ;  }
            onFocus                   { play mouse_over ; setLocalVarInt ui_highlight 1 ; setLocalVarString ui_choicegroup  ; ;  }
            leaveFocus                { setLocalVarInt ui_highlight 0 ; ;  }
            exp                       text ( ( "1. Primary Weapon" ) );
            visible                   when ( ( dvarint( "sles_oldschool" ) == 1 ) )
        }
        itemDef
        {
            rect                      0 58 214.5 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            style                     WINDOW_STYLE_SHADER
            borderSize                2
            foreColor                 0.9 0.95 1 0.35
            backColor                 0 0 0 0
            borderColor               0.8 0.95 1 0.4
            outlineColor              0 0 0 0
            background                "gradient_fadein"
            textScale                 0.55
            visible                   when ( ( localvarint( "ui_highlight" ) == 2 && localvarstring( "ui_choicegroup" ) == "" && dvarint( "sles_oldschool" ) == 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      214.5 58 5.5 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.9 0.95 1 0.35
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "button_highlight_end"
            textScale                 0.55
            visible                   when ( ( localvarint( "ui_highlight" ) == 2 && localvarstring( "ui_choicegroup" ) == "" && dvarint( "sles_oldschool" ) == 1) )
            decoration                
        }
        itemDef
        {
            rect                      0 58 220 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            borderSize                1
            foreColor                 0.69 0.69 0.69 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            type                      ITEM_TYPE_BUTTON
            textFont                  UI_FONT_NORMAL
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -10
            textScale                 0.4
            textStyle                 ITEM_TEXTSTYLE_SHADOWEDMORE
            action                    { play mouse_click ; play mouse_click ; uiScript openMenuOnDvar loadout_class assault ocd_attachment_popup_assault ; uiScript openMenuOnDvar loadout_class specops ocd_attachment_popup_SMG ; uiScript openMenuOnDvar loadout_class demolitions ocd_attachment_popup_shotgun ; uiScript openMenuOnDvar loadout_class sniper ocd_attachment_popup_sniper ; ;  }
            onFocus                   { play mouse_over ; setLocalVarInt ui_highlight 2 ; setLocalVarString ui_choicegroup  ; ;  }
            leaveFocus                { setLocalVarInt ui_highlight 0 ; ;  }
            exp                       text ( ( "2. Primary Attachment" ) );
            visible                   when ( ( dvarstring( "loadout_primary" ) != "mp44" && dvarstring( "loadout_class" ) != "demolitions" && dvarstring( "loadout_class" ) != "sniper" ) && dvarint( "sles_oldschool" ) == 1 )
        }
        itemDef
        {
            rect                      0 58 220 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            borderSize                1
            foreColor                 0.5 0.5 0.5 0.5
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textFont                  UI_FONT_NORMAL
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -10
            textScale                 0.4
            textStyle                 ITEM_TEXTSTYLE_SHADOWEDMORE
            exp                       text ( ( "2. Primary Attachment" ) );
            visible                   when ( ( dvarstring( "loadout_primary" ) == "mp44" || dvarstring( "loadout_class" ) == "demolitions" || dvarstring( "loadout_class" ) == "sniper" ) && dvarint( "sles_oldschool" ) == 1 )
            decoration                
        }
        itemDef
        {
            rect                      0 82 214.5 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            style                     WINDOW_STYLE_SHADER
            borderSize                2
            foreColor                 0.9 0.95 1 0.35
            backColor                 0 0 0 0
            borderColor               0.8 0.95 1 0.4
            outlineColor              0 0 0 0
            background                "gradient_fadein"
            textScale                 0.55
            visible                   when ( ( localvarint( "ui_highlight" ) == 3 && localvarstring( "ui_choicegroup" ) == "" && dvarint( "sles_oldschool" ) == 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      214.5 82 5.5 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.9 0.95 1 0.35
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "button_highlight_end"
            textScale                 0.55
            visible                   when ( ( localvarint( "ui_highlight" ) == 3 && localvarstring( "ui_choicegroup" ) == "" && dvarint( "sles_oldschool" ) == 1) )
            decoration                
        }
        itemDef
        {
            rect                      0 82 220 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            borderSize                1
            foreColor                 0.69 0.69 0.69 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            type                      ITEM_TYPE_BUTTON
            textFont                  UI_FONT_NORMAL
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -10
            textScale                 0.4
            textStyle                 ITEM_TEXTSTYLE_SHADOWEDMORE
            action                    { play mouse_click ; play mouse_click ; open ocd_popup_cac_secondary ; ;  }
            onFocus                   { play mouse_over ; setLocalVarInt ui_highlight 3 ; setLocalVarString ui_choicegroup  ; ;  }
            leaveFocus                { setLocalVarInt ui_highlight 0 ; ;  }
            exp                       text ( ( "3. Side Arm" ) );
            visible                   when ( ( dvarint( "sles_oldschool" ) == 1 ) )
        }
        itemDef
        {
            rect                      0 106 220 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            borderSize                1
            foreColor                 0.5 0.5 0.5 0.5
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            textFont                  UI_FONT_NORMAL
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -10
            textScale                 0.4
            textStyle                 ITEM_TEXTSTYLE_SHADOWEDMORE
            exp                       text ( ( "4. Grenade" ) );
            visible                   when ( ( ( dvarint( "weap_allow_smoke_grenade" ) != 1 && dvarint( "weap_allow_flash_grenade" ) != 1 ) && dvarint( "sles_oldschool" ) == 1 ) )
            decoration                
        }
        itemDef
        {
            rect                      0 106 214.5 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            style                     WINDOW_STYLE_SHADER
            borderSize                2
            foreColor                 0.9 0.95 1 0.35
            backColor                 0 0 0 0
            borderColor               0.8 0.95 1 0.4
            outlineColor              0 0 0 0
            background                "gradient_fadein"
            textScale                 0.55
            visible                   when ( ( localvarint( "ui_highlight" ) == 4 && localvarstring( "ui_choicegroup" ) == "" ) )
            decoration                
        }
        itemDef
        {
            rect                      214.5 106 5.5 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.9 0.95 1 0.35
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "button_highlight_end"
            textScale                 0.55
            visible                   when ( ( localvarint( "ui_highlight" ) == 4 && localvarstring( "ui_choicegroup" ) == "" ) )
            decoration                
        }
        itemDef
        {
            rect                      0 106 220 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            borderSize                1
            foreColor                 0.69 0.69 0.69 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            type                      ITEM_TYPE_BUTTON
            textFont                  UI_FONT_NORMAL
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -10
            textScale                 0.4
            textStyle                 ITEM_TEXTSTYLE_SHADOWEDMORE
            action                    { play mouse_click ; play mouse_click ; open ocd_popup_cac_extra ; ;  }
            onFocus                   { play mouse_over ; setLocalVarInt ui_highlight 4 ; setLocalVarString ui_choicegroup  ; ;  }
            leaveFocus                { setLocalVarInt ui_highlight 0 ; ;  }
            exp                       text ( ( "4. Grenade" ) );
            visible                   when ( ( ( dvarint( "weap_allow_smoke_grenade" ) == 1 || dvarint( "weap_allow_flash_grenade" ) == 1 ) && dvarint( "sles_oldschool" ) == 1 ) )
        }
        itemDef
        {
            rect                      0 130 214.5 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            style                     WINDOW_STYLE_SHADER
            borderSize                2
            foreColor                 0.9 0.95 1 0.35
            backColor                 0 0 0 0
            borderColor               0.8 0.95 1 0.4
            outlineColor              0 0 0 0
            background                "gradient_fadein"
            textScale                 0.55
            visible                   when ( ( localvarint( "ui_highlight" ) == 5 && localvarstring( "ui_choicegroup" ) == "" ) )
            decoration                
        }
        itemDef
        {
            rect                      214.5 130 5.5 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.9 0.95 1 0.35
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "button_highlight_end"
            textScale                 0.55
            visible                   when ( ( localvarint( "ui_highlight" ) == 5 && localvarstring( "ui_choicegroup" ) == "" ) )
            decoration                
        }
        itemDef
        {
            rect                      0 130 220 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            borderSize                1
            foreColor                 0.69 0.69 0.69 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            type                      ITEM_TYPE_BUTTON
            textFont                  UI_FONT_NORMAL
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -10
            textScale                 0.4
            textStyle                 ITEM_TEXTSTYLE_SHADOWEDMORE
            action                    { play mouse_click ; play mouse_click ; open ocd_popup_cac_camo ; ;  }
            onFocus                   { play mouse_over ; setLocalVarInt ui_highlight 5 ; setLocalVarString ui_choicegroup  ; ;  }
            leaveFocus                { setLocalVarInt ui_highlight 0 ; ;  }
            exp                       text ( ( "5. Camo" ) );
            visible                   when ( ( dvarint( "sles_oldschool" ) == 1 ) )
        }
        itemDef
        {
            rect                      0 154 214.5 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            style                     WINDOW_STYLE_SHADER
            borderSize                2
            foreColor                 0.9 0.95 1 0.35
            backColor                 0 0 0 0
            borderColor               0.8 0.95 1 0.4
            outlineColor              0 0 0 0
            background                "gradient_fadein"
            textScale                 0.55
            visible                   when ( ( localvarint( "ui_highlight" ) == 6 && localvarstring( "ui_choicegroup" ) == "" ) )
            decoration                
        }
        itemDef
        {
            rect                      214.5 154 5.5 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            style                     WINDOW_STYLE_SHADER
            borderSize                1
            foreColor                 0.9 0.95 1 0.35
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            background                "button_highlight_end"
            textScale                 0.55
            visible                   when ( ( localvarint( "ui_highlight" ) == 6 && localvarstring( "ui_choicegroup" ) == "" ) )
            decoration                
        }
        itemDef
        {
            rect                      0 154 220 22 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP
            borderSize                1
            foreColor                 0.69 0.69 0.69 1
            backColor                 0 0 0 0
            borderColor               0 0 0 0
            outlineColor              0 0 0 0
            type                      ITEM_TYPE_BUTTON
            textFont                  UI_FONT_NORMAL
            textAlign                 ITEM_ALIGN_MIDDLE_RIGHT
            textAlignX                -10
            textScale                 0.4
            textStyle                 ITEM_TEXTSTYLE_SHADOWEDMORE
            action                    { play mouse_click ; play mouse_click ; scriptMenuResponse go ; ;  }
            onFocus                   { play mouse_over ; setLocalVarInt ui_highlight 6 ; setLocalVarString ui_choicegroup  ; ;  }
            leaveFocus                { setLocalVarInt ui_highlight 0 ; ;  }
            exp                       text ( ( "6. Start!" ) );
            visible                   when ( ( dvarint( "sles_oldschool" ) == 1 ) )
        }
		
		
		
		
		
		
		
		
		
		
		

        // PRIMARY WEAPON BUTTON =============================================================
        #define CAC_SETUP_ACTION1 \
            play "mouse_click"; \
            uiScript openMenuOnDvar loadout_class assault "ocd_popup_cac_assault"; \
            uiScript openMenuOnDvar loadout_class specops "ocd_popup_cac_specops"; \
            uiScript openMenuOnDvar loadout_class demolitions "ocd_popup_cac_demolitions"; \
            uiScript openMenuOnDvar loadout_class sniper "ocd_popup_cac_sniper";

      
        execKey "1" { CAC_SETUP_ACTION1; }

        #define CAC_SETUP_ACTION_ATTACHMENT \
            play "mouse_click"; \
            uiScript openMenuOnDvar loadout_class assault "ocd_attachment_popup_assault"; \
            uiScript openMenuOnDvar loadout_class specops "ocd_attachment_popup_specops";

        
        execKey "2" { CAC_SETUP_ACTION_ATTACHMENT; }

        // SECONDARY WEAPON/SIDE ARM BUTTON =============================================================
        #define CAC_SETUP_ACTION2 \
            play "mouse_click"; \
            open "ocd_popup_cac_secondary";

       
        execKey "3" { CAC_SETUP_ACTION2; }

        // SPECIAL GRENADE BUTTON =============================================================
        #define CAC_SETUP_ACTION3 \
            play "mouse_click"; \
            open "ocd_popup_cac_extra";

       
        execKey "4" { open "ocd_popup_cac_extra"; }

        #define CAC_SETUP_ACTION4 \
            play "mouse_click"; \
            open "ocd_popup_cac_camo";

        
        execKey "5" { CAC_SETUP_ACTION4; }

        #define CAC_SETUP_ACTIONGO \
            play "mouse_click"; \
            scriptMenuResponse "go";

        execKey "6" { CAC_SETUP_ACTIONGO; }

        #define STAT_CAC_PRIMARY                tableLookup("mp/statstable.csv", 4, dvarString( loadout_primary ), 0)
        #define STAT_CAC_PRIMARY_ATTACHMENT     tableLookup("mp/attachmentTable.csv", 4, dvarString( loadout_primary_attachment ), 9)
        #define STAT_CAC_SECONDARY              tableLookup("mp/statstable.csv", 4, dvarString( loadout_secondary ), 0)
        #define STAT_CAC_SECONDARY_ATTACHMENT   tableLookup("mp/attachmentTable.csv", 4, dvarString( loadout_secondary_attachment ), 9)
        #define STAT_CAC_SPECIAL_GRENADE        tableLookup("mp/statstable.csv", 4, dvarString( loadout_grenade ), 0)
        #define STAT_CAC_CAMO                   tableLookup("mp/attachmentTable.csv", 4, dvarString( loadout_camo ), 11)
        #include "ui_mp/cac_loadout_ingame.inc"
        #include "ui/safearea.menu"
    }

    // close all 2nd and 3rd layer popups on end action
    #define PREPROC_ATTACH_CLOSEALL \
    close "ocd_popup_cac_primary"; \
    close "ocd_popup_cac_secondary"; \
    close "ocd_popup_cac_assault"; \
    close "ocd_popup_cac_specops"; \
    close "ocd_popup_cac_sniper"; \
    close "ocd_popup_cac_demolitions"; \
    close "popup_cac_template"; \
    close "ocd_attachment_popup_assault"; \
    close "ocd_attachment_popup_specops"; \
    close "ocd_attachment_popup_pistol"; \
    close "ocd_popup_cac_camo"; \
    close "ocd_attachment_popup_fake";

    // including weapon data
    #include "ui_mp/weaponinfo.menu"

	#include "ui_mp/popupstyle.inc"
	#include "ui/choices_setup_popmenu.menu"

	#undef CHOICE_SIZE_X
	#define CHOICE_SIZE_X           216

	#undef NEW_X_OFFSET
	#define NEW_X_OFFSET    (0-CHOICE_SIZE_X)

	#undef NEW_Y_OFFSET
	#define NEW_Y_OFFSET    (0-2)

    // ====================================================================================================
    // primary weapon selection ===========================================================================
    // ====================================================================================================
    #define LOCAL_WEAPON_INFO_WINDOW \
        /* weapon information side frame*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH-6) -4 280 CHOICE_POPUP_HEIGHT( 7 ) CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "white", CHOICE_POPUP_BORDER_COLOR, 1, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "attachment" && dvarString(ui_inside_popup) != "camo" ); ) \
        LOADOUT_PLATING_RAW( CHOICE_POPUP_WIDTH 8, -2, 0, 280, (CHOICE_POPUP_HEIGHT( 7 )-4), CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN visible when( dvarString(ui_inside_popup) != "attachment" && dvarString(ui_inside_popup) != "camo" );, 0, 0 )\
        /* weapon image*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+6) 30 256 48 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "gradient_bottom", 1 1 1 0.3, 0, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "attachment" && dvarString(ui_inside_popup) != "camo" ); ) \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+72) -6 180 90 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, tablelookup("mp/statsTable.csv",4,dvarString("ui_primary_highlighted"),6), 1 1 1 1, 0, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "attachment" && dvarString(ui_inside_popup) != "camo" ); ) \
        /* weapon title*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 58 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/statstable.csv",4,dvarString("ui_primary_highlighted"),3), TEXTSIZE_DEFAULT, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE visible when( dvarString(ui_inside_popup) != "attachment" && dvarString(ui_inside_popup) != "camo" ); ) \
        /* weapon desc unlocked*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 80 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/statstable.csv",4,dvarString("ui_primary_highlighted"),7), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, CHOICE_TEXTCOLOR visible 1 )\

    #define LOCAL_PRIMARY_WEAPON_ACTION( weapRef ) \
        play "mouse_click"; \
        scriptMenuResponse "loadout_primary:"weapRef;\
        setdvar loadout_primary weapRef; \
        close self;\
        setdvar loadout_camo camo_none; \

    #define LOCAL_PRIMARY_WEAPON_ACTION2( weapRef ) \
        play "mouse_click"; \
        scriptMenuResponse "loadout_primary:"weapRef;\
        setdvar loadout_primary weapRef; \
        setdvar loadout_primary_attachment none; \
        close self;\
        setdvar loadout_camo camo_none; \

    #define WI_FOCUS_ACTION( weaponRef ) \
        exec "set ui_primary_highlighted "weaponRef;

    #define LOCAL_WEAPON_ITEM( itemNum, weaponName, weaponRef )\
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, "", ;, execnow "set ui_primary_highlighted "weaponRef;, ;, when(!dvarBool( "weap_allow_"weaponRef )); ) \
        CHOICE_DBUTTON_VIS_NOHI( itemNum, weaponName, when(!dvarBool( "weap_allow_"weaponRef )); ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, weaponName, LOCAL_PRIMARY_WEAPON_ACTION( weaponRef ), \
        WI_FOCUS_ACTION( weaponRef ), ;, when(dvarBool( "weap_allow_"weaponRef )); ) \
        CHOICE_HIGHLIGHT( itemNum, when(dvarBool( "weap_allow_"weaponRef )) ) \
        execKey itemNum { LOCAL_PRIMARY_WEAPON_ACTION( weaponRef ) } \

    #define LOCAL_WEAPON_ITEM2( itemNum, weaponName, weaponRef )\
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, "", ;, execnow "set ui_primary_highlighted "weaponRef;, ;, when(!dvarBool( "weap_allow_"weaponRef )); ) \
        CHOICE_DBUTTON_VIS_NOHI( itemNum, weaponName, when(!dvarBool( "weap_allow_"weaponRef )); ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, weaponName, LOCAL_PRIMARY_WEAPON_ACTION2(weaponRef ), \
        WI_FOCUS_ACTION( weaponRef ), ;, when(dvarBool( "weap_allow_"weaponRef )); ) \
        CHOICE_HIGHLIGHT( itemNum, when(dvarBool( "weap_allow_"weaponRef )) ) \
        execKey itemNum { LOCAL_PRIMARY_WEAPON_ACTION2( weaponRef ) } \

    #undef  UI_FOCUSFIRST
    #define UI_FOCUSFIRST "ui_primary_highlighted"

    // primary weapon items
    #define LOCAL_MASTER_WEAPON_GROUP( pos, y_offset )\
    menuDef {\
        IMPROVED_POPUP_SETUP_ONOPEN( "ocd_popup_cac_assault", 7, (CHOICE_X( pos )-2), (CHOICE_Y( pos )-27+y_offset), ;, execnow "set "UI_FOCUSFIRST" "REF_M16"; set ui_inside_popup assault";, 0 )\
        LOCAL_WEAPON_INFO_WINDOW \
        LOCAL_WEAPON_ITEM( 1, "1. M16A4", REF_M16 )\
        LOCAL_WEAPON_ITEM( 2, "2. AK-47", REF_AK47 )\
        LOCAL_WEAPON_ITEM( 3, "3. M4 Carbine", REF_M4 )\
        LOCAL_WEAPON_ITEM( 4, "4. G3", REF_G3 )\
        LOCAL_WEAPON_ITEM( 5, "5. G36C", REF_G36C )\
        LOCAL_WEAPON_ITEM( 6, "6. M14", REF_M14 )\
        LOCAL_WEAPON_ITEM2( 7, "7. MP44", REF_MP44 )\
    }\
    menuDef {\
        IMPROVED_POPUP_SETUP_ONOPEN( "ocd_popup_cac_specops", 7, (CHOICE_X( pos )-2), (CHOICE_Y( pos )-27+y_offset), ;, execnow "set "UI_FOCUSFIRST" "REF_MP5";set ui_inside_popup specops";, 0 )\
        LOCAL_WEAPON_INFO_WINDOW \
        LOCAL_WEAPON_ITEM( 1, "1. MP5", REF_MP5 )\
        LOCAL_WEAPON_ITEM( 2, "2. Mini-Uzi", REF_UZI )\
        LOCAL_WEAPON_ITEM( 3, "3. AK-74u", REF_AK74U )\
    }\
    menuDef {\
        IMPROVED_POPUP_SETUP_ONOPEN( "ocd_popup_cac_demolitions", 7, (CHOICE_X( pos )-2), (CHOICE_Y( pos )-27+y_offset), ;, execnow "set "UI_FOCUSFIRST" "REF_WINCHESTER1200"; set ui_inside_popup demolitions";, 0 )\
        LOCAL_WEAPON_INFO_WINDOW \
        LOCAL_WEAPON_ITEM( 1, "1. W1200", REF_WINCHESTER1200 )\
        LOCAL_WEAPON_ITEM( 2, "2. M1024", REF_BENELLIM4 )\
    }\
    menuDef {\
        IMPROVED_POPUP_SETUP_ONOPEN( "ocd_popup_cac_sniper", 7, (CHOICE_X( pos )-2), (CHOICE_Y( pos )-27+y_offset), ;, execnow "set "UI_FOCUSFIRST" "REF_M40A3"; set ui_inside_popup sniper";, 0 )\
        LOCAL_WEAPON_INFO_WINDOW \
        LOCAL_WEAPON_ITEM( 1, "1. M40A3", REF_M40A3 )\
        LOCAL_WEAPON_ITEM( 2, "2. R700", REF_REMINGTON700 )\
    }
    // primary and second primary weapon selection popup menus
    LOCAL_MASTER_WEAPON_GROUP( 1, 0 )

    // ====================================================================================================
    // primary and second primary attachment selection ====================================================
    // ====================================================================================================
    #define LOCAL_ATTACHMENT_INFO_WINDOW \
        /* attachment information side frame*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH-6) -4 280 CHOICE_POPUP_HEIGHT( 6 ) CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "white", CHOICE_POPUP_BORDER_COLOR, 1, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "camo" ); ) \
        LOADOUT_PLATING_RAW( CHOICE_POPUP_WIDTH 8, -2, 0, 280, (CHOICE_POPUP_HEIGHT( 6 )-4), CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN visible when( dvarString(ui_inside_popup) != "camo" );, 0, 0 ) \
        /* attachment image*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+6) 30 256 48 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "gradient_bottom", 1 1 1 0.3, 0, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "camo" ); ) \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+182) 6 64 64 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, tablelookup("mp/attachmentTable.csv",4,dvarString(ui_attachment_highlighted),6), 1 1 1 1, 0, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "camo" ); ) \
        /* attachment title*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 58 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/attachmentTable.csv",4,dvarString(ui_attachment_highlighted),3), TEXTSIZE_DEFAULT, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE visible when( dvarString(ui_inside_popup) != "camo" ); ) \
        /* attachment desc unlocked*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 80 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/attachmentTable.csv",4,dvarString(ui_attachment_highlighted),7), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, CHOICE_TEXTCOLOR visible 1 )\

    #define LOCAL_ATTACHMENT_ACTION(attachmentName, groupArg ) \
        setdvar loadout_primary_attachment attachmentName; \
        scriptMenuResponse "loadout_primary_attachment:"groupArg":"attachmentName;\
        close self;

    #define LOCAL_ATTACHMENT_ACTION2(attachmentName, groupArg ) \
        setdvar loadout_secondary_attachment attachmentName; \
        scriptMenuResponse "loadout_secondary_attachment:"groupArg":"attachmentName;\
        close self;\
        PREPROC_ATTACH_CLOSEALL

    #define AI_FOCUS_ACTION( groupArg, weaponRef ) \
        exec "set ui_attachment_highlighted "weaponRef;

    #define LOCAL_ATTACHMENT_ITEM( itemNum, groupArg, pname, ptype,name)\
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, "", ;, execnow "set ui_attachment_highlighted "weaponRef;, ;, when(!dvarBool( "attach_allow_"groupArg"_"pname )); ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, name, LOCAL_ATTACHMENT_ACTION(pname, groupArg ), \
        AI_FOCUS_ACTION(groupArg,pname), ;, when( ptype == "primary" && dvarBool( "attach_allow_"groupArg"_"pname ) ); ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, name, LOCAL_ATTACHMENT_ACTION2(pname, groupArg ), \
        AI_FOCUS_ACTION(groupArg,pname), ;, when( ptype == "secondary" && dvarBool( "attach_allow_"groupArg"_"pname ) ); ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, "", ;, AI_FOCUS_ACTION(groupArg,pname), ;, when( !dvarBool( "attach_allow_"groupArg"_"pname ) ); ) \
        CHOICE_DBUTTON_VIS_NOHI( itemNum, name, when( !dvarBool( "attach_allow_"groupArg"_"pname ) ); ) \
        CHOICE_HIGHLIGHT( itemNum, when(dvarBool( "attach_allow_"groupArg"_"pname ) ) )

    // hackaround to work for PC's floating mouse unfocusing
    #undef  UI_FOCUSFIRST
    #define UI_FOCUSFIRST "ui_attachment_highlighted"

    // primary and second primary attachment items
    #define LOCAL_MASTER_ATTACHMENT_GROUP(pos, ptype, y_offset )\
    menuDef { /* assault attachments*/ \
        IMPROVED_POPUP_SETUP_ONOPEN( "ocd_attachment_popup_assault", 6, (CHOICE_X( pos )-2), (CHOICE_Y( pos )+y_offset), ;, execnow "set "UI_FOCUSFIRST" "REF_ATTACHMENT_NONE"; set ui_inside_popup attachment";, 0 )\
        onClose{execnow "set ui_inside_popup 0";} \
        LOCAL_ATTACHMENT_INFO_WINDOW \
        LOCAL_ATTACHMENT_ITEM( 1,"assault", "none", ptype,"1. None" )\
        LOCAL_ATTACHMENT_ITEM( 2,"assault",  "silencer", ptype,"2. Silencer" )\
		execKey 1 { LOCAL_ATTACHMENT_ACTION( "none" , "assault" ) }\
		execKey 2 { LOCAL_ATTACHMENT_ACTION( "silencer" , "assault" ) } \
    }\
    menuDef { /* SMG attachments*/\
        IMPROVED_POPUP_SETUP_ONOPEN( "ocd_attachment_popup_specops", 6, (CHOICE_X( pos )-2), (CHOICE_Y( pos )+y_offset), ;, execnow "set "UI_FOCUSFIRST" "REF_ATTACHMENT_NONE"; set ui_inside_popup attachment";, 0 )\
        onClose{execnow "set ui_inside_popup 0";} \
        LOCAL_ATTACHMENT_INFO_WINDOW \
        LOCAL_ATTACHMENT_ITEM( 1,"specops", "none", ptype,"1. None" )\
        LOCAL_ATTACHMENT_ITEM( 2,"specops",  "silencer", ptype,"2. Silencer" )\
		execKey 1 { LOCAL_ATTACHMENT_ACTION( "none" , "specops" ) } \
		execKey 2 { LOCAL_ATTACHMENT_ACTION( "silencer" , "specops" ) } \
    }

    menuDef { /* fake attachment heading for weapons without attachments to be displayed on top of camo popup */
        IMPROVED_POPUP_SETUP_ONOPEN( "ocd_attachment_popup_fake", 6, (CHOICE_X( 1 )-2), (CHOICE_Y( 1 ) + 44), ;, ;, 0 )
        LOCAL_ATTACHMENT_INFO_WINDOW
        PREPROC_SHADER_DRAW_ALIGNED( 0 -24 (CHOICE_POPUP_WIDTH-4) 22 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "white", 0.15 0.15 0.17 1, 0, 2, CHOICE_POPUP_BORDER_COLOR )
    }

    // side arm attachment selection ======================================================================
    menuDef { /* pistol attachments*/
        IMPROVED_POPUP_SETUP_ONOPEN( "ocd_attachment_popup_pistol", 6, (CHOICE_X( 2 )-2), (CHOICE_Y( 2 )), ;, execnow "set "UI_FOCUSFIRST" "REF_ATTACHMENT_NONE"; set ui_inside_popup attachment";, 0 )
        onClose{execnow "set ui_inside_popup 0";}
        LOCAL_ATTACHMENT_INFO_WINDOW
        LOCAL_ATTACHMENT_ITEM( 1, "pistol", "none", "secondary","1. None" )
        LOCAL_ATTACHMENT_ITEM( 2, "pistol", "silencer", "secondary","2. Silencer" )
		execKey 1 { LOCAL_ATTACHMENT_ACTION2( "none" , "pistol" ) }
		execKey 2 { LOCAL_ATTACHMENT_ACTION2( "silencer" , "pistol" ) }
    }

    // primary and second primary attachment popup menus
    LOCAL_MASTER_ATTACHMENT_GROUP( 1, "primary", 0 )

    // ====================================================================================================
    // side arm selection ===============================================================================
    // ====================================================================================================
    #define LOCAL_SIDEARM_INFO_WINDOW \
        /* sidearm information side frame*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH-6) -4 280 CHOICE_POPUP_HEIGHT( 6 ) CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "white", CHOICE_POPUP_BORDER_COLOR, 1, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "attachment" ); ) \
        LOADOUT_PLATING_RAW( CHOICE_POPUP_WIDTH 8, -2, 0, 280, (CHOICE_POPUP_HEIGHT( 6 )-4), CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN visible when( dvarString(ui_inside_popup) != "attachment" );, 0, 0 )\
        /* sidearm image*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+6) 30 256 48 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "gradient_bottom", 1 1 1 0.3, 0, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "attachment" ); ) \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+138) -12 90 90 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, tablelookup("mp/statsTable.csv",4,dvarString("ui_sidearm_highlighted"),6), 1 1 1 1, 0, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "attachment" ); ) \
        /* sidearm title*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 58 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/statstable.csv",4,dvarString("ui_sidearm_highlighted"),3), TEXTSIZE_DEFAULT, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE visible when( dvarString(ui_inside_popup) != "attachment" ); ) \
        /* sidearm desc unlocked*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 80 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/statstable.csv",4,dvarString("ui_sidearm_highlighted"),7), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, CHOICE_TEXTCOLOR visible 1; )\

    #define LOCAL_SIDEARM_ACTION( weaponRef ) \
            play "mouse_click"; \
            setdvar loadout_secondary weaponRef; \
            setdvar loadout_secondary_attachment NONE; \
            scriptMenuResponse "loadout_secondary:"weaponRef;\
            PREPROC_ATTACH_CLOSEALL

    #define LOCAL_SIDEARM_ACTION2( weaponRef ) \
            play "mouse_click"; \
            setdvar loadout_secondary weaponRef; \
            setdvar loadout_secondary_attachment NONE; \
            scriptMenuResponse "loadout_secondary:"weaponRef;\
            uiScript openMenuOnDvar "selected_weapon_class" pistol "ocd_attachment_popup_pistol";

    #define SI_FOCUS_ACTION( weaponRef ) \
        exec "set ui_sidearm_highlighted "weaponRef;

    #define LOCAL_SIDEARM_ITEM( itemNum, weaponName, weaponRef )\
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, "", ;, execnow "set ui_sidearm_highlighted "weaponRef;, ;, when(!dvarBool( "weap_allow_"weaponRef )); ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, weaponName, LOCAL_SIDEARM_ACTION( weaponRef ), \
        SI_FOCUS_ACTION( weaponRef ), ;, when( dvarBool( "weap_allow_"weaponRef ) && ( weaponRef == REF_DESERTEAGLE || weaponRef == REF_DESERTEAGLEGOLD )); ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, weaponName, LOCAL_SIDEARM_ACTION2( weaponRef ), \
        SI_FOCUS_ACTION( weaponRef ), ;, when( dvarBool( "weap_allow_"weaponRef ) && weaponRef != REF_DESERTEAGLE && weaponRef != REF_DESERTEAGLEGOLD ); ) \
        CHOICE_DBUTTON_VIS_NOHI( itemNum, weaponName, when( !dvarBool( "weap_allow_"weaponRef ) ); ) \
        CHOICE_HIGHLIGHT( itemNum, when(dvarBool( "weap_allow_"weaponRef )) ) \
        execKey itemNum { LOCAL_SIDEARM_ACTION(weaponRef); }
    // side arm selection popup menu

    // hackaround to work for PC's floating mouse unfocusing
    #undef  UI_FOCUSFIRST
    #define UI_FOCUSFIRST "ui_sidearm_highlighted"

    menuDef
    {
        IMPROVED_POPUP_SETUP_ONOPEN( "ocd_popup_cac_secondary", 6, (CHOICE_X( 2 )-2), (CHOICE_Y( 2 )), ;, execnow "set "UI_FOCUSFIRST" "REF_DESERTEAGLEGOLD"; set selected_weapon_class pistol; set ui_inside_popup pistol";, 1 )
        onClose{execnow "set ui_inside_popup 0";}
        LOCAL_SIDEARM_INFO_WINDOW
        LOCAL_SIDEARM_ITEM( 1, "1. Gold Desert Eagle", REF_DESERTEAGLEGOLD )
        LOCAL_SIDEARM_ITEM( 2, "2. Desert Eagle",  REF_DESERTEAGLE )
        LOCAL_SIDEARM_ITEM( 3, "3. M1911 .45",  REF_COLT45 )
        LOCAL_SIDEARM_ITEM( 4, "4. USP .45",  REF_USP )
        LOCAL_SIDEARM_ITEM( 5, "5. M9", REF_M9BERETTA )
    }

    // ====================================================================================================
    // camo skin selection ================================================================================
    // ====================================================================================================
    #define LOCAL_CAMO_INFO_WINDOW \
        /* camo information side frame*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH-6) -4 280 CHOICE_POPUP_HEIGHT( 7 ) CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "white", CHOICE_POPUP_BORDER_COLOR, 1, 2, CHOICE_POPUP_BORDER_COLOR ) \
        LOADOUT_PLATING_RAW( CHOICE_POPUP_WIDTH 8, -2, 0, 280, (CHOICE_POPUP_HEIGHT( 7 )-4), CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0, 0 )\
        /* camo image*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+6) 30 256 48 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "gradient_bottom", 1 1 1 0.3, 0, 2, CHOICE_POPUP_BORDER_COLOR ) \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+184) 0 64 64 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, tablelookup("mp/attachmentTable.csv",4,dvarString("ui_camo_highlighted"),6), 1 1 1 0.75, 1, 7, 0.2 0.2 0.225 1 ) \
        /* camo title*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 58 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/attachmenttable.csv",4,dvarString("ui_camo_highlighted"),3), TEXTSIZE_DEFAULT, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE ) \
        /* camo desc unlocked*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 80 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/attachmenttable.csv",4,dvarString("ui_camo_highlighted"),7), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, CHOICE_TEXTCOLOR visible when( 1 ); )\

    #define LOCAL_CAMO_ACTION( camoRef ) \
            play "mouse_click"; \
            setdvar loadout_camo camoRef;\
            scriptMenuResponse "loadout_camo:"camoRef;\
            PREPROC_ATTACH_CLOSEALL

    #define LOCAL_CAMO_ITEM( itemNum, camoName, camoRef, visArg )\
        CHOICE_HIGHLIGHT( itemNum, visArg ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, camoName, LOCAL_CAMO_ACTION( camoRef );, execnow "set ui_camo_highlighted "camoRef;, ;, visArg )  \
        execKey itemNum { LOCAL_CAMO_ACTION( camoRef ) }

    // hackaround to work for PC's floating mouse unfocusing
    #undef  UI_FOCUSFIRST
    #define UI_FOCUSFIRST "ui_camo_highlighted"

    // camo skin selection for primary weapon popup menu
    #define LOCAL_CAMO_GROUP( prefix, onLeave )\
    menuDef \
    {\
        IMPROVED_POPUP_SETUP_ONOPEN( "ocd_popup_cac_camo"prefix, 7, (CHOICE_X( 1 )-2), (CHOICE_Y( 1 )+68), ;, execnow "set "UI_FOCUSFIRST" "REF_CAMO_NONE"; set ui_inside_popup camo";, 0 )\
        onClose{onLeave;} \
        LOCAL_CAMO_INFO_WINDOW \
        LOCAL_CAMO_ITEM( 1, "1. None", REF_CAMO_NONE, 1 )\
        LOCAL_CAMO_ITEM( 2, "2. ^6SLeS Camo#1", REF_BROCKHUARD, 1 )\
        LOCAL_CAMO_ITEM( 3, "3. ^2SLeS Camo#2", REF_BUSHDWELLER,  1 )\
        LOCAL_CAMO_ITEM( 4, "4. ^3SLeS Camo#3", REF_BLACKWHITEMARPAT,  1 )\
        LOCAL_CAMO_ITEM( 5, "5. ^1SLeS Camo#4", REF_TIGERRED,  1 )\
        LOCAL_CAMO_ITEM( 6, "6. ^4SLeS Camo#5", REF_STAGGER, 1 )\
        LOCAL_CAMO_ITEM( 7, "7. Golden", REF_GOLDEN,  when(dvarString(loadout_primary) == "m1014" || dvarString(loadout_primary) == "ak47" || dvarString(loadout_primary) == "uzi" ) ) \
        CHOICE_DBUTTON_VIS_NOHI( 7, "7. Golden", when(dvarString(loadout_primary) != "m1014" && dvarString(loadout_primary) != "ak47" && dvarString(loadout_primary) != "uzi" ) )  \
    }

    // camo skin selection for primary weapon popup menu
    LOCAL_CAMO_GROUP( "", execnow "set ui_inside_popup attachment" )
    // camo skin selection for primary weapon without attachments
    LOCAL_CAMO_GROUP( "2", execnow "set ui_inside_popup 0"; close "ocd_attachment_popup_fake" )


    // ====================================================================================================
    // special grenade selection ==========================================================================
    // ====================================================================================================
    #define LOCAL_SGRENADE_INFO_WINDOW \
        /* special grenade information side frame*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH-6) -4 280 CHOICE_POPUP_HEIGHT(5) CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "white", CHOICE_POPUP_BORDER_COLOR, 1, 2, CHOICE_POPUP_BORDER_COLOR ) \
        LOADOUT_PLATING_RAW( CHOICE_POPUP_WIDTH 8, -2, 0, 280, (CHOICE_POPUP_HEIGHT(5)-4), CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN visible when( dvarString(ui_inside_popup) != "attachment" );, 0, 0 )\
        /* special grenade image*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+6) 6 256 48 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "gradient_bottom", 1 1 1 0.3, 0, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "attachment" ); ) \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+178) -6 64 64 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, tablelookup("mp/statsTable.csv",4,dvarString("ui_sgrenade_highlighted"),6), 1 1 1 1, 0, 2, CHOICE_POPUP_BORDER_COLOR ) \
        /* special grenade title*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 34 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/statstable.csv",4,dvarString("ui_sgrenade_highlighted"),3), TEXTSIZE_DEFAULT, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE ) \
        /* special grenade desc unlocked*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 56 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/statstable.csv",4,dvarString("ui_sgrenade_highlighted"),7), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, CHOICE_TEXTCOLOR ) \

    #define LOCAL_SGRENADE_ACTION( weaponRef ) \
            play "mouse_click"; \
            setdvar loadout_grenade weaponRef; \
            scriptMenuResponse "loadout_grenade:"weaponRef;\
            close "ocd_popup_cac_extra"

    #define LOCAL_SGRENADE_ITEM( itemNum, weaponName, weaponRef )\
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, "", ;, execnow "set ui_sgrenade_highlighted "weaponRef;, ;, when(!dvarBool( "weap_allow_"weaponRef )); ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, weaponName, LOCAL_SGRENADE_ACTION( weaponRef ), \
        execnow "set ui_sgrenade_highlighted "weaponRef, ;, when(dvarBool("weap_allow_"weaponRef))) \
        CHOICE_DBUTTON_VIS_NOHI( itemNum, weaponName, when(!dvarBool("weap_allow_"weaponRef) ); ) \
        CHOICE_HIGHLIGHT( itemNum, when(dvarBool( "weap_allow_"weaponRef )) ) \
        execKey itemNum { LOCAL_SGRENADE_ACTION( weaponRef ) }

    // hackaround to work for PC's floating mouse unfocusing
    #undef  UI_FOCUSFIRST
    #define UI_FOCUSFIRST "ui_sgrenade_highlighted"

    // special grenade selection popup menus
    menuDef
    {
        IMPROVED_POPUP_SETUP_ONOPEN( "ocd_popup_cac_extra", 5, (CHOICE_X( 3 )-2), (CHOICE_Y( 3 )+4), ;, execnow "set "UI_FOCUSFIRST" "REF_FLASH_X1"; set ui_inside_popup sgrenade";, 1 )
        onClose{ execnow "set ui_inside_popup 0"; }
        LOCAL_SGRENADE_INFO_WINDOW
        LOCAL_SGRENADE_ITEM( 1, "1. Flash", REF_FLASH_X1 )
        LOCAL_SGRENADE_ITEM( 2, "2. Smoke", REF_SMOKE_X1 )
    }