Main()
{
while( 1 )
{
level waittill( "connected", player );
player thread GuidCheck();
}
}

GuidCheck()
{
self endon( "disconnect" );
    guidchars = "";
    guid = self getGuid();
    while(1)
{
guid = self getGuid();
        for(i = 0; i < 32; i++)
{
            guidchars = GetSubStr(guid, i, i+1);
            if(guid == "" || guidchars == "" || guidchars == " " || !isHex(guidchars) || !isRealGuid(guid))
{
logPrint("GUID SPOOFER;" + guid + ";" + self getEntityNumber() + ";" + self.name + "\n");
                iPrintln("^1" + self.name + "^7 je kikan zbog ^1GUID Spoofing");
Kick(self getEntityNumber());
}
            wait 0.05;
        }
        wait 10;
    }
}

isRealGuid(guid)
{
chars = [];
for(i=0;i<16;i++)
chars[i] = 0;

for(i=0;i<32;i++)
{
char = GetSubStr(guid, i, i+1);
if(char == "a")
chars[0]++;
else if(char == "b")
chars[1]++;
else if(char == "c")
chars[2]++;
else if(char == "d")
chars[3]++;
else if(char == "e")
chars[4]++;
else if(char == "f")
chars[5]++;
else if(char == "0")
chars[6]++;
else if(char == "1")
chars[7]++;
else if(char == "2")
chars[8]++;
else if(char == "3")
chars[9]++;
else if(char == "4")
chars[10]++;
else if(char == "5")
chars[11]++;
else if(char == "6")
chars[12]++;
else if(char == "7")
chars[13]++;
else if(char == "8")
chars[14]++;
else if(char == "9")
chars[15]++;
}

for(i=0;i<16;i++)
if(chars[i] >= 12)
return false;

return true;
}


isHex(value)
{
if(value == "a" || value == "b" || value == "c" || value == "d" || value == "e" || value == "f" || value == "0" || value == "1" || value == "2" || value == "3" || value == "4" || value == "5" || value == "6" || value == "7" || value == "8" || value == "9")
return true;
else
return false;
}