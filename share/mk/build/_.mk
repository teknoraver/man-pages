########################################################################
# Copyright 2021-2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_BUILD_INCLUDED
MAKEFILE_BUILD_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/findutils.mk
include $(MAKEFILEDIR)/configure/build-depends/grep.mk
include $(MAKEFILEDIR)/configure/build-depends/sed.mk
include $(MAKEFILEDIR)/configure/build-depends/sortman.mk
include $(MAKEFILEDIR)/src.mk


builddir := .tmp

_MANDIR := $(builddir)/man


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


.PHONY: build
build: build-book build-catman build-html build-pdf build-ps build-src;

.PHONY: clean
clean:
	$(info RM -rf	$(builddir))
	$(RM) -rf $(builddir)


endif  # include guard
