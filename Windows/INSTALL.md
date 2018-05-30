# Windows

_These are some notes on how to setup the author's system. These aren't expected to be useful to anyone else._

Generally follow the Linux section, adapting it for Windows. Also install:

- 7zip
- fastpictureviewer codec pack
- link shell extension
- ext2fsd
- steam
- malwarebytes
- internet explorer 11 + edge
- [chromium](https://download-chromium.appspot.com/)
- renamemaestro
- svg explorer extension

## mingw and unxutils

Install unxutils to `%AppData%\Local\bin`. Next time, remember to change all references to `~/local` in `init.vim`.

Add both of these to the user's PATH, with unxutils at the bottom of the list so it is the least priority.

Move git's stuff to the top of the system's PATH, so its `find` command overrides Windows'.

## Pins

- firefox
- thunderbird
- neovim-qt
- vlc
- quod libet
- keepassx
- git's terminal
- explorer
