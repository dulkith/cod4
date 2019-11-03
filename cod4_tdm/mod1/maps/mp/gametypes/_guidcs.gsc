init()
{
	// Get the main module's dvar
	level.scr_guidcs_enable = getdvarx( "scr_guidcs_enable", "int", 0, 0, 2 );

	// If the GUID control system is not enabled then there's nothing else to do here
	if ( level.scr_guidcs_enable == 0 )
		return;

	// Load the rest of the variables
	checkedInGUIDs = getdvarlistx( "scr_guidcs_allowed_", "string", "" );
	level.checkedInGUIDs = [];
	for ( i=0; i < checkedInGUIDs.size; i++ ) {
		theseGUIDs = strtok( checkedInGUIDs[i], ";" );
		
		for ( j=0; j < theseGUIDs.size; j++ ) {
			level.checkedInGUIDs[ "" + theseGUIDs[j] ] = true;
		}		
	}

	level thread addNewEvent( "onPlayerConnected", ::onPlayerConnected );
}


onPlayerConnected()
{
	// Check we are only in check-in mode
	if ( level.scr_guidcs_enable == 1 ) {
		playerGUID = "" + self getGUID();
		// Check if this player is already defined so we don't log it 
		if ( !isDefined( level.checkedInGUIDs[ playerGUID ] ) ) {
			level.checkedInGUIDs[ playerGUID ] = true;
			logPrint( "GCS;" + self.name + ";" + playerGUID + "\n" );
		}		
	
	// We need to disconnect any player that is not registered
	} else if ( level.scr_guidcs_enable == 2 ) {
		playerGUID = "" + self getGUID();
		// Check if this player is already defined so we don't log it 
		if ( !isDefined( level.checkedInGUIDs[ playerGUID ] ) ) {
			// Close any menu that the player might have on screen
			self closeMenu();
			self closeInGameMenu();

			// Let the player know why he/she is being disconnected from the server
			self iprintlnbold( &"OW_GUIDCS_GUID_NOT_ALLOWED" );
			self iprintlnbold( &"OW_GUIDCS_INFORMATION" );
			self iprintlnbold( &"OW_GUIDCS_CONTACT", getDvar( "_Website" ) );
	
			wait (5.0);			
			
			logPrint( "GCS;K;" + self.name + ";" + playerGUID + "\n" );
			kick( self getEntityNumber() );
		}
	}
}