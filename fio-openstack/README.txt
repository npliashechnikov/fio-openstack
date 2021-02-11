CEPH Load test HOWTO
===================================
The basic idea behind this tool is to spawn a VM on each hypervisor, attach a large volume to it, then include it in the FIO botnet and run the load tests with different load profiles.
The following jobs are included:
	- RR / 4K
	- RW / 4K
	- SR / 4M
	- SW / 4M
	
Feel free to edit or create new FIO jobs.

1. Open svc-spawn-vm-and-vol.sh and set the following variables:
    - sg (security group name)
	- pool (floating ip pool name)
	- net-id (fixed network to use). Make sure the network is large enough to accomodate all the VMs.
	- image (ubuntu image with iperf and fio packages installed, root user MUST be enabled and the public key must be placed with 400 to /root/.ssh/authorized_keys)
	Don't set or create the flavor. It will be created automatically.
	If a custom volume type is used, be sure to edit the volume spawning command appropriately.
	Make sure the FIO is installed on the machine you're working on and you have access to the floating network.

NOTE:
If you opt not to use the floating IPs and run the tests from a management VM, make the following changes to your procedure:
	- In 01-spawn-vms.sh, use svc-spawn-vm-and-vol-nofip.sh instead of svc-spawn-vm-and-vol.sh and remove the "> fips" operator. (be sure to fill its variables as described in #1 though)
	- After 01-spawn-vms.sh finishes, run 012-collect-fixed-ips.sh to gather the fixed addresses of the VMs.

2. Copy the VM private key to this directory and rename it to "vm_key".
	
3. Clean up ~/.ssh/known_hosts if required.

4. Run 01-spawn-vms.sh. It will update the quota, create the flavor, spawn the VMs, volumes and attach volumes to the VMs.

5. Run 02-generate-scripts.sh. It will create the following scripts you have to run:
	- 021-add-keys.sh - Will add the VM keys to the known hosts
	- 022-alloc.sh - Will allocate the free space on VMs' persistent storage. Run the script, it will start asynchronously. Wait until it exits.
	- 023-start-fio.sh - Will launch the FIO in the daemon mode across the VMs.
	- svc-reset-io.sh - Will flush the buffers on the VMs. It is used by the next stage of the testing

5. Open 03-gen-fip-lists.sh and edit it to your test needs. 
6. Edit 04-spt.sh match the 03-gen-fip-lists.sh
7. Create the directory structure:
     - fio-results
	    | -> persistent
		| -> ephemeral

8. Run the 021, 022 and 023 scripts.
9. Run the 03 script.
10. Start the 04 script. At this point, FIO should start running.

11. Use the supplied parse.py tool to generate the CSV data from the raw FIO results. The CSV data contains the following results: IOPS, clat/95%clat, throughput.
NOTE:
If you have modified the job files (fio_job_ephemeral, fio_job_pers), make sure to edit the "jobs" variable declaration in parse.py accordingly.

12. Clean up the testing VMs by running 05-cleanup.sh