# install

_These are some notes on how to install the author's system. These aren't expected to be useful to anyone else._

- Install Debian's minimal version ([the one that includes non-free firmware](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/), if necessary)
- Select nothing at the software selection menu
- Partition:
    - A 512 MiB (536870912 bytes) EFI paritition
    - A 12 GiB (12884901888 bytes) ext4 partition for /
    - A swap partition; 1.5 * RAM (for hibernation)
    - An ext4 partition for ~, using the remaining space


## network

To get the network working, add the following to `/etc/network/interfaces`:

```
# enable wifi
auto [device name from `ip link`]
   # enable this if it's external:
   # allow-hotplug [device name]

   iface [device name] inet dhcp
      wpa-ssid {{ WIFI_NAME }}
      wpa-psk {{ WIFI_PASSWORD }}
```

Then run `service networking restart`, `apt install network-manager`, remove what was added above, restart networking again, then use `nmtui` to re-enable the network.

If `nmtui` doesn't work, edit `/etc/NetworkManager/NetworkManager.conf` and make sure `[ifupdown] managed=true`, then restart network-manager.


## update

```
apt update
apt upgrade
apt full-upgrade
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
git clone https://github.com/bedax/system
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

### scheme
chicken-bin
rlwrap

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
neofetch
less
links2
nano
ncdu
netcat-openbsd
net-tools
openssh-client
pandoc
ripgrep
shellcheck
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
gimp
gimp-help-en
gnome-boxes
gparted
inkscape
keepassx
meld
openmw
pavucontrol
picard
sigil
transmission
viewnior
vlc

### quodlibet
quodlibet
gstreamer1.0-plugins-bad

### thunar
thunar
thunar-volman
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

rustup target add wasm32-unknown-unknown
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
cargo install twiggy

sudo apt install musl-tools
rustup target add x86_64-unknown-linux-musl

sudo apt install rust-lldb valgrind
```

### cargo extensions

```
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

### cargo packages

```
cargo install bat
cargo install ruplacer
cargo install mdbook
cargo install mdbook-epub
cargo install b3sum
```


## npm

```
sudo apt install npm
npm config set prefix "$HOME/.local"
```

### npm packages

```
npm install -g npm-check
npm install -g serve
```


## graphics

Add non-free to the first source in `/etc/apt/sources.list`.

For ThinkPad x2?0, install `firmware-misc-nonfree`.


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


## firefox

```
wget "https://download-installer.cdn.mozilla.net/pub/devedition/releases/72.0b6/linux-x86_64/en-GB/firefox-72.0b6.tar.bz2"
tar xf firefox-72.0b6.tar.bz2
rm -f firefox-72.0b6.tar.bz2
mv firefox ~/.local/opt/
ln -s ~/.local/opt/firefox/firefox ~/.local/bin/firefox
sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser (which firefox) 250
```


## geany

```
sudo apt install geany
sudo apt install geany-plugin-pairtaghighlighter
sudo apt install geany-plugin-addons
git clone https://github.com/geany/geany-themes/
mkdir -p ~/.config/geany/colorschemes
mv geany-themes/colorschemes/*.conf ~/.config/geany/colorschemes/
rm -rf geany-themes
```


## blender

```
wget https://ftp.nluug.nl/pub/graphics/blender/release/Blender2.82/blender-2.82-linux64.tar.xz
tar xf blender-2.82-linux64.tar.xz
rm -f blender-2.82-linux64.tar.xz
mv blender-2.82-linux64/ ~/.local/opt/blender-2.82
ln -s ~/.local/opt/blender-2.81/blender ~/.local/bin/blender
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


## openrct2

```
cd ~/.local/opt/
wget "https://github.com/OpenRCT2/OpenRCT2/releases/download/v0.2.5/OpenRCT2-0.2.5-linux-x86_64.AppImage"
chmod +x OpenRCT2-0.2.5-linux-x86_64.AppImage
ln -s ~/.local/opt/OpenRCT2-0.2.5-linux-x86_64.AppImage ~/.local/bin/openrct2
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
request "[set dns ip link]"
```

### apache

```
sudo apt install apache2

sudo a2enmod ssl
sudo a2ensite user
sudo a2dissite 000-default
sudo systemctl reload apache2
```


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


## backup

Run `env EDITOR=geani crontab -e` and add:

```
*/3 * * * *  . "$HOME/.profile"; DISPLAY=:0  react-to-low-battery 12 6
0 */2 * * *  . "$HOME/.profile"; DISPLAY=:0  flock --nonblock "$HOME/.backup.lock" "$HOME/.backup.sh" || notify-confirmation --urgency critical "backup failed"
0 14 * * *   . "$HOME/.profile"; DISPLAY=:0  flock --nonblock "$HOME/.backup.lock" "$HOME/.backup-full.sh" || notify-confirmation --urgency critical "full backup failed"
```

### ~/.backup.sh

If the crontab is running `~/.backup.sh`, then that can contain:

```
#!/bin/sh

fdfind . ~ -E audiobooks -E downloads -E videos -E music -E books -E games -E images | backup --keep 7 /mnt/usb/backups/ /mnt/sdcard/backups/ || exit 1
```

### ~/.backup-full.sh

If the crontab is running `~/.backup-full.sh`, then that can contain:

```
#!/bin/sh

fdfind . ~ -E downloads | backup --keep 2 /mnt/sdcard/backups-full/ || exit 1
```

### automount backup drives

To automount the usb/sdcard on boot, add the following to `/etc/fstab`:

```
UUID=[UUID from `lsblk -f`]  /mnt/[usb]     ext4  noauto,nofail,x-systemd.automount,x-systemd.idle-timeout=2,x-systemd.device-timeout=2
```

And run the following:

```
sudo mkdir /mnt/[usb]
sudo mount /mnt/[usb]
sudo chown -R [user]:[user] /mnt/[usb]
```


## logging

[enable persistent logging](https://unix.stackexchange.com/a/159390) by running:

```
mkdir /var/log/journal
systemd-tmpfiles --create --prefix /var/log/journal
systemctl restart systemd-journald
```

To automatically clean old logs, run `sudo EDITOR=nano crontab -e` and add:

```
0 */6 * * *  journalctl --vacuum-time=14d
```


## connect

```
connect-dots --with-root --with-suckless --with-fonts
```


## ssh key

Save `id_rsa` and `id_rsa.pub` to `~/.ssh` and `chmod 0600 ~/.ssh/id_rsa`.


## restart

```
rmdir ~/temp
restart
```


## setup

- meld
- quodlibet


### geany

Download/enable the following plugins

- Split Window
- Scope or Debugger
- Pair Tag Highlighter
- Addons


### firefox

- uBlock Origin
- EPUBReader
- Save Page WE
- Tab Session Manager
- Open Image in New Tab (robines)
- Activate Reader View (disabled by default)

`ln -s ~/.mozilla/firefox/user.js ~/.mozilla/firefox/[profile]/user.js`

Set up the developer tools.


### firefox remote debugging

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


### openmw

- [Better Dialogue Font](https://www.nexusmods.com/morrowind/mods/36873)
- [Graphic Herbalism](https://www.nexusmods.com/morrowind/mods/43140)
- [Weapon Sheathing](https://www.nexusmods.com/morrowind/mods/46069)
- [Westly's Pluginless Head and Hair Replacer](http://download.fliggerty.com/download-127-874)
- [Others](https://en.uesp.net/wiki/Morrowind:Plugins)
