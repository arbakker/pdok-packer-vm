#!/bin/bash -eux

export DEBIAN_FRONTEND="noninteractive"

# Update the box

sudo add-apt-repository ppa:ubuntugis/ppa
sudo apt-get update -qq > /dev/null
sudo apt-get dist-upgrade -qq -y > /dev/null
sudo apt-get install -y qgis nodejs npm unzip snap curl vim
sudo snap install --classic code

curl -L "https://plugins.qgis.org/plugins/pdokservicesplugin/version/3.4.4/download/" -o /tmp/pdok.zip
mkdir -p /home/vagrant/.local/share/QGIS/QGIS3/profiles/default/python/plugins/
unzip /tmp/pdok.zip -d  /home/vagrant/.local/share/QGIS/QGIS3/profiles/default/python/plugins/

echo "from PyQt5.QtCore import QSettings" > /home/vagrant/.local/share/QGIS/QGIS3/startup.py
echo "QSettings().setValue( 'PythonPlugins/' + 'pdokservicesplugin', True )" >> /home/vagrant/.local/share/QGIS/QGIS3/startup.py

curl -O -L https://github.com/t-rex-tileserver/t-rex/releases/download/v0.10.0/t-rex-v0.10.0-x86_64-unknown-linux-gnu.deb && sudo dpkg -i t-rex-v0.10.0-x86_64-unknown-linux-gnu.deb
sudo echo 'pref("browser.startup.homepage", "https://www.pdok.nl/");' >> /usr/lib/firefox/browser/defaults/preferences/all-users.js

sudo -u vagrant dbus-launch gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'org.qgis.qgis.desktop', 'code_code.desktop']"
mkdir -p /home/vagrant/workshop
sudo chown -R vagrant:vagrant /home/vagrant

