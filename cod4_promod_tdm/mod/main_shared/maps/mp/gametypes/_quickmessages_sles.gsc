init()
{
	game["menu_quickcommands"] = "quickcommands_fun_sles";
	
	precacheMenu(game["menu_quickcommands_fun_sles"]);
	//precacheHeadIcon("talkingicon");

}

quickcommands_sles_fun(response)
{
	self endon ( "disconnect" );
	
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	self.spamdelay = true;
	
	switch(response)		
	{
		case "1":
			soundalias = "sles_fun_1_amarabaduRupasingha";
			saytext = "Amara Bandu Ruupasingha";
			break;

		case "2":
			soundalias = "sles_fun_2_thamaKapannaGaththeNaNe";
			saytext = "Thama Kapanna Gaththe Na ne...";
			break;

		case "3":
			soundalias = "sles_fun_3_surpriceMotherFucker";
			saytext = "Surprise Mother Fucker";
			break;

		case "4":
			soundalias = "sles_fun_4_danSapada";
			saytext = "Dan Sapada...";
			break;

		case "5":
			soundalias = "sles_fun_5_pissekVage";
			saytext = "Pissek Vage Pissek Vage";
			break;

		case "6":
			soundalias = "sles_fun_6_iiiya";
			saytext = "Eeeeyaaa...";
			break;

		case "7":
			soundalias = "sles_fun_7_kalinKiyannaEpai";
			saytext = "Kalin Kiyanna Epai Hu***";
			break;

		case "8":
			assert(response == "8");
			soundalias = "sles_fun_8_OkaAragenaGahaGanin";
			saytext = "Ooka Aragena Gahaganin Pu**";
			break;
		
		default:
			assert(response == "9");
			soundalias = "sles_fun_9_adukuleParahaththa";
			saytext = "Adu Kule Para Haththa, Palayan Yanna Mage Daahata Pennathuwa.";
			break;
	}

	self saveHeadIcon();
	self doQuickMessage(soundalias, saytext);

	wait 2;
	self.spamdelay = undefined;
	self restoreHeadIcon();	
}

doQuickMessage( soundalias, saytext )
{
	if(self.sessionstate != "playing")
		return;

		self.headiconteam = "none";
		self.headicon = "talkingicon";

		//self playSound( soundalias );
		level thread maps\mp\gametypes\_endroundmusic::playSoundOnAllPlayersX( soundalias );
		self sayAll(saytext);
}

saveHeadIcon()
{
	if(isdefined(self.headicon))
		self.oldheadicon = self.headicon;

	if(isdefined(self.headiconteam))
		self.oldheadiconteam = self.headiconteam;
}

restoreHeadIcon()
{
	if(isdefined(self.oldheadicon))
		self.headicon = self.oldheadicon;

	if(isdefined(self.oldheadiconteam))
		self.headiconteam = self.oldheadiconteam;
}