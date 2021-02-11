#!/bin/sh

export az=$1
export flavor=fio-100g
export sg=spt-test-secgroup-612
export image=xenial-with-fio
export net_id=913ec2bf-f6a0-4a41-9e06-6fb96bc22e0d

export server_id=`openstack server create fio-slave-${az} --image ${image} --flavor ${flavor} --nic net-id=${net_id} --security-group ${sg} --availability-zone ${az} | grep "\ id\ " | awk '{print $4}'`
export vol_id=`openstack volume create fio-vol-${az} --size 110 | grep name | awk '{print $4}'`
sleep 15
