Jump()
{
	self notifyOnPlayerCommand("JumpUp", "+gostand");
	iPrintln( "^5" + player.name + "^7 jumpheight ^7[^2ON^7]" );
	self notifyOnPlayerCommand("ReleasedJumpButton", "-gostand");
	setDvar("bg_fallDamageMinHeight", "999999");
	setDvar("bg_fallDamageMaxHeight", "999999");
	for( ; ; )
	{
		self waittill("JumpUp");
		setDvar("jump_height", "999");
		wait 0.5;
		self waittill("ReleasedJumpButton");
		setDvar("jump_height", "39");
	    iPrintln( "^5" + player.name + "^7 jumpheight ^7[^1OFF^7]" );
	}
}