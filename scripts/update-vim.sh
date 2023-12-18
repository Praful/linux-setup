#!/usr/bin/env bash
#
pushd $DATA/dev/open-source/vim

# discard local changes since we have only one, which is backed up
git reset --hard

# stash changes, usually just makefile
# git stash

# get updates
git pull

cd src

# restore backed up file
cp $DATA/dev/projects/vim-config/Makefile.pk ./Makefile

#restore changes
# git stash pop


# clean previous build
sudo make distclean
sudo make
sudo make install

popd
