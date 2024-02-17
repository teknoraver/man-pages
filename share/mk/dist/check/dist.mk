# Copyright 2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_CHECK_DIST_INCLUDED
MAKEFILE_DIST_CHECK_DIST_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/sed.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/dist/check/tar.mk


REDIST  := $(TMPDIR1)/$(DISTNAME)/.tmp/$(DISTNAME).tar


$(REDIST): %/.tmp/$(DISTNAME).tar: % | $$(@D)/
	$(info	MAKE		dist)
	$(MAKE) -C $< dist \
	| $(SED)   's,^,MAKE dist:		,'


endif  # include guard
