# Transferring files between the Fileshare and VMs 

Once you have mounted the fileshare, it is very easy to copy files to a specific folder on the VM. Processes cannot read files directly from the fileshare, they must be moved to a direct location somewhere within your VM. Preferably in the `/home` directory. Once you have generated files on the VM, if they are small files, just `cp` them back to your location on the fileshare. If they are particularly large, do the following: 

1. Create a tarball of the files using `tar -czf` 
2. `scp` to the fileshare
3. The fileshare location is usually under `/Volumes` of your "local" computer, although it is another remote location technically. Move it to your home folder of the fileshare while you are on your local computer.
4. Ex: `scp your_username@IP####:/path/to/file/directory /Volumes/home/your_username`
5. Also use `rsync` so the file transfer is not interuppted 

These steps also work if you are on another remote server, such as CHTC, with which you can't mount the fileshare. So either way if you are on the VM, choose to just `cp` into the mounted fileshare, or `scp`. 

Example for transferring directories: 
`scp -r root@10.128.254.54:/home/emcdaniel/phylo-trees/TB-Deltas/* .`
