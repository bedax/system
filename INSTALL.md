# gnix

_These are some notes on how to setup the author's system. These aren't expected to be useful to anyone else._

- Install Debian's minimal version ([the one that includes non-free firmware](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/), if necessary)
- [Add to the boot arguments](https://wiki.debian.org/systemd#Installing_without_systemd). If this is done, skip the SysVinit section
- Select nothing at the software selection menu
- Partition:
    - A swap partition; 1.5 * RAM
    - A ~12gb ext4 partition for /
    - A ~512mb ext2 partition for .../backup-source/System
    - An ext3 partition for ~, using the remaining space

---


## Automated Wifi

Add the following to `/etc/network/interfaces`:

```
# enable the loopback
auto lo
iface lo inet loopback

# enable top left usb tethering
auto enp0s20u1
   allow-hotplug enp0s20u1
   iface enp0s20u1 inet dhcp
      metric 200

# enable right usb tethering
auto enp0s26u1u2
   allow-hotplug enp0s26u1u2
   iface enp0s26u1u2 inet dhcp
      metric 200

# enable internal wifi
auto wlp3s0
   iface wlp3s0 inet dhcp
      wpa-psk [key]
      wpa-ssid [ssid]
      metric 300

# disable internal wifi
#iface wlp3s0 inet manual

# enable external wifi
auto wlx74da38d41aaa
   iface wlx74da38d41aaa inet dhcp
      wpa-psk [key]
      wpa-ssid [ssid]
      metric 400
```

Then:

```
sudo service networking restart
```

---


## SysVinit

Add this to `/etc/apt/sources.list.d/nosystemd.list`, changing the reference to `stretch` if necessary:

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

```
cd [this repository]/home/.local/bin
sudo ./link [this repository's full path]/usr/ /usr/
./link [this repository's full path]/home/ /home/[name]/
./link [this repository's full path]/fonts/ /home/[name]/.fonts/
fc-cache -fv
```

---


## Set-up the environment

```
sudo apt install coreutils
sudo apt install build-essential make cmake autoconf automake pkg-config libtool-bin
sudo apt install python python-pip python3 python3-pip
sudo apt install gdebi apt-file flatpak
sudo apt install pulseaudio
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
sudo apt install compton redshift hsetroot xbacklight # startup stuff
sudo apt install maim xdotool xclip pm-utils pulseaudio-utils alsa-utils desktop-base
```

```
sudo apt install xinit x11-xserver-utils xserver-xorg-video-intel
sudo apt install python3-dev python3-setuptools
sudo apt install libxcb-render0-dev libffi-dev libcairo2 libpangocairo-1.0-0 libxcb-cursor-dev
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

### Set-up the backlight

```
sudo apt install xbacklight
```

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
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fisher fischerling/plugin-wd
fisher oh-my-fish/plugin-pbcopy
fisher externl/fish-symnav
# if any plugins rely on oh-my-fish:
#fisher tuvistavie/oh-my-fish-core
```

```
fish_config
```

Set the colour to Mono Smoke,

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


## Emscripten

```
cd ~/.local/opt
git clone https://github.com/juj/emsdk.git
cd emsdk

# until https://github.com/rust-lang/rust/issues/51856 is fixed:
   ./emsdk install sdk-1.38.0-64bit
   ./emsdk activate sdk-1.38.0-64bit
# else
   ./emsdk install latest
   ./emsdk activate latest

source ./emsdk_env.sh # will need to ctrl+d first if in fish
```

Make sure the paths in `~/.profile` are in line with the content of `./emsdk_set_env.sh` produced by `emsdk construct env`.

---


## Rust

```
curl https://sh.rustup.rs -sSf | sh # don't modify the path as it's already done
rustup install nightly
```

```
rustup target add asmjs-unknown-emscripten
rustup target add asmjs-unknown-emscripten --toolchain nightly
```

```
rustup component add clippy-preview
rustup component add rustfmt-preview
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

```
sudo apt install valgrind lldb-3.9 # atleast 3.9
```

---


## Node.js

```
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt install -y nodejs
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


## Linters

### Rust

```
cargo +nightly install clippy
```

### RDF

```
sudo apt install raptor2-utils
```

### HTML

```
npm install -g htmlhint
```

### Markdown

```
npm install -g markdownlint-cli
```

### (S)CSS

```
npm install -g stylelint stylelint-config-recommended
```

### JavaScript

```
npm install -g eslint
```

### JSON

```
npm install -g jsonlint
```

### Python

```
python3 -m pip install flake8 flake8-docstrings
```

### Vim

```
python3 -m pip install vim-vint
```

### Shell

```
sudo apt install shellcheck
```

### English

Use [LanguageTool](https://github.com/languagetool-org/languagetool).

---


## Firefox

```
sudo apt install firefox-esr
```

### Add-ons:
- EPUBReader
- uBlock Origin
    - the default lists
    - Adguard's Annoyance List (it blocks more cookie warnings, like those on serverfault.com)
- NoScript (allow scripts globally, just use it for the other stuff)
- HTTPS Everywhere
- Privacy Badger
- Open Image in New Tab (bedstash)
- Vue.js devtools

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

### Extensions

- Lightning
- SOGo Connector
- G-Hub Lite

### Connect the email accounts, calendars, and address books

See https://docs.iredmail.org/thunderbird.sogo.html

---


## Gimp

```
sudo flatpak install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref
sudo apt install gimp-help-en
```

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
sudo gdebi downloaded.deb
```

`djv_view` will likely complain about not being able to find `libpng12.so`, in which case manually [get it from jessie](http://ftp.uk.debian.org/debian/pool/main/libp/libpng/libpng12-0_1.2.50-2+deb8u3_amd64.deb) and install it with gdebi.

---


## [ripgrep](https://github.com/BurntSushi/ripgrep/releases) and [fd](https://github.com/sharkdp/fd/releases)

```
sudo gdebi downloaded.deb
```

---


## [Protege](https://protege.stanford.edu/), [OpenMW](https://downloads.openmw.org/linux/other/), and [Dwarf Fortress](http://www.bay12games.com/dwarves/)

Download to `/opt`, extract, link to from `/usr/local/bin`.

### OpenMW extensions:

- [Better Dialogue Font](https://www.nexusmods.com/morrowind/mods/36873)
- [Westly's Pluginless Head and Hair Replacer](http://download.fliggerty.com/download-127-874)
- [Graphic Herbalism](https://www.nexusmods.com/morrowind/mods/43140)
- [Others](http://en.uesp.net/wiki/Morrowind:Official_Add-Ons)

---


## Wine

```
sudo dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/Release.key
sudo apt-key add Release.key
rm Release.key
```

Add this to `/etc/apt/sources.list`:

```
deb https://dl.winehq.org/wine-builds/debian/ stable main
```

```
sudo apt-get update
sudo apt-get install --install-recommends winehq-stable
```

---


## Retroarch

```
sudo apt install retroarch
```

If it's buggy, like on debian stretch the enter key doesn't work, then download and install the following from a higher version (the order is important):

```
sudo gdebi libretro-core-info...
sudo gdebi retroarch-assets...
sudo gdebi retroarch...
```

If the icons are black, download the [`assets.zip`](http://buildbot.libretro.com/assets/frontend/assets.zip) and extract them to `~/.config/retroarch/assets/`.

Update everything in the Online Updater and download thumbnails.

### [Download cores](https://buildbot.libretro.com/nightly/linux/x86_64/latest/)

Extract these to `~/.config/retroarch/cores/`.

- `mednafen_psx_libretro.so.zip`
- `snes9x_libretro.so.zip`
- `ppsspp_libretro.so.zip`

```
git clone https://github.com/hrydgard/ppsspp
mv ppsspp/assets ~/.config/retroarch/system/PPSSPP
rm -rf ppsspp
```

---


## Project64

```
wget http://www.emulator-zone.com/download.php/emulators/n64/project64/project64_1.6.exe
wine project64_1.6.exe
rm project64_1.6.exe
```

Use the N-Rage input plugin. If the gamepad has two versions (`event` and `js`) use `event`. Disable `raw data`.

---


## [Rsyncrypto 1.14](https://rsyncrypto.lingnu.com/index.php/Home_Page)

```
sudo apt install libargtable2-dev
cd ~/.local/src
wget ...
tar xf rsyncrypto...
cd rsyncrypto...
```

Apply the following patch [from here](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=884721):

```
--- rsyncrypto-1.14.orig/autofd.h
+++ rsyncrypto-1.14/autofd.h
@@ -216,7 +216,7 @@ public:
     // unless it failed with ENOENT - the file already doesn't exist
     static int unlink(const char *pathname)
     {
-        bool success=unlink( pathname )==0;
+        bool success=::unlink( pathname )==0;
         if( !success && errno!=ENOENT )
             throw rscerror("Erasing file", errno, pathname );
```

And then run the following commands:

```
./configure --prefix=/usr/local
make
sudo make install
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


## Schedule the backups

```
sudo apt install flock
crontab -e
```

Add something like:

```
0 */2 * * *  DISPLAY=:0 PATH=$PATH:/usr/local/bin flock --nonblock /path/to/backup.lock /path/to/backup.sh
```

---


## Other stuff

```
sudo apt install openssh-client rsync rdiff-backup
sudo apt install gparted policykit-1-gnome gksu
sudo apt install quodlibet gstreamer1.0-plugins-bad
sudo apt install thunar thunar-media-tags-plugin thunar-volman gvfs-backends thunar-archive-plugin xarchiver p7zip-full zip xz-utils
sudo apt install w3m wget curl viewnior mousepad nano tmux gucharmap git keepassx vlc audacity dunst lxtask filezilla inkscape scribus geogebra meld picard mpv ffmpeg pandoc chromium libreoffice-writer libreoffice-calc sqlitebrowser redland-utils raptor2-utils rasqal-utils sigil gnome-calculator ncdu pavucontrol swi-prolog jstest-gtk
python -m pip install webpage2html
python3 -m pip install youtube-dl
cargo install mdbook
```

And reconnect the dots, in case the installations disconnected any.
