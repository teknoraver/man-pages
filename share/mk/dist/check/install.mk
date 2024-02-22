# Copyright 2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_CHECK_INSTALL_INCLUDED
MAKEFILE_DIST_CHECK_INSTALL_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/sed.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/dist/check/_.mk


_DESTDIR := $(builddir)/destdir


$(builddir)/distcheck.install.touch: $(_DISTCHECKDIR)/$(DISTNAME) | $$(@D)/
	$(info	$(INFO_)MAKE		install)
	$(MAKE) -C $< install DESTDIR=$(_DESTDIR) \
		'INFO_= install:		'
	$(TOUCH) $@


endif  # include guard
