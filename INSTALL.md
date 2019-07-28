# todo

- merge vscodium and textadept


# install

_These are some notes on how to install the author's system. These aren't expected to be useful to anyone else._

- Install Debian's minimal version ([the one that includes non-free firmware](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/), if necessary)
- Select nothing at the software selection menu
- Partition:
    - A ~12gb ext4 partition for /
    - A swap partition; 1.5 * RAM (for hibernation)
    - An ext4 partition for ~, using the remaining space


## logging

[enable persistent logging](https://unix.stackexchange.com/a/159390):

```
mkdir /var/log/journal
systemd-tmpfiles --create --prefix /var/log/journal
systemctl restart systemd-journald
```


## network

To get the network working add whatever's relevant from the following to `/etc/network/interfaces`:

```
# enable internal wifi
auto [device name from `ip link`]
   # enable this if it's external:
   # allow-hotplug [device name]

   iface [device name] inet dhcp

      # don't include these two if it's usb tethering:
      wpa-ssid {{ WIFI_NAME }}
      wpa-psk {{ WIFI_PASSWORD }}
```

Then use `service networking restart`, run `apt install network-manager`, remove what was added above, restart networking again, then use `nmtui` to re-enable the network.

If `nmtui` doesn't work, edit `/etc/NetworkManager/NetworkManager.conf` and make sure `[ifupdown] managed=true`, then restart network-manager.


## update

```
su
apt update
apt upgrade
```


## sudo

```
apt install sudo
adduser [user] sudo
```


## login

```
su - [user]
```


## clone

```
cd ~
sudo apt install git
git clone git@github.com:bedax/system.git
```


## .profile

```
. ~/system/home/.profile
```


## mkdirs

```
mkdir -p ~/.local/src
mkdir -p ~/.local/bin
mkdir -p ~/.local/opt
mkdir ~/temp
cd ~/temp
```


## apt

```
sudo apt install [name]
```

### package manager stuff
gdebi
apt-file

### build tools
build-essential
pkg-config
automake
cmake

### python and its package manager
python
python-pip
python3
python3-pip

### command line utilities
cloc
coreutils
curl
fd-find
ffmpeg
flake8
git
htop
inxi
less
links2
miniupnpc
nano
ncdu
netcat-openbsd
net-tools
openssh-client
pandoc
ripgrep
rsync
shellcheck
sqlite3
tree
unzip
wget
xz-utils
youtube-dl
zip

### graphical applications
audacity
chromium
filezilla
firefox-esr
gimp
gimp-help-en
gnome-boxes
gnome-orca
gparted
gucharmap
hexchat
inkscape
keepassx
meld
mousepad
openmw
pavucontrol
picard
sigil
sqlitebrowser
transmission
viewnior
vlc

### quodlibet
quodlibet
gstreamer1.0-plugins-bad

### thunar
thunar
thunar-volman
thunar-gtkhash
thunar-media-tags-plugin
thunar-archive-plugin
gvfs-backends
policykit-1-gnome
xarchiver
p7zip-full

### window manager stuff
xinit
x11-utils
bspwm
sxhkd
dunst

### appearance
adwaita-icon-theme
adwaita-qt
adwaita-qt4 - as it's not in buster, install it and adwaita-qt-data from stretch with gdebi
qt4-qtconfig
gnome-themes-standard
ttf-mscorefonts-installer

### for the local scripts
alsa-utils
jshon
maim
pm-utils
pulseaudio-utils
xclip
xdotool

### for the startup script
compton
hsetroot
redshift
x11-xserver-utils
xbacklight
xinput

### for st and dmenu
libx11-dev
libxinerama-dev
libxft-dev

### other
pulseaudio
fontconfig
cron


## fish

```
sudo apt install fish

curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

fish -c "fisher add fischerling/plugin-wd"
fish -c "fisher add oh-my-fish/plugin-pbcopy"
# fish -c "fisher add externl/fish-symnav"
```


## rust

```
curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y
rustup install nightly

rustup component add clippy rustfmt

sudo apt install musl-tools
rustup target add x86_64-unknown-linux-musl

sudo apt install rust-lldb valgrind

cargo install cargo-bloat
cargo install cargo-fuzz
cargo install cargo-profiler
cargo install cargo-watch
cargo install evcxr_repl
cargo +nightly install cargo-expand

sudo apt install libssl-dev
cargo install cargo-audit

sudo apt install libssl-dev
cargo install cargo-deadlinks

sudo apt install libssl-dev
cargo install cargo-tree

sudo apt install libssl-dev zlib1g-dev
cargo install cargo-tarpaulin

sudo apt install libssl-dev libssh2-1-dev libgit2-dev
cargo install cargo-update

sudo apt install libssl-dev
cargo install --git https://github.com/kbknapp/cargo-outdated

# cargo install cargo-deb
# cargo install cargo-make
# cargo install cargo-release
# cargo install cargo-script

# sudo apt install libssl-dev
# cargo install cargo-cook
```


## npm

```
sudo apt install npm
npm config set prefix "$HOME/.local"
npm install -g npm-check
```


## graphics

Add non-free to the first source in `/etc/apt/sources.list`.

For ThinkPad x2?0, install `firmware-misc-nonfree`.

For iMacs (mid 2011), install `firmware-amd-graphics`.


## st

```
wget https://dl.suckless.org/st/st-0.8.2.tar.gz
tar xf st-0.8.2.tar.gz
rm -f st-0.8.2.tar.gz

rm -rf ~/.local/src/st-0.8.2
mv st-0.8.2 ~/.local/src/
```


## dmenu

```
wget https://dl.suckless.org/tools/dmenu-4.9.tar.gz
tar xf dmenu-4.9.tar.gz
rm -f dmenu-4.9.tar.gz

rm -rf ~/.local/src/dmenu-4.9
mv dmenu-4.9 ~/.local/src/
```


## notify-send.py

```
# dbus-x11 is required when running notify-send.py with cron
# see: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=918149
sudo apt install python3-notify2 dbus-x11

cd ~/.local/src
git clone https://github.com/phuhl/notify-send.py
cd notify-send.py

python3 setup.py install --user
cd ~/temp
```


## vscodium

```
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -
echo 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list

sudo apt update
sudo apt install codium
```

Launch `codium`, ctrl+p, then enter:

```
ext install AndrsDC.base16-themes
ext install rust-lang.rust
ext install be5invis.toml
ext install vadimcn.vscode-lldb
ext install Tyriar.sort-lines
# ext install christian-kohler.path-intellisense
# ext install webfreak.debug
```


## webpage2html

```
python -m pip install --user webpage2html requests termcolor
```


## blender

```
sudo apt install libglu1-mesa
wget https://mirrors.dotsrc.org/blender/blender-release/Blender2.79/blender-2.79b-linux-glibc219-x86_64.tar.bz2
tar xf blender-2.79b-linux-glibc219-x86_64.tar.bz2
rm -f blender-2.79b-linux-glibc219-x86_64.tar.bz2
mv blender-2.79b-linux-glibc219-x86_64 ~/.local/opt/blender-2.79b
ln -s ~/.local/opt/blender-2.79b/blender ~/.local/bin/blender
```


## djv

```
wget https://datapacket.dl.sourceforge.net/project/djv/djv-beta/2.0.2/DJV2_2.0.2_amd64.deb
sudo gdebi DJV2_2.0.2_amd64.deb
rm -f DJV2_2.0.2_amd64.deb
```


## wine

```
sudo dpkg --add-architecture i386

wget "https://dl.winehq.org/wine-builds/winehq.key"
sudo apt-key add winehq.key
rm -f winehq.key

echo "deb https://dl.winehq.org/wine-builds/debian/ stable main" | sudo tee -a "/etc/apt/sources.list"

sudo apt-get update
sudo apt-get install --install-recommends winehq-stable
```


## project64

```
wget http://www.emulator-zone.com/download.php/emulators/n64/project64/project64_1.6.exe
wine project64_1.6.exe
rm -f project64_1.6.exe
```

Start with:

```
wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Project64\ 1.6/Project64.exe "$@"
```


## server

### dns

Create/update the `home/.local/bin/set-dyn-dns` script (which should be in `autostart` (and maybe cron)):

```
#!/bin/sh

request() {
   wget \
      --quiet \
      --read-timeout=0.0 \
      --waitretry=5 \
      --tries=400 \
      --background \
      --output-file=/dev/null \
      --output-document=/dev/null \
      "$1"
}

# for each hosted domain:
request [set dns ip link]
```

### apache

```
sudo apt install apache2

sudo a2enmod ssl
sudo a2ensite user
sudo a2dissite 000-default
sudo systemctl reload apache2
```

### mariadb

```
sudo apt install mariadb-client mariadb-server

# default password is blank
sudo mysql_secure_installation
```

### wordpress

```
# this is just to install php properly
sudo apt install wordpress php-mbstring

# for wordpress' proper permalinks
sudo a2enmod rewrite
sudo systemctl reload apache2
```

```
cd ~/.local/bin
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar wp
wp --info
```

```
mkdir [site]
cd [site]
wp core download

# wp wants these for later
# do it now for the permissions
mkdir wp-content/upgrade
mkdir wp-content/uploads
touch .htaccess

# during development; before the move
chmod -R 0777 wp-content/uploads

cp wp-config-sample.php wp-config.php
```

```
mysql -u root -p
CREATE DATABASE db_name CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER db_user@localhost IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON db_name.* TO db_user@localhost IDENTIFIED BY 'password';
EXIT
```

Set `DB_CHARSET` and `DB_COLLATE` as above in `wp-config.php`, and use `https://api.wordpress.org/secret-key/1.1/salt/`.

If you set the permissions properly, add `define('FS_METHOD', 'direct');` to `wp-config.php`.

Set `WP_DEBUG` to `true`.

#### import/export

```
cd .../wp/
wp db export

# download db.sql to [new wp root]
# download wp-content/themes,plugins,uploads to [new wp root]/wp-content
# or git clone the theme into wp-content/themes if it's in git

# need to run the install if importing the database?
# do it next time and see if it enables the permalinks

cd [new wp root]
sudo -u www-data -- wp db import db.sql
sudo -u www-data -- wp search-replace "http://localhost/x.co.uk" "http://x.co.uk"
```

If you get a whitescreen, check the theme is enabled properly.

You might need to set permalinks to plain in the settings.

When moving to the main site, make sure `WP_DEBUG` is `false`, and:

```
chown -R www-data:www-data .
find . -type d -exec chmod 750 {} \;
find . -type f -exec chmod 640 {} \;
```

#### remove

```
mysql -u root -p
SELECT User FROM mysql.user;
SHOW GRANTS FOR db_user@localhost;
REVOKE ALL PRIVILEGES, GRANT OPTION FROM db_user@localhost;
DROP USER db_user@localhost;
DROP DATABASE db_name;
EXIT
```

#### composer

```
curl -sS https://getcomposer.org/installer -o composer-setup.php
php composer-setup.php --install-dir="$HOME/.local/bin" --filename=composer
rm composer-setup.php
```

```
composer require [vendor/package]
```

Then include `require_once "vendor/autoload.php";` in `functions.php` or somewhere equivalent.


## sudoers

```
sudo addgroup demi
sudo adduser [user] demi
```

Run `visudo` and add:

```
%demi ALL=NOPASSWD:/sbin/shutdown
%demi ALL=NOPASSWD:/usr/sbin/pm-suspend
%demi ALL=NOPASSWD:/usr/sbin/pm-suspend-hybrid
%demi ALL=NOPASSWD:/usr/sbin/pm-hibernate
```


## fnlock

To disable fnlock on an external ThinkPad keyboard, run `visudo` and add (along with the command in `uutostart`):

```
%demi ALL=NOPASSWD:/usr/bin/tee /sys/bus/hid/devices/*17EF\:604*/fn_lock
```


## crontab

Run `env EDITOR=mousepad crontab -e` and add:

```
*/3 * * * *  . "$HOME/.profile"; DISPLAY=:0  react-to-low-battery 12 6
# 0 */2 * * *  . "$HOME/.profile"; DISPLAY=:0  flock --nonblock "$HOME/.backup.lock" backup
```

Run `sudo EDITOR=mousepad crontab -e` and add:

```
0 */6 * * *  journalctl --vacuum-time=14d
```


## connect

```
connect-dots --with-root --with-suckless --with-fonts
```


## ssh key

Save `id_rsa` and `id_rsa.pub` to `~/.ssh` and `chmod 0600 ~/.ssh/id_rsa`


## restart

```
rmdir ~/temp
sudo shutdown -r now
```


## setup

- meld
- mousepad
- quodlibet


### firefox-esr

- NoScript (allow scripts globally, just use it for the other stuff)
- EPUBReader
- Smart HTTPS
- Privacy Badger
- Decentraleyes
- Maximizer for YouTube
- Open Image in New Tab (robines)
- uBlock Origin
- Video Resumer

`ln -s ~/.mozilla/firefox/user.js ~/.mozilla/firefox/[profile]/user.js`


### firefox-dev

Install the Arc Darker theme and set up the developer tools.

- Open Image in New Tab (robines)

`ln -s ~/.mozilla/firefox/dev-user.js ~/.mozilla/firefox/[dev-profile]/user.js`


### firefox remote debugging

on old versions of firefox for the desktop
- sudo apt install adb
- sudo adduser [user] plugdev
- open webide in firefox
- project > manage extra components
- install adb helper

on new versions of firefox for the desktop
- open about:debugging
- enable usb debugging

on android
- open settings > about phone
- tap build number 7 times
- open settings > developer options
- enable usb debugging

on firefox for android
- open settings > advanced
- enable remote debugging via usb


### chromium

- Backspace to go Back


### blender animation nodes

- Download from: `https://github.com/JacquesLucke/animation_nodes/releases`
- Open Blender
- Go to `User Preferences > Add ons`
- Click `Install from File` and choose the downloaded file
- Activate the add-on


### openmw

- [Better Dialogue Font](https://www.nexusmods.com/morrowind/mods/36873)
- [Westly's Pluginless Head and Hair Replacer](http://download.fliggerty.com/download-127-874)
- [Graphic Herbalism](https://www.nexusmods.com/morrowind/mods/43140)
- [Others](http://en.uesp.net/wiki/Morrowind:Official_Add-Ons)


### project64

Use the N-Rage input plugin. If the gamepad has two versions (`event` and `js`) use `event`. Disable `raw data`.
