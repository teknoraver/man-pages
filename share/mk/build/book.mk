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


LMBDIR   := $(CURDIR)/scripts/LinuxManBook


BOOK      := $(DISTNAME).pdf
_BOOKDIR  := $(builddir)
_BOOK     := $(_BOOKDIR)/$(BOOK)


$(_BOOK): $(_MANPAGES) $(wildcard $(LMBDIR)/* $(LMBDIR)/*/*) | $$(@D)/
	$(info	$(INFO_)GROPDF		$@)
	( \
		$(CAT) "$(LMBDIR)"/LMBfront.roff; \
		$(CAT) "$(LMBDIR)"/an.tmac; \
		"$(LMBDIR)"/prepare.pl "$(_MANDIR)"; \
	) \
	| $(PRECONV) \
	| $(PIC) \
	| $(TBL) \
	| $(EQN) -Tpdf \
	| $(TROFF) -Tpdf -F"$(LMBDIR)" -dpaper=a4 $(TROFFFLAGS) \
	| $(GROPDF) -F"$(LMBDIR)" -pa4 $(GROPDFFLAGS) \
	| $(SPONGE) $@


.PHONY: build-book
build-book: $(_BOOK);


endif  # include guard
