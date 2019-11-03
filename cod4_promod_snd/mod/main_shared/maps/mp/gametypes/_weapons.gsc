#include duffman\_common;

init()
{
	//precacheItem( "knife_mp" );
	precacheItem( "c4_mp" );
	precacheItem( "claymore_mp" );
	precacheItem( "radar_mp" );
	//precacheItem( "throwingknife_mp" );
	precacheitem( "brick_blaster_mp" );
    precacheItem( "rpg_mp" );
	precacheItem("ak47_mp");
	precacheItem("ak47_silencer_mp");
	precacheItem("ak74u_mp");
	precacheItem("ak74u_silencer_mp");
	precacheItem("beretta_mp");
	precacheItem("beretta_silencer_mp");
	precacheItem("colt45_mp");
	precacheItem("colt45_silencer_mp");
	precacheItem("deserteagle_mp");
	precacheItem("deserteaglegold_mp");
	precacheItem("frag_grenade_mp");
	precacheItem("frag_grenade_short_mp");
	precacheItem("g3_mp");
	precacheItem("g3_silencer_mp");
	precacheItem("g36c_mp");
	precacheItem("g36c_silencer_mp");
	precacheItem("m4_mp");
	precacheItem("m4_silencer_mp");
	precacheItem("m14_mp");
	precacheItem("m14_silencer_mp");
	precacheItem("m16_mp");
	precacheItem("m16_silencer_mp");
	precacheItem("m40a3_mp");
	precacheItem("m1014_mp");
	precacheItem("mp5_mp");
	precacheItem("mp5_silencer_mp");
	precacheItem("mp44_mp");
	precacheItem("remington700_mp");
	precacheItem("usp_mp");
	precacheItem("usp_silencer_mp");
	precacheItem("uzi_mp");
	precacheItem("uzi_silencer_mp");
	precacheItem("winchester1200_mp");
	precacheItem("smoke_grenade_mp");
	precacheItem("flash_grenade_mp");
	precacheItem("destructible_car");
	precacheShellShock("default");
	thread maps\mp\_flashgrenades::main();
	level thread onPlayerConnect();
}
onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting",player);
		player thread onPlayerSpawned();
	}
}
onPlayerSpawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.hasDoneCombat=false;
		self thread watchWeaponUsage();
		self thread watchGrenadeUsage();
		self thread watchGrenadeAmmo();
		self thread antiHack_plusieurs();
		if(!isDefined(self.pers["shots"]))self.pers["shots"]=0;
		self thread shotCounter();
		
		self.droppedDeathWeapon = undefined;
		self.tookWeaponFrom = [];
	}
}
watchGrenadeAmmo()
{
	self endon("death");
	self endon("disconnect");
	self endon("game_ended");
	prim=true;
	sec=true;
	while(prim||sec)
	{
		self waittill("grenade_fire");
		if((isDefined(game["promod_do_readyup"])&&game["promod_do_readyup"])||(isDefined(game["PROMOD_MATCH_MODE"])&&game["PROMOD_MATCH_MODE"]=="strat")||getDvarInt("sv_cheats"))break;
		wait 0.25;pg="";
		if(self hasWeapon("frag_grenade_mp"))pg="frag_grenade_mp";
		else if(self hasWeapon("frag_grenade_short_mp"))pg="frag_grenade_short_mp";
		else prim=false;sg="";
		if(self hasWeapon("flash_grenade_mp"))sg="flash_grenade_mp";
		else if(self hasWeapon("smoke_grenade_mp"))sg="smoke_grenade_mp";
		else sec=false;
		if(prim&&pg!=""&&self GetAmmoCount(pg)<1)
		{
			self TakeWeapon(pg);
			prim=false;
		}
		if(sec&&sg!=""&&self GetAmmoCount(sg)<1)
		{
			self TakeWeapon(sg);
			sec=false;
		}
	}
}
shotCounter()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("weapon_fired");
		if(!isDefined(level.rdyup)||!level.rdyup)self.pers["shots"]++;
	}
}
printStats()
{
	if(isDefined(game["PROMOD_MATCH_MODE"])&&game["PROMOD_MATCH_MODE"]=="match"&&isDefined(self.hasDoneCombat)&&self.hasDoneCombat&&isDefined(level.gameEnded)&&!level.gameEnded&&(!isDefined(game["promod_do_readyup"])||!game["promod_do_readyup"]))
	{
		self iprintln("Can't display stats. Wait for the round to end.");
	}
	else
	{
	if(!isDefined(self.pers["damage_done"]))self.pers["damage_done"]=0;
	if(!isDefined(self.pers["damage_taken"]))self.pers["damage_taken"]=0;
	if(!isDefined(self.pers["friendly_damage_done"]))self.pers["friendly_damage_done"]=0;
	if(!isDefined(self.pers["friendly_damage_taken"]))self.pers["friendly_damage_taken"]=0;
	if(!isDefined(self.pers["shots"]))self.pers["shots"]=0;if(!isDefined(self.pers["hits"]))self.pers["hits"]=0;
	if(self.pers["damage_done"]>0||self.pers["damage_taken"]>0||self.pers["friendly_damage_done"]>0||self.pers["friendly_damage_taken"]>0||self.pers["shots"]>0||self.pers["hits"]>0)logPrint("P_A;"+self getGuid()+";"+self getEntityNumber()+";"+self.name+";"+self.pers["shots"]+";"+self.pers["hits"]+";"+self.pers["damage_done"]+";"+self.pers["damage_taken"]+";"+self.pers["friendly_damage_done"]+";"+self.pers["friendly_damage_taken"]+"\n");self iprintln("^3"+self.name);self iprintln("Damage Done: ^2"+self.pers["damage_done"]+"^7 Damage Taken: ^1"+self.pers["damage_taken"]);
	if(level.teamBased)self iprintln("Friendly Damage Done: ^2"+self.pers["friendly_damage_done"]+"^7 Friendly Damage Taken: ^1"+self.pers["friendly_damage_taken"]);
	acc=0;
	if(self.pers["shots"]>0)acc=int(self.pers["hits"]/self.pers["shots"]*10000)/100;self iprintln("Shots Fired: ^2"+self.pers["shots"]+"^7 Shots Hit: ^2"+self.pers["hits"]+"^7 Accuracy: ^1"+acc+" pct");
	self.pers["damage_done"]=0;
	self.pers["damage_taken"]=0;
	self.pers["friendly_damage_done"]=0;
	self.pers["friendly_damage_taken"]=0;
	self.pers["shots"]=0;
	self.pers["hits"]=0;
	}
}
dropWeaponForDeath(attacker)
{
	weapon=self getCurrentWeapon();
	if(!isDefined(weapon)||!self hasWeapon(weapon))return;
	if(isPrimaryWeapon(weapon))
	{
		switch(level.primary_weapon_array[weapon])
		{
			case"weapon_assault":if(!getDvarInt("class_assault_allowdrop"))return;
			break;
			case"weapon_smg":if(!getDvarInt("class_specops_allowdrop"))return;
			break;
			case"weapon_sniper":if(!getDvarInt("class_sniper_allowdrop"))return;
			break;
			case"weapon_shotgun":if(!getDvarInt("class_demolitions_allowdrop"))return;
			break;
			default:return;
		}
	}
	else if(WeaponClass(weapon)!="pistol")return false;
	clipAmmo=self GetWeaponAmmoClip(weapon);
	if(!clipAmmo)return;
	stockAmmo=self GetWeaponAmmoStock(weapon);
	stockMax=WeaponMaxAmmo(weapon);
	if(stockAmmo>stockMax)stockAmmo=stockMax;
	item=self dropItem(weapon);
	item ItemWeaponSetAmmo(clipAmmo,stockAmmo);
	if(!isDefined(game["PROMOD_MATCH_MODE"])||game["PROMOD_MATCH_MODE"]!="match"||(game["PROMOD_MATCH_MODE"]=="match"&&level.gametype!="sd")||game["promod_do_readyup"])
	item thread watchPickup();
	item thread deletePickupAfterAWhile();
}

getItemWeaponName()
{
	classname = self.classname;
	weapname = getSubStr( classname, 7 );
	return weapname;
}
watchPickup()
{
	self endon("death");
	
	weapname = self getItemWeaponName();
	
	while(1)
	{
		self waittill( "trigger", player, droppedItem );
		
		if ( isDefined( droppedItem ) )
			break;
	}

	droppedWeaponName = droppedItem getItemWeaponName();
	if ( isDefined( player.tookWeaponFrom[ droppedWeaponName ] ) )
	{
		droppedItem.owner = player.tookWeaponFrom[ droppedWeaponName ];
		droppedItem.ownersattacker = player;
		player.tookWeaponFrom[ droppedWeaponName ] = undefined;
	}
	droppedItem thread watchPickup();
	
	if ( isDefined( self.ownersattacker ) && self.ownersattacker == player )
		player.tookWeaponFrom[ weapname ] = self.owner;
	else
		player.tookWeaponFrom[ weapname ] = undefined;
}


deletePickupAfterAWhile()
{
	self endon("death");
	wait 180;
	if(!isDefined(self))return;
	self delete();
}
watchWeaponUsage()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("begin_firing");
	self.hasDoneCombat=true;
}
watchGrenadeUsage()
{
	self endon("death");
	self endon("disconnect");
	self.throwingGrenade=false;
	for(;;)
	{
		self waittill("grenade_pullback",weaponName);
		self.hasDoneCombat=true;
		self.throwingGrenade=true;
		self beginGrenadeTracking();
	}
}
beginGrenadeTracking()
{
	self endon("death");
	self endon("disconnect");
	self waittill("grenade_fire",grenade,weaponName);
	if(weaponName=="frag_grenade_mp"||weaponName=="frag_grenade_short_mp")grenade thread maps\mp\gametypes\_shellshock::grenade_earthQuake();
	self.throwingGrenade=false;
}
onWeaponDamage(eInflictor,sWeapon,meansOfDeath,damage)
{
	self endon("death");
	self endon("disconnect");
	maps\mp\gametypes\_shellshock::shellshockOnDamage(meansOfDeath,damage);
}
isPrimaryWeapon(weaponname)
{
	return isdefined(level.primary_weapon_array[weaponname]);
}
antiHack_plusieurs() //for multi-shot (hold down fire) weapons
{
    self endon("disconnect");
    self endon("death");

    while(!isDefined(self.firingWeapon))
        wait .05;

    suspiciousCount = 0;
    currentRun = 0;

    while(1)
    {
        if(self.pers["team"] == "spectator")
            return;
    
        lastFiring = self.firingWeapon;
        lastAng = self getPlayerAngles();

        wait .05;

        curFiring = self.firingWeapon;
        curAng = self getPlayerAngles();

        wep = self getCurrentWeapon();
        if(lastFiring && curFiring && lastAng == curAng && isNormalWep(wep) && self.health > 0 && game["state"] != "postgame")
        {
            currentRun++;
        }
        else
        {
            currentRun = 0;
        }
        
        if(currentRun >= 6)
        {
            suspiciousCount++;
            currentRun = 0;
            
            if(suspiciousCount == 5)
            {
				self thread dropPlayer("kick","WallHack (Autokick)");
				iPrintlnBold("^1[WALL HACK DETECTED]:^2",self.name, "Banned");
                return;
            }
        }
    }
}

isNormalWep(wep)
{
    strange = (wep == "none" || wep == "c4_mp" || isSubStr(wep, "gl_") || wep == "claymore_mp");
    return !strange && !isHackWeapon(wep);
}

isHackWeapon( weapon )
{
	if ( weapon == "radar_mp" || weapon == "airstrike_mp" || weapon == "helicopter_mp" )
		return true;
	if ( weapon == "briefcase_bomb_mp" )
		return true;
	return false;
}

friendlyFireCheck( owner, attacker, forcedFriendlyFireRule )
{
	if ( !isdefined(owner) ) // owner has disconnected? allow it
		return true;
	
	if ( !level.teamBased ) // not a team based mode? allow it
		return true;
	
	friendlyFireRule = level.friendlyfire;
	if ( isdefined( forcedFriendlyFireRule ) )
		friendlyFireRule = forcedFriendlyFireRule;
	
	if ( friendlyFireRule != 0 ) // friendly fire is on? allow it
		return true;
	
	if ( attacker == owner ) // owner may attack his own items
		return true;
	
	if (!isdefined(attacker.pers["team"])) // attacker not on a team? allow it
		return true;
	
	if ( attacker.pers["team"] != owner.pers["team"] ) // attacker not on the same team as the owner? allow it
		return true;
	
	return false; // disallow it
}