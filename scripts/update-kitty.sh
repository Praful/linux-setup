#!/bin/sh
#
# installs or updates into ~/.local/kitty.app/
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin
ln -s ~/.local/kitty.app/bin/kitten ~/.local/bin
