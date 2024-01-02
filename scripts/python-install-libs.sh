#/bin/sh

# install pip
python3 -m ensurepip --default-pip
# upgrade pip
python3 -m pip install --upgrade pip

pip install jupyterlab
pip install pandas
pip install matplotlib
pip install scipy
pip install numpy
pip install statsmodels
pip install scikit-learn
pip install beautifulsoup4
pip install requests
pip install pylint
pip install seaborn

pip install autopep8
# pip install ipython
pip install jupyter-console

# better version of top
pip install --user 'glances[all]'
