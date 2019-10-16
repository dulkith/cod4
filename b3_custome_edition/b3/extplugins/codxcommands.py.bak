import b3
import b3.events

__author__    = 'andr and norma'
__version__ = '1.0'

class CodxcommandsPlugin(b3.plugin.Plugin):
  _adminPlugin = None

  def startup(self):
    self.debug('Starting Chatter plugin')

    self._adminPlugin = self.console.getPlugin('admin')
    if not self._adminPlugin:
      self.error("Couldn't get admin plugin")
      return False

    self._registerCommands()
    
  def onLoadConfig(self):
      """\
      Initialize plugin settings
      """
      return True    

  def getCmd(self, cmd):
      cmd = 'cmd_%s' % cmd
      if hasattr(self, cmd):
          func = getattr(self, cmd)
          return func
      return None

  def _registerCommands(self):
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

  def cmd_say(self, data, client, cmd=None):
    """
    <text> - say <text> to the server.
    """
    if not data:
      client.message('^7Missing text, please provide something to say!')
      return False
    else:
      self.console.say(data)
      
  def cmd_tell(self, data, client, cmd=None):
    """
    <text> - pm <text> to specified client. Can give client number or name/partial name.
    """
    if not data:
      client.message('^7Missing text, give player name or number!')
      return False
    else:
        target = self._adminPlugin.findClientPrompt(data, client)  
        if target:
          target.message(data)

  def cmd_set(self, data, client, cmd=None):
    """
    <text> - set <command> to particular value, warning, this essentially gives full rcon access.
    """
    if not data:
      client.message('^7Missing data, usage: <variable> <value>')
      return False
    elif data == 'quit':
      client.message('^7You cannot use this command to kill the server, sorry :)')
    else:
      self.console.write(data)

  def cmd_map_rotate(self, data, client, cmd=None):
    """
    rotate the map
    """
    if not data:
      client.message('^7Missing data, usage: <variable> <value>')
      return False
    else:  
      self.console.write('map_rotate')

  def cmd_loadplugin(self, data, client, cmd=None):
    """
    load the plugin with name <plugin_name>
    """
    if not data:
      client.message('^7Missing data, usage: loadplugin <plugin name>')
      return False
    else:      
      self.console.write('loadplugin %s' % data)
      client.message('plugin %s has been loaded' % data)

  def cmd_unloadplugin(self, data, client, cmd=None):
    """
    unload the plugin with name <plugin_name>
    """
    if not data:
      client.message('^7Missing data, usage: unloadplugin <plugin name>')
      return False
    else:  
      self.console.write('unloadplugin %s' % data)
      client.message('plugin %s has been unloaded' % data)    
          
  def cmd_ss(self, data, client, cmd=None):
    """
    <client> - name or partial name of the player. Alternatively you can use 'all' to take
    screenshot of all players.
    """
    if not data:
      client.message('^7Missing data, usage: getss <player name>')
    elif data.lower() == 'all':
      client.message('Taking screenshots of all players.')
      self.console.write('getss all')
    else:
      target = self._adminPlugin.findClientPrompt(data, client)
      if not target:
        return
      else:
        self.console.write('getss %s' % data)
        client.message('Screenshot of %s will be taken soon.' % target.exactName)

  def cmd_record(self, data, client, cmd=None):
    """
    <client> - name or partial name of the player. 
    """
    if not data:
      client.message('^7Missing data, usage: record <player name> <demo name>')
      return False
    else:
      target = self._adminPlugin.findClientPrompt(data, client)
      if not target:
        return
      else:
        self.console.write('record %s %s' % (target.cid, target.exactName))
        client.message('Taking demo of %s' % target.exactName) 
        
  def cmd_stoprecord(self, data, client, cmd=None):
    """
    <client> - name or partial name of the player. 
    """
    if not data:
      client.message('^7Missing data, usage: record <player name> <demo name>')
      return False
    else:
      target = self._adminPlugin.findClientPrompt(data, client)
      if not target:
        return
      else:
        self.console.write('record %s %s' % (target.cid, target.exactName))
        client.message('Stopping demo of %s' % target.exactName)

  def cmd_undercover(self, data, client, cmd=None):
    """
    sets client to undercover mode. 
    """
    self.console.write('undercover %s 1' % client.cid)
    client.message('You are undercover!')

  def cmd_advert(self, data, client, cmd=None):
    """
    <text> - set <text> advert to server (top hud)
    """
    if not data:
      client.message('^7Missing data, usage: advert <text>')
      return False
    else:
      self.console.write('addadvertMessage %s' % data)
      client.message('Advert [%s] added to server!' % data)

  def cmd_deladvert(self, data, client, cmd=None):
    """
    Deletes any advert messages added.
    """
    self.console.write('clearallmsg')
    client.message('Server ads deleted!')