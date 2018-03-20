#!/usr/bin/env python3

import os
import subprocess
import sys


state_raw = subprocess.check_output([
	"acpi",
	"-b"
])

state_summary = state_raw.strip().decode("utf-8").split(":", 1)[1]
state_parts = [part.rstrip(",") for part in state_summary.split(" ")]
state_direction = state_parts[1]
state_percentage = int(state_parts[2].rstrip("%"))
state_time = state_parts[3] if len(state_parts) >= 4 else None

low = int(sys.argv[1]) if len(sys.argv) > 1 else 7
if state_direction != "Charging" and state_percentage < low:
	subprocess.call([
		"notify-send",
		"--urgency", "critical",
		"Battery low",
		"{}%".format(
			state_percentage,
			"" if state_time is None else "; {} remaining".format(
				state_time
			)
		)
	])
