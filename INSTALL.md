# install

_These are some notes on how to install the author's system. These aren't expected to be useful to anyone else._

- Install debian's minimal version ([the one that includes non-free firmware](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/), if necessary)
- Select nothing at the software selection menu
- Partition:
    - A 512 MiB EFI partition (536870912 bytes)
    - A 8 GiB ext4 partition for / (8589934592 bytes)
    - A swap partition; 1.5 * RAM (for hibernation) (12 GiB = 12884901888 bytes)
    - An ext4 partition for /home, using the remaining space


## terminal font

`sudo dpkg-reconfigure -plow console-setup`


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

Then run:

```
service networking restart
apt install network-manager
nano /etc/network/interfaces # remove what was added above
service networking restart
service network-manager restart
nmtui
```


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
su - [user]
```


## clone

```
cd ~
sudo apt install git
git clone https://github.com/bedax/system
```


## mkdirs

```
mkdir -p ~/.local/src
mkdir -p ~/.local/bin
mkdir -p ~/.local/opt
```


## apt

```
sudo apt install [name]
```

- `adwaita-icon-theme`
- `adwaita-qt`
- `adwaita-qt4` (as it's not in buster, install it and adwaita-qt-data from stretch with gdebi)
- `alsa-utils` (used by `volume-mute`)
- `apt-file`
- `audacity`
- `blender`
- `bspwm`
- `build-essential`
- `cloc`
- `compton`
- `coreutils`
- `cron`
- `dunst`
- `ffmpeg`
- `filezilla`
- `firefox-esr`
- `fontconfig`
- `gdebi`
- `gimp`
- `gimp-help-en`
- `git`
- `gnome-themes-standard`
- `gparted`
- `gstreamer1.0-plugins-bad`
- `hexchat`
- `hsetroot` (used to set the background in `autostart`)
- `htop`
- `inkscape`
- `jshon` (used by `desktop-get`)
- `keepassx`
- `less`
- `libnotify-bin`
- `libx11-dev` (used by st and dmenu)
- `libxft-dev` (used by st and dmenu)
- `libxinerama-dev` (used by st and dmenu)
- `links2`
- `maim` (used by `screenshot`)
- `man`
- `meld`
- `mpv`
- `nano`
- `ncdu`
- `neofetch`
- `netcat-openbsd`
- `openmw`
- `openssh-client`
- `pandoc`
- `picard`
- `pm-utils` (used by the sleep and hibernate scripts)
- `pulseaudio`
- `pulseaudio-utils` (used by `volume-get` and `volume-set`)
- `python3`
- `python3-pip`
- `qt4-qtconfig`
- `quodlibet`
- `redshift`
- `shellcheck`
- `sigil`
- `sxhkd`
- `thunar`
- `thunar-archive-plugin`
- `thunar-volman`
- `tmux`
- `transmission`
- `tree`
- `ttf-mscorefonts-installer`
- `unzip`
- `viewnior`
- `virt-manager`
- `wget`
- `x11-utils` (contains xev)
- `x11-xserver-utils`
- `xarchiver`
- `xbacklight`
- `xclip` (used by `screenshot`)
- `xdotool` (used by `screenshot`)
- `xinit`
- `xinput` (for disabling the touchpad in `autostart`)
- `youtube-dl`
- `zip`


## fish

```
sudo apt install fish

wget https://git.io/fisher
mkdir -p ~/.config/fish/functions
mv fisher ~/.config/fish/functions/fisher.fish

fish -c "fisher add fischerling/plugin-wd"
fish -c "fisher add oh-my-fish/plugin-pbcopy"
# fish -c "fisher add externl/fish-symnav"
```


## chicken

```
cd ~/.local/src
wget https://code.call-cc.org/releases/5.2.0/chicken-5.2.0.tar.gz
tar zxf chicken-5.2.0.tar.gz
rm -f chicken-5.2.0.tar.gz
cd chicken-5.2.0
make PLATFORM=linux PREFIX="$HOME/.local"
make PLATFORM=linux PREFIX="$HOME/.local" install
cd ~/.local/bin
mv csi chicken-csi # so as not to conflict with the wrapper script
sudo apt install rlwrap
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
cd ~/.local/src
rm -rf st-0.8.2
wget https://dl.suckless.org/st/st-0.8.2.tar.gz
tar zxf st-0.8.2.tar.gz
rm -f st-0.8.2.tar.gz
```


## dmenu

```
cd ~/.local/src
rm -rf dmenu-4.9
wget https://dl.suckless.org/tools/dmenu-4.9.tar.gz
tar zxf dmenu-4.9.tar.gz
rm -f dmenu-4.9.tar.gz
```


## notify-send.py

```
sudo apt install libdbus-1-dev libglib2.0-dev
python3 -m pip install --user notify-send.py
```


## geany

```
sudo apt install geany
sudo apt install geany-plugin-addons
sudo apt install geany-plugin-pairtaghighlighter

git clone https://github.com/geany/geany-themes/
mkdir -p ~/.config/geany/colorschemes
mv geany-themes/colorschemes/*.conf ~/.config/geany/colorschemes/
rm -rf geany-themes
```


## openrct2

```
cd ~/.local/opt/
wget https://github.com/OpenRCT2/OpenRCT2/releases/download/v0.2.5/OpenRCT2-0.2.5-linux-x86_64.AppImage
chmod +x OpenRCT2-0.2.5-linux-x86_64.AppImage
ln -s ~/.local/opt/OpenRCT2-0.2.5-linux-x86_64.AppImage ~/.local/bin/openrct2
```


## ludo

```
cd ~/.local/opt/
wget https://github.com/libretro/ludo/releases/download/v0.11.0/Ludo-Linux-x86_64-0.11.0.tar.gz
tar zxf Ludo-Linux-x86_64-0.11.0.tar.gz
# no need to create a symlink, as a script lauches it
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


## cron

Run `env EDITOR=geani crontab -e` and add:

```
*/3 * * * *  . "$HOME/.profile"; DISPLAY=:0  react-to-low-battery 12 6
0 */2 * * *  . "$HOME/.profile"; DISPLAY=:0  flock --nonblock "$HOME/.backup.lock" "$HOME/.backup.sh" || notify-send --urgency critical "backup failed"
0 14 * * *   . "$HOME/.profile"; DISPLAY=:0  flock --nonblock "$HOME/.backup.lock" "$HOME/.backup-full.sh" || notify-send --urgency critical "full backup failed"
```

### ~/.backup.sh and ~/.backup-full.sh

If the crontab is running a backup script, then it can contain:

```
#!/bin/sh

files=$(find ~ \
   -type d \( \
          -path "$HOME/.*" \
      -or -path ~/downloads \
      -or -path ~/videos \
   \) -prune -or -print)

echo "$files" | backup --keep 7 /media/usb/backups/ /media/sdcard/backups/ || exit 1
```

### automount backup drives

To automount the usb/sdcard on boot, add the following to `/etc/fstab`:

```
UUID=[UUID from `lsblk -f`]  /media/[usb]     ext4  noauto,nofail,x-systemd.automount,x-systemd.idle-timeout=2,x-systemd.device-timeout=2
```

And run the following:

```
sudo mkdir /media/[usb]
sudo mount /media/[usb]
sudo chown -R [user]:[user] /media/[usb]
```


## logging

[enable persistent logging](https://unix.stackexchange.com/a/159390) by running:

```
mkdir /var/log/journal
systemd-tmpfiles --create --prefix /var/log/journal
systemctl restart systemd-journald
```

To automatically clean old logs, run `sudo crontab -e` and add:

```
0 */6 * * *  journalctl --vacuum-time=14d
```


## connect

```
. ~/system/home/.profile
connect-dots --with-root --with-suckless --with-fonts
```


## restart

```
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

#### firefox remote debugging

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


### openmw

- [Better Dialogue Font](https://www.nexusmods.com/morrowind/mods/36873)
- [Graphic Herbalism](https://www.nexusmods.com/morrowind/mods/43140)
- [Weapon Sheathing](https://www.nexusmods.com/morrowind/mods/46069)
- [Westly's Pluginless Head and Hair Replacer](http://download.fliggerty.com/download-127-874)
- [Others](https://en.uesp.net/wiki/Morrowind:Plugins)
