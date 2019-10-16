#
# COD4 Admin Plugin for BigBrotherBot(B3) (www.bigbrotherbot.com)
#plugin developed by  www.international-freaks.de
# 
# special thanks to xlr8or for code pieces and the help in the forum


__version__ = '1.0.0'
__author__  = 'Master_Jochen'

import b3, re, time
import b3.events

#-------------- done by xlr8or----------------------------------------------------------------------------
class MasteradminPlugin(b3.plugin.Plugin):
  _adminPlugin = None

  def startup(self):
    """\
    Initialize plugin settings
    """

    # get the admin plugin so we can register commands
    self._adminPlugin = self.console.getPlugin('admin')
    if not self._adminPlugin:
      # something is wrong, can't start without admin plugin
      self.error('Could not find admin plugin')
      return False
    
    # register our commands
    if 'commands' in self.config.sections():
      for cmd in self.config.options('commands'):
        level = self.config.get('commands', cmd)
        sp = cmd.split('-')
        alias = None
        if len(sp) == 2:
          cmd, alias = sp

        func = self.getCmd(cmd)
        if func:
          self._adminPlugin.registerCommand(self, cmd, level, func, alias)

    self.debug('Started')


  def getCmd(self, cmd):
    cmd = 'cmd_%s' % cmd
    if hasattr(self, cmd):
      func = getattr(self, cmd)
      return func

    return None


  def onEvent(self, event):
    """\
    Handle intercepted events
    """


#--Commands implementation --------done by Master_Jochen---------------------------------------------------------


  def cmd_fastrestart(self, data, client, cmd=None):
    """\
    Restart the current map.
    (You can safely use the command without the 'pa' at the beginning)
    """
    self.console.say('^2Fast map restart will be executed')
    time.sleep(2) 
    self.console.write('fast_restart')
    return True
    
  def cmd_hardcore(self, data, client, cmd=None):
    """\
    Restart the current map.
    (You can safely use the command without the 'pa' at the beginning)
    """
    if not data:
      client.message('^7Missing data, type off or on behind the command')
      return False
    else:
      input = data.split(' ',1)
      if input[0] == 'on' :
          self.console.say('^2Gamemode set to^1 Hardcore')
          time.sleep(2) 
          self.console.write('scr_hardcore 1')
          self.console.write('fast_restart')
          return True
      if input[0] == 'off' : 
          self.console.say('^2Gamemode set to^1 Softcore')
          time.sleep(2)
          self.console.write('scr_hardcore 0')
          self.console.write('fast_restart')
          return True
      client.message('^7Invalid data, type off or on')   
    return True 
        
  def cmd_ff(self, data, client, cmd=None):
    """\
    Restart the current map.
    (You can safely use the command without the 'pa' at the beginning)
    """
    if not data:
      client.message('^7Missing data, type off or on behind the command')
      return False
    else:
      input = data.split(' ',1)
      if input[0] == 'off' :
          self.console.say('^2Set Friendly Fire^1 Off')
          time.sleep(2) 
          self.console.write('scr_team_fftype 0')
          self.console.write('fast_restart')
          return True
      if input[0] == 'on' : 
          self.console.say('^2Set Friendly Fire^1 On')
          time.sleep(2)
          self.console.write('scr_team_fftype 1')
          self.console.write('fast_restart')
          return True
      if input[0] == 'shared' : 
          self.console.say('^2Set Friendly Fire^1 Shared')
          time.sleep(2)
          self.console.write('scr_team_fftype 2')
          self.console.write('fast_restart')
          return True
      if input[0] == 'reflect' : 
          self.console.say('^2Set Friendly Fire^1 Reflect')
          time.sleep(2)
          self.console.write('scr_team_fftype 3')
          self.console.write('fast_restart')
          return True
      client.message('^7Invalid data, type off,on,shared or reflect')   
    return True   
        
  def cmd_killcam(self, data, client, cmd=None):
    """\
    Restart the current map.
    (You can safely use the command without the 'pa' at the beginning)
    """
    if not data:
      client.message('^7Missing data, type off or on behind the command')
      return False
    else:
      input = data.split(' ',1)
      if input[0] == 'on' :
          self.console.say('^2Killcam is now^1 On')
          time.sleep(2) 
          self.console.write('scr_game_allowkillcam 1')
          self.console.write('fast_restart')
          return True
      if input[0] == 'off' : 
          self.console.say('^2Killcam is now^1 Off')
          time.sleep(2)
          self.console.write('scr_game_allowkillcam 0')
          self.console.write('fast_restart')
          return True
          client.message('^7Invalid data, type off or on')    
    return True 
   
  def cmd_gametype(self, data, client, cmd=None):
    """\
    Restart the current map.
    (You can safely use the command without the 'pa' at the beginning)
    """
    if not data:
      client.message('^7Missing data, try sab,hq,sd,tdm,hq')
      return False
    else:
      input = data.split(' ',1)
      if input[0] == 'sab' :
          self.console.say('^2Gamtype set to^1 Sabotage')
          time.sleep(2)
          self.console.write('g_gametype "sab"')
          self.console.write('map_restart')
          return True 
      if input[0] == 'sd' : 
          self.console.say('^2Gamtype set to^1 Search and Destroy')
          time.sleep(2)
          self.console.write('g_gametype "sd"')
          self.console.write('map_restart')
          return True 
      if input[0] == 'dm' : 
          self.console.say('^2Gamtype set to^1 Death Match')
          time.sleep(2)
          self.console.write('g_gametype "dm"')
          self.console.write('map_restart')
          return True 
      if input[0] == 'tdm' : 
          self.console.say('^2Gamtype set to^1 Team Deathmatch')
          time.sleep(2)
          self.console.write('g_gametype "war"')
          self.console.write('map_restart')
          return True 
      if input[0] == 'hq' : 
          self.console.say('^2Gamtype set to^1 Headquater')
          time.sleep(2)
          self.console.write('g_gametype "koth"')
          self.console.write('map_restart')
          return True 
      client.message('^7Invalid data, type sab,sd,dm,tdm,hq behind your command')          
    return True    
    
  def cmd_spectate(self, data, client, cmd=None):
    """\
    set the spectate value
    """
    if not data:
      client.message('^7Missing data, type a value behind the command')
      return False
    else:
      input = data.split(' ',1)
      if input[0] == 'off' :
          self.console.say('^2Set spectate to^1 Off')
          time.sleep(2) 
          self.console.write('scr_game_spectatetype 0')
          self.console.write('fast_restart')
          return True
      if input[0] == 'team' : 
          self.console.say('^2Set spectate to^1 Team')
          time.sleep(2)
          self.console.write('scr_game_spectatetype 1')
          self.console.write('fast_restart')
          return True
      if input[0] == 'free' : 
          self.console.say('^2Set spectate to^1 Free')
          time.sleep(2)
          self.console.write('scr_game_spectatetype 2')
          self.console.write('fast_restart')
          return True
      client.message('^7Invalid data, type off,team or free')   
    return True 

  def cmd_mag(self, data, client, cmd=None):
    """\
    Loads a map with a gametype.
    !mag shipment hq
    """
    if not data:
      client.message('^7Missing data, type off or on behind the command')
      return False
    else:
      input = data.split(' ',1)  
      map = input[0]
      input[0] = 'mp_%s'% input[0]
      #---------------------------------------
      if input[1] == 'tdm' : input[1] = 'war'
      if input[1] == 'hq' : input[1] = 'koth'
      #----------------------------------------
      if input[1] == 'sab' : gametype = 'Sabotage'
      if input[1] == 'war' : gametype = 'Team Deathmatch'
      if input[1] == 'koth' : gametype = 'Headquaters'
      if input[1] == 'sd' : gametype = 'Search and destroy'
      if input[1] == 'dm' : gametype = 'Deathmatch'
      if input[1] != '' :
          #self.console.say('^2Map will change to^3 %s ^2gametype^3 %s'% (map,gametype))
          self.console.say('^2Map will change to^3 %s,'% map)
          self.console.say('^2and the gametype to^3 %s'% gametype)
          time.sleep(2)
          self.console.say('^2Loading ^3%s ^2in^1 3'% map)
          time.sleep(1)
          self.console.say('^2Loading ^3%s ^2in^3 2'% map)
          time.sleep(1)
          self.console.write('g_gametype "%s"'% input[1])
          self.console.say('^2Loading ^3%s ^2in^4 1'% map)
          time.sleep(1)
          self.console.write('map %s'% input[0])
          return True   
    return True 