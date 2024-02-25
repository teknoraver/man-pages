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
	$(MAKE) $(_MAKE_OPTS) -k lint-man \
		'INFO_= lint-man -k:		' \
		$(HIDE_ERR) \
	|| $(TRUE)
	$(MAKE) $(_MAKE_OPTS) -i nothing $(DISTCHECK_IGNORE_LINT_MAN) \
		'INFO_= lint-man -i:		' \
		$(HIDE_ERR)
	$(MAKE) $(_MAKE_OPTS) lint-man \
		'INFO_= lint-man:		'
	$(TOUCH) $@

$(builddir)/distcheck.lint-mdoc.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		lint-mdoc)
	$(MAKE) $(_MAKE_OPTS) lint-mdoc \
		'INFO_= lint-mdoc:		'
	$(TOUCH) $@


.PHONY: distcheck-lint-man
distcheck-lint-man: $(builddir)/distcheck.lint-man.touch;

.PHONY: distcheck-lint-mdoc
distcheck-lint-mdoc: $(builddir)/distcheck.lint-mdoc.touch;


.PHONY: distcheck-lint
distcheck-lint: distcheck-lint-man distcheck-lint-mdoc;


endif  # include guard
