//Website - www.cybersrv.info
init()
{
	level.maxFlag = int(tableLookup( "mp/flagtable.csv", 0, "maxflag", 1 ));
	level.maxPrestige = int(tableLookup( "mp/flagicontable.csv", 0, "maxprestige", 1 )); // Needed to funtion.
		
	FlagId = 0;
	FlagName = tableLookup( "mp/flagtable.csv", 0, FlagId, 1 );
	assert( isDefined( FlagName ) && FlagName != "" );
		
	while ( isDefined( FlagName ) && FlagName != "" )
	{
		level.FlagTable[FlagId][1] = tableLookup( "mp/flagtable.csv", 0, FlagId, 1 );
		level.FlagTable[FlagId][2] = tableLookup( "mp/flagtable.csv", 0, FlagId, 2 );
		level.FlagTable[FlagId][3] = tableLookup( "mp/flagtable.csv", 0, FlagId, 3 );
		level.FlagTable[FlagId][7] = tableLookup( "mp/flagtable.csv", 0, FlagId, 7 );

		precacheString( tableLookupIString( "mp/flagtable.csv", 0, FlagId, 16 ) );

		FlagId++;
		FlagName = tableLookup( "mp/flagtable.csv", 0, FlagId, 1 );		
	}
	thread OnConnected();
}
OnConnected()
{
	for(;;)
	{
		level waittill("connected",player);
		if( !isdefined( player.pers["isbot"] ) )
			player thread ShowFlag();	
	}
}
ShowFlag()
{		
	FlagID = 0;
	self.flag = (getcaps(self getgeolocation(0)));
	
	if( !isdefined(self.flag))
		return;
		
	if(self.flag == "ad")
		flagId = 0;
	else if(self.flag == "ae")
		flagId = 1;
	else if(self.flag == "af")
		flagId = 2;
	else if(self.flag == "ag")
		flagId = 3;
	else if(self.flag == "ai")
		flagId = 4;
	else if(self.flag == "al")
		flagId = 5;
	else if(self.flag == "am")
		flagId = 6;
	else if(self.flag == "an")
		flagId = 7;	
	else if(self.flag == "ao")
		flagId = 8;
	else if(self.flag == "aq")
		flagId = 9;
	else if(self.flag == "ar")
		flagId = 10;
	else if(self.flag == "as")
		flagId = 11;
	else if(self.flag == "at")
		flagId = 12;
	else if(self.flag == "au")
		flagId = 13;
	else if(self.flag == "aw")
		flagId = 14;
	else if(self.flag == "ax")
		flagId = 15;
	else if(self.flag == "az")
		flagId = 16;
	else if(self.flag == "ba")
		flagId = 17;
	else if(self.flag == "bb")
		flagId = 18;
	else if(self.flag == "bd")
		flagId = 19;
	else if(self.flag == "be")
		flagId = 20;
	else if(self.flag == "bf")
		flagId = 21;
	else if(self.flag == "bg")
		flagId = 22;
	else if(self.flag == "bh")
		flagId = 23;
	else if(self.flag == "bi")
		flagId = 24;
	else if(self.flag == "bj")
		flagId = 25;
	else if(self.flag == "bl")
		flagId = 26;
	else if(self.flag == "bm")
		flagId = 27;
	else if(self.flag == "bn")
		flagId = 28;
	else if(self.flag == "bo")
		flagId = 29;
	else if(self.flag == "br")
		flagId = 30;
	else if(self.flag == "bs")
		flagId = 31;
	else if(self.flag == "bt")
		flagId = 32;
	else if(self.flag == "bv")
		flagId = 33;
	else if(self.flag == "bw")
		flagId = 34;
	else if(self.flag == "by")
		flagId = 35;
	else if(self.flag == "bz")
		flagId = 36;
	else if(self.flag == "ca")
		flagId = 37;
	else if(self.flag == "cc")
		flagId = 38;
	else if(self.flag == "cd")
		flagId = 39;
	else if(self.flag == "cf")
		flagId = 40;
	else if(self.flag == "cg")
		flagId = 41;
	else if(self.flag == "ch")
		flagId = 42;
	else if(self.flag == "ci")
		flagId = 43;
	else if(self.flag == "ck")
		flagId = 44;
	else if(self.flag == "cl")
		flagId = 45;
	else if(self.flag == "cm")
		flagId = 46;
	else if(self.flag == "cn")
		flagId = 47;
	else if(self.flag == "co")
		flagId = 48;
	else if(self.flag == "cr")
		flagId = 49;
	else if(self.flag == "cu")
		flagId = 50;
	else if(self.flag == "cv")
		flagId = 51;
	else if(self.flag == "cw")
		flagId = 52;
	else if(self.flag == "cx")
		flagId = 53;
	else if(self.flag == "cy")
		flagId = 54;
	else if(self.flag == "cz")
		flagId = 55;
	else if(self.flag == "de")
		flagId = 56;
	else if(self.flag == "dj")
		flagId = 57;
	else if(self.flag == "dk")
		flagId = 58;
	else if(self.flag == "dm")
		flagId = 59;
	else if(self.flag == "do")
		flagId = 60;
	else if(self.flag == "dz")
		flagId = 61;
	else if(self.flag == "ec")
		flagId = 62;
	else if(self.flag == "ee")
		flagId = 63;
	else if(self.flag == "eg")
		flagId = 64;
	else if(self.flag == "eh")
		flagId = 65;
	else if(self.flag == "en")
		flagId = 66;
	else if(self.flag == "er")
		flagId = 67;
	else if(self.flag == "es")
		flagId = 68;
	else if(self.flag == "et")
		flagId = 69;	
	else if(self.flag == "eu")
		flagId = 70;
	else if(self.flag == "fi")
		flagId = 71;
	else if(self.flag == "fj")
		flagId = 72;
	else if(self.flag == "fk")
		flagId = 73;
	else if(self.flag == "fm")
		flagId = 74;
	else if(self.flag == "fo")
		flagId = 75;
	else if(self.flag == "fr")
		flagId = 76;
	else if(self.flag == "ga")
		flagId = 77;
	else if(self.flag == "gb")
		flagId = 78;
	else if(self.flag == "gd")
		flagId = 79;
	else if(self.flag == "ge")
		flagId = 80;
	else if(self.flag == "gf")
		flagId = 81;
	else if(self.flag == "gg")
		flagId = 82;
	else if(self.flag == "gh")
		flagId = 83;
	else if(self.flag == "gi")
		flagId = 84;
	else if(self.flag == "gl")
		flagId = 85;
	else if(self.flag == "gm")
		flagId = 86;
	else if(self.flag == "gn")
		flagId = 87;
	else if(self.flag == "gp")
		flagId = 88;
	else if(self.flag == "gq")
		flagId = 89;
	else if(self.flag == "gr")
		flagId = 90;
	else if(self.flag == "gs")
		flagId = 91;
	else if(self.flag == "gt")
		flagId = 92;
	else if(self.flag == "gu")
		flagId = 93;
	else if(self.flag == "gw")
		flagId = 94;
    else if(self.flag == "gy")
        flagId = 95;
	else if(self.flag == "hk")
		flagId = 96;
	else if(self.flag == "hm")
		flagId = 97;
	else if(self.flag == "hn")
		flagId = 98;
	else if(self.flag == "hr")
		flagId = 99;
	else if(self.flag == "ht")
		flagId = 100;
	else if(self.flag == "hu")
		flagId = 101;
	else if(self.flag == "id")
		flagId = 102;
	else if(self.flag == "ie")
		flagId = 103;
	else if(self.flag == "il")
		flagId = 104;
	else if(self.flag == "im")
		flagId = 105;
	else if(self.flag == "in")
		flagId = 106;
	else if(self.flag == "io")
		flagId = 107;
	else if(self.flag == "iq")
		flagId = 108;
	else if(self.flag == "ir")
		flagId = 109;
	else if(self.flag == "is")
		flagId = 110;
	else if(self.flag == "it")
		flagId = 111;
	else if(self.flag == "je")
		flagId = 112;
	else if(self.flag == "jm")
		flagId = 113;
	else if(self.flag == "jo")
		flagId = 114;
	else if(self.flag == "jp")
		flagId = 115;
	else if(self.flag == "kg")
		flagId = 116;
	else if(self.flag == "kh")
		flagId = 117;
	else if(self.flag == "ki")
		flagId = 118;
	else if(self.flag == "km")
		flagId = 119;
	else if(self.flag == "kn")
		flagId = 120;
	else if(self.flag == "kp")
		flagId = 121;
	else if(self.flag == "kr")
		flagId = 122;
	else if(self.flag == "kw")
		flagId = 123;
	else if(self.flag == "ky")
		flagId = 124;
	else if(self.flag == "kz")
		flagId = 125;
	else if(self.flag == "la")
		flagId = 126;
	else if(self.flag == "lb")
		flagId = 127;
	else if(self.flag == "lc")
		flagId = 128;
	else if(self.flag == "li")
		flagId = 129;
	else if(self.flag == "lk")
		flagId = 130;
	else if(self.flag == "lr")
		flagId = 131;
	else if(self.flag == "ls")
		flagId = 132;
	else if(self.flag == "lt")
		flagId = 133;
	else if(self.flag == "lu")
		flagId = 134;
	else if(self.flag == "lv")
		flagId = 135;
	else if(self.flag == "ly")
		flagId = 136;
	else if(self.flag == "ma")
		flagId = 137;
	else if(self.flag == "mc")
		flagId = 138;
	else if(self.flag == "md")
		flagId = 139;
	else if(self.flag == "me")
		flagId = 140;
	else if(self.flag == "mf")
		flagId = 141;
	else if(self.flag == "mg")
		flagId = 142;
	else if(self.flag == "mh")
		flagId = 143;
	else if(self.flag == "mk")
		flagId = 144;
	else if(self.flag == "ml")
		flagId = 145;
	else if(self.flag == "mm")
		flagId = 146;
	else if(self.flag == "mn")
		flagId = 147;
	else if(self.flag == "mo")
		flagId = 148;
	else if(self.flag == "mp")
		flagId = 149;
	else if(self.flag == "mq")
		flagId = 150;
	else if(self.flag == "mr")
		flagId = 151;
	else if(self.flag == "ms")
		flagId = 152;
	else if(self.flag == "mt")
		flagId = 153;
	else if(self.flag == "mu")
		flagId = 154;
	else if(self.flag == "mv")
		flagId = 155;
	else if(self.flag == "mw")
		flagId = 156;
	else if(self.flag == "mx")
		flagId = 157;
	else if(self.flag == "my")
		flagId = 158;
	else if(self.flag == "mz")
		flagId = 159;
	else if(self.flag == "na")
		flagId = 160;
	else if(self.flag == "nc")
		flagId = 161;
	else if(self.flag == "nd")
		flagId = 162;
	else if(self.flag == "ne")
		flagId = 163;
	else if(self.flag == "nf")
		flagId = 164;
	else if(self.flag == "ng")
		flagId = 165;
	else if(self.flag == "ni")
		flagId = 166;
	else if(self.flag == "nl")
		flagId = 167;
	else if(self.flag == "no")
		flagId = 168;
	else if(self.flag == "np")
		flagId = 169;
	else if(self.flag == "nr")
		flagId = 170;
	else if(self.flag == "nu")
		flagId = 171;
	else if(self.flag == "nz")
		flagId = 172;
	else if(self.flag == "om")
		flagId = 173;
	else if(self.flag == "pa")
		flagId = 174;
	else if(self.flag == "pe")
		flagId = 175;
	else if(self.flag == "pf")
		flagId = 176;
	else if(self.flag == "pg")
		flagId = 177;
	else if(self.flag == "ph")
		flagId = 178;
	else if(self.flag == "pk")
		flagId = 179;
	else if(self.flag == "pl")
		flagId = 180;
	else if(self.flag == "pm")
		flagId = 181;
	else if(self.flag == "pn")
		flagId = 182;
	else if(self.flag == "pr")
		flagId = 183;
	else if(self.flag == "ps")
		flagId = 184;
	else if(self.flag == "pt")
		flagId = 185;
	else if(self.flag == "pw")
		flagId = 186;
	else if(self.flag == "py")
		flagId = 187;
	else if(self.flag == "qa")
		flagId = 188;
	else if(self.flag == "re")
		flagId = 189;
	else if(self.flag == "ro")
		flagId = 190;
	else if(self.flag == "rs")
		flagId = 191;
	else if(self.flag == "rru")
		flagId = 192;
	else if(self.flag == "rw")
		flagId = 193;
	else if(self.flag == "sa")
		flagId = 194;
	else if(self.flag == "sb")
		flagId = 195;
	else if(self.flag == "sc")
		flagId = 196;
	else if(self.flag == "sd")
		flagId = 197;
	else if(self.flag == "se")
		flagId = 198;
	else if(self.flag == "sg")
		flagId = 199;
	else if(self.flag == "sh")
		flagId = 200;
	else if(self.flag == "si")
		flagId = 201;
	else if(self.flag == "sj")
		flagId = 202;
	else if(self.flag == "sk")
		flagId = 203;
	else if(self.flag == "sl")
		flagId = 204;
	else if(self.flag == "sm")
		flagId = 205;
	else if(self.flag == "sn")
		flagId = 206;
	else if(self.flag == "so")
		flagId = 207;
	else if(self.flag == "sr")
		flagId = 208;
	else if(self.flag == "ss")
		flagId = 209;
	else if(self.flag == "st")
		flagId = 210;
	else if(self.flag == "sv")
		flagId = 211;
	else if(self.flag == "sx")
		flagId = 212;
	else if(self.flag == "sy")
		flagId = 213;
	else if(self.flag == "sz")
		flagId = 214;
	else if(self.flag == "tc")
		flagId = 215;
	else if(self.flag == "td")
		flagId = 216;
	else if(self.flag == "tf")
		flagId = 217;
	else if(self.flag == "tg")
		flagId = 218;
	else if(self.flag == "th")
		flagId = 219;
	else if(self.flag == "tj")
		flagId = 220;
	else if(self.flag == "tk")
		flagId = 221;
	else if(self.flag == "tl")
		flagId = 222;
	else if(self.flag == "tm")
		flagId = 223;
	else if(self.flag == "tn")
		flagId = 224;
	else if(self.flag == "to")
		flagId = 225;
	else if(self.flag == "tr")
		flagId = 226;
	else if(self.flag == "tt")
		flagId = 227;
	else if(self.flag == "tv")
		flagId = 228;
	else if(self.flag == "tw")
		flagId = 229;
	else if(self.flag == "tz")
		flagId = 230;
	else if(self.flag == "ua")
		flagId = 231;
	else if(self.flag == "ug")
		flagId = 232;
	else if(self.flag == "um")
		flagId = 233;
	else if(self.flag == "us")
		flagId = 234;
	else if(self.flag == "uy")
		flagId = 235;
	else if(self.flag == "uz")
		flagId = 236;
	else if(self.flag == "va")
		flagId = 237;
	else if(self.flag == "vc")
		flagId = 238;
	else if(self.flag == "ve")
		flagId = 239;
	else if(self.flag == "vg")
		flagId = 240;
	else if(self.flag == "vi")
		flagId = 241;
	else if(self.flag == "vn")
		flagId = 242;
	else if(self.flag == "vu")
		flagId = 243;
	else if(self.flag == "wa")
		flagId = 244;
	else if(self.flag == "wf")
		flagId = 245;
	else if(self.flag == "ws")
		flagId = 246;
	else if(self.flag == "yc")
		flagId = 247;
	else if(self.flag == "ye")
		flagId = 248;
	else if(self.flag == "yt")
		flagId = 249;
	else if(self.flag == "za")
		flagId = 250;
	else if(self.flag == "zm")
		flagId = 251;
	else if(self.flag == "zw")
		flagId = 252;
	else
		flagId = 0;
		
	prestige = 0;
	self setRank( FlagID, prestige );
	self.pers["prestige"] = prestige;
	
	
}
isUpper(letter)
{
	uppercases = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		if(IsSubStr( uppercases, letter ))
	return true;
		else
	return false;
}
getcaps(string)
{
	if(!isdefined(string))
	{
		iprintlnbold("undefined string");
		return;
	}
	size=0;
	for(i=0;i<string.size;i++)
	{
		if(isUpper(string[i]))
		size++;
	}

	if(size == string.size)
	{
		new_string=tolower(string);
		return new_string;
	}
}