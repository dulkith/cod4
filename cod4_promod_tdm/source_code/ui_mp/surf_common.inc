/*
	Call of Duty 4: Surf Mod
	Copyright (C) 2016  Jordy Rymenants

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#define rank (stat(2350)+1)
#define CHARACTER_TABLE "mp/characterTable.csv"
#define HANDS_TABLE "mp/handsTable.csv"
#define ITEM_TABLE "mp/itemTable.csv"
#define KNIVES_TABLE "mp/knivesTable.csv"
#define TRAILS_TABLE "mp/trailTable.csv"

#ifndef SURF_BUTTON_FORECOLOR
	#define SURF_BUTTON_FORECOLOR 1 1 1 1
	#define SURF_BUTTON_BACKCOLOR 0.3 0.3 0.3 0.3
	#define SURF_BUTTON_BACKCOLOR_FOCUSED 0.4 0.4 0.4 0.4
	#define SURF_BUTTON_BORDERCOLOR 0.5 0.5 0.5 0.15
#endif

#ifndef SURF_BUTTON_ALIGN
	#define SURF_BUTTON_ALIGN HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_FULLSCREEN
#endif

#define SURF_CHOICE_BUTTON_VIS( itemIndex, textArg, actionArg, visArg ) \
		SURF_CHOICE_BUTTON_BG( itemIndex, visArg ) \
		SURF_CHOICE_HIGHLIGHT( itemIndex, 1 ) \
		SURF_CHOICE_BUTTON_VIS_NOHI( itemIndex, textArg, actionArg, visArg )

#define SURF_CHOICE_HIGHLIGHT( itemIndex, vis ) \
	SURF_CHOICE_HIGHLIGHT_CUSTOM( itemIndex, HIGHLIGHT_COLOR, HIGHLIGHT_BORDER_COLOR, vis )

#define SURF_CHOICE_HIGHLIGHT_CUSTOM( itemIndex, foreColorArg, borderColorArg, visArg ) \
		itemDef \
		{ \
			style			WINDOW_STYLE_SHADER \
			rect			CHOICE_ORIGIN( itemIndex ) (CHOICE_SIZE_X-(CHOICE_SIZE_Y/4) + 8) CHOICE_SIZE_Y CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN \
			background		HIGHLIGHT_SHADER \
			forecolor		foreColorArg \
			border			HIGHLIGHT_BORDER \
			bordersize		2 \
			bordercolor		borderColorArg \
			visible			when( localVarInt( ui_highlight ) == itemIndex && localVarString( ui_choicegroup ) == CHOICE_GROUP ); \
			decoration \
		} \
		CHOICE_ACCEPT_HINT( itemIndex, visArg )

#define SURF_CHOICE_BUTTON_BG( itemIndex, visArg ) SURF_CHOICE_BUTTON_BG_RAW( itemIndex, "gradient_fadein", BUTTON_BG_COLOR, visArg )

#define SURF_CHOICE_BUTTON_BG_RAW( itemIndex, bgimage, foreColorArg, visArg ) \
		itemDef \
		{ \
			style			WINDOW_STYLE_FILLED \
			rect			CHOICE_ORIGIN( itemIndex ) (CHOICE_SIZE_X-(CHOICE_SIZE_Y/4) + 8) CHOICE_SIZE_Y CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN \
			backcolor		foreColorArg \
			forecolor		1 1 1 1 \
			visible			visArg; \
			decoration \
		} \

#define SURF_CHOICE_BUTTON_VIS_NOHI( itemIndex, textArg, actionArg, visArg ) \
		SURF_CHOICE_BUTTON_FOCUS_VIS_NOHI( itemIndex, textArg, actionArg, ;, ;, visArg )

#define SURF_CHOICE_BUTTON_FOCUS_VIS_NOHI( itemIndex, textArg, actionArg, onFocusArg, leaveFocusArg, visArg ) \
		SURF_CHOICE_BUTTON_FOCUS_VIS_NOHI_EX( itemIndex, textArg, actionArg, onFocusArg, leaveFocusArg, visArg, ; )

#define SURF_CHOICE_BUTTON_FOCUS_VIS_NOHI_EX( itemIndex, textArg, actionArg, onFocusArg, leaveFocusArg, visArg, extraArgs ) \
		itemDef \
		{ \
			type			ITEM_TYPE_BUTTON \
			rect			CHOICE_RECT( itemIndex ) \
			exp				text( textArg ); \
			textfont		CHOICE_TEXTFONT \
			textscale		CHOICE_TEXTSIZE \
			textstyle		CHOICE_TEXTSTYLE \
			textAlign		ITEM_ALIGN_MIDDLE_LEFT \
			textAlignX		22 \
			forecolor		CHOICE_TEXTCOLOR \
			visible			visArg \
			extraArgs \
			CHOICE_SCRIPTS_ALL( itemIndex, actionArg, onFocusArg, leaveFocusArg ) \
		} \

#define SURF_BUTTON( id, x, y, w, h, itemName, itemAction, visArg ) \
		SURF_BUTTON_EXT( id, x, y, w, h, itemName, itemAction, ;, ;, visArg )

#define SURF_BUTTON_EXT( id, x, y, w, h, itemName, itemAction, onItemEnter, onItemExit, visArg ) \
itemDef \
{ \
	visible			visArg \
	name			"button_default"id \
	rect			(x+90) y w h SURF_BUTTON_ALIGN \
	style			WINDOW_STYLE_FILLED \
	border			0 \
	bordercolor		SURF_BUTTON_BORDERCOLOR \ 
	forecolor		SURF_BUTTON_FORECOLOR \ 
	backcolor		SURF_BUTTON_BACKCOLOR \
} \
itemDef \
{ \
	visible			0 \
	name			"button_over"id \
	rect			(x+90) y w h SURF_BUTTON_ALIGN \
	style			WINDOW_STYLE_FILLED \
	border			0 \
	bordercolor		SURF_BUTTON_BORDERCOLOR \ 
	forecolor		SURF_BUTTON_FORECOLOR \ 
	backcolor		SURF_BUTTON_BACKCOLOR_FOCUSED \
} \
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y w h SURF_BUTTON_ALIGN \
	forecolor	1 1 1 0.85 \
	exp			text( itemName ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_CENTER \
	textscale	0.3 \
	textalignx	0 \
	textaligny	(h-8) \
	visible		visArg \
	mouseEnter \
	{ \
		play "mouse_over"; \
		show "button_over"id; \
		hide "button_default"id; \
		onItemEnter \
	} \
	mouseExit \
	{ \
		show "button_default"id; \
		hide "button_over"id; \
		onItemExit \
	} \
	action \
	{ \
		itemAction \
	} \
}

#define SURF_WEAPON( x, y, itemID, menuResponse ) \
itemDef \
{ \
	visible			when( dvarString( "customization_menu" ) == "weapon" ) \
	rect			(x+90) y 128 28 SURF_BUTTON_ALIGN \
	style			WINDOW_STYLE_FILLED \
	border			0 \
	bordercolor		SURF_BUTTON_BORDERCOLOR \ 
	forecolor		SURF_BUTTON_FORECOLOR \ 
	backcolor		SURF_BUTTON_BACKCOLOR \
} \
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	1 1 1 0.8 \
	exp			text( tableLookup(ITEM_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "weapon" && rank >= tableLookup(ITEM_TABLE, 0, itemID, 2) ) /*unlocked*/ \
	mouseEnter \
	{ \
		play "mouse_over"; \
	} \
	action \
	{ \
		scriptMenuResponse menuResponse; \
		setdvar customization_menu "none"; \
	} \
} \ 
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	0.8 0.8 0.8 0.6 \
	exp			text( tableLookup(ITEM_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "weapon" && rank < tableLookup(ITEM_TABLE, 0, itemID, 2) ) /*locked*/ \
} \
itemDef \
{ \
	visible		when( dvarString( "customization_menu" ) == "weapon" && rank < tableLookup(ITEM_TABLE, 0, itemID, 2) ) /*locked*/ \
	origin		x y \
	textscale	0.22 \
	textalignx 	208 \
	textaligny	19 \
	forecolor	1 1 1 0.8 \
	exp			text( "^1LOCKED ("+tableLookup(ITEM_TABLE, 0, itemID, 2)+")" ) \
	textfont	UI_FONT_NORMAL \
	textalign	ITEM_ALIGN_RIGHT \
	textscale	0.2 \
	decoration \
}

#define SURF_CHARACTER( x, y, itemID, menuResponse ) \
itemDef \
{ \
	visible			when( dvarString( "customization_menu" ) == "character" ) \
	rect			(x+90) y 128 28 SURF_BUTTON_ALIGN \
	style			WINDOW_STYLE_FILLED \
	border			0 \
	bordercolor		SURF_BUTTON_BORDERCOLOR \ 
	forecolor		SURF_BUTTON_FORECOLOR \ 
	backcolor		SURF_BUTTON_BACKCOLOR \
} \
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	1 1 1 0.8 \
	exp			text( tableLookup(CHARACTER_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "character" && rank >= tableLookup(CHARACTER_TABLE, 0, itemID, 2) ) /*unlocked*/ \
	mouseEnter \
	{ \
		play "mouse_over"; \
	} \
	action \
	{ \
		scriptMenuResponse menuResponse; \
		setdvar customization_menu "none"; \
	} \
} \ 
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	0.8 0.8 0.8 0.6 \
	exp			text( tableLookup(CHARACTER_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "character" && rank < tableLookup(CHARACTER_TABLE, 0, itemID, 2) ) /*locked*/ \
} \
itemDef \
{ \
	visible		when( dvarString( "customization_menu" ) == "character" && rank < tableLookup(CHARACTER_TABLE, 0, itemID, 2) ) /*locked*/ \
	origin		x y \
	textscale	0.22 \
	textalignx 	208 \
	textaligny	19 \
	forecolor	1 1 1 0.8 \
	exp			text( "^1LOCKED ("+tableLookup(CHARACTER_TABLE, 0, itemID, 2)+")" ) \
	textfont	UI_FONT_NORMAL \
	textalign	ITEM_ALIGN_RIGHT \
	textscale	0.2 \
	decoration \
}

#define SURF_HANDS( x, y, itemID, menuResponse ) \
itemDef \
{ \
	visible			when( dvarString( "customization_menu" ) == "hands" ) \
	rect			(x+90) y 128 28 SURF_BUTTON_ALIGN \
	style			WINDOW_STYLE_FILLED \
	border			0 \
	bordercolor		SURF_BUTTON_BORDERCOLOR \ 
	forecolor		SURF_BUTTON_FORECOLOR \ 
	backcolor		SURF_BUTTON_BACKCOLOR \
} \
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	1 1 1 0.8 \
	exp			text( tableLookup(HANDS_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "hands" && rank >= tableLookup(HANDS_TABLE, 0, itemID, 2) ) /*unlocked*/ \
	mouseEnter \
	{ \
		play "mouse_over"; \
	} \
	action \
	{ \
		scriptMenuResponse menuResponse; \
		setdvar customization_menu "none"; \
	} \
} \ 
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	0.8 0.8 0.8 0.6 \
	exp			text( tableLookup(HANDS_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "hands" && rank < tableLookup(HANDS_TABLE, 0, itemID, 2) ) /*locked*/ \
} \
itemDef \
{ \
	visible		when( dvarString( "customization_menu" ) == "hands" && rank < tableLookup(HANDS_TABLE, 0, itemID, 2) ) /*locked*/ \
	origin		x y \
	textscale	0.22 \
	textalignx 	208 \
	textaligny	19 \
	forecolor	1 1 1 0.8 \
	exp			text( "^1LOCKED ("+tableLookup(HANDS_TABLE, 0, itemID, 2)+")" ) \
	textfont	UI_FONT_NORMAL \
	textalign	ITEM_ALIGN_RIGHT \
	textscale	0.2 \
	decoration \
}

#define SURF_KNIFE( x, y, itemID, menuResponse ) \
itemDef \
{ \
	visible			when( dvarString( "customization_menu" ) == "knives" ) \
	rect			(x+90) y 128 28 SURF_BUTTON_ALIGN \
	style			WINDOW_STYLE_FILLED \
	border			0 \
	bordercolor		SURF_BUTTON_BORDERCOLOR \ 
	forecolor		SURF_BUTTON_FORECOLOR \ 
	backcolor		SURF_BUTTON_BACKCOLOR \
} \
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	1 1 1 0.8 \
	exp			text( tableLookup(KNIVES_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "knives" && rank >= tableLookup(KNIVES_TABLE, 0, itemID, 2) ) /*unlocked*/ \
	mouseEnter \
	{ \
		play "mouse_over"; \
	} \
	action \
	{ \
		scriptMenuResponse menuResponse; \
		setdvar customization_menu "none"; \
	} \
} \ 
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	0.8 0.8 0.8 0.6 \
	exp			text( tableLookup(KNIVES_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "knives" && rank < tableLookup(KNIVES_TABLE, 0, itemID, 2) ) /*locked*/ \
} \
itemDef \
{ \
	visible		when( dvarString( "customization_menu" ) == "knives" && rank < tableLookup(KNIVES_TABLE, 0, itemID, 2) ) /*locked*/ \
	origin		x y \
	textscale	0.22 \
	textalignx 	208 \
	textaligny	19 \
	forecolor	1 1 1 0.8 \
	exp			text( "^1LOCKED ("+tableLookup(KNIVES_TABLE, 0, itemID, 2)+")" ) \
	textfont	UI_FONT_NORMAL \
	textalign	ITEM_ALIGN_RIGHT \
	textscale	0.2 \
	decoration \
}

#define SURF_TRAIL( x, y, itemID, menuResponse ) \
itemDef \
{ \
	visible			when( dvarString( "customization_menu" ) == "trails" ) \
	rect			(x+90) y 128 28 SURF_BUTTON_ALIGN \
	style			WINDOW_STYLE_FILLED \
	border			0 \
	bordercolor		SURF_BUTTON_BORDERCOLOR \ 
	forecolor		SURF_BUTTON_FORECOLOR \ 
	backcolor		SURF_BUTTON_BACKCOLOR \
} \
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	1 1 1 0.8 \
	exp			text( tableLookup(TRAILS_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "trails" && rank >= tableLookup(TRAILS_TABLE, 0, itemID, 2) ) /*unlocked*/ \
	mouseEnter \
	{ \
		play "mouse_over"; \
	} \
	action \
	{ \
		scriptMenuResponse menuResponse; \
		setdvar customization_menu "none"; \
	} \
} \ 
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	0.8 0.8 0.8 0.6 \
	exp			text( tableLookup(TRAILS_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "trails" && rank < tableLookup(TRAILS_TABLE, 0, itemID, 2) ) /*locked*/ \
} \
itemDef \
{ \
	visible		when( dvarString( "customization_menu" ) == "trails" && rank < tableLookup(TRAILS_TABLE, 0, itemID, 2) ) /*locked*/ \
	origin		x y \
	textscale	0.22 \
	textalignx 	208 \
	textaligny	19 \
	forecolor	1 1 1 0.8 \
	exp			text( "^1LOCKED ("+tableLookup(TRAILS_TABLE, 0, itemID, 2)+")" ) \
	textfont	UI_FONT_NORMAL \
	textalign	ITEM_ALIGN_RIGHT \
	textscale	0.2 \
	decoration \
}

// I'm lazy so I just copied and edited these
// omgwtfbbq = vip menu
#define SURF_WEAPON_VIP( x, y, itemID, menuResponse ) \
itemDef \
{ \
	visible			when( dvarString( "customization_menu" ) == "omgwtfbbq" ) \
	rect			(x+90) y 128 28 SURF_BUTTON_ALIGN \
	style			WINDOW_STYLE_FILLED \
	border			0 \
	bordercolor		SURF_BUTTON_BORDERCOLOR \ 
	forecolor		SURF_BUTTON_FORECOLOR \ 
	backcolor		SURF_BUTTON_BACKCOLOR \
} \
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	1 1 1 0.8 \
	exp			text( tableLookup(ITEM_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && rank >= tableLookup(ITEM_TABLE, 0, itemID, 2) ) /*unlocked*/ \
	mouseEnter \
	{ \
		play "mouse_over"; \
	} \
	action \
	{ \
		scriptMenuResponse menuResponse; \
		setdvar customization_menu "none"; \
	} \
} \ 
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	0.8 0.8 0.8 0.6 \
	exp			text( tableLookup(ITEM_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && rank < tableLookup(ITEM_TABLE, 0, itemID, 2) ) /*locked*/ \
} \
itemDef \
{ \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && rank < tableLookup(ITEM_TABLE, 0, itemID, 2) ) /*locked*/ \
	origin		x y \
	textscale	0.22 \
	textalignx 	208 \
	textaligny	19 \
	forecolor	1 1 1 0.8 \
	exp			text( "^1LOCKED ("+tableLookup(ITEM_TABLE, 0, itemID, 2)+")" ) \
	textfont	UI_FONT_NORMAL \
	textalign	ITEM_ALIGN_RIGHT \
	textscale	0.2 \
	decoration \
}

#define SURF_CHARACTER_VIP( x, y, itemID, menuResponse ) \
itemDef \
{ \
	visible			when( dvarString( "customization_menu" ) == "omgwtfbbq" ) \
	rect			(x+90) y 128 28 SURF_BUTTON_ALIGN \
	style			WINDOW_STYLE_FILLED \
	border			0 \
	bordercolor		SURF_BUTTON_BORDERCOLOR \ 
	forecolor		SURF_BUTTON_FORECOLOR \ 
	backcolor		SURF_BUTTON_BACKCOLOR \
} \
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	1 1 1 0.8 \
	exp			text( tableLookup(CHARACTER_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && rank >= tableLookup(CHARACTER_TABLE, 0, itemID, 2) ) /*unlocked*/ \
	mouseEnter \
	{ \
		play "mouse_over"; \
	} \
	action \
	{ \
		scriptMenuResponse menuResponse; \
		setdvar customization_menu "none"; \
	} \
} \ 
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	0.8 0.8 0.8 0.6 \
	exp			text( tableLookup(CHARACTER_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && rank < tableLookup(CHARACTER_TABLE, 0, itemID, 2) ) /*locked*/ \
} \
itemDef \
{ \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && rank < tableLookup(CHARACTER_TABLE, 0, itemID, 2) ) /*locked*/ \
	origin		x y \
	textscale	0.22 \
	textalignx 	208 \
	textaligny	19 \
	forecolor	1 1 1 0.8 \
	exp			text( "^1LOCKED ("+tableLookup(CHARACTER_TABLE, 0, itemID, 2)+")" ) \
	textfont	UI_FONT_NORMAL \
	textalign	ITEM_ALIGN_RIGHT \
	textscale	0.2 \
	decoration \
}

#define SURF_HANDS_VIP( x, y, itemID, menuResponse ) \
itemDef \
{ \
	visible			when( dvarString( "customization_menu" ) == "omgwtfbbq" ) \
	rect			(x+90) y 128 28 SURF_BUTTON_ALIGN \
	style			WINDOW_STYLE_FILLED \
	border			0 \
	bordercolor		SURF_BUTTON_BORDERCOLOR \ 
	forecolor		SURF_BUTTON_FORECOLOR \ 
	backcolor		SURF_BUTTON_BACKCOLOR \
} \
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	1 1 1 0.8 \
	exp			text( tableLookup(HANDS_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && rank >= tableLookup(HANDS_TABLE, 0, itemID, 2) ) /*unlocked*/ \
	mouseEnter \
	{ \
		play "mouse_over"; \
	} \
	action \
	{ \
		scriptMenuResponse menuResponse; \
		setdvar customization_menu "none"; \
	} \
} \ 
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	0.8 0.8 0.8 0.6 \
	exp			text( tableLookup(HANDS_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && rank < tableLookup(HANDS_TABLE, 0, itemID, 2) ) /*locked*/ \
} \
itemDef \
{ \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && rank < tableLookup(HANDS_TABLE, 0, itemID, 2) ) /*locked*/ \
	origin		x y \
	textscale	0.22 \
	textalignx 	208 \
	textaligny	19 \
	forecolor	1 1 1 0.8 \
	exp			text( "^1LOCKED ("+tableLookup(HANDS_TABLE, 0, itemID, 2)+")" ) \
	textfont	UI_FONT_NORMAL \
	textalign	ITEM_ALIGN_RIGHT \
	textscale	0.2 \
	decoration \
}

#define SURF_KNIFE_VIP( x, y, itemID, menuResponse ) \
itemDef \
{ \
	visible			when( dvarString( "customization_menu" ) == "omgwtfbbq" ) \
	rect			(x+90) y 128 28 SURF_BUTTON_ALIGN \
	style			WINDOW_STYLE_FILLED \
	border			0 \
	bordercolor		SURF_BUTTON_BORDERCOLOR \ 
	forecolor		SURF_BUTTON_FORECOLOR \ 
	backcolor		SURF_BUTTON_BACKCOLOR \
} \
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	1 1 1 0.8 \
	exp			text( tableLookup(KNIVES_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && rank >= tableLookup(KNIVES_TABLE, 0, itemID, 2) ) /*unlocked*/ \
	mouseEnter \
	{ \
		play "mouse_over"; \
	} \
	action \
	{ \
		scriptMenuResponse menuResponse; \
		setdvar customization_menu "none"; \
	} \
} \ 
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	0.8 0.8 0.8 0.6 \
	exp			text( tableLookup(KNIVES_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && rank < tableLookup(KNIVES_TABLE, 0, itemID, 2) ) /*locked*/ \
} \
itemDef \
{ \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && rank < tableLookup(KNIVES_TABLE, 0, itemID, 2) ) /*locked*/ \
	origin		x y \
	textscale	0.22 \
	textalignx 	208 \
	textaligny	19 \
	forecolor	1 1 1 0.8 \
	exp			text( "^1LOCKED ("+tableLookup(KNIVES_TABLE, 0, itemID, 2)+")" ) \
	textfont	UI_FONT_NORMAL \
	textalign	ITEM_ALIGN_RIGHT \
	textscale	0.2 \
	decoration \
}

#define SURF_TRAIL_VIP( x, y, itemID, menuResponse ) \
itemDef \
{ \
	visible			when( dvarString( "customization_menu" ) == "omgwtfbbq" ) \
	rect			(x+90) y 128 28 SURF_BUTTON_ALIGN \
	style			WINDOW_STYLE_FILLED \
	border			0 \
	bordercolor		SURF_BUTTON_BORDERCOLOR \ 
	forecolor		SURF_BUTTON_FORECOLOR \ 
	backcolor		SURF_BUTTON_BACKCOLOR \
} \
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	1 1 1 0.8 \
	exp			text( tableLookup(TRAILS_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && rank >= tableLookup(TRAILS_TABLE, 0, itemID, 2) ) /*unlocked*/ \
	mouseEnter \
	{ \
		play "mouse_over"; \
	} \
	action \
	{ \
		scriptMenuResponse menuResponse; \
		setdvar customization_menu "none"; \
	} \
} \ 
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	0.8 0.8 0.8 0.6 \
	exp			text( tableLookup(TRAILS_TABLE, 0, itemID, 4) ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && rank < tableLookup(TRAILS_TABLE, 0, itemID, 2) ) /*locked*/ \
} \
itemDef \
{ \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && rank < tableLookup(TRAILS_TABLE, 0, itemID, 2) ) /*locked*/ \
	origin		x y \
	textscale	0.22 \
	textalignx 	208 \
	textaligny	19 \
	forecolor	1 1 1 0.8 \
	exp			text( "^1LOCKED ("+tableLookup(TRAILS_TABLE, 0, itemID, 2)+")" ) \
	textfont	UI_FONT_NORMAL \
	textalign	ITEM_ALIGN_RIGHT \
	textscale	0.2 \
	decoration \
}

#define SURF_VIPITEM( x, y, itemName, itemVar, menuResponse ) \
itemDef \
{ \
	visible			when( dvarString( "customization_menu" ) == "omgwtfbbq" ) \
	rect			(x+90) y 128 28 SURF_BUTTON_ALIGN \
	style			WINDOW_STYLE_FILLED \
	border			0 \
	bordercolor		SURF_BUTTON_BORDERCOLOR \ 
	forecolor		SURF_BUTTON_FORECOLOR \ 
	backcolor		SURF_BUTTON_BACKCOLOR \
} \
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		(x+90) y 128 28 SURF_BUTTON_ALIGN \
	forecolor	1 1 1 0.8 \
	exp			text( itemName ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.3 \
	textalignx	9 \
	textaligny	20 \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" ) /*unlocked*/ \
	mouseEnter \
	{ \
		play "mouse_over"; \
	} \
	action \
	{ \
		scriptMenuResponse menuResponse; \
	} \
} \ 
itemDef \
{ \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && dvarInt( itemVar ) != 1 ) /*disabled*/ \
	origin		x y \
	textscale	0.22 \
	textalignx 	208 \
	textaligny	19 \
	forecolor	1 1 1 0.8 \
	exp			text( "^1DISABLED" ) \
	textfont	UI_FONT_NORMAL \
	textalign	ITEM_ALIGN_RIGHT \
	textscale	0.2 \
	decoration \
} \
itemDef \
{ \
	visible		when( dvarString( "customization_menu" ) == "omgwtfbbq" && dvarInt( itemVar ) == 1 ) /*enabled*/ \
	origin		x y \
	textscale	0.22 \
	textalignx 	208 \
	textaligny	19 \
	forecolor	1 1 1 0.8 \
	exp			text( "^2ENABLED" ) \
	textfont	UI_FONT_NORMAL \
	textalign	ITEM_ALIGN_RIGHT \
	textscale	0.2 \
	decoration \
}