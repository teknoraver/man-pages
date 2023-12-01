########################################################################
# Copyright 2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_BUILD_BOOK_INCLUDED
MAKEFILE_BUILD_BOOK_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/src.mk


LMBDIR   := $(srcdir)/scripts/LinuxManBook
BUILDLMB := $(LMBDIR)/build.sh


_LMB     := $(_MANDIR)/man-pages.pdf


$(_LMB): $(MANPAGES) $(wildcard $(LMBDIR)/* $(LMBDIR)/*/*) | $$(@D)/
	$(info	Build	$@)
	$(BUILDLMB) $(MANDIR) >$@


.PHONY: build-book
build-book: $(_LMB);


endif  # include guard
