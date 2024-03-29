# install

_These are some notes on how to install the author's system. These aren't expected to be useful to anyone else._

- Install debian's minimal version ([the one that includes non-free firmware](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/), if necessary)
- Select nothing at the software selection menu
- Partition:
    - A 512 MiB EFI partition (536870912 bytes)
    - A 8 GiB ext4 partition for / (8589934592 bytes)
    - A swap partition; 1.5 * RAM (for hibernation) (12 GiB = 12884901888 bytes)
    - An ext4 partition for /home, using the remaining space


## guixsd

In the install script, set `use-substitutes?` to `#f`. Note:

https://guix.gnu.org/manual/en/html_node/Using-the-Configuration-System.html
https://guix.gnu.org/manual/en/html_node/Getting-Substitutes-from-Other-Servers.html
https://guix.gnu.org/manual/en/html_node/Base-Services.html#index-guix_002dconfiguration


## terminal font

`/sbin/dpkg-reconfigure -plow console-setup`


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
/sbin/service networking restart
apt install network-manager
nano /etc/network/interfaces # remove what was added above
/sbin/service networking restart
/sbin/service network-manager restart
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
/sbin/adduser [user] sudo
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
- `adwaita-qt4` (as it's not in buster, install it and `adwaita-qt-data` from stretch with `gdebi`)
- `alsa-utils` (`amixer` used by `volume-mute`)
- `apt-file`
- `audacity`
- `binutils`
- `blender`
- `bspwm`
- `bzip2`
- `clang`
- `clang-tools`
- `cloc`
- `compton`
- `coreutils`
- `cron`
- `dbus-x11` (used by `notify-send.py` in `crontab`)
- `djview`
- `dunst`
- `ffmpeg`
- `firefox-esr`
- `fontconfig`
- `gcc`
- `gcc-doc` (enable `buster-backports` with `contrib` and `non-free`)
- `gdebi`
- `gimp`
- `gimp-help-en`
- `git`
- `gnome-themes-standard`
- `gparted`
- `gzip`
- `hexchat`
- `hsetroot` (used to set the background in `autostart`)
- `htop`
- `inkscape`
- `jshon` (used by `desktop-get`)
- `keepassx`
- `less`
- `libx11-dev` (used to compile `st` and `dmenu`)
- `libxft-dev` (used to compile `st` and `dmenu`)
- `libxinerama-dev` (used to compile `st` and `dmenu`)
- `links2`
- `lua5.3`
- `luarocks`
- `maim` (used by `screenshot`)
- `make`
- `man`
- `manpages`
- `manpages-dev`
- `manpages-posix`
- `manpages-posix-dev`
- `meld`
- `mpv`
- `nano`
- `ncdu`
- `netcat-traditional`
- `openssh-client`
- `pandoc`
- `pm-utils` (used by the `sleep` and `hibernate` scripts)
- `pulseaudio`
- `pulseaudio-utils` (used by `volume-get` and `volume-set`)
- `python3`
- `python3-pip`
- `qt4-qtconfig`
- `redshift`
- `shellcheck`
- `sigil`
- `sxhkd`
- `tar`
- `tcc`
- `thunar`
- `thunar-archive-plugin`
- `thunar-volman`
- `transmission-gtk`
- `tree`
- `ttf-mscorefonts-installer`
- `unzip`
- `viewnior`
- `wget`
- `x11-utils` (contains `xev`)
- `x11-xserver-utils` (`xsetroot` used in `autostart` to set the cursor; `xmodmap` used in `autostart` to disable the capslock)
- `xarchiver`
- `xbacklight` (used in `sxhkdrc`, `autostart`, and `brightness-get`)
- `xclip` (used by `screenshot`)
- `xdotool` (used by `screenshot`)
- `xinit` (contains `startx`)
- `xinput` (for disabling the touchpad in `autostart`)
- `xz-utils`
- `yash`
- `youtube-dl` (or `python3 -m pip install youtube-dl`)
- `zip`


## gdb

```
cd ~
sudo apt install gdb nemiver strace
python3 -m pip install pygments
wget -P ~ https://git.io/.gdbinit
mv .gdbinit .gdb-dashboard
```


## fish

```
sudo apt install fish

wget https://git.io/fisher
mkdir -p ~/.config/fish/functions
mv fisher ~/.config/fish/functions/fisher.fish

fish -c "fisher install fischerling/plugin-wd"
fish -c "fisher install oh-my-fish/plugin-pbcopy"
```


## npm

```
curl -sL https://deb.nodesource.com/setup_14.x | sudo TERM=xterm bash -
sudo apt install npm
npm config set prefix "$HOME/.local"
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
# may need to do this first:
# python3 -m pip install --upgrade pip
sudo apt install libdbus-1-dev libglib2.0-dev
python3 -m pip install --user notify-send.py
```


## geany

```
sudo apt install geany
sudo apt install geany-plugin-addons

git clone https://github.com/geany/geany-themes/
mkdir -p ~/.config/geany/colorschemes
mv geany-themes/colorschemes/*.conf ~/.config/geany/colorschemes/
rm -rf geany-themes

git clone https://github.com/robloach/base16-geany
mv base16-geany/*.conf ~/.config/geany/colorschemes/
rm -rf base16-geany
```


## virtualbox

Add the following to `/etc/apt/sources.list`:

```
deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian buster contrib
```

And run the following:

```
wget https://www.virtualbox.org/download/oracle_vbox_2016.asc
sudo apt-key add oracle_vbox_2016.asc
rm -f oracle_vbox_2016.asc
sudo apt update
sudo apt install virtualbox-5.2
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

Run `crontab -e` and add:

```
*/3 * * * *  . "$HOME/.profile"; DISPLAY=:0 react-to-low-battery 12 6
0 */3 * * *  . "$HOME/.profile"; flock --nonblock "$HOME/.backup.lock" "$HOME/.backup.sh" || DISPLAY=:0 notify-confirmation --urgency critical "backup failed"
```

### ~/.backup.sh

If the crontab is running a backup script, then it can contain something like:

```
#!/bin/sh

files=$(find ~ \
   -type d \( \
          -path "$HOME/.*" \
      -or -path ~/downloads \
      -or -path ~/videos \
      -or -name ".git" \
   \) -prune -or -print)

echo "$files" | backup --keep 14 /media/usb/backups/ /media/sdcard/backups/ || exit 1
```

### automount backup drives

To automount the usb/sdcard on boot, add the following to `/etc/fstab`:

```
UUID=[UUID from `lsblk -f`]   /media/[usb]      [ext4]        noauto,nofail,x-systemd.automount,x-systemd.idle-timeout=2,x-systemd.device-timeout=2,user
UUID=[UUID from `lsblk -f`]   /media/[shared]   [vfat/ntfs]   noauto,nofail,x-systemd.automount,x-systemd.idle-timeout=2,x-systemd.device-timeout=2,user,uid=[username],gid=[username]
```

And run the following:

```
sudo mkdir /media/[usb]
sudo chown [user]:[user] /media/[usb]
mount /media/[usb]
```


## logging

[enable persistent logging](https://unix.stackexchange.com/a/159390) by running:

```
sudo mkdir /var/log/journal
sudo systemd-tmpfiles --create --prefix /var/log/journal
sudo systemctl restart systemd-journald
```

To automatically clean old logs, run `sudo crontab -e` and add:

```
0 */6 * * *  journalctl --vacuum-time=14d
```


## disable beeps

```
sudo rmmod pcspkr
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


## list

```
apt-list > ~/.fresh-apt-list
```


## setup

- meld


### firefox

- EPUBReader
- Open Image in New Tab (robines)
- Save Page WE
- Tab Session Manager
- uBlock Origin

`ln -s ~/.mozilla/firefox/user.js ~/.mozilla/firefox/[profile]/user.js`

See `about:profiles` to find the current profile.

Then set up the developer tools.


### openmw

- [Better Dialogue Font](https://www.nexusmods.com/morrowind/mods/36873)
- [Graphic Herbalism](https://www.nexusmods.com/morrowind/mods/43140)
- [Weapon Sheathing](https://www.nexusmods.com/morrowind/mods/46069)
- [Westly's Pluginless Head and Hair Replacer](http://download.fliggerty.com/download-127-874)
- [Others](https://en.uesp.net/wiki/Morrowind:Plugins)
