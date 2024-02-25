# Copyright 2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_CHECK_DIST_INCLUDED
MAKEFILE_DIST_CHECK_DIST_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/sed.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/dist/check/_.mk
include $(MAKEFILEDIR)/dist/check/tar.mk


REDIST := $(_DISTCHECKBUILDDIR)/$(DISTNAME).tar


$(REDIST): $(_DISTCHECKSRCDIR) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		dist)
	$(MAKE) $(_MAKE_OPTS) dist \
		'INFO_= dist:			'


.PHONY: distcheck-dist
distcheck-dist: $(REDIST);


endif  # include guard
