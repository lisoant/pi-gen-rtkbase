#!/bin/bash

cd /home/gnssbs/rtkbase/tools && \
sudo ./install.sh --user gnssbs --unit-files --detect-modem --detect-gnss --configure-gnss --start-services

# Poista palvelu itsensä jälkeen
sudo rm /lib/systemd/system/firstboot.service
