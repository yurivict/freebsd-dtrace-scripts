#!/usr/sbin/dtrace -s

/*
 * Trace failed syscalls with a given name
 * Args: syscall-name
 */

syscall::$$1:return /errno != 0/ {
  printf("failure: errno=%d @tm=%d pid=%d", errno, timestamp, pid);
  ustack();
  stack();
}
