# Copyright 2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_CHECK_BUILD_INCLUDED
MAKEFILE_DIST_CHECK_BUILD_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/configure/verbose.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/dist/check/_.mk
include $(MAKEFILEDIR)/dist/tar.mk


DISTCHECK_IGNORE_BUILD_CATMAN := \
	$(_DISTCHECK_MANDIR)/man2/fanotify_init.2.cat \
	$(_DISTCHECK_MANDIR)/man2/fanotify_init.2.cat.set \
	$(_DISTCHECK_MANDIR)/man3/unlocked_stdio.3.cat \
	$(_DISTCHECK_MANDIR)/man3/unlocked_stdio.3.cat.set \
	$(_DISTCHECK_MANDIR)/man4/console_codes.4.cat \
	$(_DISTCHECK_MANDIR)/man4/console_codes.4.cat.set \
	$(_DISTCHECK_MANDIR)/man4/lirc.4.cat \
	$(_DISTCHECK_MANDIR)/man4/lirc.4.cat.set \
	$(_DISTCHECK_MANDIR)/man5/proc_pid_smaps.5.cat \
	$(_DISTCHECK_MANDIR)/man5/proc_pid_smaps.5.cat.set \
	$(_DISTCHECK_MANDIR)/man5/tzfile.5.cat \
	$(_DISTCHECK_MANDIR)/man5/tzfile.5.cat.set \
	$(_DISTCHECK_MANDIR)/man7/ascii.7.cat \
	$(_DISTCHECK_MANDIR)/man7/ascii.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/bpf-helpers.7.cat \
	$(_DISTCHECK_MANDIR)/man7/bpf-helpers.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/charsets.7.cat \
	$(_DISTCHECK_MANDIR)/man7/charsets.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-1.7.cat \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-1.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-10.7.cat \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-10.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-11.7.cat \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-11.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-13.7.cat \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-13.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-14.7.cat \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-14.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-15.7.cat \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-15.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-16.7.cat \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-16.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-2.7.cat \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-2.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-3.7.cat \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-3.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-4.7.cat \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-4.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-5.7.cat \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-5.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-6.7.cat \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-6.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-7.7.cat \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-7.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-8.7.cat \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-8.7.cat.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-9.7.cat \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-9.7.cat.set \
	$(_DISTCHECK_MANDIR)/man8/tzselect.8.cat \
	$(_DISTCHECK_MANDIR)/man8/tzselect.8.cat.set \
	$(_DISTCHECK_MANDIR)/man8/zdump.8.cat \
	$(_DISTCHECK_MANDIR)/man8/zdump.8.cat.set \
	$(_DISTCHECK_MANDIR)/man8/zic.8.cat \
	$(_DISTCHECK_MANDIR)/man8/zic.8.cat.set

DISTCHECK_IGNORE_BUILD_PS := \
	$(_DISTCHECK_MANDIR)/man1/iconv.1.ps \
	$(_DISTCHECK_MANDIR)/man1/iconv.1.ps.set \
	$(_DISTCHECK_MANDIR)/man2/fanotify_init.2.ps \
	$(_DISTCHECK_MANDIR)/man2/fanotify_init.2.ps.set \
	$(_DISTCHECK_MANDIR)/man2/syscall.2.ps \
	$(_DISTCHECK_MANDIR)/man2/syscall.2.ps.set \
	$(_DISTCHECK_MANDIR)/man3/newlocale.3.ps \
	$(_DISTCHECK_MANDIR)/man3/newlocale.3.ps.set \
	$(_DISTCHECK_MANDIR)/man7/address_families.7.ps \
	$(_DISTCHECK_MANDIR)/man7/address_families.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/armscii-8.7.ps \
	$(_DISTCHECK_MANDIR)/man7/armscii-8.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/ascii.7.ps \
	$(_DISTCHECK_MANDIR)/man7/ascii.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/bpf-helpers.7.ps \
	$(_DISTCHECK_MANDIR)/man7/bpf-helpers.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/charsets.7.ps \
	$(_DISTCHECK_MANDIR)/man7/charsets.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/cp1251.7.ps \
	$(_DISTCHECK_MANDIR)/man7/cp1251.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-10.7.ps \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-10.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-11.7.ps \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-11.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-13.7.ps \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-13.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-14.7.ps \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-14.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-16.7.ps \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-16.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-2.7.ps \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-2.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-3.7.ps \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-3.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-4.7.ps \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-4.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-5.7.ps \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-5.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-6.7.ps \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-6.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-7.7.ps \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-7.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-8.7.ps \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-8.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/koi8-r.7.ps \
	$(_DISTCHECK_MANDIR)/man7/koi8-r.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/koi8-u.7.ps \
	$(_DISTCHECK_MANDIR)/man7/koi8-u.7.ps.set \
	$(_DISTCHECK_MANDIR)/man7/vdso.7.ps \
	$(_DISTCHECK_MANDIR)/man7/vdso.7.ps.set

DISTCHECK_IGNORE_BUILD_PDF := \
	$(_DISTCHECK_MANDIR)/man1/iconv.1.pdf \
	$(_DISTCHECK_MANDIR)/man1/iconv.1.pdf.set \
	$(_DISTCHECK_MANDIR)/man2/fanotify_init.2.pdf \
	$(_DISTCHECK_MANDIR)/man2/fanotify_init.2.pdf.set \
	$(_DISTCHECK_MANDIR)/man2/syscall.2.pdf \
	$(_DISTCHECK_MANDIR)/man2/syscall.2.pdf.set \
	$(_DISTCHECK_MANDIR)/man3/newlocale.3.pdf \
	$(_DISTCHECK_MANDIR)/man3/newlocale.3.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/address_families.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/address_families.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/armscii-8.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/armscii-8.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/ascii.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/ascii.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/bpf-helpers.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/bpf-helpers.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/charsets.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/charsets.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/cp1251.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/cp1251.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-10.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-10.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-11.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-11.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-13.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-13.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-14.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-14.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-16.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-16.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-2.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-2.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-3.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-3.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-4.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-4.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-5.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-5.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-6.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-6.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-7.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-7.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-8.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/iso_8859-8.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/koi8-r.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/koi8-r.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/koi8-u.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/koi8-u.7.pdf.set \
	$(_DISTCHECK_MANDIR)/man7/vdso.7.pdf \
	$(_DISTCHECK_MANDIR)/man7/vdso.7.pdf.set


$(builddir)/distcheck.build-pre.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		build-pre)
	$(MAKE) $(_MAKE_OPTS) build-pre \
		'INFO_= build-pre:		'
	$(TOUCH) $@

$(builddir)/distcheck.build-catman.touch: $(builddir)/distcheck.build-pre.touch
$(builddir)/distcheck.build-catman.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		build-catman)
	$(MAKE) $(_MAKE_OPTS) -k build-catman \
		'INFO_= build-catman -k:	' \
		$(HIDE_ERR) \
	|| $(TRUE)
	$(MAKE) $(_MAKE_OPTS) -i nothing $(DISTCHECK_IGNORE_BUILD_CATMAN) \
		'INFO_= build-catman -i:	' \
		$(HIDE_ERR)
	$(MAKE) $(_MAKE_OPTS) build-catman \
		'INFO_= build-catman:		'
	$(TOUCH) $@

$(builddir)/distcheck.build-ps.touch: $(builddir)/distcheck.build-pre.touch
$(builddir)/distcheck.build-ps.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		build-ps)
	$(MAKE) $(_MAKE_OPTS) -k build-ps \
		'INFO_= build-ps -k:		' \
		$(HIDE_ERR) \
	|| $(TRUE)
	$(MAKE) $(_MAKE_OPTS) -i nothing $(DISTCHECK_IGNORE_BUILD_PS) \
		'INFO_= build-ps -i:		' \
		$(HIDE_ERR)
	$(MAKE) $(_MAKE_OPTS) build-ps \
		'INFO_= build-ps:		'
	$(TOUCH) $@

$(builddir)/distcheck.build-pdf.touch: $(builddir)/distcheck.build-pre.touch
$(builddir)/distcheck.build-pdf.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		build-pdf)
	$(MAKE) $(_MAKE_OPTS) -k build-pdf \
		'INFO_= build-pdf -k:		' \
		$(HIDE_ERR) \
	|| $(TRUE)
	$(MAKE) $(_MAKE_OPTS) -i nothing $(DISTCHECK_IGNORE_BUILD_PDF) \
		'INFO_= build-pdf -i:		' \
		$(HIDE_ERR)
	$(MAKE) $(_MAKE_OPTS) build-pdf \
		'INFO_= build-pdf:		'
	$(TOUCH) $@

$(builddir)/distcheck.build-html.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		build-html)
	$(MAKE) $(_MAKE_OPTS) build-html \
		'INFO_= build-html:		'
	$(TOUCH) $@

$(builddir)/distcheck.build-book.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		build-book)
	$(MAKE) $(_MAKE_OPTS) -k build-book \
		'INFO_= build-book -k:		' \
		$(HIDE_ERR) \
	|| $(TRUE)
	$(MAKE) $(_MAKE_OPTS) build-book \
		'INFO_= build-book:		'
	$(TOUCH) $@


.PHONY: distcheck-build-pre
distcheck-build-pre: $(builddir)/distcheck.build-pre.touch;

.PHONY: distcheck-build-catman
distcheck-build-catman: $(builddir)/distcheck.build-catman.touch;

.PHONY: distcheck-build-ps
distcheck-build-ps: $(builddir)/distcheck.build-ps.touch;

.PHONY: distcheck-build-pdf
distcheck-build-pdf: $(builddir)/distcheck.build-pdf.touch;

.PHONY: distcheck-build-html
distcheck-build-html: $(builddir)/distcheck.build-html.touch;

.PHONY: distcheck-build-book
distcheck-build-book: $(builddir)/distcheck.build-book.touch;


.PHONY: distcheck-build
distcheck-build: \
	distcheck-build-pre \
	distcheck-build-catman \
	distcheck-build-ps \
	distcheck-build-pdf \
	distcheck-build-html \
	distcheck-build-book;


endif  # include guard
