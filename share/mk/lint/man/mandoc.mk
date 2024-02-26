# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_MAN_MANDOC_INCLUDED
MAKEFILE_LINT_MAN_MANDOC_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/grep.mk
include $(MAKEFILEDIR)/configure/build-depends/mandoc.mk
include $(MAKEFILEDIR)/configure/src.mk
include $(MAKEFILEDIR)/configure/xfail.mk
include $(MAKEFILEDIR)/lint/man/_.mk
include $(MAKEFILEDIR)/src.mk


_XFAIL_LINT_man_mandoc := \
	$(_MANDIR)/man3/pthread_cond_init.3.lint-man.mandoc.touch \
	$(_MANDIR)/man3/pthread_key_create.3.lint-man.mandoc.touch \
	$(_MANDIR)/man3/pthread_mutex_init.3.lint-man.mandoc.touch \
	$(_MANDIR)/man5/dir_colors.5.lint-man.mandoc.touch \
	$(_MANDIR)/man7/bpf-helpers.7.lint-man.mandoc.touch \
	$(_MANDIR)/man7/uri.7.lint-man.mandoc.touch \
	$(_MANDIR)/man8/zic.8.lint-man.mandoc.touch


_LINT_man_mandoc := \
	$(patsubst $(MANDIR)/%, $(_MANDIR)/%.lint-man.mandoc.touch, $(NONSO_MAN))
ifeq ($(SKIP_XFAIL),yes)
_LINT_man_mandoc := $(filter-out $(_XFAIL_LINT_man_mandoc), $(_LINT_man_mandoc))
endif


mandoc_man_ignore_grep := $(DATAROOTDIR)/lint/mandoc/man.ignore.grep


$(_LINT_man_mandoc): $(_MANDIR)/%.lint-man.mandoc.touch: $(MANDIR)/% $(mandoc_man_ignore_grep) $(MK) | $$(@D)/
	$(info	$(INFO_)MANDOC		$@)
	! ($(MANDOC) -man $(MANDOCFLAGS) $< 2>&1 \
	   | $(GREP) -v -f '$(mandoc_man_ignore_grep)' \
	   || $(TRUE); \
	) \
	| $(GREP) ^ >&2
	$(TOUCH) $@


.PHONY: lint-man-mandoc
lint-man-mandoc: $(_LINT_man_mandoc);


endif  # include guard
