# Copyright 2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_CHECK_INSTALL_INCLUDED
MAKEFILE_DIST_CHECK_INSTALL_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/sed.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/dist/check/_.mk


$(builddir)/distcheck.install.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		install)
	$(MAKE) $(_MAKE_OPTS) install \
		'INFO_= install:		'
	$(TOUCH) $@


endif  # include guard
