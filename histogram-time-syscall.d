#!/usr/sbin/dtrace -s

/*
 * Timing system calls
 * Shows histogram of timespans for a given syscall
 * Args: syscall-name
 */

#pragma D option quiet

dtrace:::BEGIN {printf("Tracing... Hit Ctrl-C to end.\n");}

syscall::$$1:entry {
  self->t = timestamp;
}

syscall::$$1:return /self->t/ {
  @[$$1] = quantize(timestamp - self->t); self->t = 0;
}

