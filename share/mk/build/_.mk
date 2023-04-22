########################################################################
# Copyright 2021-2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_BUILD_INCLUDED
MAKEFILE_BUILD_INCLUDED := 1


include $(MAKEFILEDIR)/cmd.mk
include $(MAKEFILEDIR)/src.mk


builddir := .tmp

SYSCONFDIR := $(srcdir)/etc

_MANDIR := $(builddir)/man


MKDIR := mkdir -p
RM    := rm


NONSO_MAN := $(shell $(FIND) $(MANDIR)/man*/ -type f \
		| $(GREP) '$(MANEXT)' \
		| $(XARGS) $(GREP) -l '^\.TH ' \
		| $(SORT))
NONSO_MDOC := $(shell $(FIND) $(MANDIR)/man*/ -type f \
		| $(GREP) '$(MANEXT)' \
		| $(XARGS) $(GREP) -l '^\.Dt ' \
		| $(SORT))
_MANDIRS := $(patsubst $(MANDIR)/%,$(_MANDIR)/%/,$(MANDIRS))


$(_MANDIRS): %/: | $$(dir %) $(_MANDIR)/


$(builddir)/%/:
	+$(info MKDIR	$@)
	+$(MKDIR) $@


.PHONY: build
build: build-catman build-html build-src
	@:

.PHONY: clean
clean:
	$(info RM -rf	$(builddir))
	$(RM) -rf $(builddir)


endif  # MAKEFILE_BUILD_INCLUDED
