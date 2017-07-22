# FreeBSD DTrace scripts
Useful DTrace scripts for FreeBSD

This repository contains various useful, ready-to-use DTrace scripts.

All scripts require root permissions.

# User stacks
In order to allow DTrace to show meaningful user stacks, you need:
* to add ustack(); call to the corresponding probe script
* to have these lines in /etc/make.conf:

  \#\# allow DTrace stack trace to pick up stack
  STRIP=

  CFLAGS+=-fno-omit-frame-pointer

  CXXFLAGS+=-fno-omit-frame-pointer

  CPPFLAGS+=-fno-omit-frame-pointer

* to have proper symbols in the binaries by rebuilding the ports: portupgrade -f {port-name}
