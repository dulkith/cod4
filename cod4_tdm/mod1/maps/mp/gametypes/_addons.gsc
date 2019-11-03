#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init()
{
   level.allowGL = GetDvarInt("scr_game_allow_gl");
   level.allowLS = GetDvarInt("scr_game_allow_3s");
   level.allowLS = GetDvarInt("scr_game_allow_3g");
   level.allowLS = GetDvarInt("scr_game_allow_ls");
   level.allowMD = GetDvarInt("scr_game_allow_md");
   level.allowMD = GetDvarInt("scr_game_allow_jg");
   
   if(!isDefined(level.allowGL))
      level.allowGL = false;
   
   if(!isDefined(level.allow3S))
      level.allow3S = false;
   
   if(!isDefined(level.allow3G))
      level.allow3G = false;
   
   if(!isDefined(level.allowMD))
      level.allowMD = false;
   
   if(!isDefined(level.allowLS))
      level.allowLS = false;
   
   if(!isDefined(level.allowJG))
      level.allowJG = false;
   
}

OnPlayerConnected()
{
   self thread OnPlayerSpawned();
}

OnPlayerSpawned()
{
   self endon("disconnect");
   
   for(;;)
   {
      self waittill("spawned_player");
      
      wait 0.2;
      self thread checkGL();
      
   }
}

checkGL()
{
   self endon("disconnect");
   self endon("death");
   
   for(;;)
   {
      self thread CheckUnallowedPerks();
      
      curWeapon = self GetCurrentWeapon();
      
      if(isSubStr(curWeapon,"_gl") && !level.allowGL)
      {
         self TakeWeapon(curWeapon);
         
         iPrintLn(self.name + " Grenade Launcher isn't allowed - Removing ...");
         
         prefix = StrTok(curWeapon,"_");
         newWeapon = prefix[0] + "_mp";

         self GiveWeapon(newWeapon);
         self GiveStartAmmo(newWeapon);
         
         wait 0.5;
         
         self SwitchToWeapon( newWeapon );
      }
      
      self waittill( "weapon_change", newWeapon );
   }
}

CheckUnallowedPerks()
{
   if(self HasPerk("specialty_specialgrenade") && !level.allowLS)
   {
      iPrintLn(self.name + " 3 Special perk isn't allowed - Removing ...");
      self UnSetPerk("specialty_specialgrenade");
   }
   
   if(self HasPerk("specialty_fraggrenade") && !level.allowLS)
   {
      iPrintLn(self.name + " 3 Grenade perk isn't allowed - Removing ...");
      self UnSetPerk("specialty_fraggrenade");
   }
   
   if(self HasPerk("specialty_pistoldeath") && !level.allowLS)
   {
      iPrintLn(self.name + " Last Stand perk isn't allowed - Removing ...");
      self UnSetPerk("specialty_pistoldeath");
   }
   
   if(self HasPerk("specialty_grenadepulldeath") && !level.allowMD )
   {
      iPrintLn(self.name + " Martyrdoom perk isn't allowed - Removing ...");
      self UnSetPerk("specialty_grenadepulldeath");  
   }
   
   if(self HasPerk("specialty_armorvest") && !level.allowMD )
   {
      iPrintLn(self.name + " Juggernaut perk isn't allowed - Removing ...");
      self UnSetPerk("specialty_armorvest");
   }
   
}