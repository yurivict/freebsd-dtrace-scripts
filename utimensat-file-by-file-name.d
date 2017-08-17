#!/usr/sbin/dtrace -s

/*
 * Trace file access and modification times change via utimensat for a given file (the name is relative, so you need to guess how it was changed)
 * Args: file-name
 */

syscall::utimensat:entry /copyinstr(arg1) == $$1/ {
  self->tm = timestamp;
  printf("fd=%d file=%s pid=%d exe=%s", arg0, copyinstr(arg1), pid, execname);
  self->fd = arg0;
  self->file = copyinstr(arg1);
  ustack();
}

syscall::utimensat:return /self->file == $$1/ {
  printf("fd=%d file=%s errno=%d pid=%d exe=%s", self->fd, self->file, errno, pid, execname);
}

