#! /bin/bash

# Installations for VM setup
# Run this AFTER the user privileges have been setup, fileshare has been mounted as root, and home directory has been grown as root as well


# Make sure you are in your home directory to make these directories and unpack everything there

# Get installations 
# mapMetasVsRefs github repo with mapping code for BBMap and Samtools
sudo apt-get install git
git clone https://github.com/lizilla1993/mapMetasVsRefs.git

# Directories in emcdaniel for installations and other things
mkdir Ext-Inst Raw-Data Scripts

# Samtools
cd Ext-Inst
sudo apt-get install samtools
# Doesn't actually put it in this folder - it's in the bin with apt-get install

# BBMap
sudo wget -N -N https://sourceforge.net/projects/bbmap/files/latest/download/BBMap_37.36.tar.gz
tar -xvzf BBMap_37.36.tar.gz
rm BBMap_37.36.tar.gz

# hmmer
sudo wget http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2-linux-intel-x86_64.tar.gz
tar -xvzf hmmer-3.1b2-linux-intel-x86_64.tar.gz
rm hmmer-3.1b2-linux-intel-x86_64.tar.gz
cd hmmer-3.1b2-linux-intel-x86_64
./configure && make && sudo make install
cd ..

# MCL
sudo wget http://www.micans.org/mcl/src/mcl-latest.tar.gz
tar -zxvf mcl-latest.tar.gz && cd mcl-14-137
./configure && make && sudo make install
cd ..
rm mcl-latest.tar.gz

# Things for anvi'o 

# Prodigal
wget https://github.com/hyattpd/Prodigal/archive/v2.6.2.tar.gz
tar -zxvf v2.6.2.tar.gz && cd Prodigal-2.6.2/ && make
sudo cp prodigal /usr/local/bin/
cd ..
rm v2.6.2.tar.gz

# SQLite 3
sudo apt-get install sqlite3

# GNU Scientific Library

wget ftp://ftp.gnu.org/gnu/gsl/gsl-latest.tar.gz
tar -zxvf gsl-latest.tar.gz
cd gsl-*
./configure && make && sudo make install
cd ..
rm gsl-latest.tar.gz

# Cython
sudo pip3 install Cython

# Fasttree

wget http://www.microbesonline.org/fasttree/FastTree.c
gcc -DNO_SSE -O3 -finline-functions -funroll-loops -Wall -o FastTree FastTree.c -lm
sudo mv FastTree /usr/local/bin
rm FastTree.c

# HDF5

wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.17/src/hdf5-1.8.17.tar.bz2
tar -jxvf hdf5-1.8.17.tar.bz2
cd hdf5-1.8.17
./configure && make && sudo make install
cd ..
rm hdf5-1.8.17.tar.bz2

# Did not install centrifuge, eggnog, or muscle for now. Should be fine. Although I might need muscle down the line for some things. For now I will install anvi'o codebase later on. 


# Python packages - specifically pandas, also installs numpy
cd /home
# First need to install pip
sudo apt-get install python3-pip
# pandas
sudo -H pip3 install pandas 

# java 
cd /home/emcdaniel/Ext-Inst
sudo apt-get install default-jre

# Multiprocessing comes with python, don't need to install separately 
# FastQC
sudo apt-get install fastqc

# Mafft
# wget http://mafft.cbrc.jp/alignment/software.source.html/mafft-7.313-with-extensions-src.tgz 
# tar -xvfz mafft-7.313-with-extensions-src.tgz # this probably doesn't work, this isn't how I installed it before
sudo apt-get install mafft
# I no longer remember how I installed mafft without apt-get

# Raxml
sudo apt-get install raxml

# Biopython
sudo pip3 install biopython

# Pyparanoid for COGs analyses
# all the python2 things
sudo apt-get install libfreetype6-dev
sudo apt-get install pypy-dev
sudo apt-get install hmmer
sudo apt-get install cd-hit
# IMPORTANT CDHIT THING, MAKE SOFT LINK TO CD-HIT AND NOT CDHIT
sudo apt-get install muscle
sudo wget http://github.com/bbuchfink/diamond/releases/download/v0.9.14/diamond-linux64.tar.gz
sudo tar xzf diamond-linux64.tar.gz
sudo rm -rf diamond-linux64.tar.gz
sudo mv diamond /usr/local/bin
# dumb things with pypy for numpy
sudo apt-get install python-dev
sudo pip install numpy
sudo pip install pandas
sudo pip install biopython 
# error came up when plotting things
sudo apt-get install python-tk

# ANI Calculator: download from JGI, move over, and into bin plus the nmscan script

# FastViromeExplorer
cd /home/emcdaniel/Ext-Inst
sudo git clone https://code.vt.edu/saima5/FastViromeExplorer
sudo apt-get install default-jdk
cd FastViromeExplorer/tools-linux
sudo cp kallisto samtools /usr/local/bin
sudo javac -d bin src/*.java

# DESMAN
sudo apt-get install build-essential libgsl0-dev
sudo git clone https://github.com/chrisquince/DESMAN
cd DESMAN
sudo pip install Cython
sudo python ./setup.py install

# Ete3 dependencies
sudo apt-get install python-numpy python-qt4 python-lxml python-six
# Ete3 with miniconda because manually works like shit
sudo wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh -O Miniconda-latest-Linux-x86_64.sh
bash Miniconda-latest-Linux-x86_64.sh -b -p ~/anaconda_ete/
# ete3 with conda
conda install anaconda-client
conda install -c etetoolkit ete3 ete_toolchain
# now python paths are changed because with anaconda
# ETE3 visualization needs an X server
sudo apt-get install xvfb
# then preface scripts for viz with "xvfb-run python Script"

