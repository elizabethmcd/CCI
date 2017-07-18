# This markdown file contains the workflow and list of things I have installed on the VM. 

## 2017-07-11

Made the initial git repository commit with the instructions for setting up a VM through CCI and my initial shell script with the commands for configuring sudo privileges, fileshare mount, and software/packages installation. The following software/packages are included in the shell script and are successfully installed: 

- BBMap
- Samtools
- Python pandas
- Python pip for installation of packages 
- HMMer
- MCL

Somehow I got BLAST to install. Not sure how. 

## 2017-07-18

Some wonky things are happening with my current VM. Attempted to reboot. It won't tab complete paths and giving lots of errors. Unmounted my fileshare. So I destroyed the current VM and starting anew. Interesting sidenote, the VM gives the same IP address after a few cycles. So you have to go into your /.ssh/known_hosts file and get rid of the previous time that IP address was used and then ssh into it or else it won't let you in. Now I will try to use my shell script to re-install things. 

Another sidenote. With running the shell script, you have to type y/n a few times. Try to see if I can bypass that automatically. 

Alright, also not the best idea to have the sudo privileges in the shell script. That should probably be first. List of instructions to do before running `vm-installs.sh`: 

1. Mount the fileshare as `root`
2. Increase home size by 5 G as `root`
3. Make user with sudo privileges as `root`, then switch to that user.
4. Run `vm-installs.sh` 

