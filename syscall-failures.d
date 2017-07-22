#!/usr/sbin/dtrace -s

/*
 * Trace failed syscalls for process(es) with a given name
 * Args: process-name
 */

syscall:::return /execname == $$1 && arg1 == -1/ {
  printf("failure: errno=%d @tm=%d pid=%d", errno, timestamp, pid);
}
