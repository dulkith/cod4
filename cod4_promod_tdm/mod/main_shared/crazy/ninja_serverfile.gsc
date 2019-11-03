init()
{ 
	level.ninjaServerFile = false;
	level.authorizeMode = getDvarInt("sv_authorizemode");
	level.getGuid = ::_getGuid;
	level.getDay = ::_getDay;
} 
_getGuid()
{
	return self getGuid();
}
_getDay()
{
	return "Monday";
}