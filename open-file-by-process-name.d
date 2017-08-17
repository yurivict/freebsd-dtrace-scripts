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
  printf("file=%s flags=%x errno=%d return-fd=%d @tm=%d dt=%d pid=%d", copyinstr(self->file), self->flags, errno, arg0, timestamp, timestamp-self->tm, pid);
  ustack();
}

syscall::openat:entry /execname == $$1/ {
  self->tm = timestamp;
  printf("file=%s flags=%x at-fd=%d @tm=%d pid=%d", copyinstr(arg1), arg2, arg0, self->tm, pid);
  self->file = arg1;
  self->flags = arg2;
}

syscall::openat:return /execname == $$1/ {
  printf("file=%s flags=%x errno=%d return-fd=%d @tm=%d dt=%d pid=%d", copyinstr(self->file), self->flags, errno, arg0, timestamp, timestamp-self->tm, pid);
  /*ustack();*/
}
