########################################################################
# Copyright (C) 2021 - 2023 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier:  GPL-3.0-or-later  OR  LGPL-3.0-or-later
########################################################################


ifndef MAKEFILE_CHECK_CATMAN_INCLUDED
MAKEFILE_CHECK_CATMAN_INCLUDED := 1


include $(srcdir)/lib/cmd.mk
include $(srcdir)/lib/build.mk
include $(srcdir)/lib/build-catman.mk
include $(srcdir)/lib/check.mk
include $(srcdir)/lib/src.mk


DEFAULT_COLFLAGS := -b
DEFAULT_COLFLAGS += -p
DEFAULT_COLFLAGS += -x
EXTRA_COLFLAGS   :=
COLFLAGS         := $(DEFAULT_COLFLAGS) $(EXTRA_COLFLAGS)
COL              := col


_CHECK_catman_grep := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.cat.grep,$(NONSO_MAN))
_CHECK_catman := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.check-catman.touch,$(NONSO_MAN))


$(_CHECK_catman_grep): %.grep: % | $$(@D)/
	$(info	COL	$@)
	$(COL) $(COLFLAGS) <$< >$@

$(_CHECK_catman): %.check-catman.touch: %.cat.grep | $$(@D)/
	$(info	GREP	$@)
	! $(GREP) -n '.\{$(MANWIDTH)\}.' $< /dev/null >&2
	touch $@


.PHONY: check-catman-col
check-catman-col: $(_CHECK_catman_grep)
	@:

.PHONY: check-catman-grep
check-catman-grep: $(_CHECK_catman)
	@:

.PHONY: check-catman
check-catman: check-catman-grep
	@:


endif  # MAKEFILE_CHECK_CATMAN_INCLUDED
