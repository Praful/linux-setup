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

mkdir -p $DATA/dev/open-source
push $DATA/dev/open-source
git clone https://github.com/vim/vim.git
popd

source ./update-vim.sh
