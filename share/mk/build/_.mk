########################################################################
# Copyright 2021-2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_BUILD_INCLUDED
MAKEFILE_BUILD_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk


_MANDIR := $(builddir)/man


.PHONY: build
build: build-book build-catman build-html build-pdf build-ps build-ex;

.PHONY: clean
clean:
	$(info	RM -rf		$(builddir))
	$(RM) -rf $(builddir)


endif  # include guard
