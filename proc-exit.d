#!/usr/sbin/dtrace -s

/*
 * Trace process termination events
 * Args: <none>
 */

proc:::exit {
  printf("proc:::exit pid=%d exec=%s exit-reason=%d", pid, execname, args[0]);
}
