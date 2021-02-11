#!/bin/sh
fio --client=./fio_fips_1 ./fio_job_ephemeral 2>&1 | tee fio-results/ephemeral/1client-io64
./resetio.sh
fio --client=./fio_fips_10 ./fio_job_ephemeral 2>&1 | tee fio-results/ephemeral/10client-io64
./resetio.sh
fio --client=./fio_fips_20 ./fio_job_ephemeral 2>&1 | tee fio-results/ephemeral/20client-io64
./resetio.sh
fio --client=./fio_fips_50 ./fio_job_ephemeral 2>&1 | tee fio-results/ephemeral/50client-io64
./resetio.sh
fio --client=./fio_fips_100 ./fio_job_ephemeral 2>&1 | tee fio-results/ephemeral/100client-io64
./resetio.sh
fio --client=./fio_fips_1 ./fio_job_pers 2>&1 | tee fio-results/persistent/1client-io64
./resetio.sh
fio --client=./fio_fips_10 ./fio_job_pers 2>&1 | tee fio-results/persistent/10client-io64
./resetio.sh
fio --client=./fio_fips_20 ./fio_job_pers 2>&1 | tee fio-results/persistent/20client-io64
./resetio.sh
fio --client=./fio_fips_50 ./fio_job_pers 2>&1 | tee fio-results/persistent/50client-io64
./resetio.sh
fio --client=./fio_fips_100 ./fio_job_pers 2>&1 | tee fio-results/persistent/100client-io64
