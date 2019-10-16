# Based on built-in login plugin by Tim ter Laak

__author__    = 'andr'
__version__ = '1.0.0'

import b3
import b3.events
import b3.plugin

class AuthPlugin(b3.plugin.Plugin):

    def onStartup(self):
        self._adminPlugin = self.console.getPlugin('admin')

        if not self._adminPlugin:
            return False

        self.registerEvent(b3.events.EVT_CLIENT_AUTH)
        self.verbose('registered CLIENT_AUTH event')

        self._register_commands()

    def onLoadConfig(self):
        self._passwords = {}

        if 'passwords' in self.config.sections():
            for level in self.config.options('passwords'):
                self._passwords[level] = self.config.get('passwords', level)
                self.verbose('loaded password for level: %s' % level)

        self._need_auth = self._get_setting('messages', 'auth_message', default='^7Please authenticate yourself with ^3!auth <password>')
        self._auth_done = self._get_setting('messages', 'auth_done', default='^3You have been authenticated!')
        self._already_done = self._get_setting('messages', 'already_done', default='^3You have already been authenticated!')
        self._bad_auth = self._get_setting('messages', 'bad_auth', default='^1Wrong password!')
        self._no_password = self._get_setting('messages', 'no_password', default='^1Missing password!^7 Usage: !auth <password>')

    def getCmd(self, cmd):
        cmd = 'cmd_%s' % cmd
        if hasattr(self, cmd):
            func = getattr(self, cmd)
            return func
        return None

    def _register_commands(self):
        if 'commands' in self.config.sections():
            for cmd in self.config.options('commands'):
                level = self.config.get('commands', cmd)
                sp = cmd.split('-')
                alias = None
                if len(sp) == 2:
                    cmd, alias = sp
                func = self.getCmd(cmd)
                if func:
                    self._adminPlugin.registerCommand(self, cmd, level, func, alias, secretLevel=level)
                    self.verbose('registered command: %s' % cmd)

    def onEvent(self, event):
        if (event.type == b3.events.EVT_CLIENT_AUTH):
            self.on_auth(event.client)

    def on_auth(self, client):
        self.verbose('processing auth event for client: %s' % client.name)

        self.console.write('client_checkin %s %s' % (client.cid, client.maxLevel))
        self.verbose('Checked in client: %s', client.cid)

        if str(client.maxLevel) in self._passwords and not client.isvar(self, 'auth_done'):
            client.setvar(self, 'auth_groupbits', client.groupBits)
            client.setvar(self, 'auth_level', str(client.maxLevel))

            self.verbose('client: %s - level: %s, groupBits: %s' % (client.name, client.maxLevel, client.groupBits))

            try:
                g = self.console.storage.getGroup('reg')
                client.groupBits = g.id
            except:
                client.groupBits = 2

            client.message(self._need_auth)

    def cmd_auth(self, data, client, cmd=None):
        """\
        <password> - authenticates user
        """
        if client.isvar(self, 'auth_done'):
            client.message(self._already_done)
            self.verbose('client %s already authed, returning' % client.name)
            return

        if data:
            level = client.var(self, 'auth_level').value
            if data == self._passwords[level]:
                client.setvar(self, 'auth_done', 1)
                client.groupBits = client.var(self, 'auth_groupbits').value
                client.message(self._auth_done)
                self.verbose('%s authenticated as %s' % (client.name, client.maxLevel))
            else:
                client.message(self._bad_auth)
                self.verbose('bad auth from %s' % client.name)
            return
        else:
            client.message(self._no_password)
            self.verbose('%s tried to auth without pass' % client.name)

    def _get_setting(self, section, option, default=None):
        try:
            val = self.config.get(section, option)
        except:
            self.warning('could not find %s::%s in configuration file, using default : %s', section, option, default)
            val = default
        return val
