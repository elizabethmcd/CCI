#! /bin/bash

# Installation shell commands for VM setup

# Moving 3 GB space

/sbin/lvextend --size +3G /dev/mapper/Volume00-home

# Grow home

/sbin/resize2fs /dev/mapper/Volume00-home

# Updates to mount fileshare

apt-get update
apt-get dist-upgrade
apt-get install cifs-utils
mkdir /mcmahon-fileshare
sudo mount -t cifs -o user=emcdaniel,domain=ad.wisc.edu,sec=ntlmssp //bact-mcmahonlab.drive.wisc.edu/mcmahonlab/mcmahon-fileshare

# Make user with sudo privileges and switch to that user for future installations

adduser - emcdaniel
usermod -aG sudo - emcdaniel

# Change to emcdaniel
su - emcdaniel

# Directories in emcdaniel for installations 

cd emcdaniel

# Get installations 
# mapMetasVsRefs github repo with mapping code for BBMap and Samtools
git clone https://github.com/lizilla1993/mapMetasVsRefs.git

# Directories in emcdaniel for installations 
mkdir Ext-Inst Raw-Data Scripts

# Samtools
cd Ext-Inst
sudo apt-get install samtools

## BBMap
# For whatever reason I can't wget, gzip and tar all in one with pipes, so separate commands and get rid of the old .tar file 
sudo wget -N -N https://sourceforge.net/projects/bbmap/files/latest/download/BBMap_37.36.tar.gz
gzip -d BBMap_37.36.tar.gz
tar BBMap_37.36.tar
rm BBMap_37.36.tar

# Python packages - specifically pandas
cd /home
# First need to install pip
sudo apt-get install python3-pip
# pandas
sudo -H pip3 install pandas 

