/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\¯¯\/////¯¯//||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|__|/////////|__|/////////////|__|/////||
||===================================================================||
||     DO NOT USE, SHARE OR MODIFY THIS FILE WITHOUT PERMISSION      ||
||===================================================================*/

init()
{
	level thread duffman\_languages::init();
	level thread duffman\_kdratio::init();
	level thread duffman\_menu::init();
	level thread duffman\_predator::init();
	level thread duffman\_iprint::init();
	level thread duffman\_killcard::init();
	level thread duffman\_prestige::init();
	level thread duffman\_carepackage::main();
	level thread duffman\_playerstatus::init();
	level thread duffman\_artillery::init();
	level thread duffman\_misc::init();
	level thread duffman\_engine_fixes::init();
	level thread duffman\_spectating::init();
	level thread duffman\_commands::init();
	level thread duffman\_anticheat::init();
	
	return duffman\_common::array(
	"^71.6 05. January 2014",
	"Last edit, ^518th of January 2014",
	"^5~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
	"[C] New NoRecoil detection",
	"[C] Changed Mapvote layout",
	"[C] Changed Mappool",
	"[C] Changed Framework",
	"[+] Added Changelog");
	
	
	
	//level thread duffman\_nuke::init();
	//level thread duffman\_guidspooffix::init();
	//level thread duffman\_bots::init();
	//level thread duffman\_antiafk_camp::init();
	//level thread duffman\_better_noscope::init();
}