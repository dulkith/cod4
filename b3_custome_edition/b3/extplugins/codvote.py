# CoDVote plugin for BigBrotherBot(B3) (www.bigbrotherbot.net)
# Copyright (C) 2015 ph03n1x
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
#
# Changelog:
# v1.0.1 - Fixed vote remaining in progress if requirements for vote unmet.
# v1.0.2 - Added  "!vote maps" to show what maps can be called into vote.
#        - Fixed issue where person who called vote needed to vote as well. Changed to automatic yes vote.

__version__ = '1.0.2'
__author__ = 'ph03n1x'

import b3, threading
import b3.plugin
import b3.events


class CodvotePlugin(b3.plugin.Plugin):
    adminPlugin = None
    _vote = None  # Stores which vote is currently in progress
    _value = None  # Stores the value of the vote
    _votetime = 30  # Time before a vote will be canceled for not passing
    _aVotes = {}  # All votes allowed. Imported from "votes" section in config
    _aMaps = {}  # All vote allowed maps. Imported from "votemaps" section in config
    _amt_yes = []  # Amount of players who voted yes. Checked against amount of players in game
    _amt_no = []
    _allplayers = []  # Amount of players in game
    _mapRequested = None # Stores which map is being voted for
    _kickRequested = None  # Stores which player will be kicked if vote passed
    _default_messages = {
        'tovote': '^7Use ^2!yes ^7or ^2!no ^7 to vote',
        'map': "Map vote in progress: Change map to ^3$s^7?",
        'nextmap': "Next map vote in progress. Change next map to ^3$s^7?",
        'kick': "Kick vote in progress: Kick ^2$s^7?",
        'maprotate': "Rotate map vote in progress. Go to next map?",
        'maprestart': "Maprestart vote in progress. Restart current map?",
        'friendlyfire': "Friendlyfire vote in progress. Change friendlyfire mode to ^2$s^7?",
        'killcam': "Killcam vote in progress. Turn killcam ^2$s^7?",
        'scorelimit': "Scorelimit vote in progress. Change score limit to ^2$s^7?",
        'timelimit': "Timelimit vote in progress. Change time limit to ^2$s^7?",
        'roundlength': "Round length vote in progress. Change round length to ^2$s^7?",
        'roundlimit': "Round limit vote in progress. Change round limit to ^2$s^7?",
        }

    def onStartup(self):
        self.adminPlugin = self.console.getPlugin('admin')

        if not self.adminPlugin:
            self.error('Could not find admin plugin')
            return

        # Register commands
        if 'commands' in self.config.sections():
            for cmd in self.config.options('commands'):
                level = self.config.get('commands', cmd)
                sp = cmd.split('-')
                alias = None
                if len(sp) == 2:
                    cmd, alias = sp

                func = self.getCmd(cmd)
                if func:
                    self.adminPlugin.registerCommand(self, cmd, level, func, alias)

        # Re-deploy commands for consideration of this plugin
        self.adminPlugin.registerCommand(self, 'nextmap', 1, self.cmd_nextmap, 'nm')
        self.adminPlugin.registerCommand(self, 'maprotate', 20, self.cmd_maprotate, None)
        self.adminPlugin.registerCommand(self, 'allvotes', 1, self.cmd_allvotes, None)

        # Register events
        self.registerEvent('EVT_GAME_EXIT', self.onGameEnd)

    def onLoadConfig(self):
        # Load settings section
        try:
            self._votetime = self.config.getint('settings', 'votetime')
        except:
            self.debug('Unable to get [votetime] from settings. Using default: %s' % self._votetime)

        # Load votemaps section
        if self.config.has_section('votemaps'):
            for (mapname, consolename) in self.config.items('votemaps'):
                if mapname:
                    self._aMaps[mapname] = consolename
            self.debug('Successfully entered maps for voting: %s' % self._aMaps)

        # Load votes section
        if self.config.has_section('votes'):
            adLvl = {'guest': 0,
                     'user': 1,
                     'reg': 2,
                     'mod': 20,
                     'admin': 40,
                     'fulladmin': 60,
                     'senioradmin': 80,
                     'superadmin': 100}
            for (entry, value) in self.config.items('votes'):
                try:
                    value = int(value)
                    self._aVotes[entry.lower()] = value
                except ValueError:
                    self._aVotes[entry.lower()] = adLvl[value]
            self.debug('Allowed votes are: %s' % self._aVotes)

    def getCmd(self, cmd):
        cmd = 'cmd_%s' % cmd
        if hasattr(self, cmd):
            func = getattr(self, cmd)
            return func

        return None

    ######################### VOTE TIMING ##############################
    def voteTimer(self):
        t1 = threading.Timer((self._votetime - 5), self.voteMessage)
        t1.start()

    def voteMessage(self):
        if self._vote:
            self.console.say('^110 seconds until vote end!')
            t2 = threading.Timer(10, self.denyVote)
            t2.start()

    ######################### MAP HANDLING ##############################
    def _search(self, maplist, partial):
        a = []
        for mapname, consolename in maplist.iteritems():
            if partial in mapname:
                a.append(mapname)
            elif partial in consolename:
                a.append(mapname)
        return a

    def mapvote(self, client, wantedMap):
        # Find if map is in allowed list
        match = self._search(self._aMaps, wantedMap)
        if len(match) == 1:
            self._mapRequested = match[0]
            self._value = match[0]
            return True
        elif len(match) > 1:
            match = (', ').join(match)
            client.message('^1ABORTED!^7Multiple matches: %s' % match)
            return False
        elif len(match) == 0:
            client.message('^1ABORTED!^7No maps matching your request')
            return False

    ############### NEXTMAP FUNCTIONING ################
    def onGameEnd(self, event):
        """
        Handle EVT_GAME_ROUND_END
        """
        if self._mapRequested:
            self.confirmMap()
            self._mapRequested = None

    ############### CONFIRM VOTES ######################
    def confirmVote(self):
        self.console.say('^3Vote passed!^7')
        if self._vote == 'map':
            self.confirmMap()
        elif self._vote == 'nextmap':
            self.debug('nextmap vote passed. Params already stored')
        elif self._vote == 'kick':
            self.confirmKick()
        elif self._vote == 'maprotate':
            if self._mapRequested:
                self.confirmMap()
            else:
                self.console.rotateMap()
        elif self._vote == 'maprestart':
            self.confirmMaprestart()
        elif self._vote == 'friendlyfire':
            self.confirmFriendlyFire()
        elif self._vote == 'killcam':
            self.confirmKillCam()
        elif self._vote == 'scorelimit':
            self.confirmScoreLimit()
        elif self._vote == 'timelimit':
            self.confirmTimeLimit()
        elif self._vote == 'roundlength':
            self.confirmRoundLength()
        elif self._vote == 'roundlimit':
            self.confirmRoundLimit()
        else:
            self.error('Unable to commit. Vote: %s, Value: %s'  % (self._vote, self._value))
        self._vote = None
        self._value = None
        self._amt_no = []
        self._amt_yes = []
        self._allplayers = []

    def denyVote(self):
        if self._vote:
            self.console.say('^3Vote failed!')
            self._vote = None
            self._value = None
            self._amt_no = []
            self._amt_yes = []
            self._allplayers = []

    def confirmKick(self):
        # Note - to kick someone we need: client.kick(reason, keyword, admin, silent=True/False, data)
        s = self._kickRequested
        self.debug('Kick vote passed. Kicking %s' % s.name)
        s.kick('Voted against', '', None, True, '')
        self._kickRequested = None

    def confirmMap(self):
        # This will cycle to next map when needed.
        self.console.write('map %s' % self._aMaps[self._mapRequested])
        self._mapRequested = None

    def confirmMaprestart(self):
        # This will restart the current map
        self.console.write('fast_restart')

    def confirmFriendlyFire(self):
        # This will toggle friendly fire on and off
        setting = self._value
        if not isinstance(setting, int):
            if self._value == 'on':
                setting = 1
            elif self._value == 'off':
                setting = 0
            else:
                self.debug('Unknown wanted setting for Friendlyfire. Toggling to next mode')
                now = self.console.getCvar('scr_team_fftype').getInt()
                if now >= 1:
                    setting = 0
                elif now == 0:
                    setting = 1
        self.console.setCvar('scr_team_fftype', int(setting))

    def confirmKillCam(self):
        # rcon for killcam: scr_game_allowkillcam - 0 or 1
        setting = self._value
        if self._value == 'on':
                setting = 1
        elif self._value == 'off':
                setting = 0

        if not isinstance(setting, int):
            try:
                setting = int(setting)
            except ValueError:
                now = self.console.getCvar('scr_game_allowkillcam').getInt()
                self.debug('Setting being voted for is not valid. Toggling to next mode. Killcam currently: %s' % now)
                if now == 0:
                    setting = 1
                else:
                    setting = 0

        self.console.setCvar('scr_game_allowkillcam', int(setting))

    def confirmScoreLimit(self):
        # CVAR to write is scr_<gametype>_scorelimit <number>
        setting = self._value
        gt = self.getGameType()
        if not isinstance(setting, int):
            try:
                setting = int(setting)
            except ValueError:
                self.debug('ERROR: Could not set new scorelimit. Voted value is not integer')
                return

        cparams = 'scr_' + gt + '_scorelimit'
        self.console.setCvar(cparams, setting)

    def confirmTimeLimit(self):
        setting = self._value
        gt = self.getGameType()
        if not isinstance(setting, int):
            try:
                setting = int(setting)
            except ValueError:
                self.debug('ERROR: Could not set new timelimit. Voted value is not integer')
                return

        cparams = 'scr_' + gt + '_timelimit'
        self.console.setCvar(cparams, setting)

    def confirmRoundLength(self):
        setting = self._value
        amodes = ['ctf', 'sd', 're', 'bas', 'dom']
        gt = self.getGameType()
        if not isinstance(setting, int):
            try:
                setting = int(setting)
            except ValueError:
                self.debug('ERROR: Could not set new round length. Voted value is not integer')
                return

        if gt in amodes:
            cparams = 'scr_' + gt + '_roundlength'
            self.console.setCvar(cparams, setting)

    def confirmRoundLimit(self):
        setting = self._value
        amodes = ['ctf', 'sd', 're', 'bas', 'dom']
        gt = self.getGameType()
        if not isinstance(setting, int):
            try:
                setting = int(setting)
            except ValueError:
                self.debug('Could not set new round limit. Voted value is not integer')
                return

        if gt in amodes:
            cparams = 'scr_' + gt + '_roundlimit'
            self.console.setCvar(cparams, setting)
        else:
            self.debug('Could not set round limit as gametype do not have rounds')

    def getGameType(self):
        gametype = self.console.getCvar('g_gametype').getString()
        if gametype:
            return gametype
        else:
            self.debug('Error getting gametype. Response is %s' % gametype)
            return False

    def sendBroadcast(self):
        # This wil broadcast vote message to server.
        a = self._value
        if a == 'maprestart' or a == 'maprotate':
            self.console.say(self.getMessage(self._vote))
        elif a != 'maprestart' and a != 'maprotate':
            param = {'s': a}
            self.console.say(self.getMessage(self._vote, param))
        self.console.say(self.getMessage('tovote'))

    def aquireCmdLock2(self, cmd, client, delay, all=True):
        if client.maxLevel >= 20:
            return True
        elif cmd.time + 5 <= self.console.time():
            return True
        else:
            return False

    def checkIfAllowed(self, client, voteType):
        if client.maxLevel >= self._aVotes[voteType]:
            return True
        else:
            return False

    #################################################################################
    #                       COMMANDS                                                #
    #################################################################################
    def cmd_vote(self, data, client, cmd=None):
        """\
        !vote <setting> <value> - vote to change setting or cvar on server.
        """
        # Check if vote already in progress
        if self._vote:
            client.message('^1ERROR^7: Vote already in progress')
            return

        # Check if we have enough data for vote
        data = data.split()
        if len(data) == 1 and data[0] == 'maprotate' or len(data) == 1 and data[0] == 'maprestart' or len(data) == 1 and data[0] == 'maps':
            self._vote = data[0]
            self._value = data[0]
        elif len(data) == 2:
            type = data[0]
            value = data[1]
            self._vote = type
            self._value = value
        else:
            client.message('^1ERROR^7: Invalid usage. Type ^2!help vote ^7for info')
            return

        # Check if player is asking what maps can be voted on
        if self._vote == 'maps':
            v1 = self.checkIfAllowed(client, 'map')
            v2 = self.checkIfAllowed(client, 'nextmap')
            if v1 or v2:
                cmd.sayLoudOrPM(client, 'Vote enabled maps: ^2%s' % (('^7, ^2').join(self._aMaps.keys())))
                self._vote = None
                self._value = None
                return
            else:
                client.message('^2You do not have permission to call map votes')
                self._vote = None
                self._value = None
                return

        # Check if enough players in game to vote and store present players. Only players present at vote call can vote
        playersInGame = 0
        self._allplayers = []
        for c in self.console.clients.getList():
            if c.team != b3.TEAM_SPEC:
                playersInGame += 1
                self._allplayers.insert(0, c)
        if playersInGame <= 1 and client.maxLevel < 100:
            client.message('^1ABORT^7: Not enough players in game to vote.')
            self._vote = None
            return

        # Check if type of vote is allowed
        if self._vote not in self._aVotes:
            client.message('Vote type not allowed. Use ^2!allvotes ^7for available votes.')
            self._vote = None
            return

        # Check if player has permission to call vote type
        v = self.checkIfAllowed(client, self._vote)
        if not v:
            client.message('You do not have permission to call this vote')
            self._vote = None
            return

        # Get further info for proper processing
        if self._vote == 'map' or self._vote == 'nextmap':
            q = self.mapvote(client, self._value)
            if not q:
                self.debug('Vote aborted: Cannot vote for maps. mapvote turned out false')
                self._vote = None
                return

        if self._vote == 'kick':
            self._kickRequested = self.adminPlugin.findClientPrompt(self._value, client)
            if self._kickRequested:
                if self._kickRequested.maxLevel >= 20:
                    client.message('^1ABORTED^7: Cannot vote to kick admin!')
                    self._vote = None
                    self._value = None
                    self._kickRequested = None
                    return
                self._value = self._kickRequested.name
            else:
                self.debug('could not get the person to kick')
                self._vote = None
                self._value = None
                self._kickRequested = None
                return


        # Seems like vote is ok. Broadcast to server
        self.sendBroadcast()

        # Start timer
        self.voteTimer()

        # Set person who called vote as yes vote
        self._amt_yes.insert(0, client)
        if len(self._amt_yes) > (len(self._allplayers) / 2):
            self.confirmVote()


    def cmd_allvotes(self, data, client, cmd=None):
        """\
        Show all the votes you are allowed to call
        """
        allowed = []
        for k in self._aVotes.keys():
            if client.maxLevel >= self._aVotes[k]:
                allowed.insert(0, k)

        if len(allowed) > 0:
            p = sorted(allowed)
            x = (', ').join(p)
            client.message('Allowed votes are: %s' % x)
        elif len(allowed) == 0:
            client.message('You are not allowed to call any votes')

    def cmd_yes(self, data, client, cmd=None):
        """\
        Vote yes to the vote in progress
        """
        # Check if there is a vote in progress
        if not self._vote:
            client.message('No vote in progress')
            return

        # Check if player is allowed to vote
        if client not in self._allplayers:
            client.message('Sorry, you cannot enter current vote')
            return

        # Check if the player already voted. If not, register vote
        if client in self._amt_yes or client in self._amt_no:
            client.message('Are you drunk? You already voted!')
            return
        elif client not in self._amt_yes or client not in self._amt_no:
            self._amt_yes.insert(0, client)

        # Let player know that vote is registered
        client.message('^3Your vote has been entered')

        # Check if majority of players voted already
        vYes = len(self._amt_yes)
        vPass = len(self._allplayers) / 2
        if vYes > vPass:
            self.confirmVote()

    def cmd_no(self, data, client=None, cmd=None):
        """\
        Vote NO to the current vote
        """
        # Check if there is a vote in progress
        if not self._vote:
            client.message('No vote in progress')
            return

        # Check if player is allowed to vote
        if client not in self._allplayers:
            client.message('Sorry, you cannot enter current vote')
            return

        # Check if the player already voted
        if client in self._amt_yes or client in self._amt_no:
            client.message('Are you drunk? You already voted!')
            return
        elif client not in self._amt_yes or client not in self._amt_no:
            self._amt_no.insert(0, client)

        # Let player know that vote is registered
        client.message('^3Your vote has been entered')

        # Check if majority of players voted
        vNo = len(self._amt_no)
        vPass = len(self._allplayers) / 2
        if vNo > vPass:
            self.denyVote()

    def cmd_nextmap(self, data, client=None, cmd=None):
        """\
        - list the next map in rotation
        """
        if not self.aquireCmdLock2(cmd, client, 60, True):
            client.message('^7Do not spam commands')
            return

        if self._mapRequested:
            cmd.sayLoudOrPM(client, '^7Next Map: ^2%s' % self._mapRequested.title())
            return

        mapname = self.console.getNextMap()
        if mapname:
            cmd.sayLoudOrPM(client, '^7Next Map: ^2%s' % mapname)
        else:
            client.message('^1Error:^7 could not get map list')

    def cmd_maprotate(self, data, client, cmd=None):
        """\
        Cycle to next map in rotation
        """
        if self._mapRequested:
            self.confirmMap()
        else:
            self.console.rotateMap()

    def cmd_veto(self, data, client, cmd=None):
        """\
        Cancel a vote in progress
        """
        if self._vote:
            client.message('^3Vote canceled')
            self.denyVote()
        elif not self._vote:
            client.message('^3No vote in progress')
