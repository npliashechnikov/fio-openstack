#!/bin/sh

export az=$1
openstack server add volume fio-worker-${az} fio-vol-${az}
