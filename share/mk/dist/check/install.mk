# Copyright 2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_CHECK_INSTALL_INCLUDED
MAKEFILE_DIST_CHECK_INSTALL_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/moreutils.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/dist/check/tar.mk


$(builddir)/distcheck.install.touch: $(TMPDIR1)/$(DISTNAME) | $$(@D)/
	$(info	MAKE		install)
	$(MAKE) -C $< install DESTDIR=$(TMPDIR2) \
	| $(TS) 'MAKE install:'
	$(TOUCH) $@


endif  # include guard
