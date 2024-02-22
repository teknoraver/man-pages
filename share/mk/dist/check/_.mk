# Copyright 2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_CHECK_INCLUDED
MAKEFILE_DIST_CHECK_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk


_DISTCHECKDIR      := $(shell $(REALPATH) -m $(builddir)/distcheck)
_DISTCHECKSRCDIR   := $(_DISTCHECKDIR)/$(DISTNAME)
_DISTCHECKBUILDDIR := $(_DISTCHECKDIR)/$(DISTNAME)_builddir
_DISTCHECKDESTDIR  := $(_DISTCHECKDIR)/$(DISTNAME)_destdir
_DISTCHECK_MANDIR  := $(_DISTCHECKBUILDDIR)/man


.PHONY: distcheck
distcheck: \
	$(builddir)/distcheck.all.touch \
	$(builddir)/distcheck.install.touch \
	$(builddir)/distcheck.diffoscope.touch


endif  # include guard
