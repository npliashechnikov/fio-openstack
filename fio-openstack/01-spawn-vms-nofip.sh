#!/bin/sh
openstack host list | grep compute | awk '{print $6 ":" $2}' > hosts
openstack quota set --ram -1 --cores -1 --fixed-ips -1 --instances -1 --per-volume-gigabytes -1 --gigabytes -1 --volumes -1 --floating-ips -1
flavor=`openstack flavor list | grep fio-100g`
if [[ -z $flavor ]]; then
openstack flavor create --name fio-100g --vcpus 4 --disk 110 --ram 4096
fi

chmod +x svc*.sh

cat hosts | xargs -n 1 ./svc-spawn-vm-and-vol-nofip.sh
cat hosts | xargs -n 1 ./svc-connect-volume.sh

openstack server list | grep fio-worker | grep "ACTIVE" | awk '{print $8}' | tr ',' ' ' | tr '=' ' ' | awk '{print $2}' > fips