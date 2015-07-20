#!/usr/bin/sh

virt-install --name="$1" --arch=x86_64 --vcpus= maxvcpus=3,vcpus=1 \
             --memory maxmemory=1537,memory=512 --os-type=linux --os-variant=debian8 \
             --cdrom=/var/lib/libvirt/images/debian.iso \
             --disk path=/var/lib/libvirt/images/disk-"$(echo $1 | tr '[A-Z]' '[a-z]')".qcow2,format=qcow2,size=10 \
             --accelerate --noautoconsole
