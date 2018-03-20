# Start

```
sudo apt update
sudo apt install gdebi
```


# If not built

```
sudo gdebi woeusb-build-deps_<version>_<architecture>.deb # downloaded from: https://github.com/slacka/WoeUSB/releases

sudo apt install git
git clone https://github.com/slacka/WoeUSB.git
cd WoeUSB/
./setup-development-environment.bash
dpkg-buildpackage -uc -b # NOTE: Currently, due to a bug in the build system, this command will fail if the source's path contains space or single quotes, refer to issue #84 for details
```


# If built

```
sudo gdebi ../woeusb_<version>_<architecture>.deb
```


# Run WoeUSB

First format the target drive as NTFS.

Then run:

```
sudo apt install grub2
woeusbgui
```
