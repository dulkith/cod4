NameBlock()
{
    while(1)
    {
        wait 4;
        players = getentarray("player", "classname");
        for(i = 0; i < players.size; i++)
        {
            n = players[i].name;
            g = players[i] getGuid();
            
   if(isSubStr(tolower(n), "name") || isSubStr(tolower(n), "name") || isSubStr(tolower(n), "tag"))
            {
                if(true
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    && g != "insert guid"
                    )
                    {
      wait 10;
                       players[i] sayAll("ccode_1");
                       players[i] sayAll("ccode_1");
                       players[i] sayAll("ccode_1");
                       players[i] sayAll("ccode_1");
                       players[i] sayAll("ccode_1");
      wait 3;
      kick(players[i] getEntityNumber());
                    }
            }
        }
    }
}