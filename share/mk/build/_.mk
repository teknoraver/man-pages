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


NONSO_MAN := $(shell $(FIND) $(MANDIR)/* -type f \
		| $(GREP) '$(MANEXT)' \
		| $(XARGS) $(GREP) -l '^\.TH ' \
		| $(SORTMAN) \
		| $(SED) 's,:,\\:,g')
NONSO_MDOC := $(shell $(FIND) $(MANDIR)/* -type f \
		| $(GREP) '$(MANEXT)' \
		| $(XARGS) $(GREP) -l '^\.Dt ' \
		| $(SORTMAN) \
		| $(SED) 's,:,\\:,g')


$(builddir)/%/:
	+$(info MKDIR	$@)
	+$(MKDIR) $@


.PHONY: build
build: build-book build-catman build-html build-pdf build-ps build-src;

.PHONY: clean
clean:
	$(info RM -rf	$(builddir))
	$(RM) -rf $(builddir)


endif  # include guard
