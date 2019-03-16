# install

_These are some notes on how to install the author's system. These aren't expected to be useful to anyone else._

- Install Debian's minimal version ([the one that includes non-free firmware](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/), if necessary)
- Select nothing at the software selection menu
- Partition:
    - A swap partition; 1.5 * RAM
    - A ~10gb ext4 partition for /
    - An ext3 partition for ~, using the remaining space


## update

```
su
apt-get update
apt-get upgrade
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
coreutils
w3m
wget
curl
nano
ncdu
ffmpeg
sqlite3
git
zip
unzip
xz-utils
pandoc
openssh-client
shellcheck
cloc

### graphical applications
vlc
firefox-esr
viewnior
mousepad
gucharmap
keepassx
audacity
lxtask
inkscape
hexchat
filezilla
transmission
meld
picard
chromium
sqlitebrowser
sigil
gnome-calculator
pavucontrol
gparted
geogebra

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
rdiff-backup

### for the local scripts
maim
xdotool
xclip
jshon
pm-utils
pulseaudio-utils
alsa-utils
gksu

### for the startup script
compton
hsetroot
redshift
xbacklight
x11-xserver-utils
pulseaudio

### for st and dmenu
libx11-dev
libxinerama-dev
libxft-dev

### other
fontconfig
cron


## pip

```
python[3] -m pip install --user --upgrade [name]
```

### pip2

webpage2html

### pip3

youtube-dl
flake8
flake8-bugbear
flake8-docstrings


## neovim

```
cd ~/.local/src
git clone "https://github.com/neovim/neovim"
cd neovim

sudo apt install libtool-bin
make CMAKE_EXTRA_FLAGS=-DCMAKE_INSTALL_PREFIX="$HOME/.local"
make install
cd ~/temp

python -m pip install --user --upgrade neovim
python3 -m pip install --user --upgrade neovim

~/system/home/.local/bin/connect-dots \
   --without-suckless --without-fonts --without-root
```

Launch `nvim` and let it install the plugins, then run `:Obsess ~/.vim-session` and exit, ignoring any errors.


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

rustup component add clippy
rustup component add rustfmt

sudo apt install musl-tools
rustup target add x86_64-unknown-linux-musl

sudo apt install rust-lldb
sudo apt install valgrind

cargo install --force evcxr_repl
cargo install --force cargo-deadlinks
cargo install --force cargo-watch
cargo install --force cargo-fuzz
cargo install --force cargo-bloat
cargo install --force cargo-profiler
cargo +nightly install --force cargo-expand
cargo +nightly install --force cargo-modules

sudo apt install libssl-dev
cargo install --force cargo-audit

sudo apt install libssl-dev
cargo install --force cargo-tree

sudo apt install libssl-dev
cqrgo install --force --git https://github.com/kbknapp/cargo-outdated

sudo apt install libssl-dev zlib1g-dev
RUSTFLAGS='--cfg procmacro2_semver_exempt' cargo +nightly install --force cargo-tarpaulin

sudo apt install libssl-dev libssh2-1-dev libgit2-dev
cargo install --force cargo-update

# cargo install --force cargo-release
# cargo install --force cargo-make
# cargo install --force cargo-script
# cargo install --force cargo-deb

# sudo apt install libssl-dev
# cargo install --force cargo-cook
```


## ctags

```
cd ~/.local/src
git clone https://github.com/universal-ctags/ctags
cd ctags

./autogen.sh
./configure --prefix="$HOME/.local"
make
make install
cd ~/temp
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
python3 -m pip install --user --upgrade notify2

cd ~/.local/src
git clone https://github.com/phuhl/notify-send.py
cd notify-send.py

python3 setup.py install --user --force
cd ~/temp
```


## jupyter

```
sudo apt install libzmq3-dev
sudo apt install jupyter-core
sudo apt install jupyter-client
sudo apt install jupyter-notebook
sudo apt install jupyter-qtconsole

cargo install --force evcxr_jupyter
evcxr_jupyter --install

npm install -g ijavascript --zmq-external
ijsinstall
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
cd ~/temp

# sudo apt install gimp-help-en
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

- `https://datapacket.dl.sourceforge.net/project/djv/djv-stable/1.2.5/DJV_1.2.5_amd64.deb`
- `https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb`
- `https://github.com/sharkdp/fd/releases/download/v7.2.0/fd_7.2.0_amd64.deb`


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
connect-dots --with-interfaces
```


## restart

```
rmdir ~/temp
sudo shutdown -r now
```


## setup

### browsers

Install the following addons for firefox, firefox-dev (minus epubreader), and chromium (where relevant):

- EPUBReader
- uBlock Origin
    - the default lists
    - Adguard's Annoyance List (it blocks more cookie warnings, like those on serverfault.com)
- NoScript (allow scripts globally, just use it for the other stuff)
- HTTPS Everywhere
- Privacy Badger
- Open Image in New Tab (bedstash)
- Maximizer for YouTube
- Vue.js devtools

`ln -s ~/.mozilla/firefox/user.js ~/.mozilla/firefox/[profile]/user.js`


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
