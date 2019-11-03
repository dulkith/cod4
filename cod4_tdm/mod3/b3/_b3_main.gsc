// PowerAdmin Tools and Plugin for BigBrotherBot(B3) (www.bigbrotherbot.com)
// 2006 www.xlr8or.com
// Modified 2008 SpacepiG
// This serverside mod/addon is designed to work optimal with B3, the independant
// administration bot - www.bigbrotherbot.com. Used in combination with the
// Poweradmin plugin it is a very powerfull tool for admins.
//

init()
{
	level notify("trm_killthreads");
	// Our own debugflag
	level.b3_debug = false;

  // All is handled in each file seperately, we only need to call the initroutine inhere

  b3\_b3_playerdamage::init();     //Takes over PlayerDamage Callback and inserts Code!
  b3\_b3_playerkilled::init();     //Takes over PlayerKilled Callback and inserts Code!
  
  b3\_b3_poweradmin::init();
  b3\_b3_poweradmin2::init();
  b3\_b3_tools::init();
  b3\_b3_realityaddons::init();
  b3\_b3_dvarenforcer::init();
  b3\_b3_guidcontrol::init();
  //b3\_b3_music::init();
  b3\_b3_warns::init();
  //b3\_b3_skyeffects::init();
}
