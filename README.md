# Connecting to a Virtual Server through CCI

1. Go to the website https://virtualization.cci.wisc.edu/vcac/#csp.catalog.item.list and login. 

2. Request server with all the no specifications. Wait a while for it to be successfully uploaded. 

3. Then go to items > machines > Network information and copy the Root @ IP # to ssh into. 

4. This website has the information for allocating memory to the /home directory: https://kb.wisc.edu/cci/page.php?id=64024. These steps are also in the `vm-sizer.sh` script. 

5. The rest of the steps including giving a modified user sudo privileges and installing software from previous VM sessions are in the scripts of this repository. 
- `fileshare-mount.sh` as the root user 
- `vm-sizer.sh` as the root user
- Then give sudo privileges to a user to switch to

6. `vm-installs.sh` installs the external software and packages for doing what you want to do. Do this as whatever user you have setup and given sudo privileges to. 


