# Copyright 2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_CHECK_CHECK_INCLUDED
MAKEFILE_DIST_CHECK_CHECK_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/tar.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/configure/verbose.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/dist/check/_.mk


DISTCHECK_IGNORE_CHECK_CATMAN := \
	$(_DISTCHECK_MANDIR)/man1/memusage.1.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man3/mallopt.3.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man3/unlocked_stdio.3.cat.grep \
	$(_DISTCHECK_MANDIR)/man3/unlocked_stdio.3.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man4/console_codes.4.cat.grep \
	$(_DISTCHECK_MANDIR)/man4/console_codes.4.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man4/lirc.4.cat.grep \
	$(_DISTCHECK_MANDIR)/man4/lirc.4.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man4/smartpqi.4.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man4/veth.4.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man5/proc_buddyinfo.5.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man5/proc_pid_fdinfo.5.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man5/proc_pid_maps.5.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man5/proc_pid_mountinfo.5.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man5/proc_pid_net.5.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man5/proc_pid_smaps.5.cat.grep \
	$(_DISTCHECK_MANDIR)/man5/proc_pid_smaps.5.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man5/proc_timer_stats.5.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man5/proc_version.5.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man5/slabinfo.5.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man5/tzfile.5.cat.grep \
	$(_DISTCHECK_MANDIR)/man5/tzfile.5.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/ascii.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/ascii.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/bpf-helpers.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/bpf-helpers.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/charsets.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/charsets.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-1.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-1.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-10.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-10.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-11.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-11.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-13.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-13.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-14.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-14.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-15.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-15.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-16.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-16.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-2.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-2.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-3.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-3.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-4.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-4.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-5.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-5.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-6.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-6.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-7.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-7.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-8.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-8.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-9.7.cat.grep \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-9.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/keyrings.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man7/uri.7.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man8/tzselect.8.cat.grep \
	$(_DISTCHECK_MANDIR)/man8/tzselect.8.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man8/zdump.8.cat.grep \
	$(_DISTCHECK_MANDIR)/man8/zdump.8.check-catman.touch \
	$(_DISTCHECK_MANDIR)/man8/zic.8.cat.grep \
	$(_DISTCHECK_MANDIR)/man8/zic.8.check-catman.touch


$(builddir)/distcheck.check-catman.touch: \
	$(builddir)/distcheck.build-catman.touch
$(builddir)/distcheck.check-catman.touch: $(_DISTCHECKDIR)/$(DISTNAME) | $$(@D)/
	$(info	$(INFO_)MAKE		check-catman)
	$(MAKE) -C $< -k check-catman \
		'INFO_= check-catman -k:	' builddir=$(_DISTCHECKBUILDDIR) $(HIDE_ERR) \
	|| $(TRUE)
	$(MAKE) -C $< -i nothing $(DISTCHECK_IGNORE_CHECK_CATMAN) \
		'INFO_= check-catman -i:	' builddir=$(_DISTCHECKBUILDDIR)  $(HIDE_ERR)
	$(MAKE) -C $< check-catman \
		'INFO_= check-catman:		' builddir=$(_DISTCHECKBUILDDIR)
	$(TOUCH) $@

$(builddir)/distcheck.check.touch: \
	$(builddir)/distcheck.check-catman.touch
$(builddir)/distcheck.check.touch: $(_DISTCHECKDIR)/$(DISTNAME) | $$(@D)/
	$(info	$(INFO_)MAKE		check)
	$(MAKE) -C $< check \
		'INFO_= check:			' builddir=$(_DISTCHECKBUILDDIR)
	$(TOUCH) $@


endif  # include guard
