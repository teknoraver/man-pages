########################################################################
# Copyright 2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_BUILD_PS_INCLUDED
MAKEFILE_BUILD_PS_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/build/groff.mk
include $(MAKEFILEDIR)/cmd.mk
include $(MAKEFILEDIR)/src.mk


DEFAULT_GROPSFLAGS :=
EXTRA_GROPSFLAGS   :=
GROPSFLAGS         := $(DEFAULT_GROPSFLAGS) $(EXTRA_GROPSFLAGS)
GROPS              := grops


_PSMAN_troff   := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.ps.troff,$(NONSO_MAN) $(NONSO_MDOC))
_PSMAN_MAN_set := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.ps.set,$(NONSO_MAN))
_PSMAN_MDOC_set:= $(patsubst $(MANDIR)/%,$(_MANDIR)/%.ps.set,$(NONSO_MDOC))
_PSMAN         := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.ps,$(NONSO_MAN) $(NONSO_MDOC))


$(_PSMAN_troff): %.ps.troff: %.eqn $(MK) | $$(@D)/
	$(info	EQN	$@)
	! ($(EQN) -Tps $(EQNFLAGS) <$< 2>&1 >$@) \
	| $(GREP) ^ >&2

$(_PSMAN_MAN_set): %.ps.set: %.ps.troff $(MK) | $$(@D)/
	$(info	TROFF	$@)
	! ($(TROFF) -Tps $(TROFFFLAGS_MAN) <$< 2>&1 >$@) \
	| $(GREP) ^ >&2

$(_PSMAN_MDOC_set): %.ps.set: %.ps.troff $(MK) | $$(@D)/
	$(info	TROFF	$@)
	! ($(TROFF) -Tps $(TROFFFLAGS_MDOC) <$< 2>&1 >$@) \
	| $(GREP) ^ >&2

$(_PSMAN): %.ps: %.ps.set $(MK) | $$(@D)/
	$(info	GROPS	$@)
	$(GROPS) $(GROPSFLAGS) <$< >$@


.PHONY: build-ps-eqn
build-ps-eqn: $(_PSMAN_troff);

.PHONY: build-ps-troff-man
build-ps-troff-man: $(_PSMAN_MAN_set);

.PHONY: build-ps-troff-mdoc
build-ps-troff-mdoc: $(_PSMAN_MDOC_set);

.PHONY: build-ps-troff
build-ps-troff: build-ps-troff-man build-ps-troff-mdoc;

.PHONY: build-ps-grops
build-ps-grops: $(_PSMAN);

.PHONY: build-ps
build-ps: build-ps-grops;


endif  # include guard
