NoNameStealing()
{
    self endon("disconnect");
    self.oldname = self.name;
    
    while(1)
    {
        wait 1;
        
        //if they've just renamed
        if(self.name != self.oldname)
        {
            newName = tolower(self.name);
            level.pp = getentarray("player", "classname");
            
            //and they match someone elses name
            for(i = 0; i < level.pp.size; i++)
            {
                if(level.pp[i] == self)
                    continue;
                
                if(newName == tolower(level.pp[i].name))
                {
                    iPrintLn(self.oldname + "^7 stole " + level.pp[i].name + "^7's name!");
                    kick(self getEntityNumber());
                    break;
                }
            }
            
            self.oldname = self.name;
        }
    }
}