#!/bin/sh
cat fips | head -n 1 > fio_fips_1
cat fips | head -n 10 > fio_fips_10
cat fips | head -n 20 > fio_fips_20
cat fips | head -n 50 > fio_fips_50
cat fips | head -n 100 > fio_fips_100
