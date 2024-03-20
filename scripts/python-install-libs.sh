#/bin/sh

# install pip
python3 -m ensurepip --default-pip
# upgrade pip
python3 -m pip install --upgrade pip

pip install jupyterlab --upgrade
pip install pandas --upgrade
pip install matplotlib --upgrade
pip install scipy --upgrade
pip install numpy --upgrade
pip install statsmodels --upgrade
pip install scikit-learn --upgrade
pip install beautifulsoup4 --upgrade
pip install requests --upgrade
pip install pylint --upgrade
pip install seaborn --upgrade
pip install more-itertools --upgrade
pip install autopep8 --upgrade
# pip install ipython --upgrade
pip install jupyter-console --upgrade
pip install networkx --upgrade

# used by vim coc plugin for refactoring eg extract method
pip install rope --upgrade

pip install ptipython --upgrade

# better version of top
pip install --user 'glances[all]' --upgrade

