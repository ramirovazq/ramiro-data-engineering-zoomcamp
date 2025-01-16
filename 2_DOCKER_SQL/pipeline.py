import sys
import pandas as pd

print(sys.argv)

day = sys.argv[1]
next_arg = sys.argv[2]

# do some stuff using pandas

print(f"job executed successfully in day {day} {next_arg}")