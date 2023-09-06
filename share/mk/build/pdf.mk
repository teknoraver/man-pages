########################################################################
# Copyright 2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_BUILD_PDF_INCLUDED
MAKEFILE_BUILD_PDF_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/build/groff.mk
include $(MAKEFILEDIR)/cmd.mk
include $(MAKEFILEDIR)/src.mk


DEFAULT_GROPDFFLAGS :=
EXTRA_GROPDFFLAGS   :=
GROPDFFLAGS         := $(DEFAULT_GROPDFFLAGS) $(EXTRA_GROPDFFLAGS)
GROPDF              := gropdf


_PDFMAN_troff   := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.pdf.troff,$(NONSO_MAN) $(NONSO_MDOC))
_PDFMAN_MAN_set := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.pdf.set,$(NONSO_MAN))
_PDFMAN_MDOC_set:= $(patsubst $(MANDIR)/%,$(_MANDIR)/%.pdf.set,$(NONSO_MDOC))
_PDFMAN         := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.pdf,$(NONSO_MAN) $(NONSO_MDOC))


$(_PDFMAN_troff): %.pdf.troff: %.eqn $(MK) | $$(@D)/
	$(info	EQN	$@)
	! ($(EQN) -Tpdf $(EQNFLAGS) <$< 2>&1 >$@) \
	| $(GREP) ^ >&2

$(_PDFMAN_MAN_set): %.pdf.set: %.pdf.troff $(MK) | $$(@D)/
	$(info	TROFF	$@)
	! ($(TROFF) -Tpdf $(TROFFFLAGS_MAN) <$< 2>&1 >$@) \
	| $(GREP) ^ >&2

$(_PDFMAN_MDOC_set): %.pdf.set: %.pdf.troff $(MK) | $$(@D)/
	$(info	TROFF	$@)
	! ($(TROFF) -Tpdf $(TROFFFLAGS_MDOC) <$< 2>&1 >$@) \
	| $(GREP) ^ >&2

$(_PDFMAN): %.pdf: %.pdf.set $(MK) | $$(@D)/
	$(info	GROPDF	$@)
	$(GROPDF) $(GROPDFFLAGS) <$< >$@


.PHONY: build-pdf-eqn
build-pdf-eqn: $(_PDFMAN_troff);

.PHONY: build-pdf-troff-man
build-pdf-troff-man: $(_PDFMAN_MAN_set);

.PHONY: build-pdf-troff-mdoc
build-pdf-troff-mdoc: $(_PDFMAN_MDOC_set);

.PHONY: build-pdf-troff
build-pdf-troff: build-pdf-troff-man build-pdf-troff-mdoc;

.PHONY: build-pdf-gropdf
build-pdf-gropdf: $(_PDFMAN);

.PHONY: build-pdf
build-pdf: build-pdf-gropdf;


endif  # include guard
