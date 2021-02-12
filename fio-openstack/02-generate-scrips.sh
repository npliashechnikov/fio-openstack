#!/bin/sh

cat fips | awk '{print "ssh -oStrictHostKeyChecking=no -i ./vm_key root@" $1 " #uptime#"}' | tr "#" "'" > 021-add-keys.sh
chmod +x 021-add-keys.sh
cat 021-add-keys.sh

cat fips | awk '{print "ssh -i ~/source/vm_key root@" $1 " #dd if=/dev/zero of=/root/test.img bs=1M count=105000# &"}' | tr "#" "'" > 022-alloc.sh
chmod +x 022-alloc.sh
cat 022-alloc.sh

cat fips | awk '{print "ssh -i ~/source/vm_key root@" $1 " #fio --server --daemonize=/tmp/fio.pid#"}' | tr "#" "'" > 023-launch-fio.sh
chmod +x 023-launch-fio.sh


cat fips | awk '{print "ssh -i ~/source/vm_key root@" $1 " #sync; echo 3 > /proc/sys/vm/drop_caches; blockdev --flushbufs /dev/vdc# &"}' | tr "#" "'" > svc-reset-io.sh
echo "sleep 10" >> svc-reset-io.sh
chmod +x svc-reset-io.sh
