#!/bin/sh
#
#run once:
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# ~/.fzf/install --all

# update
cd ~/.fzf && git pull && ./install --all
sudo cp --verbose ~/.fzf/bin/fzf /usr/bin/
sudo cp --verbose ~/.fzf/bin/fzf-tmux /usr/bin/
