//  ________/\\\\\\\\\__________________________________________________________        
//   _____/\\\////////___________________________________________________________       
//    ___/\\\/_________________________________________________________/\\\__/\\\_      
//     __/\\\______________/\\/\\\\\\\___/\\\\\\\\\_____/\\\\\\\\\\\___\//\\\/\\\__     
//      _\/\\\_____________\/\\\/////\\\_\////////\\\___\///////\\\/_____\//\\\\\___    
//       _\//\\\____________\/\\\___\///____/\\\\\\\\\\_______/\\\/________\//\\\____   
//        __\///\\\__________\/\\\__________/\\\/////\\\_____/\\\/_______/\\_/\\\_____  
//         ____\////\\\\\\\\\_\/\\\_________\//\\\\\\\\/\\__/\\\\\\\\\\\_\//\\\\/______ 
//          _______\/////////__\///___________\////////\//__\///////////___\////________

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include crazy\_common;

main()
{
	if(level.gametype != "sd")
		return;
	level.fx[ "tank_fire_engine" ] = loadfx("fire/tank_fire_engine");
	thread spawnTriggers();
}
spawnTriggers()
{
	waittillframeend;
	switch(level.script)
	{
		case "mp_crash":
			addBlockerWall((2294,1377,80),(2291,1550,80));
			addBlockerWall((2291,1550,80),(2134,1551,80));
			addBlockerWall((2134,1551,80),(2172,2122,80));
			addBlockerWall((2172,2122,80),(2658,2117,80));
			addBlockerWall((2658,2117,80),(2666,1363,80));
			addBlockerWall((2666,1363,80),(2294,1377,80));
			break;
			
		case "mp_crash_snow":
			addBlockerWall((2294,1377,80),(2291,1550,80));
			addBlockerWall((2291,1550,80),(2134,1551,80));
			addBlockerWall((2134,1551,80),(2172,2122,80));
			addBlockerWall((2172,2122,80),(2658,2117,80));
			addBlockerWall((2658,2117,80),(2666,1363,80));
			addBlockerWall((2666,1363,80),(2294,1377,80));
			break;	
			
		case "mp_crossfire":
			addBlockerWall((7104,14,378),(6899,1015,378));
			addBlockerWall((6883,976,345),(6194,820,345));
			addBlockerWall((6221,791,378),(6422,-137,378));
			addBlockerWall((7094,-3,345),(6405,-156,345));
			break;
			
		case "mp_backlot":
			addBlockerWall((-896,2214,67),(-862,2911,67));
			addBlockerWall((-1633,2194,75),(-896,2214,67));
			break;
		
		case "mp_strike":
			addBlockerWall((108,-2782,480),(524,-2782,480));
			addBlockerWall((524,-2782,480),(524,-2422,480));
			addBlockerWall((524,-2422,480),(108,-2422,480));
			addBlockerWall((108,-2422,480),(108,-2782,480));
			break;
			
		case "mp_vacant":
			addBlockerWall((-2712,1273,-111),(-2707,188,-111));
			addBlockerWall((-2707,188,-111),(-3560,188,-111));
			addBlockerWall((-3560,188,-111),(-3523,1261,-111));
			addBlockerWall((-3523,1261,-111),(-2712,1273,-111));
			break;			
		
		case "mp_citystreets":
			addBlockerWall((2657,-3179,-101),(2409,-2651,-101));
			break;
			
		case "mp_convoy":
			addBlockerWall((-3399,825,-57),(-3409,401,-57));
			break;
			
		case "mp_bloc":
			addBlockerWall((2189,-8195,19),(2170,-9168,19));
			addBlockerWall((2170,-9168,19),(1260,-9155,19));
			addBlockerWall((1260,-9155,19),(1279,-8169,19));
			addBlockerWall((2189,-8195,19),(1279,-8169,19));
			break;
			
		case "mp_bog":
			addBlockerWall((6451,-136,345),(6290,648,345));
			addBlockerWall((6290,648,345),(6906,789,345));
			addBlockerWall((6906,789,345),(7067,29,345));
			addBlockerWall((7067,29,345),(6451,-136,345));
			
			break;
			
		case "mp_cargoship":
			addBlockerWall((-2373,-223,725),(-2371,-397,725));
			addBlockerWall((-2411,-388,725),(-2414,-457,773));
			addBlockerWall((-2414,-457,773),(-2425,-641,773));
			addBlockerWall((-2425,-641,773),(-2615,-627,773));
			addBlockerWall((-2615,-627,773),(-2609,-447,773));
			addBlockerWall((-2609,-447,773),(-2609,-390,725));
			addBlockerWall((-2609,-390,725),(-2782,-392,725));
			addBlockerWall((-2782,-392,725),(-2782,410,725));
			addBlockerWall((-2782,410,725),(-2614,403,725));
			addBlockerWall((-2614,403,725),(-2612,451,773));
			addBlockerWall((-2612,451,773),(-2610,465,773));
			addBlockerWall((-2610,465,773),(-2594,642,773));
			addBlockerWall((-2594,642,773),(-2422,636,773));
			addBlockerWall((-2422,636,773),(-2419,469,773));
			addBlockerWall((-2419,469,773),(-2417,395,773));
			addBlockerWall((-2417,395,730),(-2429,393,730));
			addBlockerWall((-2429,393,730),(-2358,184,730));
			addBlock((-2647, 380, 730), 10); 
			addBlock((-2301,-121,765), 10); 
			addBlock((-2298, 120, 765), 10);
			break;
			
		case "mp_countdown":
			addBlockerWall((1136,4628,-1),(2452,3927,-1));
			addBlockerWall((2452,3927,-1),(2769,4522,-1));
			addBlockerWall((2769,4522,-1),(1464,5203,-1));
			addBlockerWall((1464,5203,-1),(1136,4628,-1));
			break;
			
		case "mp_farm":
			addBlockerWall((298,-2283,135),(1407,-2113,135));
			addBlockerWall((1407,-2113,135),(1469,-1710,135));
			addBlockerWall((298,-2283,135),(280,-1733,135));
			break;
			
		case "mp_overgrown":
			addBlockerWall((4048,-1198,-114),(3183,-1161,-114));
			addBlockerWall((3183,-1161,-114),(3178,-1744,-114));
			addBlockerWall((3178,-1744,-114),(3972,-1700,-114));
			addBlockerWall((3972,-1700,-114),(4048,-1198,-114));
			break;
			
		case "mp_pipeline":
			addBlockerWall((-2267,-4346,298),(-1671,-4399,298));
			break;
			
		case "mp_showdown":
			addBlockerWall((1198,-480,403),(1210,1154,403));
			addBlockerWall((1210,1154,403),(1766,1142,403));
			addBlockerWall((1766,1142,403),(1776,-474,403));
			addBlockerWall((1776,-474,403),(1198,-480,403));
			break;
			
		case "mp_shipment":
			addBlockerWall((-3332,2024,203),(-3334,791,203));
			addBlockerWall((-3332,2024,203),(-1815,2015,203));
			addBlockerWall((-1815,2015,203),(-1842,790,203));
			addBlockerWall((-1842,790,203),(-3334,791,203));
			break;
		
		case "mp_nuketown":
			addBlockerWall((769,-986,190),(769,-1486,253));
			addBlockerWall((772,-1471,253),(1443,-1467,253));
			addBlockerWall((1436,-1491,253),(1419,-1010,190));
			addBlockerWall((1446,-1040,190),(769,-986,190));
			break;
		
		case "mp_marketcenter":
			addBlockerWall((591,3749,200),(1417,3749,200));
			break;		
	}
}
AddBlockerWall(a,b)
{
	thread AddfireWall(a,b);
	speed = distance(a,b)/700;
 	link = spawn("script_origin",a);
	link MoveTo(b,speed); 
	for(k=0;k<speed*20;k++)
	{ 		
		//Addfire(link.origin+(0,0,100));
		AddBlock(link.origin,25,100);
		wait .05;
	} 	link delete();
}
/*
_addfwall(a,b) {
	speed = distance(a,b)/700;
	for(;;wait (speed)) {
		AddfireWall(a,b);
	}
}*/

AddfireWall(a,b)
{
	/*speed = distance(a,b);
 	link = spawn("script_origin",a);
	link MoveTo(b,speed); 
	for(k=0;k<speed*20;k++)
	{ 
		Addfire(link.origin);
		wait .05;
	} 	link delete();*/
}

Addfire( o )
{
	while(1) 
	{
		playFx( level.fx["tank_fire_engine"],  o );
		wait 2;
    }
}

addBlock(o, w, h)
{
	if (! isDefined(h))
		h = w;

	a = spawn("trigger_radius", o, 0, w, h);
	thread Addfire( o );
	a setContents(1);
}