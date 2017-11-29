# Increasing a VM Disk Size 

### 2017-09-27 Note:

This was an extremely painful process for me. These steps may not be reproducible just yet. It depends on how many partitions already exist on the disk. 

Sources: 

- [Managing Filesystems](https://kb.wisc.edu/cci/64024)
- [Storage Management Reconfigurations](https://kb.wisc.edu/cci/52028)
- [Blog Post on Increasing VM Disk Size](https://ma.ttias.be/increase-a-vmware-disk-size-vmdk-formatted-as-linux-lvm-without-rebooting/)


The guidelines below are a combination of workflows from the above 3 articles with some modifications. 

## Using 40G as Default

Use the guidlines in the managing filesystems post. Don't have to do anything below. 

## Using Above the 40G Default Size

1. Reconfigure a machine on the right hand side
2. Press 'edit' in the storage tab and change the amount of storage. Collectively across VMs we can't go over 2 TB. 
2. Submit a reconfiguration request
3. Partition as following below following the steps in the Blog Post

## Partitioning Disk Space 

Type `fdisk -l` to view the partitions. It should give you a list of `/dev/sda#`. The most important thing to note here is that whatever number is missing, that's the number of "partitions" you will add. The ones that exist can't have anything done to them, from what I can tell. 

Check the names of the scsi devices with:

```
ls /sys/class/scsi_device/
```

Should give you something like `0:0:0:0 1:0:0:0 2:0:0:0` or something of that variation. 

Rescan the scsi bus. Do it with the first listed one. The one I used the first time was `1:0:0:0`:

```
echo 1 > /sys/class/scsi_device/1\:0\:0\:0/device/rescan
```

This rescans the current scsi bus and the disk size that has changed will then show up. 

```
ls /sys/class/scsi_host/
```

This gives a list of "hosts". Use whatever host is listed first, such as host0:

```
echo "- - -" > /sys/class/scsi_host/host0/scan
```

Now create the new partition. Once the rescan is done, you can check if the extra space can be seen on the disk with `fdisk -l`. Now it can see whatever you physically added with the reconfiguration request. To create the partition, start fdisk for the /dev/sda device. THIS IS WHERE IT GETS IMPORTANT. WHATEVER NUMBER SDA# WAS MISSING OR IS MISSING, THAT'S HOW MNAY PARTITIONS YOU ADD. IDK WHY. 

```
fdisk /dev/sda
n
p
4
<enter>
<enter>
t
4
8e
w
```

Here is what you have done: 

- `n` creates the new partition
- `p` creates a new primary partition. The system can only have 4 primary partitions on the disk. If you reach the limit then you have to create an extended partition, so the other option is `e`. I haven't ran into this issue yet, which means it will haunt me later on. 
- Partition number. The default is 3 BUT THIS IS WHERE YOU PUT WHATEVER NUMBER IS MISSING. In this case, there wasn't an /dev/sda4, do I entered 4. This is called the logical number since the other ones are already present?
- `t` changes the partition type
- Enter number of partitions you've just created in the previous steps, so 4 in this case
- Hex code: enter 8e
- Back to main command within fdisk, `w` writes the partitions to the disk. You'll get some dumb message about kernel using old partition table and to reboot to use new table. Don't have to necessarily reboot. Can also rescan using `partprobe` as described next.

Run `partprobe -s` to scan for the newly created partition.

That worked for me, but if it doesn't, it's also suggested to try `partx -v -a /dev/sda`

Now Extend the Logical Volume with the new partition

`pvcreate /dev/sda4`

This creates a new physical volume. You should get a `Physical volume "/dev/sda4" successfully created` mesage. 

Find out what your Volume Group is called with `vgdisplay`. 

For our specific Ubuntu machines, the Volume Group is Volume00, except it's not by itself in /dev/mapper. It's Volume00-home, Volume00-dev, etc. We are interested in Volume00-home since we are working on the home directory for everything pretty much. Extend the Volume Group: 

```
vgextend Volume00 /dev/sda4
```

See the newly added physical volume with `pvscan` and see the usable space. 

Now extend the Logical Volume, SPECIFIC TO UBUNTU: (see blog post for not Ubuntu)

```
lvextend /dev/mapper/Volume00-home /dev/sda4
```

Then resize the file system to the volume group to use the space. These last two steps are basically the same as the normal size management steps for the VM given by CCI. 

```
resize2fs /dev/mapper/Volume00-home
```

YOU SHOULD THEN BE GOOD TO GO! 

This will then allow you to add files from the mounted fileshare to folders in your /home folder so you can directly do analyses there. Because who in the heck knows how to link programs to look at things in the fileshare. You have to move things back and forth for now.

### Wednesday 2017-11-29 Note

I've come to a point where I need to extend the disk space to 1.5 TB for filtering a bunch of metagenomes. The important thing I learned is that you can't have more than 4 partitions. So you have to delete a partition, but I haven't figured out if I've deleted the correct one. Usually I list the fdisk and look at where I think the allocated space is put, and I delete a different one. Usually it will give some error that it's in use if it can't be deleted, so pick a different partition to delete. When you go to make a new partition, it will show the partition types, and under primary currently is says "2 primary, 1 extended, 1 free" so those are the 4 partitions, and I can use 1 to mess with. So then make a primary one. 

Ok none of that worked because all of the /dev/sda disks are in use so I can't delete them or extend them. I've tried rebooting the machine because it said something about that. 

WELL I can't even ssh into the machine anymore, so I'm destroying it. START OVER!!! 

Ok starting over. Evidently if you scan the 1 sys/device and the space doesn't show up in fdisk -l, scan the 2. I've only used host0 though. 