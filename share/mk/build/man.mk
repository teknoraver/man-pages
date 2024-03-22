# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_BUILD_MAN_MAN_INCLUDED
MAKEFILE_BUILD_MAN_MAN_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/git/git.mk
include $(MAKEFILEDIR)/configure/build-depends/sed/sed.mk
include $(MAKEFILEDIR)/configure/src.mk
include $(MAKEFILEDIR)/configure/verbose.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/src.mk


_MANPAGES := $(patsubst $(MANDIR)/%,$(_MANDIR)/%,$(MANPAGES))


$(_MANPAGES): $(_MANDIR)/%: $(MANDIR)/% $(MK) | $$(@D)/
	$(info	$(INFO_)SED		$@)
	<$< \
	$(SED) "/^\.TH/s/(date)/$$($(GIT) log --format=%cs -1 -- $< $(HIDE_ERR))/" \
	| $(SED) '/^\.TH/s/(unreleased)/$(DISTVERSION)/' >$@


.PHONY: build-man
build-man: $(_MANPAGES)


endif  # include guard
