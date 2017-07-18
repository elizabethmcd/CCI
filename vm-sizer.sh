#! /bin/bash

# Moving 3 GB space
# Do this as root as well after usermod

/sbin/lvextend --size +5G /dev/mapper/Volume00-home

# Grow home

/sbin/resize2fs /dev/mapper/Volume00-home
