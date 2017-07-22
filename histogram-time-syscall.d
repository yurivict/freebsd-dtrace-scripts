#!/bin/sh

##
## Timing system calls
## Shows histogram of timespans for a given syscall
## Args: syscall-name
##

dtrace -n "syscall::$1:entry {self->t = timestamp;}
           syscall::$1:return /self->t/
             { @[\"$1\"] = quantize(timestamp - self->t); self->t = 0; }"

