# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_BUILD_HTML_TROFF_INCLUDED
MAKEFILE_BUILD_HTML_TROFF_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/build-depends/grep.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base.mk
include $(MAKEFILEDIR)/configure/src.mk
include $(MAKEFILEDIR)/configure/xfail.mk
include $(MAKEFILEDIR)/src.mk


_XFAIL_HTMLMAN_MAN_set := \
	$(_MANDIR)/man2/membarrier.2.html.set \
	$(_MANDIR)/man5/proc.5.html.set \
	$(_MANDIR)/man7/charsets.7.html.set \
	$(_MANDIR)/man7/iso_8859-16.7.html.set \
	$(_MANDIR)/man7/iso_8859-6.7.html.set


_HTMLMAN_MAN_set := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.html.set,$(NONSO_MAN))
_HTMLMAN_MDOC_set:= $(patsubst $(MANDIR)/%,$(_MANDIR)/%.html.set,$(NONSO_MDOC))


ifeq ($(SKIP_XFAIL),yes)
_HTMLMAN_MAN_set := $(filter-out $(_XFAIL_HTMLMAN_MAN_set), $(_HTMLMAN_MAN_set))
endif


$(_HTMLMAN_MAN_set): %.html.set: %.eqn $(MK) | $$(@D)/
	$(info	$(INFO_)TROFF		$@)
	! ($(TROFF) -man -Thtml $(TROFFFLAGS) <$< 2>&1 >$@) \
	| $(GREP) ^ >&2

$(_HTMLMAN_MDOC_set): %.html.set: %.eqn $(MK) | $$(@D)/
	$(info	$(INFO_)TROFF		$@)
	! ($(TROFF) -mdoc -Thtml $(TROFFFLAGS) <$< 2>&1 >$@) \
	| $(GREP) ^ >&2


.PHONY: build-html-troff-man
build-html-troff-man: $(_HTMLMAN_MAN_set);

.PHONY: build-html-troff-mdoc
build-html-troff-mdoc: $(_HTMLMAN_MDOC_set);

.PHONY: build-html-troff
build-html-troff: build-html-troff-man build-html-troff-mdoc;


endif  # include guard
