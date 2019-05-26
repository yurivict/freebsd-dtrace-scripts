#!/usr/sbin/dtrace -s

/*
 * Trace internal functions in a process with a given pid
 * Args: pid
 *       function-name
 */

pid$1::$$2:entry {
  ustack();
}
