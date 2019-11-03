itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			FULLSCREEN_WIDE
	background		"animbg_front"
	visible			when( dvarString( fs_game ) == "" )
	decoration
}

itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			FULLSCREEN_WIDE
	background		"animbg_front2"
	visible			when( dvarString( fs_game ) == "" )
	decoration
}


itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			FULLSCREEN_WIDE
	background		"animbg_back"
	forecolor		1 1 1 1
	visible			when( dvarString( fs_game ) != "" )
	decoration
}

itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			FULLSCREEN_WIDE
	background		"animbg_front"
	forecolor		1 1 1 1
	visible			when( dvarString( fs_game ) != "" )
	decoration
}

itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			FULLSCREEN_WIDE
	background		"animbg_front2"
	forecolor		1 1 1 1
	visible			when( dvarString( fs_game ) != "" )
	decoration
}

itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			FULLSCREEN_WIDE
	background		"sles_main_background"
	forecolor		1 1 1 1
	visible			1
	decoration
}

#undef	FOG_SCROLL_TIME
#define FOG_SCROLL_TIME 25000 //30000

#undef	THINFOG_SCROLL_TIME
#define THINFOG_SCROLL_TIME 100000 //50000

#define FOG_COLOR 1 1 1 0.3

itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			-107 0 1708 480
	exp				rect X((-107) - ((float(milliseconds() % FOG_SCROLL_TIME) / FOG_SCROLL_TIME) * (854)))
	forecolor		0 0 0 0.6
	background		"animbg_fogscroll"
	visible			1
	decoration
}

