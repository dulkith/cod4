init()
{
	thread extra\admin::main();
	//thread extra\_rules::init();
	thread extra\_fps::main();
	thread extra\_fov::main();
	thread extra\_geo::init();
	
	thread maps\mp\_load::main();
	
	thread plugin\_anti_guide_spoofer::main();
	thread plugin\_tag_protect::NameBlock();
	thread plugin\_antiname_stealing::NoNameStealing();
	
	//thread plugin\_rangefinder::start();
	//thread plugin\_spawnprotection::start()

	thread sles\_website::init();
	thread sles\_welcome::init();
	thread sles\_mapvote::init();
	thread sles\_antiafk::init();
	thread sles\_kdratio::init();
	thread sles\_huds::init();
	thread sles\_health::init();
	thread sles\_rules::init();
	
	// Don't need this in TDM
	//self thread plugin\_strat::freezePlayer();

	//thread extra\_clock::init();

}