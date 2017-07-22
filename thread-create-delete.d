#!/usr/sbin/dtrace -s

/*
 * Trace thread creation and deletion for a process(es) with a given name
 * Args: process-name
 */

struct thr_param {
    void          (*start_func)(void *);
    void          *arg;
    char          *stack_base;
    size_t        stack_size;
    char          *tls_base;
    size_t        tls_size;
    long          *child_tid;
    long          *parent_tid;
    int           flags;
    struct rtprio *rtp;
};

syscall::thr_new:entry /execname == $$1/
{
  tp = (struct thr_param*)copyin(arg0, sizeof(struct thr_param));
  printf("exe=%s pid=%d tid=%x {start_func=%p arg=%p stack_base=%p stack_size=%lu tls_base=%p tls_size=%lu *child_tid=%x *parent_tid=%x flags=%x rtp=%p} param_size=%d",
    execname, pid, tid,
    tp->start_func, tp->arg, tp->stack_base, tp->stack_size, tp->tls_base, tp->tls_size,
    *(long*)copyin((uintptr_t)tp->child_tid,sizeof(long)), *(long*)copyin((uintptr_t)tp->parent_tid,
    sizeof(long)), tp->flags, tp->rtp,
    arg1);
  stack();
  ustack();
  self->arg_tp = arg0;
}

syscall::thr_new:return /execname == $$1/
{
  tp = (struct thr_param*)copyin(self->arg_tp, sizeof(struct thr_param));
  printf("exe=%s pid=%d tid=%x {start_func=%p arg=%p stack_base=%p stack_size=%lu tls_base=%p tls_size=%lu *child_tid=%x *parent_tid=%x flags=%x rtp=%p} errno=%d",
    execname, pid, tid,
    tp->start_func, tp->arg, tp->stack_base, tp->stack_size, tp->tls_base, tp->tls_size,
    *(long*)copyin((uintptr_t)tp->child_tid,sizeof(long)), *(long*)copyin((uintptr_t)tp->parent_tid,
    sizeof(long)), tp->flags, tp->rtp,
    errno);
  stack();
  ustack();
}

syscall::thr_exit:entry /execname == $$1/
{
  printf("exe=%s pid=%d tid=%x", execname, pid, tid);
  stack();
  ustack();
}

/* no syscall::thr_exit:return */

