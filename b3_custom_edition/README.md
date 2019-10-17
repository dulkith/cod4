# COD4-LK [B3] Customized Edition.

![](https://github.com/dulkith/cod4/blob/master/images/bigbrotherbot-logo.png?raw=true)
## What is B3?​

Big Brother Bot (B3) is a complete and total server administration package for online games. It is the prefered ingame RCON Tool currently available.

B3 is designed primarily to keep your server free from the derelicts of online gaming, but offers more, much more. With the stock configuration files, B3 will keep your server free from offensive language, and team killers alike. A completely automated and customizable warning system will warn the offending players that this type of behavior is not allowed on your server, and ultimately kick, and or ban them for a predetermined time limit.

Source: http://www.bigbrotherbot.net)

### Features

- This customized edition based on B3 v1.12 Iron Pigeon (Latest relese), because this include all the new features of latest edition.
- This edition support for COD4x (Call 4 of Duty 4 multiplayer) and our mod.

- **Introduce new commands.**
iamsles - When first run use this to get Super admin permission 
!sles - say b3 version info
English and Sinhala fun commands. 
!ss <player_name> - take screenshot of player.
!ssall  - take screenshot of all players.
!xlr - XLR stats of player
!id - Player ID
!xlrreset <player_ID> - reset xlrstats data
!fr - Fasr restart map
!map_rotate - Change map to next
!bal or !balance - Auto team balance in TDM and SND
!fov - Field Of View
!fps - Fullbright
!say <message> - Public message
!tell <message> <player_name> - Personal message
!menu - Open game menu
!music - mute/un-mute killcam music
!kmusic - mute/un-mute knife round music
!km - kick your-self
!cmd - for admin to play with
!cookie - give a cookie to a player
!sry - say you are sorry to your last victim
!ns - say 'Nice shot' to your killer
!emblem - Change Emblem Text
!laser - Enble Laser Force
!rpd - Get weapon rpd
!aku - Get weapon aku
!ak - Get weapon ak47
!r700 - Get weapon r700
!knife - Get weapon knife
!deagle - Get weapon deagle
!akimbo - Get weapon akimbo
!pack - Get weapon pack
!returnbomb - return the bomb
!dropBomb - Drop the bomb
!givebomb - Give Bomb To Player
!save - Save Position
!load - Load Position
!advban - Ban Player With Cfg Killer
!vip - Get Or Give Vip
!wtf - Blow up Player
!flash - Flash Player
!spawn - ReSpawn
!bounce - Bounce player
!tphere - teleport player to you
!jetpack - Get JetPack
!jump - Enable Hight Jump All Players
!jumpoff - Disable Hight Jump All Players
!party - Enable Party Mode
!rob - Take all weapons
!ammo - Unlimited Ammo
!print - say a message to all players in bold
!bold - say a message to all players in bottom left
!reset - logout to default (for menu)
!master - login to master (for menu)
!senior - login to master (for senior admin)
!admin - login (for menu)
!fulladmin - login to fulladmin (for menu)
!mod - login (for menu)
!member - login to member (for menu)
!srvlist - Rs servers
!menu - open menu
### Ubuntu Setup

***First Install following.***

`sudo apt-get install apache2`

`sudo apt-get install php5`

`sudo apt-get install mysql-server mysql-client`

`sudo apt-get install python-pip`

`sudo apt-get install phpmyadmin`

 
***Edit the Apache config file.***

`sudo nano /etc/apache2/apache2.conf`


***And add this line someware in the config file at the bottom.***

`Include /etc/phpmyadmin/apache.conf`


***And finally restart Apache.***

`/etc/init.d/apache2 restart`


**Upload the b3.sql file to the phpmyadmin database.** 
[b3.sql](https://github.com/dulkith/cod4/blob/master/b3_custom_edition/b3/sql/mysql/b3.sql "b3.sql")

### *Next is Installing b3. First download this folder and  upload it into linux vps*
[DOWNLOAD : COD4-LK [B3] Customized Edition ](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/dulkith/cod4/tree/master/b3_custom_edition "DOWNLOAD ")
**Use this link to download** 

***Then you got to install the pip packagers which is mention in the required text. ***

`sudo apt-get install python-pip`

`pip install pymysql>=0.6.6`

`pip install python-dateutil>=2.4.1`

`pip install feedparser>=4.1`

`pip install requests>=2.6.0`


***open this file***

` /b3/conf/b3.xml`

***Apply your values to below parameters***

- **database** - mysql://YOUR_MYSQL_USER_NAME:YOUR_MYSQL_PASSWORD@YOUR_MYSQL_SERVER_IP:3306/YOUR_DATABASE_NAME
- **rcon_password** - YOUR_RCON_PASSWORD
- **port** - 28960
- **game_log** - /YOUR_GAME_MOD_PATH/promod_mp.log
- **public_ip** - YOUR_VPS_IP
- **rcon_ip** - YOUR_VPS_IP
- **screenshot_website_link** - www.clan-website.com/ss

### (*Note that b3 was designed to run on Python 2.7.6)
***Check Version by using***

`python -V`


*To test run*

`python b3_run.py`


***To Keep it running on screen  use the following bash script
install the screen***

`apt-get install screen`


#### Startup Server B3

*****Change file permission***

`chmod 777 start.sh`


***To start server on screen***

`./start.sh`


# Contact me for any errors :)
