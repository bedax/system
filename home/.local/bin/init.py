#!/usr/bin/env python3

import os
import shutil
import socket
import subprocess
import sys
import tempfile

# .mozilla/firefox/user.js



SCRIPT_PATH = os.path.realpath(__file__)


def fail(message):
   print("error: {}".format(message), file=sys.stderr)
   sys.exit(1)


def command(line, shell=False, check=True, directory=None, env=None,
            stdin=None, stdout=True, stderr=False, strip=True):

   stdin = None if stdin is None else stdin.encode("utf-8")
   stdout = subprocess.PIPE if stdout else None
   stderr = subprocess.PIPE if stderr else None
   env = None if env is None else {**os.environ, **env}

   process = subprocess.run(
      line,
      shell=shell,
      input=stdin,
      stdout=stdout,
      stderr=stderr,
      cwd=directory,
      env=env
   )

   if check and process.returncode != 0:
      fail("the following command failed: {line} [{code}]".format(
         code=process.returncode,
         line=line
      ))

   if stdout is not None:
      output = process.stdout.decode("utf-8")
      output = output.strip() if strip else output
   else:
      output = None

   return output


def shell_command(line, **kwargs):
   return command(line, shell=True, **kwargs)


def profile_path():
   system_bin_dir = os.path.dirname(SCRIPT_PATH)

   return os.path.normpath(os.path.join(system_bin_dir, "../../.profile"))


def local_path():
   user = given_user() if uid() == 0 else os.environ["USER"]

   return os.path.join("/home", user, ".local")


def local_src_path():
   return os.path.join(local_path(), "src")


def local_bin_path():
   return os.path.join(local_path(), "bin")


def local_opt_path():
   return os.path.join(local_path(), "opt")


# from: https://stackoverflow.com/a/33117579
def connected():
   try:
      sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
      sock.connect(("8.8.8.8", 53))
   except Exception:
      return False
   else:
      return True


def test_connection():
   if not connected():
      fail("not connected")


def restart():
   print("\nthe computer will now restart")
   input("press enter to continue (or ctrl+c to cancel) ")

   command(["sudo", "shutdown", "-r", "now"])


def uid():
   return int(command(["id", "-u"]))


def given_user():
   if len(sys.argv) > 1:
      return sys.argv[1]
   else:
      fail("USAGE {} USER_NAME".format(sys.argv[0]))


def rerun_as_given_user():
   line = "su - {} -c '. {}; python3 {}'".format(
      given_user(),
      profile_path(),
      SCRIPT_PATH
   )

   shell_command(line, check=False, stdout=False)


def append_line_to_file(path, line, sudo=False):
   line = "echo '{}' >> '{}'".format(line, path)

   if sudo:
      line = "sudo -S su -c \"{}\"".format(line)

   shell_command(line)


def string_contains_line(string, line):
   return line in string.splitlines()


def file_name_from_link(link):
   return link.rsplit("/", 1)[-1]


def acquire_sudo_session():
   command(["sudo", "-S", "echo"], stdout=False)


def make_directory(path):
   command(["mkdir", "--parents", path])


def make_directories():
   make_directory(local_src_path())
   make_directory(local_bin_path())
   make_directory(local_opt_path())


def connect_dots(interfaces=False, suckless=True, fonts=True, root=True):
   line = ["connect-dots"]

   if interfaces:
      line.push("--with-interfaces")

   if not suckless:
      line.push("--without-suckless")

   if not fonts:
      line.push("--without-fonts")

   if not root:
      line.push("--without-root")

   command(line, stdout=(not root))


def write_crontab_line(timing, command):
   current_crontab = shell_command('crontab -u "$USER" -l', strip=False)
   new_line = '{}  . "$HOME/.profile"; DISPLAY=:0  {}'.format(timing, command)

   if not string_contains_line(current_crontab, new_line):
      new_crontab = "{}\n{}\n".format(current_crontab, new_line)
      shell_command('crontab -u "$USER" -', stdin=new_crontab)


def write_crontab():
   write_crontab_line("*/3 * * * *", "notify-if-battery-low 12 6")
   # write_...("0 */2 * * *", 'flock --nonblock "$HOME/.backup.lock" backup')


def write_sudoers_line(line):
   current_sudoers = command(["sudo", "cat", "/etc/sudoers"], strip=False)

   if not string_contains_line(current_sudoers, line):
      append_line_to_file("/etc/sudoers", line, sudo=True)


def write_sudoers():
   command(["sudo", "addgroup", "demi"], check=False)
   command(["sudo", "adduser", os.environ["USER"], "demi"])

   write_sudoers_line("%demi ALL=NOPASSWD:/sbin/shutdown")
   write_sudoers_line("%demi ALL=NOPASSWD:/usr/sbin/pm-suspend")
   write_sudoers_line("%demi ALL=NOPASSWD:/usr/sbin/pm-suspend-hybrid")
   write_sudoers_line("%demi ALL=NOPASSWD:/usr/sbin/pm-hibernate")


def configure_and_make(directory):
   configure_path = os.path.join(directory, "configure")
   configure_command = "{} --prefix='{}'".format(configure_path, local_path())
   shell_command(configure_command, directory=directory)
   command(["make"], directory=directory)
   command(["make", "install"], directory=directory)


def download_binary(link, extracted_name, opt_name,
                    opt_bin_name, bin_name, extra_links=None):

   archive_name = file_name_from_link(link)
   symlinks = [(opt_bin_name, bin_name)]

   command(["wget", link])
   command(["tar", "xf", archive_name])
   command(["rm", "-f", archive_name])
   command(["mv", extracted_name, os.path.join(local_opt_path(), opt_name)])

   if extra_links is not None:
      for extra_link in extra_links:
         symlinks.push(extra_link)

   for symlink_target_name, symlink_path_name in symlinks:
      target = os.path.join(local_opt_path(), opt_name, symlink_target_name)
      path = os.path.join(local_bin_path(), symlink_path_name)
      command(["ln", "-s", target, path])


def download_source(link):
   archive_name = file_name_from_link(link)
   src_name = archive_name.rsplit(".", 2)[0]
   src_path = os.path.join(local_src_path(), src_name)

   command(["wget", link])
   command(["tar", "xf", archive_name])
   command(["rm", "-f", archive_name])

   command(["rm", "-rf", src_path])
   command(["mv", src_name, local_src_path()])

   return src_path


def git_clone(link, to_src=True):
   name = link.rstrip("/").rsplit(".git", 1)[0].rsplit("/", 1)[-1]

   if to_src:
      clone_parent_directory = local_src_path()
      clone_directory = os.path.join(clone_parent_directory, name)
   else:
      clone_parent_directory = None
      clone_directory = os.path.join(os.getcwd(), name)

   command(["git", "clone", link], directory=clone_parent_directory)

   return clone_directory


def update_and_upgrade(sudo=False):
   update_command = ["apt-get", "update"]
   upgrade_command = ["apt-get", "upgrade", "--yes"]

   if sudo:
      update_command.insert(0, "sudo")
      upgrade_command.insert(0, "sudo")

   command(update_command)
   command(upgrade_command)


def add_apt_key(link):
   command(["wget", link, "-O", "Release.key"])
   command(["sudo", "apt-key", "add", "Release.key"])
   command(["rm", "-f", "Release.key"])


def add_apt_source(link, distribution, *components):
   apt_line = "deb {} {} {}".format(link, distribution, " ".join(components))
   append_line_to_file("/etc/apt/sources.list", apt_line, sudo=True)
   command(["sudo", "apt-get", "update"])


def install_apt_package(name, sudo=True, recommends=False):
   line = ["apt-get", "install", "--yes", name]
   env = {"DEBIAN_FRONTEND": "noninteractive"}

   if sudo:
      line.insert(0, "sudo")

   if recommends:
      line.insert(-1, "--install-recommends")

   command(line, env=env, stderr=True)


def install_deb_package(link):
   command(["wget", link, "-O", "downloaded.deb"])
   command(["sudo", "gdebi", "--non-interactive", "--quiet", "downloaded.deb"])
   command(["rm", "-f", "downloaded.deb"])


def install_cargo_package(name, git=False, nightly=False, prefix=None):
   shell_command("{} cargo {} install --force {} {}".format(
      prefix if prefix is not None else "",
      "+nightly" if nightly else "",
      "--git" if git else "",
      name
   ))


def install_pip_package(python, name):
   command([python, "-m", "pip", "install", "--user", "--upgrade", name])


def install_pip2_package(name):
   install_pip_package("python", name)


def install_pip3_package(name):
   install_pip_package("python3", name)


def install_npm_package(name, *args):
   command(["npm", "install", "-g", name, *args])


def install_appimage(name, link, file_name=None):
   file_name = file_name_from_link(link) if file_name is None else file_name
   symlink_target = os.path.join(local_opt_path(), file_name)
   symlink_path = os.path.join(local_bin_path(), name)

   command(["wget", link, "-O", file_name])
   command(["chmod", "+x", file_name])

   command(["rm", "-f", symlink_target])
   command(["rm", "-f", symlink_path])

   command(["mv", file_name, local_opt_path()])
   command(["ln", "-s", symlink_target, symlink_path])


def install_sudo():
   install_apt_package("sudo", sudo=False)
   command(["adduser", given_user(), "sudo"])


def install_apt_packages():
   # package manager stuff
   install_apt_package("gdebi")
   install_apt_package("apt-file")

   # build tools
   install_apt_package("build-essential")
   install_apt_package("pkg-config")
   install_apt_package("cmake")

   # python and its package manager
   install_apt_package("python")
   install_apt_package("python-pip")
   install_apt_package("python3")
   install_apt_package("python3-pip")

   # various command line utilities
   install_apt_package("coreutils")
   install_apt_package("w3m")
   install_apt_package("wget")
   install_apt_package("curl")
   install_apt_package("nano")
   install_apt_package("ncdu")
   install_apt_package("ffmpeg")
   install_apt_package("sqlite3")
   install_apt_package("git")
   install_apt_package("zip")
   install_apt_package("unzip")
   install_apt_package("xz-utils")
   install_apt_package("pandoc")
   install_apt_package("openssh-client")
   install_apt_package("shellcheck")
   install_apt_package("cloc")

   # scheduled stuff
   install_apt_package("cron")
   install_apt_package("acpi")

   # window manager stuff
   install_apt_package("xinit")
   install_apt_package("x11-utils")
   install_apt_package("xserver-xorg-video-intel")
   install_apt_package("bspwm")
   install_apt_package("sxhkd")
   install_apt_package("dunst")

   # appearance stuff
   install_apt_package("adwaita-qt")
   install_apt_package("adwaita-qt4")
   install_apt_package("adwaita-icon-theme")
   install_apt_package("gnome-themes-standard")
   install_apt_package("qt4-qtconfig")

   # backup stuff
   install_apt_package("rsync")
   install_apt_package("rdiff-backup")

   # quodlibet stuff
   install_apt_package("quodlibet")
   install_apt_package("gstreamer1.0-plugins-bad")

   # thunar stuff
   install_apt_package("thunar")
   install_apt_package("thunar-media-tags-plugin")
   install_apt_package("thunar-volman")
   install_apt_package("gvfs-backends")
   install_apt_package("thunar-archive-plugin")
   install_apt_package("xarchiver")
   install_apt_package("p7zip-full")

   # various graphical applications
   install_apt_package("vlc")
   install_apt_package("firefox-esr")
   install_apt_package("viewnior")
   install_apt_package("mousepad")
   install_apt_package("gucharmap")
   install_apt_package("keepassx")
   install_apt_package("audacity")
   install_apt_package("lxtask")
   install_apt_package("inkscape")
   install_apt_package("filezilla")
   install_apt_package("meld")
   install_apt_package("picard")
   install_apt_package("chromium")
   install_apt_package("sqlitebrowser")
   install_apt_package("sigil")
   install_apt_package("gnome-calculator")
   install_apt_package("pavucontrol")
   install_apt_package("gparted")
   install_apt_package("geogebra")

   # for the local scripts
   install_apt_package("maim")
   install_apt_package("xdotool")
   install_apt_package("xclip")
   install_apt_package("pm-utils")
   install_apt_package("pulseaudio-utils")
   install_apt_package("alsa-utils")
   install_apt_package("gksu")

   # for the startup script
   install_apt_package("compton")
   install_apt_package("hsetroot")
   install_apt_package("redshift")
   install_apt_package("xbacklight")
   install_apt_package("pulseaudio")

   # for st and dmenu
   install_apt_package("libx11-dev")
   install_apt_package("libxinerama-dev")
   install_apt_package("libxft-dev")


def install_pip_packages():
   install_pip2_package("webpage2html")
   install_pip3_package("youtube-dl")
   install_pip3_package("flake8")
   install_pip3_package("flake8-bugbear")
   install_pip3_package("flake8-docstrings")


def install_fish():
   add_apt_key("https://download.opensuse.org/repositories/shells:fish:release:2/Debian_9.0/Release.key")

   add_apt_source("http://download.opensuse.org/repositories/shells:/fish:/release:/2/Debian_9.0/", "/")

   install_apt_package("fish")

   fisher_link = "https://git.io/fisher"
   fisher_path = os.path.expanduser("~/.config/fish/functions/fisher.fish")
   command(["curl", "-Lo", fisher_path, "--create-dirs", fisher_link])

   shell_command("fish -c 'fisher fischerling/plugin-wd'")
   shell_command("fish -c 'fisher oh-my-fish/plugin-pbcopy'")
   # shell_command("fish -c 'fisher externl/fish-symnav'")


def install_rust():
   shell_command("curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y")
   command(["rustup", "install", "nightly"])

   command(["rustup", "component", "add", "clippy"])
   command(["rustup", "component", "add", "rustfmt"])

   install_apt_package("musl-tools")
   command(["rustup", "target", "add", "x86_64-unknown-linux-musl"])

   install_apt_package("rust-lldb")
   install_apt_package("valgrind")

   install_cargo_package("evcxr_repl")
   install_cargo_package("cargo-deadlinks")
   install_cargo_package("cargo-watch")
   install_cargo_package("cargo-fuzz")
   install_cargo_package("cargo-bloat")
   install_cargo_package("cargo-profiler")
   install_cargo_package("cargo-audit")

   install_cargo_package("https://github.com/kbknapp/cargo-outdated", git=True)

   install_cargo_package("cargo-modules", nightly=True)

   # install_cargo_package("cargo-release")
   # install_cargo_package("cargo-cook")
   # install_cargo_package("cargo-make")
   # install_cargo_package("cargo-script")
   # install_cargo_package("cargo-deb")

   install_pip3_package("Pygments")
   install_cargo_package("cargo-expand", nightly=True)

   install_apt_package("libssl-dev")
   install_cargo_package("cargo-tree")

   install_apt_package("libssl-dev")
   install_apt_package("zlib1g-dev")
   install_cargo_package(
      "cargo-tarpaulin",
      prefix="RUSTFLAGS='--cfg procmacro2_semver_exempt'",
      nightly=True
   )

   install_apt_package("libgit2-dev")
   install_apt_package("libssh2-1-dev")
   install_apt_package("libssl-dev")
   install_cargo_package("cargo-update")


def install_cargo_packages():
   install_cargo_package("mdbook")


def install_ctags():
   source_directory = git_clone("https://github.com/universal-ctags/ctags")
   autogen_path = os.path.join(source_directory, "autogen.sh")
   command([autogen_path], directory=source_directory)
   configure_and_make(source_directory)


def install_node():
   shell_command("curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -")

   install_apt_package("nodejs")

   command(["npm", "config", "set", "prefix", local_path()])
   install_npm_package("npm-check")


def install_npm_packages():
   install_npm_package("parcel-bundler")


def install_neovim():
   source_directory = git_clone("https://github.com/neovim/neovim")

   make_prefix_flag = "-DCMAKE_INSTALL_PREFIX={}".format(local_path())
   make_flags = "CMAKE_EXTRA_FLAGS='{}'".format(make_prefix_flag)
   make_command = "make CMAKE_BUILD_TYPE=RelWithDebInfo {}".format(make_flags)
   shell_command(make_command, directory=source_directory)
   command(["make", "install"], directory=source_directory)

   install_pip2_package("neovim")
   install_pip3_package("neovim")


def install_notify_send_py():
   install_pip3_package("notify2")
   source_directory = git_clone("https://github.com/phuhl/notify-send.py")
   command_line = ["python3", "setup.py", "install", "--force", "--user"]
   command(command_line, directory=source_directory)


def install_virtualbox():
   apt_source_link = "http://ftp.debian.org/debian"
   add_apt_source(apt_source_link, "stretch-backports", "main", "contrib")
   install_apt_package("virtualbox")


def install_samba():
   install_apt_package("samba")
   command(["sudo", "smbpasswd", "-a", os.environ["USER"]])


def install_gimp():
   install_appimage("gimp", "https://github.com/aferrero2707/gimp-appimage/releases/download/continuous/GIMP_AppImage-release-2.10.8-withplugins-x86_64.AppImage")

   # install_apt_package("gimp-help-en")


def install_retroarch_core(core_name):
   archive_name = "{}.zip".format(core_name)
   link_base = "https://buildbot.libretro.com/nightly/linux/x86_64/latest/"
   link = "{}{}".format(link_base, archive_name)

   command(["wget", link])
   command(["unzip", archive_name])
   command(["rm", "-f", archive_name])

   command(["mv", core_name, os.expanduser("~/.config/retroarch/cores/")])


def install_retroarch_cores():
   make_directory(os.expanduser("~/.config/retroarch/cores"))
   make_directory(os.expanduser("~/.config/retroarch/system"))

   install_retroarch_core("mednafen_psx_libretro.so")
   install_retroarch_core("snes9x_libretro.so")
   install_retroarch_core("ppsspp_libretro.so")

   ppsspp_system_path = os.expanduser("~/.config/retroarch/system/PPSSPP")
   git_clone("https://github.com/hrydgard/ppsspp", to_src=False)
   command(["mv", "ppsspp/assets", ppsspp_system_path])
   command(["rm", "-rf", "ppsspp"])


def install_retroarch_assets():
   assets_directory = os.expanduser("~/.config/retroarch/assets")
   make_directory(assets_directory)

   assets_link = "http://buildbot.libretro.com/assets/frontend/assets.zip"
   command(["wget", assets_link], directory=assets_directory)
   command(["unzip", "assets.zip"], directory=assets_directory)
   command(["rm", "-f", "assets.zip"], directory=assets_directory)


def install_retroarch():
   appimage_link = "https://bintray.com/probono/AppImages/download_file?file_path=RetroArch-1.5.0.glibc2.17-x86_64.AppImage"

   appimage_name = appimage_link.rsplit("=", 1)[-1]
   install_appimage("retroarch", appimage_link, file_name=appimage_name)

   install_retroarch_cores()
   install_retroarch_assets()


def install_wine():
   command(["sudo", "dpkg", "--add-architecture", "i386"])
   add_apt_key("https://dl.winehq.org/wine-builds/Release.key")
   apt_source_link = "https://dl.winehq.org/wine-builds/debian/"
   add_apt_source(apt_source_link, "stable", "main")
   install_apt_package("winehq-stable", recommends=True)


def install_rsyncrypto():
   source_directory = download_source("https://netcologne.dl.sourceforge.net/project/rsyncrypto/rsyncrypto/1.14/rsyncrypto-1.14.tar.bz2")

   connect_dots(interfaces=False, suckless=False, fonts=False, root=False)
   install_apt_package("libargtable2-dev")
   configure_and_make(source_directory)


def install_firefox_dev():
   download_binary(
      link="https://download-installer.cdn.mozilla.net/pub/devedition/releases/66.0b2/linux-x86_64/en-GB/firefox-66.0b2.tar.bz2",

      extracted_name="firefox",
      opt_name="firefox-dev",
      opt_bin_name="firefox",
      bin_name="firefox-dev"
   )


def install_thunderbird():
   download_binary(
      link="https://download-installer.cdn.mozilla.net/pub/thunderbird/releases/60.4.0/linux-x86_64/en-GB/thunderbird-60.4.0.tar.bz2",

      extracted_name="thunderbird",
      opt_name="thunderbird",
      opt_bin_name="thunderbird",
      bin_name="thunderbird"
   )


def install_blender():
   install_apt_package("libglu1-mesa")

   download_binary(
      link="https://mirrors.dotsrc.org/blender/blender-release/Blender2.79/blender-2.79b-linux-glibc219-x86_64.tar.bz2",

      extracted_name="blender-2.79b-linux-glibc219-x86_64",
      opt_name="blender-2.79b",
      opt_bin_name="blender",
      bin_name="blender"
   )


def install_protege():
   download_binary(
      link="https://github.com/protegeproject/protege-distribution/releases/download/v5.5.0-beta-8/Protege-5.5.0-beta-8-linux.tar.gz",

      extracted_name="Protege-5.5.0-beta-8",
      opt_name="protege-5.5.0-beta-8",
      opt_bin_name="run.sh",
      bin_name="protege"
   )


def install_openmw():
   download_binary(
      link="https://downloads.openmw.org/linux/other/openmw-0.44.0-Linux-64Bit.tar.gz",

      extracted_name="openmw-0.44.0-Linux-64Bit",
      opt_name="openmw-0.44.0",
      opt_bin_name="openmw-launcher",
      bin_name="openmw-launcher",
      extra_links=[("openmw-wizard", "openmw-wizard")]
   )


def install_djv():
   install_deb_package("https://datapacket.dl.sourceforge.net/project/djv/djv-stable/1.2.5/DJV_1.2.5_amd64.deb")


def install_ripgrep():
   install_deb_package("https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb")


def install_fd():
   install_deb_package("https://github.com/sharkdp/fd/releases/download/v7.2.0/fd_7.2.0_amd64.deb")


def install_project64():
   command(["wget", "http://www.emulator-zone.com/download.php/emulators/n64/project64/project64_1.6.exe"])

   command(["wine", "project64_1.6.exe"])
   command(["rm", "-f", "project64_1.6.exe"])


def install_jupyter():
   install_apt_package("libzmq3-dev")
   install_apt_package("jupyter-core")
   install_apt_package("jupyter-client")
   install_apt_package("jupyter-notebook")
   install_apt_package("jupyter-qtconsole")

   install_cargo_package("evcxr_jupyter")
   command(["evcxr_jupyter", "--install"])

   install_npm_package("ijavascript", "--zmq-external")
   command(["ijsinstall"])


def download_suckless():
   download_source("https://dl.suckless.org/st/st-0.7.tar.gz")
   download_source("https://dl.suckless.org/st/st-0.8.1.tar.gz")
   download_source("https://dl.suckless.org/tools/dmenu-4.8.tar.gz")


def install_packages():
   install_apt_packages()
   install_pip_packages()
   install_fish()
   install_rust()
   install_cargo_packages()
   install_node()
   install_npm_packages()
   install_ctags()
   install_neovim()
   install_notify_send_py()
   install_virtualbox()
   install_gimp()
   install_firefox_dev()
   install_blender()
   install_openmw()
   install_rsyncrypto()
   install_djv()
   install_ripgrep()
   install_fd()
   install_retroarch()
   install_jupyter()
   download_suckless()

   # install_samba()
   # install_wine()
   # install_project64()
   # install_thunderbird()
   # install_protege()


def run_stage_1():
   if uid() != 0:
      fail("this needs to be run as root")

   test_connection()
   update_and_upgrade()
   install_sudo()


def run_stage_2():
   if uid() == 0:
      fail("this needs to be run as the normal user")

   test_connection()
   acquire_sudo_session()
   update_and_upgrade(sudo=True)
   make_directories()
   install_packages()
   write_sudoers()
   write_crontab()
   connect_dots(interfaces=True)
   restart()


def run():
   with tempfile.TemporaryDirectory(prefix="system-init.py-") as temp_path:
      initial_directory = os.getcwd()
      os.chdir(temp_path)

      if shutil.which("sudo") is None:
         run_stage_1()

      if uid() == 0:
         rerun_as_given_user()
      else:
         run_stage_2()

      os.chdir(initial_directory)



if __name__ == "__main__":
   run()
