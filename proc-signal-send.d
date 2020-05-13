#!/usr/sbin/dtrace -s

/*
 * Trace signals between processes
 * Args: <none>
 */

proc:::signal-send {
  /*args[0]: struct thread*, args[1]: struct proc* (in /usr/src/sys/sys/proc.h) */
  printf("proc:::signal-send pid=%d exec=%s to-thread.td_name=%s to-pid=%d signal=%d", pid, execname, args[0]->td_name, args[1]->p_pid, args[2]);
}
