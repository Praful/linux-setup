cd ~/data/dev/open-source/vim

# stash changes, usually just makefile
git stash

# get updates
git pull

#restore changes
git stash pop

cd src

# clean previous build
make distclean
sudo make
sudo make install
