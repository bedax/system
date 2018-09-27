#!/usr/bin/env python3

import os
import subprocess
import sys


raw = subprocess.check_output(["acpi", "--battery"])
if b"Charging" in raw:
    sys.exit()

summary = raw.decode("utf-8").split(os.linesep, 1)[0].split(":", 1)[1].strip()
parts = [part.rstrip(",") for part in summary.split(" ")]
charging = parts[0] == "Charging"
percentage = int(parts[1].rstrip("%"))
time = parts[2] if len(parts) > 2 else None

low = int(sys.argv[1]) if len(sys.argv) > 1 else 8
lowest = int(sys.argv[2]) if len(sys.argv) > 2 else 4
if not charging:
    if percentage < lowest:
        subprocess.call(os.path.expanduser("~/.local/bin/hibernate"))
    elif percentage < low:
        subprocess.call([
            "notify-send",
            "--urgency", "critical",
            "Battery low",
            "{}%{}".format(
                percentage,
                "" if time is None else "; {} remaining".format(time)
            )
        ])
