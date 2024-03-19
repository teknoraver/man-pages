# Copyright 2023-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_BUILD_BOOK_INCLUDED
MAKEFILE_BUILD_BOOK_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/cat.mk
include $(MAKEFILEDIR)/configure/build-depends/groff/gropdf.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base/eqn.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base/pic.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base/preconv.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base/tbl.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base/troff.mk
include $(MAKEFILEDIR)/configure/build-depends/moreutils/sponge.mk
include $(MAKEFILEDIR)/configure/src.mk
include $(MAKEFILEDIR)/src.mk


LMBDIR   := $(srcdir)/scripts/LinuxManBook
BUILDLMB := $(LMBDIR)/build.sh


_LMB     := $(_MANDIR)/man-pages.pdf


$(_LMB): $(MANPAGES) $(wildcard $(LMBDIR)/* $(LMBDIR)/*/*) | $$(@D)/
	$(info	$(INFO_)Build		$@)
	CAT='$(CAT)' \
	PRECONV='$(PRECONV)' \
	PIC='$(PIC)' \
	TBL='$(TBL)' \
	EQN='$(EQN)' \
	TROFF='$(TROFF)' \
	GROPDF='$(GROPDF)' \
	$(BUILDLMB) $(MANDIR) \
	| $(SPONGE) $@


.PHONY: build-book
build-book: $(_LMB);


endif  # include guard
