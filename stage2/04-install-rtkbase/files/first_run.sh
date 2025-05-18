#!/bin/bash

_user="${PWD##*/}"
cd /home/$_user

# Lataa ja valmistele install.sh
wget https://raw.githubusercontent.com/Stefal/rtkbase/master/tools/install.sh
chmod +x install.sh
sed -i 's/df \"$HOME\"/df \//g' install.sh

# Aja järjestelmätason asennukset buildin aikana
./install.sh --user ${_user} --dependencies --rtklib --rtkbase-release --gpsd-chrony

# Varmista, että kaikki skriptit ovat suoritettavia
find ./ -type f -iname "*.sh" -exec chmod +x {} \;
