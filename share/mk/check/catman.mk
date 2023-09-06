########################################################################
# Copyright 2021-2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_CHECK_CATMAN_INCLUDED
MAKEFILE_CHECK_CATMAN_INCLUDED := 1


include $(MAKEFILEDIR)/cmd.mk
include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/build/catman.mk
include $(MAKEFILEDIR)/check/_.mk
include $(MAKEFILEDIR)/src.mk


DEFAULT_COLFLAGS := \
	-b \
	-p \
	-x
EXTRA_COLFLAGS   :=
COLFLAGS         := $(DEFAULT_COLFLAGS) $(EXTRA_COLFLAGS)
COL              := col


_CHECK_catman_grep := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.cat.grep,$(NONSO_MAN) $(NONSO_MDOC))
_CHECK_catman := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.check-catman.touch,$(NONSO_MAN) $(NONSO_MDOC))


$(_CHECK_catman_grep): %.grep: % $(MK) | $$(@D)/
	$(info	COL	$@)
	$(COL) $(COLFLAGS) <$< >$@

$(_CHECK_catman): %.check-catman.touch: %.cat.grep $(MK) | $$(@D)/
	$(info	GREP	$@)
	! $(GREP) -n '.\{$(MANWIDTH)\}.' $< /dev/null >&2
	touch $@


.PHONY: check-catman-col
check-catman-col: $(_CHECK_catman_grep);

.PHONY: check-catman-grep
check-catman-grep: $(_CHECK_catman);

.PHONY: check-catman
check-catman: check-catman-grep;


endif  # include guard
