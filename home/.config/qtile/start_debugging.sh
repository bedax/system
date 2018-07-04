#!/bin/sh

# from ArchWiki/Qtile

echo "exec ~/.local/bin/qtile" > /tmp/.start_qtile
xinit /tmp/.start_qtile -- :2
