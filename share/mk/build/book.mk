# Copyright 2023-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_BUILD_BOOK_INCLUDED
MAKEFILE_BUILD_BOOK_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/build/man/_.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/cat.mk
include $(MAKEFILEDIR)/configure/build-depends/groff/gropdf.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base/eqn.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base/pic.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base/preconv.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base/tbl.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base/troff.mk
include $(MAKEFILEDIR)/configure/build-depends/moreutils/sponge.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/src.mk


LMBDIR   := $(CURDIR)/scripts/LinuxManBook
BUILDLMB := $(LMBDIR)/build.sh


LMB      := $(DISTNAME).pdf
_LMBDIR  := $(builddir)
_LMB     := $(_LMBDIR)/$(LMB)


$(_LMB): $(_MANPAGES) $(wildcard $(LMBDIR)/* $(LMBDIR)/*/*) | $$(@D)/
	$(info	$(INFO_)Build		$@)
	CAT='$(CAT)' \
	PRECONV='$(PRECONV)' \
	PIC='$(PIC)' \
	TBL='$(TBL)' \
	EQN='$(EQN)' \
	TROFF='$(TROFF)' \
	GROPDF='$(GROPDF)' \
	$(BUILDLMB) $(_MANDIR) \
	| $(SPONGE) $@


.PHONY: build-book
build-book: $(_LMB);


endif  # include guard
