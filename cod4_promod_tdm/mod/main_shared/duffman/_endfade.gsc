#include duffman\_common;

init()
{

	wait 1;

	blackscreen = addTextHud( level, 0, 0, 1, "center", "middle", "center", "middle", 3, 9999999 );
	blackscreen setShader("white",1000,1000);
	blackscreen.color = (0,0,0);
	blackscreen1 = addTextHud( level, 0, 0, 1, "center", "middle", "center", "middle", 3, 9999999 );
	blackscreen1 setShader("white",1000,1000);
	blackscreen1.color = (0,0,0);	
	blackscreen thread fadeIn(1.5);
	blackscreen1 thread fadeIn(1.5);
	wait 1.8;
}
