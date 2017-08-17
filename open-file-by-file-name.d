#!/usr/sbin/dtrace -s

/*
 * Trace file opening for a given file
 * Args: file-name
 */

syscall::open:entry /copyinstr(arg0) == $$1/ {
  self->tm = timestamp;
  printf("file=%s flags=%x @tm=%d pid=%d exe=%s", copyinstr(arg0), arg1, self->tm, pid, execname);
  self->file = copyinstr(arg0);
  self->flags = arg1;
  ustack();
}

syscall::open:return /self->file == $$1/ {
  printf("file=%s flags=%x errno=%d return-fd=%d @tm=%d dt=%d pid=%d exe=%s", self->file, self->flags, errno, arg0, timestamp, timestamp-self->tm, pid, execname);
}

syscall::openat:entry /copyinstr(arg1) == $$1/ {
  self->tm = timestamp;
  printf("file=%s flags=%x at-fd=%d @tm=%d pid=%d exe=%s", copyinstr(arg1), arg2, arg0, self->tm, pid, execname);
  self->file = copyinstr(arg1);
  self->flags = arg2;
  ustack();
}

syscall::openat:return /self->file == $$1/ {
  printf("file=%s flags=%x errno=%d return-fd=%d @tm=%d dt=%d pid=%d exe=%s", self->file, self->flags, errno, arg0, timestamp, timestamp-self->tm, pid, execname);
}
