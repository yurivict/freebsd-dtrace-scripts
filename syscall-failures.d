#!/usr/sbin/dtrace -s

/*
 * Trace failed syscalls with a given name and a given errno
 * Args: syscall-name
 *       errno
 */

syscall::$$1:return /errno == $2/ {
  printf("failure: errno=%d @tm=%d pid=%d", errno, timestamp, pid);
  ustack();
  stack();
}
