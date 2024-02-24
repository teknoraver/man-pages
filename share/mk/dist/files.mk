# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_FILES_INCLUDED
MAKEFILE_DIST_FILES_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/git.mk
include $(MAKEFILEDIR)/configure/build-depends/sed.mk
include $(MAKEFILEDIR)/configure/verbose.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/dist/_.mk


DISTFILES   := $(shell $(DISTFILESCMD) | $(SED) 's,:,\\:,g')
_DISTFILES  := $(patsubst $(srcdir)/%,$(_DISTDIR)/%,$(DISTFILES))
_DISTPAGES  := $(filter     $(_DISTDIR)/man%,$(_DISTFILES))
_DISTVERSION:= $(_DISTDIR)/share/mk/configure/version.mk
_DISTOTHERS := $(filter-out $(_DISTPAGES) $(_DISTVERSION), $(_DISTFILES))


FORCE_DISTVERSION := \
	$(shell \
		if $(TEST) -f $(_DISTVERSION); then \
			<$(_DISTVERSION) \
			$(GREP) \
				-e '^DISTVERSION :=' \
				-e '^DISTNAME :=' \
				-e '^DISTDATE :=' \
			| $(GREP) -v '^DISTVERSION := $(DISTVERSION)$$' \
			| $(GREP) -v '^DISTNAME := $(DISTNAME)$$' \
			| $(GREP) -v '^DISTDATE := $(DISTDATE)$$' $(HIDE_ERR) >&2 \
			&& $(ECHO) FORCE; \
		fi; \
	)


$(_DISTPAGES): $(_DISTDIR)/man%: $(srcdir)/man% $(MK) | $$(@D)/
	$(info	$(INFO_)CP		$@)
	<$< \
	$(SED) "/^.TH/s/(date)/$$($(GIT) log --format=%cs -1 -- $< $(HIDE_ERR))/" \
	| $(SED) '/^.TH/s/(unreleased)/$(DISTVERSION)/' \
	| $(INSTALL_DATA) -T /dev/stdin $@

$(_DISTVERSION): $(MAKEFILEDIR)/configure/version.mk $(MK) $(FORCE_DISTVERSION) | $$(@D)/
	$(info	$(INFO_)SED		$@)
	<$< \
	$(SED) 's/^DISTVERSION *:=.*/DISTVERSION := $(DISTVERSION)/' \
	| $(SED) 's/^DISTNAME *:=.*/DISTNAME := $(DISTNAME)/' \
	| $(SED) 's/^DISTDATE *:=.*/DISTDATE := $(DISTDATE)/' \
	| $(INSTALL_DATA) -T /dev/stdin $@

$(_DISTOTHERS): $(_DISTDIR)/%: $(srcdir)/% $(MK) | $$(@D)/
	$(info	$(INFO_)CP		$@)
	$(CP) -dT $< $@


endif  # include guard
