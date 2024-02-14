# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_BUILD_CATMAN_TROFF_INCLUDED
MAKEFILE_BUILD_CATMAN_TROFF_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/build-depends/grep.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base.mk
include $(MAKEFILEDIR)/configure/src.mk
include $(MAKEFILEDIR)/src.mk


groff_man_ignore_grep := $(DATAROOTDIR)/lint/groff/man.ignore.grep


_CATMAN_MAN_set  := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.cat.set,$(NONSO_MAN))
_CATMAN_MDOC_set := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.cat.set,$(NONSO_MDOC))


$(_CATMAN_MAN_set): %.cat.set: %.cat.troff $(groff_man_ignore_grep) $(MK) | $$(@D)/
	$(info	TROFF	$@)
	! ($(TROFF) -man $(TROFFFLAGS) $(NROFFFLAGS) <$< 2>&1 >$@ \
	   | $(GREP) -v -f '$(groff_man_ignore_grep)' \
	   ||:; \
	) \
	| $(GREP) ^ >&2

$(_CATMAN_MDOC_set): %.cat.set: %.cat.troff $(MK) | $$(@D)/
	$(info	TROFF	$@)
	! ($(TROFF) -mdoc $(TROFFFLAGS) $(NROFFFLAGS) <$< 2>&1 >$@) \
	| $(GREP) ^ >&2


.PHONY: build-catman-troff-man
build-catman-troff-man: $(_CATMAN_MAN_set);

.PHONY: build-catman-troff-mdoc
build-catman-troff-mdoc: $(_CATMAN_MDOC_set);

.PHONY: build-catman-troff
build-catman-troff: build-catman-troff-man build-catman-troff-mdoc;


endif  # include guard
