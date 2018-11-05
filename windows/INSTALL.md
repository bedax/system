# Windows

_These are some notes on how to setup the author's system. These aren't expected to be useful to anyone else._

Install:

- 7zip
- [chromium](https://download-chromium.appspot.com/)
- ext2read
- fastpictureviewer codec pack
- firefox
- firefox dev
- geany
- git
- internet explorer 11 + edge
- keepassx
- link shell extension
- malwarebytes
- meld
- nodejs
- python3
- quod libet
- steam
- svg explorer extension
- vlc


## mingw and unxutils

Copy unxutils to `%AppData%\Local\bin`. Next time, change all references to `~/local` in `init.vim`.

Add the above paths to the user's PATH, with unxutils at the bottom of the list so it has the least priority. Move git's paths to the top of the system's PATH, so its `find` command overrides Windows'.


## Pins

- firefox
- geany
- vlc
- quod libet
- keepassx
- git's terminal
- explorer
