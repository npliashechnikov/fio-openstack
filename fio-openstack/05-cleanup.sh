#!/bin/sh
openstack server list | grep fio-worker | awk '{system("openstack server delete " $2)}'