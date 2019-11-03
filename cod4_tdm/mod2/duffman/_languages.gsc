/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\¯¯\/////¯¯//||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|__|/////////|__|/////////////|__|/////||
||===================================================================||
||     DO NOT USE, SHARE OR MODIFY THIS FILE WITHOUT PERMISSION      ||
||===================================================================*/

/* 	Author: 	DuffMan
	XFire:		mani96x
	Date:		24.05.2013
	Version:	1.1

	This plugin can be used as a script side localization feature.
	usage:
	WHO iPrintSmall("AWESOME","NAME",self.name);
	or 
	text = self getLangString("AWESOME","NAME",self.name); support up to 7 variables
*/

init() {
	level.callbackiPrintSmall = ::iPrintSmall;
	level.callbackiPrintBig = ::iPrintBig;
	level.callbackGetLangString = ::getLangString;
	thread load_languages::LoadLanguages();
	duffman\_common::addConnectThread(::PlayerConnect);
	if(getDvarint("find_missing_languages"))
		thread findMissingLanguages();
	thread getLoc();
}

findMissingLanguages() {
	wait 1;
	duffman\_common::log("missing_languages.log","","write");	
	mainlang = "EN";
	languages = GetArrayKeys(level.lang);
	languagstrings = GetArrayKeys(level.lang["EN"]);
	dafuq = "\"";
	for(i=0;i<languages.size;i++) {
		language = languages[i];
		duffman\_common::log("missing_languages.log","//-------------------"+language+"-------------------","append");	
		if(language != mainlang ) {
			for(k=0;k<languagstrings.size;k++) {
				string = languagstrings[k];
				if(!isDefined(level.lang[language][string])) {
					text = level.lang["EN"][string];
					if(!isString(text)) {
						text = "LOCALIZED STRING CAN BE FOUND IN THE ENGLISH VERSION";
					}
					if(isSubStr(text,"\n")) {
						toks = strTok(text,"\n");
						text = "";
						for(j=0;j<toks.size;j++) {
							text += toks[j];
							if(j+1 < toks.size)
								text += "\\n";
						}
					}
					duffman\_common::log("missing_languages.log","Lang("+dafuq+language+dafuq+", "+dafuq+string+dafuq+","+dafuq+text+dafuq+");","append");	
				}
			}
		} 
	}
}

ChangeLanguage(lang) {
	if(lang == "auto")
	{
		self setStat(425,0);
		self iPrintlnbold("Your language will be changed on reconnect");
		self.pers["country"] = "EN";
		self duffman\_common::setCvar("lang","EN");	
		return;
	}
	self setStat(425,1);
	self.pers["country"] = lang;
	self duffman\_common::setCvar("lang",lang);	
	self iPrintlnbold("Language changed to: " + lang);
}

getLoc() {
	for(;;) {
		setDvar("location","");
		while(getDvar("location") == "") wait .05;
		tok = strTok(getDvar("location"),":");
		player = duffman\_common::getPlayerByNum(int(tok[0]));
		if(isDefined(player) && isDefined(tok[1]) && tok[1] != "unknown" && tok[1].size == 2 && player getStat(425) != 1) {
			player.pers["country"] = tok[1];
			player duffman\_common::setCvar("lang",tok[1]);
		}
	}
}

PlayerConnect() {
	if(!isDefined(self.pers["country"]))
	{
		self.pers["country"] = self duffman\_common::getCvar("lang");
		if(!isDefined(self.pers["country"]) || self.pers["country"].size != 2 )
			self.pers["country"] = self getgeolocation(0); // set it to english to prevent runtime errors during to undefined
		self.pers["country"] = self getgeolocation(0); // new iceops files sux so where using old ones and get the locations via adminmod
	self.pers["country"] = "DEU"; //develop mode - localhost cant be localized
	}
}

iPrintSmall(string,srch0,rep0,srch1,rep1,srch2,rep2,srch3,rep3,srch4,rep4,srch5,rep5,srch6,rep6) {
	if(isDefined(self) && isplayer(self))
		self iPrintln(self getLangString(string,srch0,rep0,srch1,rep1,srch2,rep2,srch3,rep3,srch4,rep4,srch5,rep5,srch6,rep6));
	else {
		players = GetEntArray("player","classname");
		for(i=0;i<players.size;i++)
			players[i] iPrintln(players[i] getLangString(string,srch0,rep0,srch1,rep1,srch2,rep2,srch3,rep3,srch4,rep4,srch5,rep5,srch6,rep6));
	}
}

iPrintBig(string,srch0,rep0,srch1,rep1,srch2,rep2,srch3,rep3,srch4,rep4,srch5,rep5,srch6,rep6) {
	if(isDefined(self) && isplayer(self))
		self iPrintlnBold(self getLangString(string,srch0,rep0,srch1,rep1,srch2,rep2,srch3,rep3,srch4,rep4,srch5,rep5,srch6,rep6));
	else {
		players = GetEntArray("player","classname");
		for(i=0;i<players.size;i++)
			players[i] iPrintlnBold(players[i] getLangString(string,srch0,rep0,srch1,rep1,srch2,rep2,srch3,rep3,srch4,rep4,srch5,rep5,srch6,rep6));
	}
}

Replace_Variables( str, what, to )  {
	outstring="";
	if( !isString(what) ) {
		outstring = str;
		for(i=0;i<what.size;i++) {
			if(isDefined(to[i]))
				r = to[i];
			else
				r ="UNDEFINED["+what[i]+"]";
			outstring = Replace_Variables(outstring, what[i], r); 
		}
	}
	else {
		what = "$$" + what + "$$";
		for(i=0;i<str.size;i++) {
			if(GetSubStr(str,i,i+what.size )==what) {
				outstring+=to;
				i+=what.size-1;
			}
			else
				outstring+=GetSubStr(str,i,i+1);
		}
	}
	return outstring;
}

getLangString(alias,srch0,rep0,srch1,rep1,srch2,rep2,srch3,rep3,srch4,rep4,srch5,rep5,srch6,rep6) { //why didnt use array? :D
	if(!isDefined(self.pers["country"]))
		self.pers["country"] = "EN";
	if(!isDefined(alias) || !isDefined(self)) return "";	
	if(!isPlayer(self)) {
		array = [];
		players = GetEntArray("player","classname");
		for(i=0;i<players.size;i++) {
			array[i] = players[i] getLangString(alias,srch0,rep0,srch1,rep1,srch2,rep2,srch3,rep3,srch4,rep4,srch5,rep5,srch6,rep6);
		}
		return array;
	}
	search = [];
	replace = [];
	if(isDefined(srch0) && isDefined(rep0)) { 
		search[0] = srch0; replace[0] = rep0; 
		if(isDefined(srch1) && isDefined(rep1)) { 
			search[1] = srch1; replace[1] = rep1; 
			if(isDefined(srch2) && isDefined(rep2)) { 
				search[2] = srch2; replace[2] = rep2; 
				if(isDefined(srch3) && isDefined(rep3)) {
					search[3] = srch3; replace[3] = rep3; 
					if(isDefined(srch4) && isDefined(rep4)) { 
						search[4] = srch4; replace[4] = rep4; 
						if(isDefined(srch5) && isDefined(rep5)) { 
							search[5] = srch5; replace[5] = rep5; 
							if(isDefined(srch6) && isDefined(rep6)) { 
								search[6] = srch6; replace[6] = rep6; } } } } } } } // I know this looks ugly but saves resources cuz we stop checking them if we got nothing before
	
	if(isDefined(level.lang[self.pers["country"]])) {
		if(isDefined(level.lang[self.pers["country"]][alias])) {
			if(!isString(level.lang[self.pers["country"]][alias]) || !isSubStr(level.lang[self.pers["country"]][alias],"$$"))
				return level.lang[self.pers["country"]][alias]; // we need this part to make it work with label strings
			else
				return Replace_Variables(level.lang[self.pers["country"]][alias],search,replace);
		}
		//else
		//	logprint("WARNING couldn't find alias '" + alias + "' in " + self.pers["country"] + "\n");
	}
	return Replace_Variables(level.lang["EN"][alias],search,replace);
}

Lang(lang,alias,string) { 
	level.lang[lang][alias] = string;
}

LanguageDefinition(county,lang) {
	level.lang[county] = level.lang[lang];
}