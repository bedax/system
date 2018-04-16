# gnix

_These are some notes on how to setup the author's system. These aren't expected to be useful to anyone else._

- Install Debian's minimal version (the one that includes non-free firmware, if necessary)
- Select nothing at the software selection menu
- Partition:
    - An ~8gb ext4 partition for /
    - A ~2gb ext2 partition for ~/System
    - An ext3 partition for ~/, using the remaining space

---


## Automated Wifi

Add the following to `/etc/network/interfaces`:

```
auto wlp3s0
iface wlp3s0 inet dhcp
    wpa-ssid [ssid]
    wpa-psk [key]
```

Then reboot.

---


## SysVinit

Add this to `/etc/apt/sources.list.d/nosystemd.list`:

```
deb http://angband.pl/debian/ nosystemd-stretch main
```

Add this to `/etc/apt/preferences.d/nosystemd`:

```
Package: *
Pin: origin angband.pl
Pin-Priority: 1100

Package: libsystemd0
Pin: version *
Pin-Priority: 500

Package: *systemd*
Pin: release *
Pin-Priority: -1
```

Then run:

```
su
apt update
apt upgrade
apt install kilobyte-archive-keyring
apt install sysvinit-core sysvinit-utils
cp /usr/share/sysvinit/inittab /etc/inittab
/sbin/shutdown -r now
apt purge systemd*
```

---


## Add sudo

```
su
apt install sudo
adduser [username] sudo
/sbin/shutdown -r now
```

---


## Let others shutdown

Run:

```
sudo addgroup demi
sudo adduser [name] demi
```

Then run `sudo visudo` and add:

```
%demi ALL=NOPASSWD:/sbin/shutdown,/usr/sbin/pm-suspend,/usr/sbin/pm-suspend-hybrid,/usr/sbin/pm-hibernate
```

---


## Connect the dots

Do this now, and again at the end of the installation.

```
cd ~/System # the location of this repository
sudo ./connect.sh /[this repository's location]/GNUX/usr/ /usr/
./connect.sh /[this directory's full path]/GNUX/home/ /home/[name]/
./connect.sh /[this directory's full path]/Fonts/ /home/[name]/.fonts/
fc-cache -fv
```

---

## Set-up the environment

```
sudo apt install build-essential make cmake autoconf automake pkg-config libtool-bin
sudo apt install python python-pip python3 python3-pip
sudo apt install gdebi apt-file
```

---


## Samba

```
sudo apt install samba
sudo smbpasswd -a [username]
```

---


## The window manager

Install the dependencies:

```
sudo apt install xinit x11-xserver-utils xserver-xorg-video-intel
sudo apt install python3-dev python3-setuptools
sudo apt install libxcb-render0-dev libffi-dev libcairo2 libpangocairo-1.0-0 libxcb-cursor-dev
sudo apt install compton redshift hsetroot wicd xbacklight # startup stuff
sudo apt install pm-utils pulseaudio pavucontrol pulseaudio-utils alsa-utils desktop-base
sudo python3 -m pip install xcffib
sudo python3 -m pip install cairocffi # this needs to be after xcffib
```

Then install qtile:

```
sudo python3 -m pip install qtile
```

Or if installing from source:

```
cd ~/.local/src/qtile-[version]/
python3 ./setup.py build
sudo python3 ./setup.py install
```

Link `/root/.config/qtile` to `/home/[name]/.config/qtile` in case it needs debugging with `sudo ~/.config/qtile/start_debugging.sh`.

### Low battery notifications

Run:

```
sudo apt install acpi libnotify-bin
```

Then run `crontab -e` and add:

`*/3 * * * * DISPLAY=:0 /home/[name]/.config/qtile/notify-battery-low.py 12`

### Fix the backlight

If `xbacklight -set 50` fails, add the following to `/etc/X11/xorg.conf`:

```
Section "Device"
    Identifier  "Card0"
    Driver      "intel"
    Option      "Backlight"  "intel_backlight"
EndSection
```

---


## The login manager

```
sudo apt install lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
lightdm-gtk-greeter-settings
```

---


## [st](https://st.suckless.org/) and [dmenu](https://tools.suckless.org/dmenu/)

First, run:

```
sudo apt install libx11-dev libxinerama-dev libxft-dev
```

Then run `make` and `sudo make install` for both, making sure to use the connected dots from above, and the correct versions.

---


## Configure the look

```
sudo apt install adwaita-qt4 adwaita-qt adwaita-icon-theme gnome-themes-standard qt4-qtconfig
qtconfig-qt4
```

---


## [Fish](https://fishshell.com/)

```
wget -nv https://download.opensuse.org/repositories/shells:fish:release:2/Debian_9.0/Release.key -O Release.key
sudo apt-key add - < Release.key
rm Release.key
sudo echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/2/Debian_9.0/ /' > /etc/apt/sources.list.d/fish.list
sudo apt update
sudo apt install fish
```

```
curl -L https://get.oh-my.fish | fish
omf install wd pbcopy
```

---


## Rust

```
curl https://sh.rustup.rs -sSf | sh # don't modify the path as it's already done
rustup install nightly
```

```
rustup install nightly-2016-08-01
sudo apt install libncursesw5-dev
rustup run nightly-2016-08-01 cargo install --git https://github.com/murarth/rusti
```

```
cargo install cargo-check cargo-outdated
cargo +nightly install cargo-expand
```

```
sudo apt install libssl-dev
cargo install cargo-tree
```

---


## Node.js

```
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt install -y nodejs
```

---


## [ctags](https://github.com/universal-ctags/ctags)

```
cd ~/.local/src
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure
make
sudo make install
```

---


## [Neovim](https://github.com/neovim/neovim)

Install Node.js/npm first. Connect to the internet and run the following for [vim-plug](https://github.com/junegunn/vim-plug):

```
sudo apt install curl
```

Then:

```
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
sudo python -m pip install neovim
sudo python3 -m pip install neovim
```

Then for nvim-completion-manager:

```
cargo install racer
rustup component add rust-src
racer complete std::io::B # a test; should return things beginning with B
```

```
sudo python3 -m pip install jedi
```

After the first :PlugInstall, this may still be needed (but shouldn't be):

```
cd ~/.local/share/nvim/plugged/nvim-cm-tern/
npm install
```

---


## Firefox

```
sudo apt install firefox-esr
```

### Add-ons:
- uBlock Origin
- NoScript (allow scripts globally, just use for the other stuff)
- Decentraleyes
- CanvasBlocker
- HTTPS Everywhere
- Privacy Badger
- No Resource URI Leak (not needed for 57+)
- EPUBReader
- Vue.js devtools
- Open Image in New Tab (by Maximus for pre-Quantom, and bedstash for post)

---


## [Firefox Developer Edition](https://www.mozilla.org/en-GB/firefox/developer/)

Download to `/opt` and run:

```
sudo chown -R [user_name]:[user_name] /opt/firefox-dev/
sudo ln -s /opt/firefox-dev/firefox /usr/local/bin/firefox-dev
```

### Install extensions

The same ones as Firefox, minus EPUBReader

---


## [Thunderbird](https://www.mozilla.org/en-US/thunderbird/all/)

Install this the same way as Firefox Developer Edition.

Also install the Lightning extension, if it's not already.

---


## Blender

First run:

```
sudo apt install libglu1-mesa
```

Then download blender to `/opt/blender` and link the binary to `/usr/local/bin/blender`.

### [Animation Nodes](https://github.com/JacquesLucke/animation_nodes)

- Download from: https://github.com/JacquesLucke/animation_nodes/releases
- Open Blender
- Go to `User Preferences > Add ons`
- Click `Install from File` and choose the downloaded file
- Activate the add-on

---


## VirtualBox

Add the following to `/etc/apt/sources.list`:

```
deb http://ftp.debian.org/debian stretch-backports main contrib
```

Then:

```
sudo apt update
sudo apt install virtualbox
```

---


## [djv](http://djv.sourceforge.net/)

```
gdebi downloaded.deb
```

---


## [Protege](https://protege.stanford.edu/), [OpenMW](https://downloads.openmw.org/linux/other/), and [Dwarf Fortress](http://www.bay12games.com/dwarves/)

Download to `/opt`, extract, link to from `/usr/local/bin`.

For OpenMW:

- [Better Dialogue Font](https://www.nexusmods.com/morrowind/mods/36873)
- [Westly's Pluginless Head and Hair Replacer](http://download.fliggerty.com/download-127-874)
- [Graphic Herbalism](https://www.nexusmods.com/morrowind/mods/43140)
- [Others](http://en.uesp.net/wiki/Morrowind:Official_Add-Ons)

---


## [peek](https://github.com/phw/peek)

```
sudo apt install cmake valac libgtk-3-dev libkeybinder-3.0-dev libxml2-utils gettext txt2man
cd ~/.local/src
git clone https://github.com/phw/peek.git
mkdir peek/build
cd peek/build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DGSETTINGS_COMPILE=OFF .. # doesn't seem to like being in /usr/local for some reason
make package
sudo gdebi [made package name].deb
```

---


## [cbatticon](https://github.com/valr/cbatticon)

```
sudo apt install libnotify-dev
cd ~/.local/src
git clone https://github.com/valr/cbatticon.git
cd cbatticon
make
mv cbatticon ../../bin
```

---


## [pa-applet](https://github.com/fernandotcl/pa-applet)

```
sudo apt install libpulse-dev libnotify-dev
cd ~/.local/src
git clone https://github.com/fernandotcl/pa-applet.git
cd pa-applet
./autogen.sh
```

Remove `-Werror` from `./src/Makefile.am`.

```
./configure --prefix=/home/[name]/.local
make
make install
```

---


## Linters

### (S)CSS

```
npm install -g stylelint stylelint-config-recommended
```

### Rust

```
cargo +nightly install clippy
```

### Markdown

```
npm install -g markdownlint-cli
```

### JSON

```
npm install -g jsonlint
```

### HTML

```
npm install -g htmlhint
```

### Python

```
python3 -m pip install pylint flake8 flake8-docstrings
```

### JavaScript

```
npm install -g eslint
```

### Vim

```
python3 -m pip install vim-vint
```

### English

Use [LanguageTool](https://github.com/languagetool-org/languagetool).

---


## Other stuff

```
sudo apt install gparted policykit-1-gnome gksu
sudo apt install quodlibet gstreamer1.0-plugins-bad
sudo apt install thunar thunar-media-tags-plugin thunar-volman gvfs-backends thunar-archive-plugin xarchiver p7zip-full zip xz-utils
sudo apt install w3m wget httpie curl viewnior mousepad nano tmux gucharmap git keepassx vlc audacity dunst lxtask virtualbox retroarch filezilla gimp gimp-help-en inkscape scribus geogebra meld picard mypaint mpv ffmpeg pandoc chromium libreoffice-writer sqlitebrowser
python -m pip install webpage2html
python3 -m pip install youtube-dl
cargo install mdbook
```
