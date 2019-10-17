#!/bin/bash
# COD4 B3 Server Management Script.
# Coded and devoloped by COD4-LK

# Startup Server B3
screen -dm -S B3 -t B3 bash -c 'taskset -c 0 python b3_run.py'