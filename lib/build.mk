########################################################################
# Copyright (C) 2021, 2022  Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier:  GPL-2.0  OR  LGPL-2.0
########################################################################


ifndef MAKEFILE_BUILD_INCLUDED
MAKEFILE_BUILD_INCLUDED := 1


include $(srcdir)/lib/cmd.mk
include $(srcdir)/lib/src.mk


builddir := .tmp

SYSCONFDIR := $(srcdir)/etc

_SRCDIR := $(builddir)/src
_MANDIR := $(builddir)/man


MKDIR := mkdir -p
RM    := rm


NONSO_MAN := $(shell $(FIND) $(MANDIR)/man*/ -type f \
		| $(GREP) '$(MANEXT)' \
		| $(XARGS) $(GREP) -l '^\.TH ' \
		| $(SORT))
_MANDIRS := $(patsubst $(MANDIR)/%,$(_MANDIR)/%/,$(MANDIRS))
_SRCDIRS := $(patsubst $(MANDIR)/%,$(_SRCDIR)/%/,$(MANDIRS))


$(_MANDIRS): %/: | $$(dir %) $(_MANDIR)/
$(_SRCDIRS): %/: | $$(dir %) $(_SRCDIR)/


$(builddir)/%/:
	+$(info MKDIR	$(@D)/)
	+$(MKDIR) $(@D)


.PHONY: build
build: build-catman build-html build-src
	@:

.PHONY: clean
clean:
	$(info RM -rf	$(builddir))
	$(RM) -rf $(builddir)


endif  # MAKEFILE_BUILD_INCLUDED
