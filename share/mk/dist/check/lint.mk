# Copyright 2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_CHECK_LINT_INCLUDED
MAKEFILE_DIST_CHECK_LINT_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/moreutils.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/configure/verbose.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/dist/check/tar.mk


DISTCHECK_IGNORE_LINT_MAN := \
	$(_MANDIR)/man3/pthread_cond_init.3.lint-man.mandoc.touch \
	$(_MANDIR)/man3/pthread_key_create.3.lint-man.mandoc.touch \
	$(_MANDIR)/man3/pthread_mutex_init.3.lint-man.mandoc.touch \
	$(_MANDIR)/man5/dir_colors.5.lint-man.mandoc.touch \
	$(_MANDIR)/man7/bpf-helpers.7.lint-man.mandoc.touch \
	$(_MANDIR)/man7/uri.7.lint-man.mandoc.touch \
	$(_MANDIR)/man8/zic.8.lint-man.mandoc.touch


$(builddir)/distcheck.lint-man.touch: $(TMPDIR1)/$(DISTNAME) | $$(@D)/
	$(info	MAKE		lint-man)
	$(MAKE) -C $< -k lint-man $(HIDE_ERR) \
	| $(TS) 'MAKE lint-man (-k $(HIDE_ERR)):' \
	|| $(TRUE)
	$(MAKE) -C $< -i nothing $(DISTCHECK_IGNORE_LINT_MAN) $(HIDE_ERR) \
	| $(TS) 'MAKE lint-man (-i $(HIDE_ERR)):'
	$(MAKE) -C $< lint-man \
	| $(TS) 'MAKE lint-man:'
	$(TOUCH) $@

$(builddir)/distcheck.lint-mdoc.touch: $(TMPDIR1)/$(DISTNAME) | $$(@D)/
	$(info	MAKE		lint-mdoc)
	$(MAKE) -C $< lint-mdoc \
	| $(TS) 'MAKE lint-mdoc:'
	$(TOUCH) $@


endif  # include guard
