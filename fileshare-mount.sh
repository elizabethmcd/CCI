#! /bin/bash

# Mount the fileshare after user privileges are established

apt-get update
apt-get dist-upgrade
yes
apt-get install cifs-utils
Y
mkdir /mcmahon-fileshare
sudo mount -t cifs -o user=emcdaniel,domain=ad.wisc.edu,sec=ntlmssp //bact-mcmahonlab.drive.wisc.edu/mcmahonlab mcmahon-fileshare/

