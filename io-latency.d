#!/usr/sbin/dtrace -s

/*
 * Shows disk I/O latency as a distribution plot
 * from the book: Brendan Gregg, Dynamic Tracing in Oracle® Solaris, Mac OS X, and FreeBSD
 * Args: -none-
 */

io:::start
{
  start[arg0] = timestamp;
}

io:::done
/start[arg0]/
{
  @time["disk I/O latency (ns)"] = quantize(timestamp - start[arg0]);
  start[arg0] = 0;
}
