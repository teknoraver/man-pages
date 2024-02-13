########################################################################
# Copyright 2021-2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_BUILD_CATMAN_INCLUDED
MAKEFILE_BUILD_CATMAN_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/grep.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base.mk
include $(MAKEFILEDIR)/src.mk


groff_man_ignore_grep := $(DATAROOTDIR)/lint/groff/man.ignore.grep


_CATMAN_troff   := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.cat.troff,$(NONSO_MAN) $(NONSO_MDOC))
_CATMAN_MAN_set := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.cat.set,$(NONSO_MAN))
_CATMAN_MDOC_set:= $(patsubst $(MANDIR)/%,$(_MANDIR)/%.cat.set,$(NONSO_MDOC))
_CATMAN         := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.cat,$(NONSO_MAN) $(NONSO_MDOC))


$(_CATMAN_troff): %.cat.troff: %.eqn $(MK) | $$(@D)/
	$(info	EQN	$@)
	! ($(EQN) -T$(NROFF_OUT_DEVICE) $(EQNFLAGS) <$< 2>&1 >$@) \
	| $(GREP) ^ >&2

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

$(_CATMAN): %.cat: %.cat.set $(MK) | $$(@D)/
	$(info	GROTTY	$@)
	$(GROTTY) $(GROTTYFLAGS) <$< >$@


.PHONY: build-catman-eqn
build-catman-eqn: $(_CATMAN_troff);

.PHONY: build-catman-troff-man
build-catman-troff-man: $(_CATMAN_MAN_set);

.PHONY: build-catman-troff-mdoc
build-catman-troff-mdoc: $(_CATMAN_MDOC_set);

.PHONY: build-catman-troff
build-catman-troff: build-catman-troff-man build-catman-troff-mdoc;

.PHONY: build-catman-grotty
build-catman-grotty: $(_CATMAN);

.PHONY: build-catman
build-catman: build-catman-grotty;


endif  # include guard
