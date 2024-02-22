# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_MAN_MANDOC_INCLUDED
MAKEFILE_LINT_MAN_MANDOC_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/grep.mk
include $(MAKEFILEDIR)/configure/build-depends/mandoc.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/lint/man/_.mk


mandoc_man_ignore_grep := $(DATAROOTDIR)/lint/mandoc/man.ignore.grep


$(_LINT_man_mandoc): $(_MANDIR)/%.lint-man.mandoc.touch: $(MANDIR)/% $(mandoc_man_ignore_grep) $(MK) | $$(@D)/
	$(info	$(INFO_)MANDOC		$@)
	! ($(MANDOC) -man $(MANDOCFLAGS) $< 2>&1 \
	   | $(GREP) -v -f '$(mandoc_man_ignore_grep)' \
	   || $(TRUE); \
	) \
	| $(GREP) ^ >&2
	$(TOUCH) $@


endif  # include guard
