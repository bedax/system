# install

_These are some notes on how to install the author's system. These aren't expected to be useful to anyone else._

- Install Debian's minimal version ([the one that includes non-free firmware](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/), if necessary)
- Select nothing at the software selection menu
- Partition:
    - A swap partition; 1.5 * RAM
    - A ~12gb ext4 partition for /
    - An ext4 partition for ~, using the remaining space


## network

To get the network working add whatever's relevant from the following to `/etc/network/interfaces`:

```
# enable internal wifi
auto wlp4s0
   iface wlp4s0 inet dhcp
      wpa-ssid {{ WIFI_NAME }}
      wpa-psk {{ WIFI_PASSWORD }}

# enable external wifi
auto wlx74da38d41aaa
   allow-hotplug wlx74da38d41aaa
   iface wlx74da38d41aaa inet dhcp
      wpa-ssid {{ WIFI_NAME }}
      wpa-psk {{ WIFI_PASSWORD }}

# enable usb tethering
auto enp0s20u1
   allow-hotplug enp0s20u1
   iface enp0s20u1 inet dhcp
```

To find the network device name use `ip link`.

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
git clone https://.../system
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
ffmpeg
git
htop
less
lua-check
miniupnpc
nano
ncdu
netcat-openbsd
net-tools
openssh-client
pandoc
shellcheck
sqlite3
tree
unzip
w3m
wget
xz-utils
zip

### graphical applications
audacity
chromium
filezilla
geogebra
gksu
gparted
gucharmap
hexchat
inkscape
keepassx
meld
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
thunar-media-tags-plugin
thunar-volman
gvfs-backends
policykit-1-gnome
thunar-archive-plugin
xarchiver
p7zip-full

### window manager stuff
xinit
x11-utils
xserver-xorg-video-intel
bspwm
sxhkd
dunst

### appearance
adwaita-qt
adwaita-qt4
adwaita-icon-theme
gnome-themes-standard
qt4-qtconfig

### backup
rsync

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


## cargo

```
cargo install --force ripgrep fd-find
```


## pip

```
python[3] -m pip install --user --upgrade [name]
```

### pip2

webpage2html

### pip3

flake8
flake8-bugbear
flake8-docstrings
youtube-dl


## fish

```
wget https://download.opensuse.org/repositories/shells:fish:release:2/Debian_9.0/Release.key
sudo apt-key add Release.key
rm -f Release.key

echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/2/Debian_9.0/ /' | sudo tee /etc/apt/sources.list.d/fish.list

sudo apt update
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
rustup component add rustfmt --toolchain nightly-x86_64-unknown-linux-gnu

sudo apt install musl-tools
rustup target add x86_64-unknown-linux-musl

sudo apt install rust-lldb valgrind

cargo install --force cargo-bloat
cargo install --force cargo-fuzz
cargo install --force cargo-profiler
cargo install --force cargo-watch
cargo install --force evcxr_repl
cargo +nightly install --force cargo-expand
cargo +nightly install --force cargo-modules

sudo apt install libssl-dev
cargo install --force cargo-audit

sudo apt install libssl-dev
cargo install --force cargo-deadlinks

sudo apt install libssl-dev
cargo install --force cargo-tree

sudo apt install libssl-dev
cqrgo install --force --git https://github.com/kbknapp/cargo-outdated

sudo apt install libssl-dev zlib1g-dev
RUSTFLAGS='--cfg procmacro2_semver_exempt' cargo +nightly install --force cargo-tarpaulin

sudo apt install libssl-dev libssh2-1-dev libgit2-dev
cargo install --force cargo-update

# cargo install --force cargo-deb
# cargo install --force cargo-make
# cargo install --force cargo-release
# cargo install --force cargo-script

# sudo apt install libssl-dev
# cargo install --force cargo-cook
```


## node

```
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt install nodejs
npm config set prefix "$HOME/.local"
npm install -g npm-check
```


## notify-send.py

```
# dbus-x11 is required when running notify-send.py with cron
# see: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=918149
sudo apt install python3-notify2 dbus-x11

cd ~/.local/src
git clone https://github.com/phuhl/notify-send.py
cd notify-send.py

python3 setup.py install --user --force
cd ~/temp
```


## virtualbox

```
echo "deb http://ftp.debian.org/debian stretch-backports main contrib" | sudo tee -a "/etc/apt/sources.list"

sudo apt update
sudo apt install virtualbox
```


## gimp

```
cd ~/.local/opt
wget "https://github.com/aferrero2707/gimp-appimage/releases/download/continuous/GIMP_AppImage-release-2.10.8-withplugins-x86_64.AppImage"

chmod +x GIMP_AppImage-release-2.10.8-withplugins-x86_64.AppImage
ln -s ~/.local/opt/GIMP_AppImage-release-2.10.8-withplugins-x86_64.AppImage ~/.local/bin/gimp
ln -s ~/.config/GIMP ~/.config/GIMP-AppImage
cd ~/temp

# sudo apt install gimp-help-en
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

sudo a2dissite 000-default
sudo a2ensite user
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
# this is to install php properly
sudo apt install wordpress

# for wordpress' proper permalinks
sudo a2enmod rewrite
# sudo a2enmod ssl
sudo systemctl reload apache2
```

```
wget https://wordpress.org/latest.tar.gz
tar xf latest.tar.gz
mv wordpress [site]
cd [site]

# wp wants these for later
# do it now for the permissions
mkdir wp-content/upgrade
mkdir wp-content/uploads
touch .htaccess

# during development; before the move
chmod 0777 wp-content/uploads

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
mysqldump db_name -u username -p > file.sql
mysql db_name -u username -p < file.sql
```

#### move

```
define("WP_HOME", "http://localhost/dev/new_location/");
define("WP_SITEURL", "http://localhost/dev/new_location/");
```

You might need to set permalinks to plain in the settings, and make sure `WP_DEBUG` is `false`.

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


## sources

```
wget [link]
tar xf [archive]
rm -f [archive]

rm -rf ~/.local/src/[extracted_name]
mv [extracted_name] ~/.local/src/

connect-dots --without-suckless --without-fonts --without-root
```

### links

- `https://dl.suckless.org/st/st-0.8.1.tar.gz`
- `https://dl.suckless.org/tools/dmenu-4.8.tar.gz`
- `https://netcologne.dl.sourceforge.net/project/rsyncrypto/rsyncrypto/1.14/rsyncrypto-1.14.tar.bz2`


## rsyncrypto

```
cd ~/.local/src/rsyncrypto-1.14
sudo apt install libssl-dev libargtable2-dev

./configure --prefix="$HOME/.local"
make
make install
cd ~/temp
```


## binaries

```
wget [link]
tar xf [archive]
rm -f [archive]
mv [extracted] ~/.local/opt/[opt name]
ln -s ~/.local/opt/[opt name]/[opt bin name] ~/.local/bin/[bin name]
```

### textadept

```
link: https://foicica.com/textadept/download/textadept_10.3.x86_64.tgz
opt name: textadept_10.3
opt bin name: textadept
bin name: textadept

after:
cd ~/.textadept
git clone https://github.com/rgieseke/textadept-themes.git themes
ln -s ~/.local/opt/[opt name]/textadept-curses ~/.local/bin/textadept-curses
```

### firefox-dev

```
link: https://download-installer.cdn.mozilla.net/pub/devedition/releases/66.0b2/linux-x86_64/en-GB/firefox-66.0b2.tar.bz2
opt name: firefox-dev
opt bin name: firefox
bin name: firefox-dev
```

### blender

```
before: sudo apt install libglu1-mesa

link: https://mirrors.dotsrc.org/blender/blender-release/Blender2.79/blender-2.79b-linux-glibc219-x86_64.tar.bz2
opt name: blender-2.79b
opt bin name: blender
bin name: blender
```

### openmw

```
link: https://downloads.openmw.org/linux/other/openmw-0.44.0-Linux-64Bit.tar.gz
opt name: openmw-0.44.0
opt bin name: openmw-launcher
bin name: openmw-launcher

after: ln -s ~/.local/opt/[opt name]/openmw-wizard ~/.local/bin/openmw-wizard
```


## debs

```
wget [link]
sudo gdebi [downloaded.deb]
rm -f [downloaded.deb]
```

### links

- `https://datapacket.dl.sourceforge.net/project/djv/djv-stable/1.2.6/DJV_1.2.6_amd64.deb`


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


## crontab

Run `crontab -e` and add:

```
*/3 * * * *  . "$HOME/.profile"; DISPLAY=:0  react-to-low-battery 12 6
# 0 */2 * * *  . "$HOME/.profile"; DISPLAY=:0  flock --nonblock "$HOME/.backup.lock" backup
```


## connect

```
connect-dots
```


## restart

```
rmdir ~/temp
sudo shutdown -r now
```


## setup

### browsers

- Open Image in New Tab (robines)
- Vue.js devtools


### firefox-dev

Install the Arc Darker theme and set up the developer tools.

- Wappalyzer

`ln -s ~/.mozilla/firefox/dev-user.js ~/.mozilla/firefox/[dev-profile]/user.js`


### firefox-esr

- NoScript (allow scripts globally, just use it for the other stuff)
- EPUBReader
- Smart HTTPS
- Privacy Badger
- Maximizer for YouTube
- uBlock Origin
    - the default lists
    - Adguard Annoyances
    - Fanboy's Annoyance List
    - Anti-Facebook List

`ln -s ~/.mozilla/firefox/user.js ~/.mozilla/firefox/[profile]/user.js`


### meld


### blender animation nodes

- Download from: `https://github.com/JacquesLucke/animation_nodes/releases`
- Open Blender
- Go to `User Preferences > Add ons`
- Click `Install from File` and choose the downloaded file
- Activate the add-on


### djv

`djv_view` will likely complain about not being able to find `libpng12.so`, in which case manually [get it from jessie](http://ftp.uk.debian.org/debian/pool/main/libp/libpng/libpng12-0_1.2.50-2+deb8u3_amd64.deb) and install it with gdebi.


### openmw

- [Better Dialogue Font](https://www.nexusmods.com/morrowind/mods/36873)
- [Westly's Pluginless Head and Hair Replacer](http://download.fliggerty.com/download-127-874)
- [Graphic Herbalism](https://www.nexusmods.com/morrowind/mods/43140)
- [Others](http://en.uesp.net/wiki/Morrowind:Official_Add-Ons)


### project64

Use the N-Rage input plugin. If the gamepad has two versions (`event` and `js`) use `event`. Disable `raw data`.
