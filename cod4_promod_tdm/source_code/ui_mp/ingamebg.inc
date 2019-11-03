// background overlay
itemDef
{
	style			WINDOW_STYLE_FILLED
	rect			0 0 640 480 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_FULLSCREEN
	backcolor		0 0 0 0.75
	visible			1
	decoration
}

// gradient_top
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 0 854 75 HORIZONTAL_ALIGN_FULLSCREEN 0
	background		"gradient_top"
	visible			1
	decoration
}

// gradient_bottom
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 405 854 75 HORIZONTAL_ALIGN_FULLSCREEN 0
	background		"gradient_bottom"
	visible			1
	decoration
}