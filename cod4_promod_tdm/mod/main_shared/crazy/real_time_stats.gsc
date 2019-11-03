init()
{
   level thread onPlayerConnected();
   level thread onGameEnded();
}


onGameEnded()
{
   level waittill("refresh_eog");   

   level.eogBest = [];
   level.eogBest["accuracy"]["name"] = "";
   level.eogBest["accuracy"]["value"] = 0;

   level.eogBest["kills"]["name"] = "";
   level.eogBest["kills"]["value"] = 0;
   
   level.eogBest["teamkills"]["name"] = "";
   level.eogBest["teamkills"]["value"] = 0;   
   
   level.eogBest["killstreak"]["name"] = "";
   level.eogBest["killstreak"]["value"] = 0;   
   
   level.eogBest["longest"]["name"] = "";
   level.eogBest["longest"]["value"] = 0;   

   level.eogBest["melee"]["name"] = "";
   level.eogBest["melee"]["value"] = 0;

   level.eogBest["headshots"]["name"] = "";
   level.eogBest["headshots"]["value"] = 0;

   level.eogBest["longesths"]["name"] = "";
   level.eogBest["longesths"]["value"] = 0;

   level.eogBest["deaths"]["name"] = "";
   level.eogBest["deaths"]["value"] = 0;

   level.eogBest["suicides"]["name"] = "";
   level.eogBest["suicides"]["value"] = 0;

   level.eogBest["deathstreak"]["name"] = "";
   level.eogBest["deathstreak"]["value"] = 0;   
   
   level.eogBest["distance"]["name"] = "";
   level.eogBest["distance"]["value"] = 0;   
            
   for ( index = 0; index < level.players.size; index++ )
   {
      player = level.players[index];   
      
      if ( isDefined( player ) && isDefined( player.pers["stats"] ) ) 
      {   
         if ( player.pers["shots"] != 0 && isDefined(player.pers["shots"]) && isDefined(player.pers["hits"]) ) 
            player checkStatItem( int(player.pers["hits"]/player.pers["shots"]*10000)/100, "accuracy" );
         else 
            player checkStatItem( 0, "accuracy" );
         
         player checkStatItem( player.pers["stats"]["kills"]["total"], "kills" );
         player checkStatItem( player.pers["stats"]["kills"]["teamkills"], "teamkills" );
         player checkStatItem( player.pers["stats"]["kills"]["killstreak"], "killstreak" );
         player checkStatItem( player.pers["stats"]["kills"]["longest"], "longest" );
         player checkStatItem( player.pers["stats"]["kills"]["knife"], "melee" );
         player checkStatItem( player.pers["stats"]["kills"]["headshots"], "headshots" );
         player checkStatItem( player.pers["stats"]["kills"]["longesths"], "longesths" );
         
         player checkStatItem( player.pers["stats"]["deaths"]["total"], "deaths" );
         player checkStatItem( player.pers["stats"]["deaths"]["suicides"], "suicides" );
         player checkStatItem( player.pers["stats"]["deaths"]["deathstreak"], "deathstreak" );
                  
         player checkStatItem( player.pers["stats"]["misc"]["distance"], "distance" );
      }
   }
   
   level.eogBest["distance"]["value"] = int( level.eogBest["distance"]["value"] * 0.0254 * 10 ) / 10;
   longestUnit = " m";
   
   // Send the data to each player
   for ( index = 0; index < level.players.size; index++ )
   {
      player = level.players[index];   
      
      if ( isDefined( player ) ) {
         player setClientDvars(
            "gs_pg", 1,
            "gs_an", level.eogBest["accuracy"]["name"],
            "gs_a", level.eogBest["accuracy"]["value"],
            "gs_kn", level.eogBest["kills"]["name"],
            "gs_k", level.eogBest["kills"]["value"],
            "gs_tn", level.eogBest["teamkills"]["name"],
            "gs_t", level.eogBest["teamkills"]["value"],
            "gs_ksn", level.eogBest["killstreak"]["name"],
            "gs_ks", level.eogBest["killstreak"]["value"],
            "gs_ln", level.eogBest["longest"]["name"],
            "gs_l", level.eogBest["longest"]["value"] + longestUnit,
            "gs_mn", level.eogBest["melee"]["name"],
            "gs_m", level.eogBest["melee"]["value"],
            "gs_hn", level.eogBest["headshots"]["name"],
            "gs_h", level.eogBest["headshots"]["value"],
            "gs_lhn", level.eogBest["longesths"]["name"]            
         );
         player setClientDvars(
            "gs_lh", level.eogBest["longesths"]["value"] + longestUnit,
            "gs_dn", level.eogBest["deaths"]["name"],
            "gs_d", level.eogBest["deaths"]["value"],
            "gs_sn", level.eogBest["suicides"]["name"],
            "gs_s", level.eogBest["suicides"]["value"],
            "gs_dsn", level.eogBest["deathstreak"]["name"],
            "gs_ds", level.eogBest["deathstreak"]["value"]
         );
         player setClientDvars(
            "gs_dtn", level.eogBest["distance"]["name"],
            "gs_dt", level.eogBest["distance"]["value"] + longestUnit
         );         
      }
   }   
}


checkStatItem( value, statItem )
{
   // Check if this stat item is blank or if the value is higher than the current one
   if ( level.eogBest[statItem]["name"] == "" || value > level.eogBest[statItem]["value"] ) {
      level.eogBest[statItem]["name"] = self.name;
      level.eogBest[statItem]["value"] = value;      
   }   
}


onPlayerConnected()
{   
   for(;;)
   {
      level waittill("connected", player);
      
      player thread onRefreshAccuracy();
      player thread onPlayerSpawned();
      
      // Make sure the initialization happens only at the beginning of the map
      if ( !isDefined( player.pers["stats"] ) ) {
      
         longestDefault = "0 m";
            
         // Initialize the values
         player setClientDvars(
            "ps_a", 0,                                    // Accuracy
            "ps_r", 0,                                    // Kill/Deaths ratio
            "ps_k", 0,                                    // Kills
            "ps_t", 0,                                    // Teamkills
            "ps_cks", 0,                                  // Current Killstreak
            "ps_ks", 0,                                  // Highest Killstreak
            "ps_l", longestDefault,                  // Longest Kill
            "ps_mk", 0,                                    // Melee Kills
            "ps_dt", longestDefault                  // Distance Travelled
         );
         player setClientDvars(
            "ps_h", 0,                                    // Headshots
            "ps_lh", longestDefault,               // Longest Headshot
            "ps_d", 0,                                     // Deaths
            "ps_s", 0,                                    // Suicides
            "ps_cds", 0,                                 // Current Deathstreak
            "ps_ds", 0                                 // Highest Deathstreak
         );
         
         // Initialize variables to keep stats
         player.pers["stats"] = [];
         
         // Accuracy
         player.pers["shots"] = 0;
         player.pers["hits"] = 0;
         
         // Kills
         player.pers["stats"]["kills"] = [];
         player.pers["stats"]["kills"]["total"] = 0;
         player.pers["stats"]["kills"]["teamkills"] = 0;
         player.pers["stats"]["kills"]["consecutive"] = 0;
         player.pers["stats"]["kills"]["killstreak"] = 0;
         player.pers["stats"]["kills"]["longest"] = 0;
         player.pers["stats"]["kills"]["knife"] = 0;
         player.pers["stats"]["kills"]["headshots"] = 0;
         player.pers["stats"]["kills"]["longesths"] = 0;
         
         // Deaths
         player.pers["stats"]["deaths"] = [];
         player.pers["stats"]["deaths"]["total"] = 0;
         player.pers["stats"]["deaths"]["suicides"] = 0;
         player.pers["stats"]["deaths"]["consecutive"] = 0;
         player.pers["stats"]["deaths"]["deathstreak"] = 0;
         
         // Misc
         player.pers["stats"]["misc"] = [];
         player.pers["stats"]["misc"]["distance"] = 0;      
      }   
   }
}


onPlayerSpawned()
{
   self endon("disconnect");

   for(;;)
   {
      self waittill("spawned_player");
      
      mUnit = " m";
      
      oldPosition = self.origin;
      oldValue = self.pers["stats"]["misc"]["distance"];
      updateLoop = 0;
      
      // Monitor this player until he/she dies or the round ends
      while ( isAlive( self ) && game["state"] != "postgame" ) {
         wait (0.1);
         
         // Make sure the player is not jumping
         if ( self isOnGround() || self isOnLadder() ) {
            // Calculate the distance between the last knows position and the current one
            travelledDistance = distance( oldPosition, self.origin );
            
            // If we have a positive travelled distance add it up 
            if ( travelledDistance > 0 ) {
               oldPosition = self.origin;
               self.pers["stats"]["misc"]["distance"] += travelledDistance;
            }         
         }
         
         // We update every second
         updateLoop++;
         if ( updateLoop == 10 ) {
            updateLoop = 0;
            if ( oldValue != self.pers["stats"]["misc"]["distance"] ) {
               oldValue = self.pers["stats"]["misc"]["distance"];
               travelledDistance = int( oldValue * 0.0254 * 10 ) / 10;
               self setClientDvar( "ps_dt", travelledDistance + mUnit );
            }
         }      
      }
      
      // Update one more time once the player dies
      if ( oldValue != self.pers["stats"]["misc"]["distance"] ) {
         oldValue = self.pers["stats"]["misc"]["distance"];
         travelledDistance = int( oldValue * 0.0254 * 10 ) / 10;
         self setClientDvar( "ps_dt", travelledDistance + mUnit );
      }   
   }
}


onRefreshAccuracy()
{
   self endon("disconnect");
   
   if(isDefined(self.pers["hits"]) && isDefined(self.pers["shots"]) && self.pers["shots"] != 0)
   self setClientDvar( "ps_a", int(self.pers["hits"]/self.pers["shots"]*10000)/100 );
}


onPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, fDistance)
{
   self endon("disconnect");
   
      // Make sure the player is not switching teams or being team balanced (our suicides count only when the player kills himself)
      if ( sMeansOfDeath == "MOD_SUICIDE" )
         return;
         
      // Check if it was a suicide
      if ( sMeansOfDeath == "MOD_FALLING" || ( isPlayer( attacker ) && attacker == self ) ) {
         self.pers["stats"]["deaths"]["suicides"] += 1;
      }

      // Handle the stats for the victim 
      self.pers["stats"]["kills"]["consecutive"] = 0;
      self.pers["stats"]["deaths"]["total"] += 1;
      self.pers["stats"]["deaths"]["consecutive"] += 1;
      if ( self.pers["stats"]["deaths"]["consecutive"] > self.pers["stats"]["deaths"]["deathstreak"] )
         self.pers["stats"]["deaths"]["deathstreak"] = self.pers["stats"]["deaths"]["consecutive"];
      
      // Update stats for the victim
      kdRatio = int( self.pers["stats"]["kills"]["total"] / self.pers["stats"]["deaths"]["total"] * 10000 ) / 100;
      self setClientDvars(
         "ps_r", kdRatio,
         "ps_cks", 0,
         "ps_d", self.pers["stats"]["deaths"]["total"], 
         "ps_s", self.pers["stats"]["deaths"]["suicides"], 
         "ps_cds", self.pers["stats"]["deaths"]["consecutive"],
         "ps_ds", self.pers["stats"]["deaths"]["deathstreak"]
      );

      // Handle the stats for the attacker
      if ( isPlayer( attacker ) && attacker != self ) {
         // Check if it was a team kill (team kills don't count towards K/D ratio or total kills, headshots, distances, etc)
         if ( level.teambased && isPlayer( attacker ) && attacker.pers["team"] == self.pers["team"] ) {
            attacker.pers["stats"]["kills"]["teamkills"] += 1;
            // Update the stats for the attacker
            attacker setClientDvars(
               "ps_t", attacker.pers["stats"]["kills"]["teamkills"]
            );            
         } else {
            attacker.pers["stats"]["deaths"]["consecutive"] = 0;
            attacker.pers["stats"]["kills"]["consecutive"] += 1;

            // Check if consecutive kills is higher than the killstreak
            if ( attacker.pers["stats"]["kills"]["consecutive"] > attacker.pers["stats"]["kills"]["killstreak"] ) {
               attacker.pers["stats"]["kills"]["killstreak"] = attacker.pers["stats"]["kills"]["consecutive"];
            }
   
            // Check if this was a headshot
            if ( sMeansOfDeath == "MOD_HEAD_SHOT" ) {
               attacker.pers["stats"]["kills"]["headshots"] += 1;
               
            // Check if this was a melee
            } else if ( sMeansOfDeath == "MOD_MELEE" || sMeansOfDeath == "MOD_BAYONET" ) {
               attacker.pers["stats"]["kills"]["knife"] += 1;
            }            

            // Should we check the distance
            switch ( weaponClass( sWeapon ) )   {
               case "rifle":
               case "pistol":
               case "mg":
               case "smg":
               case "spread":
                  // Check in which unit are we measuring
                  shotDistance = int( fDistance * 0.0254 * 10 ) / 10;
                  
                  if ( shotDistance > attacker.pers["stats"]["kills"]["longest"] ) {
                     attacker.pers["stats"]["kills"]["longest"] = shotDistance;
                  }
                  if ( sMeansOfDeath == "MOD_HEAD_SHOT" && shotDistance > attacker.pers["stats"]["kills"]["longesths"] ) {
                     attacker.pers["stats"]["kills"]["longesths"] = shotDistance;
                  }
                  break;
            }

                  
            attacker.pers["stats"]["kills"]["total"] += 1;
            
            // Calculate some intermediary variables
            if ( attacker.pers["stats"]["deaths"]["total"] > 0 ) {
               kdRatio = int( attacker.pers["stats"]["kills"]["total"] / attacker.pers["stats"]["deaths"]["total"] * 10000 ) / 100;
            } else {
               kdRatio = attacker.pers["stats"]["kills"]["total"];
            }
            
            longestKill = attacker.pers["stats"]["kills"]["longest"] + " m";
            longestHS = attacker.pers["stats"]["kills"]["longesths"] + " m";
            
            // Update the stats for the attacker
            attacker setClientDvars(
               "ps_r", kdRatio,
               "ps_k", attacker.pers["stats"]["kills"]["total"],
               "ps_cks", attacker.pers["stats"]["kills"]["consecutive"], 
               "ps_ks", attacker.pers["stats"]["kills"]["killstreak"], 
               "ps_l", longestKill,
               "ps_mk", attacker.pers["stats"]["kills"]["knife"],
               "ps_h", attacker.pers["stats"]["kills"]["headshots"],
               "ps_lh", longestHS,
               "ps_cds", attacker.pers["stats"]["deaths"]["consecutive"]
            );         
         }   
   }
}