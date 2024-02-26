# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_C_CLANG_TIDY_INCLUDED
MAKEFILE_LINT_C_CLANG_TIDY_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/build/examples/src.mk
include $(MAKEFILEDIR)/configure/build-depends/clang.mk
include $(MAKEFILEDIR)/configure/build-depends/clang-tidy.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/cpp.mk
include $(MAKEFILEDIR)/configure/build-depends/sed.mk
include $(MAKEFILEDIR)/configure/xfail.mk


_XFAIL_LINT_c_clang_tidy := \
	$(_MANDIR)/man2/add_key.2.d/add_key.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/bpf.2.d/bpf.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/chown.2.d/chown.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/clone.2.d/clone.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/close_range.2.d/close_range.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/copy_file_range.2.d/copy_file_range.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/eventfd.2.d/eventfd.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/execve.2.d/execve.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/execve.2.d/myecho.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/futex.2.d/futex.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/getdents.2.d/getdents.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/getrlimit.2.d/getrlimit.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/ioctl_fat.2.d/display_fat_volume_id.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/ioctl_fat.2.d/ioctl_fat.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/ioctl_fat.2.d/toggle_fat_archive_flag.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/ioctl_ns.2.d/ns_show.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/ioctl_tty.2.d/tcgets.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/kcmp.2.d/kcmp.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/keyctl.2.d/key_instantiate.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/listxattr.2.d/listxattr.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/membarrier.2.d/membarrier.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/memfd_create.2.d/t_get_seals.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/memfd_create.2.d/t_memfd_create.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/mmap.2.d/mmap.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/mount_setattr.2.d/mount_setattr.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/mprotect.2.d/mprotect.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/msgop.2.d/msgop.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/open_by_handle_at.2.d/t_name_to_handle_at.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/open_by_handle_at.2.d/t_open_by_handle_at.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/perf_event_open.2.d/perf_event_open.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/pidfd_open.2.d/pidfd_open.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/pidfd_send_signal.2.d/pidfd_send_signal.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/pipe.2.d/pipe.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/pivot_root.2.d/pivot_root.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/poll.2.d/poll_input.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/process_vm_readv.2.d/process_vm_readv.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/readlink.2.d/readlink.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/recvmmsg.2.d/recvmmsg.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/request_key.2.d/t_request_key.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/sched_setaffinity.2.d/sched_setaffinity.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/seccomp.2.d/seccomp.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/seccomp_unotify.2.d/seccomp_unotify.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/select_tut.2.d/select.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/semget.2.d/t_semget.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/sendmmsg.2.d/sendmmsg.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/setns.2.d/setns.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/shmop.2.d/svshm_string_read.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/shmop.2.d/svshm_string_write.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/sigaction.2.d/sigaction.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/spu_run.2.d/spu_run.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/stat.2.d/stat.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/_syscall.2.d/_syscall.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/syscall.2.d/syscall.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/sysctl.2.d/sysctl.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/tee.2.d/tee.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/timer_create.2.d/timer_create.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/timerfd_create.2.d/timerfd_create.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/unshare.2.d/unshare.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/userfaultfd.2.d/userfaultfd.lint-c.clang-tidy.touch \
	$(_MANDIR)/man2/wait.2.d/wait.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/atexit.3.d/atexit.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/backtrace.3.d/backtrace.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/bsearch.3.d/bsearch.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/bswap.3.d/bswap.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/cacos.3.d/cacos.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/cacosh.3.d/cacosh.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/catan.3.d/catan.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/catanh.3.d/catanh.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/circleq.3.d/circleq.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/clock_getcpuclockid.3.d/clock_getcpuclockid.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/CPU_SET.3.d/CPU_SET.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/dl_iterate_phdr.3.d/dl_iterate_phdr.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/dlinfo.3.d/dlinfo.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/duplocale.3.d/duplocale.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/encrypt.3.d/encrypt.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/end.3.d/end.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/endian.3.d/endian.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/envz_add.3.d/envz_add.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/fmemopen.3.d/fmemopen.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/fopencookie.3.d/fopencookie.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/fread.3.d/fread.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/frexp.3.d/frexp.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/ftw.3.d/ftw.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/_Generic.3.d/_Generic.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/getaddrinfo.3.d/client.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/getaddrinfo.3.d/server.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/getaddrinfo_a.3.d/async.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/getaddrinfo_a.3.d/sync.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/getdate.3.d/getdate.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/getgrent_r.3.d/getgrent_r.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/getgrouplist.3.d/getgrouplist.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/getline.3.d/getline.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/getopt.3.d/getopt.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/getopt.3.d/getopt_long.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/getprotoent_r.3.d/getprotoent_r.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/getpwnam.3.d/getpwnam.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/getservent_r.3.d/getservent_r.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/getsubopt.3.d/getsubopt.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/getutent.3.d/getutent.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/hsearch.3.d/hsearch.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/if_nameindex.3.d/if_nameindex.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/inet.3.d/inet.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/inet_net_pton.3.d/inet_net_pton.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/inet_pton.3.d/inet_pton.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/insque.3.d/insque.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/list.3.d/list.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/mallinfo.3.d/mallinfo.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/malloc_info.3.d/malloc_info.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/mallopt.3.d/mallopt.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/matherr.3.d/matherr.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/MAX.3.d/MAX.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/mbstowcs.3.d/mbstowcs.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/mq_getattr.3.d/mq_getattr.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/mq_notify.3.d/mq_notify.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/newlocale.3.d/newlocale.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/offsetof.3.d/offsetof.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/posix_spawn.3.d/posix_spawn.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/__ppc_get_timebase.3.d/__ppc_get_timebase.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/pthread_attr_init.3.d/pthread_attr_init.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/pthread_cleanup_push.3.d/pthread_cleanup_push.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/pthread_create.3.d/pthread_create.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/pthread_getattr_np.3.d/pthread_getattr_np.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/pthread_setname_np.3.d/pthread_setname_np.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/pthread_setschedparam.3.d/pthreads_sched_test.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/qsort.3.d/qsort.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/rand.3.d/rand.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/rpmatch.3.d/rpmatch.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/rtime.3.d/rtime.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/scandir.3.d/scandir.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/sem_wait.3.d/sem_wait.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/setbuf.3.d/setbuf.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/shm_open.3.d/pshm_ucase_bounce.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/shm_open.3.d/pshm_ucase_send.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/slist.3.d/slist.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/stailq.3.d/stailq.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/static_assert.3.d/must_be.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/stpncpy.3.d/stpncpy.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/strcmp.3.d/string_comp.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/strcpy.3.d/strcpy.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/strftime.3.d/strftime.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/strsep.3.d/strsep.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/strtok.3.d/strtok.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/strtol.3.d/strtol.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/strverscmp.3.d/strverscmp.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/tailq.3.d/tailq.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/tsearch.3.d/tsearch.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3/wordexp.3.d/wordexp.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3const/EXIT_SUCCESS.3const.d/EXIT_SUCCESS.lint-c.clang-tidy.touch \
	$(_MANDIR)/man3head/printf.h.3head.d/register_printf_specifier.lint-c.clang-tidy.touch


_LINT_c_clang_tidy := $(patsubst %.c, %.lint-c.clang-tidy.touch, $(_UNITS_ex_c))
ifeq ($(SKIP_XFAIL),yes)
_LINT_c_clang_tidy := $(filter-out $(_XFAIL_LINT_c_clang_tidy), $(_LINT_c_clang_tidy))
endif


$(_LINT_c_clang_tidy): %.lint-c.clang-tidy.touch: %.c $(CLANG_TIDY_CONF) $(MK)
	$(info	$(INFO_)CLANG_TIDY	$@)
	$(CLANG_TIDY) $(CLANG_TIDYFLAGS) $< -- $(CPPFLAGS) $(CLANGFLAGS) 2>&1 \
	| $(SED) '/generated\.$$/d' >&2
	$(TOUCH) $@


.PHONY: lint-c-clang-tidy
lint-c-clang-tidy: $(_LINT_c_clang_tidy);


endif  # include guard
