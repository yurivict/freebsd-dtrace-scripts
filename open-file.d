#!/usr/sbin/dtrace -s

/*
 * Trace file opening for process(es) with a given name
 * Args: process-name
 */

syscall::open:entry /execname == $$1/ {
  self->tm = timestamp;
  printf("file=%s flags=%x @tm=%d pid=%d", copyinstr(arg0), arg1, self->tm, pid);
  self->file = arg0;
  self->flags = arg1;
}

syscall::open:return /execname == $$1/ {
  printf("file=%s flags=%x errno=%d @tm=%d dt=%d pid=%d", copyinstr(self->file), self->flags, errno, timestamp, timestamp-self->tm, pid);
}
