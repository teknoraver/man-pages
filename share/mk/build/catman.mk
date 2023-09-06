########################################################################
# Copyright 2021-2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_BUILD_CATMAN_INCLUDED
MAKEFILE_BUILD_CATMAN_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/build/groff.mk
include $(MAKEFILEDIR)/cmd.mk
include $(MAKEFILEDIR)/src.mk


groff_man_ignore_grep := $(DATAROOTDIR)/lint/groff/man.ignore.grep

MANWIDTH             ?= 80
TROFF_CHECKSTYLE_LVL := 3
NROFF_LINE_LENGTH    := $(shell $(EXPR) $(MANWIDTH) - 2)
NROFF_OUT_DEVICE     := $(shell $(LOCALE) charmap \
                                | $(GREP) -i 'utf-*8' >/dev/null \
                                    && $(ECHO) utf8 \
                                    || $(ECHO) ascii)

DEFAULT_NROFFFLAGS := \
	-T$(NROFF_OUT_DEVICE) \
	-rLL=$(NROFF_LINE_LENGTH)n \
	-rCHECKSTYLE=$(TROFF_CHECKSTYLE_LVL) \
	-ww
EXTRA_NROFFFLAGS   :=
NROFFFLAGS         := $(DEFAULT_NROFFFLAGS) $(EXTRA_NROFFFLAGS)

DEFAULT_GROTTYFLAGS := -c
EXTRA_GROTTYFLAGS   :=
GROTTYFLAGS         := $(DEFAULT_GROTTYFLAGS) $(EXTRA_GROTTYFLAGS)
GROTTY              := grotty


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
	! ($(TROFF) $(TROFFFLAGS_MAN) $(NROFFFLAGS) <$< 2>&1 >$@ \
	   | $(GREP) -v -f '$(groff_man_ignore_grep)' \
	   ||:; \
	) \
	| $(GREP) ^ >&2

$(_CATMAN_MDOC_set): %.cat.set: %.cat.troff $(MK) | $$(@D)/
	$(info	TROFF	$@)
	! ($(TROFF) $(TROFFFLAGS_MDOC) $(NROFFFLAGS) <$< 2>&1 >$@) \
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
