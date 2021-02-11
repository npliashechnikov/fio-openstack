#!/usr/bin/python
import re
import sys

jobs = ["random_write_4K", "random_read_4K", "seq_write_4M", "seq_read_4M"]

with open(sys.argv[1], "rt") as f:
    lines = f.readlines()
i = 0
avg=None
avgbw=None
perc95=None
iops=None
lprint = 0

res = [[] for _ in range(len(jobs))]

for line in lines:
    for job in range(len(jobs)):
        if jobs[job] in line:
            lprint = job
            break

    if ("iops" in line) and ('mixed' in line):
       iops = re.search(r'(?<=iops\=).+,', line)
       iops = iops.group(0).replace(',', '')
    if ("bw" in line) and ("mixed" not in line):
        div = 1000
        if 'MB' in line:
            div = 1.0
        if 'GB' in line:
            div = 0.001
        avgbw = re.search(r'(?<=avg\=).+,', line)
        avgbw = avgbw.group(0).replace(",","")
        avgbw = float(avgbw) / div
    if "clat" in line:
        if "perc" in line:
            if ('usec' in line):
                percdiv = 1000.0
            else:
                percdiv = 1.0
            i = 4
        else:
            latdiv = 1.0
            if 'usec' in line:
                latdiv = 1000.0
            avg = re.search(r'(?<=avg\=).+,', line)
            avg = avg.group(0).replace(",","")
            avg = float(avg) / latdiv
    if i:
        if i == 1:
            perc95 = re.search(r'(?<=95\.00th\=).+\]', line).group(0).replace('[','').replace(']','').replace(' ', '')
            perc95 = float(perc95) / percdiv
        i -= 1
    if iops and avg and avgbw and perc95:
        res[lprint].append("%s,%s/%s,%s"%(iops,avg,perc95,avgbw))
        avg = None
        perc95 = None
        avgbw = None
        iops = None


for i in range(len(jobs)):
    print(jobs[i]+":")
    for line in res[i]:
        print(line)
