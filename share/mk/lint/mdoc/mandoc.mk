# Copyright 2023-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_MDOC_MANDOC_INCLUDED
MAKEFILE_LINT_MDOC_MANDOC_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/grep.mk
include $(MAKEFILEDIR)/configure/build-depends/mandoc.mk
include $(MAKEFILEDIR)/lint/mdoc/_.mk
include $(MAKEFILEDIR)/src.mk


mandoc_mdoc_ignore_grep := $(MAKEFILEDIR)/lint/mdoc/mandoc.ignore.grep


$(_LINT_mdoc_mandoc): $(_MANDIR)/%.lint-mdoc.mandoc.touch: $(MANDIR)/% $(mandoc_mdoc_ignore_grep) | $$(@D)/
	$(info	$(INFO_)MANDOC		$@)
	! ($(MANDOC) -mdoc $(MANDOCFLAGS) $< 2>&1 \
	   | $(GREP) -v -f '$(mandoc_mdoc_ignore_grep)' \
	   || $(TRUE); \
	) \
	| $(GREP) ^ >&2
	$(TOUCH) $@


endif  # include guard
