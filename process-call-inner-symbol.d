#!/usr/sbin/dtrace -s

/*
 * Trace failed syscalls with a given name
 * Args: pid
 *       function-name
 */

pid$1::$$2:entry {
  ustack();
}
