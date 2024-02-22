# Copyright 2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_CHECK_TAR_INCLUDED
MAKEFILE_DIST_CHECK_TAR_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/tar.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/dist/tar.mk


TMPDIR1 := $(shell $(MKTEMP) -d)
TMPDIR2 := $(shell $(MKTEMP) -d)


$(TMPDIR1)/$(DISTNAME).tar: $(DISTFILE) | $$(@D)/
	$(info	$(INFO_)CP		$@)
	$(CP) $< $@

$(TMPDIR1)/$(DISTNAME): %: %.tar | $$(@D)/
	$(info	$(INFO_)TAR xf		$<)
	cd $(dir $<) \
	&& $(TAR) xf $<
	$(TOUCH) $@


endif  # include guard
