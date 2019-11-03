init()
{
        while(1)
        {
                level waittill( "connected", player );
                player thread ShowKDRatio();
        }
}

ShowKDRatio()
{
        self notify( "new_KDRRatio" );
        self endon( "new_KDRRatio" );
        self endon( "disconnect" );
level endon("game_ended");
        level endon ("vote started");
        wait 1;
        if( IsDefined( self.mc_kdratio ) )      self.mc_kdratio Destroy();
     
        self.mc_kdratio = NewClientHudElem(self);
        self.mc_kdratio.x = 111;
        self.mc_kdratio.y = 39;
        self.mc_kdratio.horzAlign = "left";
        self.mc_kdratio.alignX = "left";
        self.mc_kdratio.fontScale = 1.4;
        self.mc_kdratio.hidewheninmenu = true;
        self.mc_kdratio.label = &"^2K/D Ratio: ^1";
        self.mc_kdratio FadeOverTime(.5);
        self.mc_kdratio.alpha = 1;
        self.mc_kdratio.glowAlpha = 1;
        self.mc_kdratio.glowColor = (0.3, 0.3, 0.3);
     
        for(;;)
        {
                ratio = 0;   
                k = self.pers[ "kills" ];
                d = self.pers[ "deaths" ];
                if( IsDefined( k ) && IsDefined( d ) )
                {
                        if( d < 1 )
                                d = 1;

                        if( k < 1 )
                                self.mc_kdratio setText("^1-");

                        if( k > 0 )
                        {
                                ratio1 = k / d * 100;
                                ratio2 = int( ratio1 );
                                ratio = ratio2 / 100;
                                red = 0;
                                green = 0;
                                if(ratio <= 1)
                                {
                                        green = ratio / 2;
                                        red = 1;
                                }
                                if(ratio >= 1)
                                {
                                        red = 1.7 - ratio;
                                        green = 1;
                                }
                                if(ratio == 1)
                                {
                                        green = ratio;
                                        red = 1;
                                }     
                                if(green >= 1)
                                        green = 1;
                                if(green <= 0 )
                                        green = 0;           
                                if( red <= 0 )
                                        red = 0;
                                if( red >= 1 )
                                        red = 1;                                     
                                self.mc_kdratio FadeOverTime(1);
                                self.mc_kdratio.color = ( red , green , 0);
                                self.mc_kdratio setValue(ratio);
                        }
                }
                wait .05;
                while(k == self.pers[ "kills" ] && d == self.pers[ "deaths" ] || self.pers[ "kills" ] == 0 )
                        wait .05;
        }
}
