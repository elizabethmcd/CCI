#! /bin/bash

# Mount the fileshare after user privileges are established

apt-get update
apt-get dist-upgrade
apt-get install cifs-utils
mkdir /mcmahon-fileshare
sudo mount -t cifs -o user=emcdaniel,domain=ad.wisc.edu,sec=ntlmssp //bact-mcmahonlab.drive.wisc.edu/mcmahonlab mcmahon-fileshare/

# put it in the home directory of the home user with their sudo privileges so it's easily accessed for other folders there. 

