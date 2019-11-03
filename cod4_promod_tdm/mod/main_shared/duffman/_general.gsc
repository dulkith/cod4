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
	level thread duffman\_common::load();
	level thread duffman\_languages::init();
	level thread duffman\_menu::init();
	level thread duffman\_playerstatus::init();
	level thread duffman\_kdratio::init();
	level thread duffman\_killcard::init();
	level thread duffman\_engine_fixes::init();
	level thread duffman\_iprint::init();
	level thread duffman\_spectating::init();
	level thread duffman\_anticheat::init();
	//level thread duffman\_srvbrowser::init();
	level thread duffman\_teambalance::init();
	
	//level thread duffman\_autofav::init();
	//level thread duffman\_bots::init();
	
	
	//level thread duffman\_endfights::init();

	//level thread duffman\_misc::init();
}