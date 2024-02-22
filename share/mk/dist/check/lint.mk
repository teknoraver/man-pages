# Copyright 2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_CHECK_LINT_INCLUDED
MAKEFILE_DIST_CHECK_LINT_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/sed.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/configure/verbose.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/dist/check/_.mk


DISTCHECK_IGNORE_LINT_MAN := \
	$(_DISTCHECK_MANDIR)/man3/pthread_cond_init.3.lint-man.mandoc.touch \
	$(_DISTCHECK_MANDIR)/man3/pthread_key_create.3.lint-man.mandoc.touch \
	$(_DISTCHECK_MANDIR)/man3/pthread_mutex_init.3.lint-man.mandoc.touch \
	$(_DISTCHECK_MANDIR)/man5/dir_colors.5.lint-man.mandoc.touch \
	$(_DISTCHECK_MANDIR)/man7/bpf-helpers.7.lint-man.mandoc.touch \
	$(_DISTCHECK_MANDIR)/man7/uri.7.lint-man.mandoc.touch \
	$(_DISTCHECK_MANDIR)/man8/zic.8.lint-man.mandoc.touch


$(builddir)/distcheck.lint-man.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		lint-man)
	$(MAKE) -C $< -k lint-man \
		'INFO_= lint-man -k:		' builddir=$(_DISTCHECKBUILDDIR)  $(HIDE_ERR) \
	|| $(TRUE)
	$(MAKE) -C $< -i nothing $(DISTCHECK_IGNORE_LINT_MAN) \
		'INFO_= lint-man -i:		' builddir=$(_DISTCHECKBUILDDIR)  $(HIDE_ERR)
	$(MAKE) -C $< lint-man \
		'INFO_= lint-man:		' builddir=$(_DISTCHECKBUILDDIR)
	$(TOUCH) $@

$(builddir)/distcheck.lint-mdoc.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		lint-mdoc)
	$(MAKE) -C $< lint-mdoc \
		'INFO_= lint-mdoc:		' builddir=$(_DISTCHECKBUILDDIR)
	$(TOUCH) $@


endif  # include guard
