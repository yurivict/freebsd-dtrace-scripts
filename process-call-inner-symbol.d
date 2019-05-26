#!/usr/sbin/dtrace -s

/*
 * Trace internal functions in a process with a given pid (also works with symbols imported into the process from shared libraries)
 * Args: pid
 *       function-name
 */

pid$1::$$2:entry {
  printf("pid=%d symbol=%s", $1, $$2);
  ustack();
}

pid$1::$$2:return {
  printf("pid=%d symbol=%s arg0=%d", $1, $$2, arg0);
  ustack();
}
