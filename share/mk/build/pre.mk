########################################################################
# Copyright 2021-2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_BUILD_PRE_INCLUDED
MAKEFILE_BUILD_PRE_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base.mk
include $(MAKEFILEDIR)/src.mk


_MAN_tbl := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.tbl,$(NONSO_MAN) $(NONSO_MDOC))
_MAN_eqn := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.eqn,$(NONSO_MAN) $(NONSO_MDOC))


$(_MAN_tbl): $(_MANDIR)/%.tbl: $(MANDIR)/% $(MK) | $$(@D)/
	$(info	PRECONV	$@)
	$(PRECONV) $(PRECONVFLAGS) $< >$@

$(_MAN_eqn): %.eqn: %.tbl $(MK) | $$(@D)/
	$(info	TBL	$@)
	$(TBL) <$< >$@


.PHONY: build-pre-preconv
build-pre-preconv: $(_MAN_tbl);

.PHONY: build-pre-tbl
build-pre-tbl: $(_MAN_eqn);

.PHONY: build-pre
build-pre: build-pre-tbl;


endif  # include guard
