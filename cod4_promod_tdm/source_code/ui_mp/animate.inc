#define ZERO_TO_ONE(dvarArg)                     (milliseconds() - dvarInt(ui_time_marker) - dvarInt(spawnedTime) + dvarInt("openMenuTime" + dvarArg))

/*#define UNIT_GROWTH(time,dvarArg)             sin( sin( min( ZERO_TO_ONE(dvarArg), (time*1000) )*(1.5707/(time*1000)) )*1.5707 )

#define ANIMATE_HORIZONTAL(dvarArg,from, scale,time) \
		(from - (scale - scale*UNIT_GROWTH(time,dvarArg)))
		
#define ANIMATE_VERTICAL(dvarArg,from, scale,time) \
		(from - ((-scale) + scale*UNIT_GROWTH(time,dvarArg)))*/
		
				
#define ANIMATE(dvarArg,timeArg) max( min( ZERO_TO_ONE(dvarArg) / (timeArg*1000) , 1 ) , 0 )

#define ANIMATE_VISIBLE(dvarArg,visTimeArg)  int(ZERO_TO_ONE(dvarArg) < (visTimeArg*1000))


//min( max( (  ZERO_TO_ONE(dvarArg) + timebeforeclose ) / 150 , 0 ) , 1 )