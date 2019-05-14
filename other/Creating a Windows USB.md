# Start

```
sudo apt update
sudo apt install gdebi
```


# Build

Download from: https://github.com/slacka/WoeUSB/releases

```
sudo gdebi woeusb-build-deps_<version>_<architecture>.deb

sudo apt install git
git clone https://github.com/slacka/WoeUSB.git
cd WoeUSB/
./setup-development-environment.bash
dpkg-buildpackage -uc -b # NOTE: Currently, due to a bug in the build system, this command will fail if the source's path contains space or single quotes, refer to issue #84 for details

sudo gdebi ../woeusb_<version>_<architecture>.deb
```


# Run

First format the target drive as NTFS, then run:

```
sudo apt install grub2
woeusbgui
```
