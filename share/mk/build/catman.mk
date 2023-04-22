########################################################################
# Copyright (C) 2021 - 2023  Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier:  GPL-3.0-or-later  OR  LGPL-3.0-or-later
########################################################################


ifndef MAKEFILE_BUILD_CATMAN_INCLUDED
MAKEFILE_BUILD_CATMAN_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/cmd.mk
include $(MAKEFILEDIR)/src.mk


TMACDIR := $(SYSCONFDIR)/groff/tmac


MANWIDTH          ?= 80
NROFF_LINE_LENGTH := $(shell $(EXPR) $(MANWIDTH) - 2)
NROFF_OUT_DEVICE  := $(shell $(LOCALE) charmap \
                             | $(GREP) -i 'utf-*8' >/dev/null \
                                 && $(ECHO) utf8 \
                                 || $(ECHO) ascii)

DEFAULT_PRECONVFLAGS :=
EXTRA_PRECONVFLAGS   :=
PRECONVFLAGS         := $(DEFAULT_PRECONVFLAGS) $(EXTRA_PRECONVFLAGS)
PRECONV              := preconv

TBL := tbl

DEFAULT_EQNFLAGS :=
EXTRA_EQNFLAGS   :=
EQNFLAGS         := $(DEFAULT_EQNFLAGS) $(EXTRA_EQNFLAGS)
EQN              := eqn

TMACFILES            := $(shell $(FIND) $(TMACDIR) -not -type d | $(SORT))
TMACNAMES            := $(basename $(notdir $(TMACFILES)))
TROFF_CHECKSTYLE_LVL := 3
DEFAULT_TROFFFLAGS   := -man
DEFAULT_TROFFFLAGS   += -t
DEFAULT_TROFFFLAGS   += -M $(TMACDIR)
DEFAULT_TROFFFLAGS   += $(foreach x,$(TMACNAMES),-m $(x))
DEFAULT_TROFFFLAGS   += -rCHECKSTYLE=$(TROFF_CHECKSTYLE_LVL)
DEFAULT_TROFFFLAGS   += -ww
DEFAULT_TROFFFLAGS   += -rLL=$(NROFF_LINE_LENGTH)n
EXTRA_TROFFFLAGS     :=
TROFFFLAGS           := $(DEFAULT_TROFFFLAGS) $(EXTRA_TROFFFLAGS)
TROFF                := troff

DEFAULT_GROTTYFLAGS := -c
EXTRA_GROTTYFLAGS   :=
GROTTYFLAGS         := $(DEFAULT_GROTTYFLAGS) $(EXTRA_GROTTYFLAGS)
GROTTY              := grotty


_MAN_tbl       := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.tbl,$(NONSO_MAN))
_MAN_eqn       := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.eqn,$(NONSO_MAN))
_CATMAN_troff  := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.cat.troff,$(NONSO_MAN))
_CATMAN_set    := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.cat.set,$(NONSO_MAN))
_CATMAN        := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.cat,$(NONSO_MAN))


$(_MAN_tbl): $(_MANDIR)/%.tbl: $(MANDIR)/% | $$(@D)/
	$(info	PRECONV	$@)
	$(PRECONV) $(PRECONVFLAGS) $< >$@

$(_MAN_eqn): %.eqn: %.tbl | $$(@D)/
	$(info	TBL	$@)
	$(TBL) <$< >$@

$(_CATMAN_troff): %.cat.troff: %.eqn | $$(@D)/
	$(info	EQN	$@)
	$(EQN) -T$(NROFF_OUT_DEVICE) $(EQNFLAGS) <$< 2>&1 >$@ \
	| ( ! $(GREP) ^ )

$(_CATMAN_set): %.cat.set: %.cat.troff | $$(@D)/
	$(info	TROFF	$@)
	$(TROFF) -T$(NROFF_OUT_DEVICE) $(TROFFFLAGS) <$< 2>&1 >$@ \
	| ( ! $(GREP) ^ )

$(_CATMAN): %.cat: %.cat.set | $$(@D)/
	$(info	GROTTY	$@)
	$(GROTTY) $(GROTTYFLAGS) <$< >$@


.PHONY: build-catman-preconv
build-catman-preconv: $(_MAN_tbl)
	@:

.PHONY: build-catman-tbl
build-catman-tbl: $(_MAN_eqn)
	@:

.PHONY: build-catman-eqn
build-catman-eqn: $(_CATMAN_troff)
	@:

.PHONY: build-catman-troff
build-catman-troff: $(_CATMAN_set)
	@:

.PHONY: build-catman-grotty
build-catman-grotty: $(_CATMAN)
	@:

.PHONY: build-catman
build-catman: build-catman-grotty
	@:


endif  # MAKEFILE_BUILD_CATMAN_INCLUDED
