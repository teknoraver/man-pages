# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_C_IWYU_INCLUDED
MAKEFILE_LINT_C_IWYU_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/build/examples/src.mk
include $(MAKEFILEDIR)/configure/build-depends/clang/clang.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/tac.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/touch.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/true.mk
include $(MAKEFILEDIR)/configure/build-depends/cpp/cpp.mk
include $(MAKEFILEDIR)/configure/build-depends/grep/grep.mk
include $(MAKEFILEDIR)/configure/build-depends/iwyu/iwyu.mk
include $(MAKEFILEDIR)/configure/build-depends/sed/sed.mk
include $(MAKEFILEDIR)/configure/xfail.mk


_XFAIL_LINT_c_iwyu := \
	$(_MANDIR)/man2/clock_getres.2.d/clock_getres.lint-c.iwyu.touch \
	$(_MANDIR)/man2/getrlimit.2.d/getrlimit.lint-c.iwyu.touch \
	$(_MANDIR)/man2/listxattr.2.d/listxattr.lint-c.iwyu.touch \
	$(_MANDIR)/man2/mount_setattr.2.d/mount_setattr.lint-c.iwyu.touch \
	$(_MANDIR)/man2/recvmmsg.2.d/recvmmsg.lint-c.iwyu.touch \
	$(_MANDIR)/man2/seccomp.2.d/seccomp.lint-c.iwyu.touch \
	$(_MANDIR)/man2/seccomp_unotify.2.d/seccomp_unotify.lint-c.iwyu.touch \
	$(_MANDIR)/man2/select.2.d/select.lint-c.iwyu.touch \
	$(_MANDIR)/man2/semget.2.d/t_semget.lint-c.iwyu.touch \
	$(_MANDIR)/man2/sendmmsg.2.d/sendmmsg.lint-c.iwyu.touch \
	$(_MANDIR)/man2/_syscall.2.d/_syscall.lint-c.iwyu.touch \
	$(_MANDIR)/man2/timer_create.2.d/timer_create.lint-c.iwyu.touch \
	$(_MANDIR)/man2/userfaultfd.2.d/userfaultfd.lint-c.iwyu.touch \
	$(_MANDIR)/man3/backtrace.3.d/backtrace.lint-c.iwyu.touch \
	$(_MANDIR)/man3/bsearch.3.d/bsearch.lint-c.iwyu.touch \
	$(_MANDIR)/man3/bswap.3.d/bswap.lint-c.iwyu.touch \
	$(_MANDIR)/man3/cacos.3.d/cacos.lint-c.iwyu.touch \
	$(_MANDIR)/man3/cacosh.3.d/cacosh.lint-c.iwyu.touch \
	$(_MANDIR)/man3/catan.3.d/catan.lint-c.iwyu.touch \
	$(_MANDIR)/man3/catanh.3.d/catanh.lint-c.iwyu.touch \
	$(_MANDIR)/man3/clock_getcpuclockid.3.d/clock_getcpuclockid.lint-c.iwyu.touch \
	$(_MANDIR)/man3/CPU_SET.3.d/CPU_SET.lint-c.iwyu.touch \
	$(_MANDIR)/man3/dl_iterate_phdr.3.d/dl_iterate_phdr.lint-c.iwyu.touch \
	$(_MANDIR)/man3/dlinfo.3.d/dlinfo.lint-c.iwyu.touch \
	$(_MANDIR)/man3/duplocale.3.d/duplocale.lint-c.iwyu.touch \
	$(_MANDIR)/man3/endian.3.d/endian.lint-c.iwyu.touch \
	$(_MANDIR)/man3/envz_add.3.d/envz_add.lint-c.iwyu.touch \
	$(_MANDIR)/man3/fopencookie.3.d/fopencookie.lint-c.iwyu.touch \
	$(_MANDIR)/man3/frexp.3.d/frexp.lint-c.iwyu.touch \
	$(_MANDIR)/man3/ftw.3.d/ftw.lint-c.iwyu.touch \
	$(_MANDIR)/man3/_Generic.3.d/_Generic.lint-c.iwyu.touch \
	$(_MANDIR)/man3/getaddrinfo.3.d/client.lint-c.iwyu.touch \
	$(_MANDIR)/man3/getaddrinfo.3.d/server.lint-c.iwyu.touch \
	$(_MANDIR)/man3/getgrouplist.3.d/getgrouplist.lint-c.iwyu.touch \
	$(_MANDIR)/man3/getline.3.d/getline.lint-c.iwyu.touch \
	$(_MANDIR)/man3/getopt.3.d/getopt_long.lint-c.iwyu.touch \
	$(_MANDIR)/man3/getprotoent_r.3.d/getprotoent_r.lint-c.iwyu.touch \
	$(_MANDIR)/man3/getservent_r.3.d/getservent_r.lint-c.iwyu.touch \
	$(_MANDIR)/man3/getsubopt.3.d/getsubopt.lint-c.iwyu.touch \
	$(_MANDIR)/man3/if_nameindex.3.d/if_nameindex.lint-c.iwyu.touch \
	$(_MANDIR)/man3/inet.3.d/inet.lint-c.iwyu.touch \
	$(_MANDIR)/man3/inet_net_pton.3.d/inet_net_pton.lint-c.iwyu.touch \
	$(_MANDIR)/man3/inet_pton.3.d/inet_pton.lint-c.iwyu.touch \
	$(_MANDIR)/man3/mallinfo.3.d/mallinfo.lint-c.iwyu.touch \
	$(_MANDIR)/man3/malloc_info.3.d/malloc_info.lint-c.iwyu.touch \
	$(_MANDIR)/man3/mbstowcs.3.d/mbstowcs.lint-c.iwyu.touch \
	$(_MANDIR)/man3/mq_getattr.3.d/mq_getattr.lint-c.iwyu.touch \
	$(_MANDIR)/man3/mq_notify.3.d/mq_notify.lint-c.iwyu.touch \
	$(_MANDIR)/man3/mtrace.3.d/t_mtrace.lint-c.iwyu.touch \
	$(_MANDIR)/man3/newlocale.3.d/newlocale.lint-c.iwyu.touch \
	$(_MANDIR)/man3/posix_spawn.3.d/posix_spawn.lint-c.iwyu.touch \
	$(_MANDIR)/man3/pthread_attr_init.3.d/pthread_attr_init.lint-c.iwyu.touch \
	$(_MANDIR)/man3/pthread_cleanup_push.3.d/pthread_cleanup_push.lint-c.iwyu.touch \
	$(_MANDIR)/man3/pthread_getattr_default_np.3.d/pthread_getattr_default_np.lint-c.iwyu.touch \
	$(_MANDIR)/man3/pthread_getattr_np.3.d/pthread_getattr_np.lint-c.iwyu.touch \
	$(_MANDIR)/man3/pthread_getcpuclockid.3.d/pthread_getcpuclockid.lint-c.iwyu.touch \
	$(_MANDIR)/man3/pthread_setaffinity_np.3.d/pthread_setaffinity_np.lint-c.iwyu.touch \
	$(_MANDIR)/man3/pthread_setname_np.3.d/pthread_setname_np.lint-c.iwyu.touch \
	$(_MANDIR)/man3/pthread_setschedparam.3.d/pthreads_sched_test.lint-c.iwyu.touch \
	$(_MANDIR)/man3/sem_wait.3.d/sem_wait.lint-c.iwyu.touch \
	$(_MANDIR)/man3/shm_open.3.d/pshm_ucase_bounce.lint-c.iwyu.touch \
	$(_MANDIR)/man3/shm_open.3.d/pshm_ucase_send.lint-c.iwyu.touch \
	$(_MANDIR)/man3/slist.3.d/slist.lint-c.iwyu.touch


_LINT_c_iwyu := $(patsubst %.c, %.lint-c.iwyu.touch, $(_UNITS_ex_c))
ifeq ($(SKIP_XFAIL),yes)
_LINT_c_iwyu := $(filter-out $(_XFAIL_LINT_c_iwyu), $(_LINT_c_iwyu))
endif


$(_LINT_c_iwyu): %.lint-c.iwyu.touch: %.c $(MK)
	$(info	$(INFO_)IWYU		$@)
	! ($(IWYU) $(IWYUFLAGS) $(CPPFLAGS) $(CLANGFLAGS) $< 2>&1 \
	   | $(SED) -n '/should add these lines:/,$$p' \
	   | $(TAC) \
	   | $(SED) '/correct/{N;d}' \
	   | $(TAC) \
	   || $(TRUE); \
	) \
	| $(GREP) ^ >&2
	$(TOUCH) $@


.PHONY: lint-c-iwyu
lint-c-iwyu: $(_LINT_c_iwyu);


endif  # include guard
