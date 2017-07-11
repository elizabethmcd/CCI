# Connecting to a Virtual Server through CCI

1. Go to the website https://virtualization.cci.wisc.edu/vcac/#csp.catalog.item.list and login. 

2. Request server with all the no specifications. Wait a while for it to be successfully uploaded. 

3. Then go to items > machines > Network information and copy the Root @ IP # to ssh into. 

4. This website has the information for allocating memory to the /home directory: https://kb.wisc.edu/cci/page.php?id=64024. These steps are also in the `vm-installs.sh` script. 

5. The rest of the steps including giving a modified user sudo privileges and installing software from previous VM sessions are in the script `vm-installs.sh`. This will allocate space, mount the fileshare, give sudo privileges and also make any installations specific to external software or Python packages that you have used in the past and want to update to the shell script. 

_Important: In the future I plan to learn docker to implement the shell script a bit easier. For now everything is recapitulated as a shell script so I don't have to fiddle with everything and struggle._

## 2017-07-11

Made the initial git repository commit with the instructions for setting up a VM through CCI and my initial shell script with the commands for configuring sudo privileges, fileshare mount, and software/packages installation. The following software/packages are included in the shell script and are successfully installed: 

- BBMap
- Samtools
- Python pandas
- Python pip for installation of packages 