sudo apt install -y git
sudo apt install -y libtool-bin
sudo apt install -y libxt-dev
sudo apt install -y libgtk-3-dev
sudo apt install -y make
sudo apt install -y clang

sudo apt install -y libpython3-dev
sudo apt install -y liblua5.4-dev
sudo apt install -y libperl-dev
sudo apt install -y ruby-dev

mkdir -p ~/data/dev/open-source
cd ~/data/dev/open-source
git clone https://github.com/vim/vim.git
cd vim/src

# Edit file to enable ruby, python, perl, lua dynamic linking
vim Makefile

make reconfig
sudo make install
