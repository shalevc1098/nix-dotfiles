#!/usr/bin/env python-agsv1
from time import sleep
import sys
import psutil

try:
    direction = sys.argv[1]
except IndexError:
    direction = "recv"

init_bytes = final_bytes = 0

match direction:
    case "recv":
        init_bytes = psutil.net_io_counters().bytes_recv
        sleep(1)
        final_bytes = psutil.net_io_counters().bytes_recv

    case "sent":
        init_bytes = psutil.net_io_counters().bytes_sent
        sleep(1)
        final_bytes = psutil.net_io_counters().bytes_sent

    case _: 
        print(f"wrong direction: {direction}")
        sys.exit()

i = 0
divider = 1000
bandwidth = int((final_bytes - init_bytes))
units = ["B", "KB", "MB", "GB", "TB", "PB", "EB"]

while bandwidth >= divider:
    i += 1
    bandwidth = bandwidth / divider

print(f"{bandwidth:.1f}" + units[i] + "/s")

