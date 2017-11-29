# Requesting a New VM through CCI

1. Go to the "Catalog" tab and click request for Ubuntu 14.04 LTS
2. Go to VM_1
3. In this form you can change the instances, CPUs, and memory, but not hte storage. The default is 40 GB and you can extend the disk later with the instructions in `increase-disk-size.md`. 
4. Fill in all of the "no's"
5. I usually use chicken
6. After the request has been submitted successfully, it will give you the network # to ssh into. Root@####


## Specifically on 2017-11-29

I've added 4 CPUs and 10000 MB of memory. Default space is 40GB and I will up that to 1.5TB wiht extending the disk. I haven't figured out how to extend the disk multiple times, only once, so just up to 1.5 the first time, which is more than I think I will need. Across ALL virtual servers we can only have 2TB for now. May have to talk to CCI people if that becomes a problem down the road. 