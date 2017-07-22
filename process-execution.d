#!/usr/sbin/dtrace -s

/*
 * Snoop Process Execution
 * {rints details on new processes as they execute
 *
 * from the book: Brendan Gregg, Dynamic Tracing in Oracle® Solaris, Mac OS X, and FreeBSD
 */

#pragma D option quiet
#pragma D option switchrate=10hz

dtrace:::BEGIN
{
  printf("%-20s %6s %6s %6s %s\n", "STARTTIME",
    "UID", "PPID", "PID", "PROCESS");
}
proc:::exec-success
{
   printf("%-20Y %6d %6d %6d %s\n", walltimestamp,
     uid, ppid, pid, execname);
}

