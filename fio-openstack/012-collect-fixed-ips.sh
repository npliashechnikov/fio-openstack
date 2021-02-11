#/bin/sh
openstack server list | grep fio-slave | grep "ACTIVE" | awk '{print $8}' | tr ',' ' ' | tr '=' ' ' | awk '{print $2}' > fips