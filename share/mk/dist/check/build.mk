# Copyright 2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_CHECK_BUILD_INCLUDED
MAKEFILE_DIST_CHECK_BUILD_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/moreutils.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/configure/verbose.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/dist/check/tar.mk
include $(MAKEFILEDIR)/dist/tar.mk


DISTCHECK_IGNORE_BUILD_CATMAN := \
	$(_MANDIR)/man3/unlocked_stdio.3.cat \
	$(_MANDIR)/man3/unlocked_stdio.3.cat.set \
	$(_MANDIR)/man4/console_codes.4.cat \
	$(_MANDIR)/man4/console_codes.4.cat.set \
	$(_MANDIR)/man4/lirc.4.cat \
	$(_MANDIR)/man4/lirc.4.cat.set \
	$(_MANDIR)/man5/proc_pid_smaps.5.cat \
	$(_MANDIR)/man5/proc_pid_smaps.5.cat.set \
	$(_MANDIR)/man5/tzfile.5.cat \
	$(_MANDIR)/man5/tzfile.5.cat.set \
	$(_MANDIR)/man7/ascii.7.cat \
	$(_MANDIR)/man7/ascii.7.cat.set \
	$(_MANDIR)/man7/bpf-helpers.7.cat \
	$(_MANDIR)/man7/bpf-helpers.7.cat.set \
	$(_MANDIR)/man7/charsets.7.cat \
	$(_MANDIR)/man7/charsets.7.cat.set \
	$(_MANDIR)/man7/iso_8859-1.7.cat \
	$(_MANDIR)/man7/iso_8859-1.7.cat.set \
	$(_MANDIR)/man7/iso_8859-10.7.cat \
	$(_MANDIR)/man7/iso_8859-10.7.cat.set \
	$(_MANDIR)/man7/iso_8859-11.7.cat \
	$(_MANDIR)/man7/iso_8859-11.7.cat.set \
	$(_MANDIR)/man7/iso_8859-13.7.cat \
	$(_MANDIR)/man7/iso_8859-13.7.cat.set \
	$(_MANDIR)/man7/iso_8859-14.7.cat \
	$(_MANDIR)/man7/iso_8859-14.7.cat.set \
	$(_MANDIR)/man7/iso_8859-15.7.cat \
	$(_MANDIR)/man7/iso_8859-15.7.cat.set \
	$(_MANDIR)/man7/iso_8859-16.7.cat \
	$(_MANDIR)/man7/iso_8859-16.7.cat.set \
	$(_MANDIR)/man7/iso_8859-2.7.cat \
	$(_MANDIR)/man7/iso_8859-2.7.cat.set \
	$(_MANDIR)/man7/iso_8859-3.7.cat \
	$(_MANDIR)/man7/iso_8859-3.7.cat.set \
	$(_MANDIR)/man7/iso_8859-4.7.cat \
	$(_MANDIR)/man7/iso_8859-4.7.cat.set \
	$(_MANDIR)/man7/iso_8859-5.7.cat \
	$(_MANDIR)/man7/iso_8859-5.7.cat.set \
	$(_MANDIR)/man7/iso_8859-6.7.cat \
	$(_MANDIR)/man7/iso_8859-6.7.cat.set \
	$(_MANDIR)/man7/iso_8859-7.7.cat \
	$(_MANDIR)/man7/iso_8859-7.7.cat.set \
	$(_MANDIR)/man7/iso_8859-8.7.cat \
	$(_MANDIR)/man7/iso_8859-8.7.cat.set \
	$(_MANDIR)/man7/iso_8859-9.7.cat \
	$(_MANDIR)/man7/iso_8859-9.7.cat.set \
	$(_MANDIR)/man8/tzselect.8.cat \
	$(_MANDIR)/man8/tzselect.8.cat.set \
	$(_MANDIR)/man8/zdump.8.cat \
	$(_MANDIR)/man8/zdump.8.cat.set \
	$(_MANDIR)/man8/zic.8.cat \
	$(_MANDIR)/man8/zic.8.cat.set

DISTCHECK_IGNORE_BUILD_PS := \
	$(_MANDIR)/man1/iconv.1.ps \
	$(_MANDIR)/man1/iconv.1.ps.set \
	$(_MANDIR)/man2/syscall.2.ps \
	$(_MANDIR)/man2/syscall.2.ps.set \
	$(_MANDIR)/man3/newlocale.3.ps \
	$(_MANDIR)/man3/newlocale.3.ps.set \
	$(_MANDIR)/man7/address_families.7.ps \
	$(_MANDIR)/man7/address_families.7.ps.set \
	$(_MANDIR)/man7/armscii-8.7.ps \
	$(_MANDIR)/man7/armscii-8.7.ps.set \
	$(_MANDIR)/man7/ascii.7.ps \
	$(_MANDIR)/man7/ascii.7.ps.set \
	$(_MANDIR)/man7/bpf-helpers.7.ps \
	$(_MANDIR)/man7/bpf-helpers.7.ps.set \
	$(_MANDIR)/man7/charsets.7.ps \
	$(_MANDIR)/man7/charsets.7.ps.set \
	$(_MANDIR)/man7/cp1251.7.ps \
	$(_MANDIR)/man7/cp1251.7.ps.set \
	$(_MANDIR)/man7/iso_8859-10.7.ps \
	$(_MANDIR)/man7/iso_8859-10.7.ps.set \
	$(_MANDIR)/man7/iso_8859-11.7.ps \
	$(_MANDIR)/man7/iso_8859-11.7.ps.set \
	$(_MANDIR)/man7/iso_8859-13.7.ps \
	$(_MANDIR)/man7/iso_8859-13.7.ps.set \
	$(_MANDIR)/man7/iso_8859-14.7.ps \
	$(_MANDIR)/man7/iso_8859-14.7.ps.set \
	$(_MANDIR)/man7/iso_8859-16.7.ps \
	$(_MANDIR)/man7/iso_8859-16.7.ps.set \
	$(_MANDIR)/man7/iso_8859-2.7.ps \
	$(_MANDIR)/man7/iso_8859-2.7.ps.set \
	$(_MANDIR)/man7/iso_8859-3.7.ps \
	$(_MANDIR)/man7/iso_8859-3.7.ps.set \
	$(_MANDIR)/man7/iso_8859-4.7.ps \
	$(_MANDIR)/man7/iso_8859-4.7.ps.set \
	$(_MANDIR)/man7/iso_8859-5.7.ps \
	$(_MANDIR)/man7/iso_8859-5.7.ps.set \
	$(_MANDIR)/man7/iso_8859-6.7.ps \
	$(_MANDIR)/man7/iso_8859-6.7.ps.set \
	$(_MANDIR)/man7/iso_8859-7.7.ps \
	$(_MANDIR)/man7/iso_8859-7.7.ps.set \
	$(_MANDIR)/man7/iso_8859-8.7.ps \
	$(_MANDIR)/man7/iso_8859-8.7.ps.set \
	$(_MANDIR)/man7/koi8-r.7.ps \
	$(_MANDIR)/man7/koi8-r.7.ps.set \
	$(_MANDIR)/man7/koi8-u.7.ps \
	$(_MANDIR)/man7/koi8-u.7.ps.set \
	$(_MANDIR)/man7/vdso.7.ps \
	$(_MANDIR)/man7/vdso.7.ps.set

DISTCHECK_IGNORE_BUILD_PDF := \
	$(_MANDIR)/man1/iconv.1.pdf \
	$(_MANDIR)/man1/iconv.1.pdf.set \
	$(_MANDIR)/man2/syscall.2.pdf \
	$(_MANDIR)/man2/syscall.2.pdf.set \
	$(_MANDIR)/man3/newlocale.3.pdf \
	$(_MANDIR)/man3/newlocale.3.pdf.set \
	$(_MANDIR)/man7/address_families.7.pdf \
	$(_MANDIR)/man7/address_families.7.pdf.set \
	$(_MANDIR)/man7/armscii-8.7.pdf \
	$(_MANDIR)/man7/armscii-8.7.pdf.set \
	$(_MANDIR)/man7/ascii.7.pdf \
	$(_MANDIR)/man7/ascii.7.pdf.set \
	$(_MANDIR)/man7/bpf-helpers.7.pdf \
	$(_MANDIR)/man7/bpf-helpers.7.pdf.set \
	$(_MANDIR)/man7/charsets.7.pdf \
	$(_MANDIR)/man7/charsets.7.pdf.set \
	$(_MANDIR)/man7/cp1251.7.pdf \
	$(_MANDIR)/man7/cp1251.7.pdf.set \
	$(_MANDIR)/man7/iso_8859-10.7.pdf \
	$(_MANDIR)/man7/iso_8859-10.7.pdf.set \
	$(_MANDIR)/man7/iso_8859-11.7.pdf \
	$(_MANDIR)/man7/iso_8859-11.7.pdf.set \
	$(_MANDIR)/man7/iso_8859-13.7.pdf \
	$(_MANDIR)/man7/iso_8859-13.7.pdf.set \
	$(_MANDIR)/man7/iso_8859-14.7.pdf \
	$(_MANDIR)/man7/iso_8859-14.7.pdf.set \
	$(_MANDIR)/man7/iso_8859-16.7.pdf \
	$(_MANDIR)/man7/iso_8859-16.7.pdf.set \
	$(_MANDIR)/man7/iso_8859-2.7.pdf \
	$(_MANDIR)/man7/iso_8859-2.7.pdf.set \
	$(_MANDIR)/man7/iso_8859-3.7.pdf \
	$(_MANDIR)/man7/iso_8859-3.7.pdf.set \
	$(_MANDIR)/man7/iso_8859-4.7.pdf \
	$(_MANDIR)/man7/iso_8859-4.7.pdf.set \
	$(_MANDIR)/man7/iso_8859-5.7.pdf \
	$(_MANDIR)/man7/iso_8859-5.7.pdf.set \
	$(_MANDIR)/man7/iso_8859-6.7.pdf \
	$(_MANDIR)/man7/iso_8859-6.7.pdf.set \
	$(_MANDIR)/man7/iso_8859-7.7.pdf \
	$(_MANDIR)/man7/iso_8859-7.7.pdf.set \
	$(_MANDIR)/man7/iso_8859-8.7.pdf \
	$(_MANDIR)/man7/iso_8859-8.7.pdf.set \
	$(_MANDIR)/man7/koi8-r.7.pdf \
	$(_MANDIR)/man7/koi8-r.7.pdf.set \
	$(_MANDIR)/man7/koi8-u.7.pdf \
	$(_MANDIR)/man7/koi8-u.7.pdf.set \
	$(_MANDIR)/man7/vdso.7.pdf \
	$(_MANDIR)/man7/vdso.7.pdf.set


$(builddir)/distcheck.build-pre.touch: $(TMPDIR1)/$(DISTNAME) | $$(@D)/
	$(info	MAKE		build-pre)
	$(MAKE) -C $< build-pre \
	| $(TS) 'MAKE build-pre:'
	$(TOUCH) $@

$(builddir)/distcheck.build-catman.touch: $(builddir)/distcheck.build-pre.touch
$(builddir)/distcheck.build-catman.touch: $(TMPDIR1)/$(DISTNAME) | $$(@D)/
	$(info	MAKE		build-catman)
	$(MAKE) -C $< -k build-catman $(HIDE_ERR) \
	| $(TS) 'MAKE build-catman (-k $(HIDE_ERR)):' \
	|| $(TRUE)
	$(MAKE) -C $< -i nothing $(DISTCHECK_IGNORE_BUILD_CATMAN) $(HIDE_ERR) \
	| $(TS) 'MAKE build-catman (-i $(HIDE_ERR)):'
	$(MAKE) -C $< build-catman \
	| $(TS) 'MAKE build-catman:'
	$(TOUCH) $@

$(builddir)/distcheck.build-ps.touch: $(builddir)/distcheck.build-pre.touch
$(builddir)/distcheck.build-ps.touch: $(TMPDIR1)/$(DISTNAME) | $$(@D)/
	$(info	MAKE		build-ps)
	$(MAKE) -C $< -k build-ps $(HIDE_ERR) \
	| $(TS) 'MAKE build-ps (-k $(HIDE_ERR)):' \
	|| $(TRUE)
	$(MAKE) -C $< -i nothing $(DISTCHECK_IGNORE_BUILD_PS) $(HIDE_ERR) \
	| $(TS) 'MAKE build-ps (-i $(HIDE_ERR)):'
	$(MAKE) -C $< build-ps \
	| $(TS) 'MAKE build-ps:'
	$(TOUCH) $@

$(builddir)/distcheck.build-pdf.touch: $(builddir)/distcheck.build-pre.touch
$(builddir)/distcheck.build-pdf.touch: $(TMPDIR1)/$(DISTNAME) | $$(@D)/
	$(info	MAKE		build-pdf)
	$(MAKE) -C $< -k build-pdf $(HIDE_ERR) \
	| $(TS) 'MAKE build-pdf (-k $(HIDE_ERR)):' \
	|| $(TRUE)
	$(MAKE) -C $< -i nothing $(DISTCHECK_IGNORE_BUILD_PDF) $(HIDE_ERR) \
	| $(TS) 'MAKE build-pdf (-i $(HIDE_ERR)):'
	$(MAKE) -C $< build-pdf \
	| $(TS) 'MAKE build-pdf:'
	$(TOUCH) $@

$(builddir)/distcheck.build-html.touch: $(TMPDIR1)/$(DISTNAME) | $$(@D)/
	$(info	MAKE		build-html)
	$(MAKE) -C $< build-html \
	| $(TS) 'MAKE build-html:'
	$(TOUCH) $@

$(builddir)/distcheck.build-book.touch: $(TMPDIR1)/$(DISTNAME) | $$(@D)/
	$(info	MAKE		build-book)
	$(MAKE) -C $< -k build-book $(HIDE_ERR) \
	| $(TS) 'MAKE build-book ($(HIDE_ERR)):' \
	|| $(TRUE)
	$(MAKE) -C $< build-book \
	| $(TS) 'MAKE build-book:'
	$(TOUCH) $@


endif  # include guard
