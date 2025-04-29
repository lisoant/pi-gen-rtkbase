#!/bin/bash
set -e

# Siirry väliaikaiseen hakemistoon
cd /tmp

# Lataa RTKBase asennusskripti
wget https://raw.githubusercontent.com/Stefal/rtkbase/master/tools/install.sh -O install.sh
chmod +x install.sh

# Pieni korjaus install.sh tiedostoon
sed -i 's/df \"$HOME\"/df \//g' install.sh

# Suorita virallinen täydellinen järjestelmätason asennus
sudo ./install.sh --all release

# Siivotaan väliaikaiset tiedostot
rm -f install.sh
