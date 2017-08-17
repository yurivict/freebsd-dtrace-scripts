#!/usr/sbin/dtrace -s

/*
 * Trace file renames by file name
 * Args: file-name
 */

syscall::rename:entry /copyinstr(arg0) == $$1 || copyinstr(arg1) == $$1/ {
  self->tm = timestamp;
  printf("file1=%s file2=%s pid=%d exe=%s", copyinstr(arg0), copyinstr(arg1), pid, execname);
  self->file1 = copyinstr(arg0);
  self->file2 = copyinstr(arg1);
  ustack();
}

syscall::rename:return /self->file1 == $$1 || self->file2 == $$1/ {
  printf("file1=%s file2=%s errno=%d pid=%d exe=%s", self->file1, self->file2, errno, pid, execname);
}

