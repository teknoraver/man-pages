# Copyright 2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_CHECK_ALL_INCLUDED
MAKEFILE_DIST_CHECK_ALL_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/dist/check/_.mk


$(builddir)/distcheck.all.touch: \
	$(builddir)/distcheck.check.touch \
	$(builddir)/distcheck.build-ps.touch \
	$(builddir)/distcheck.build-pdf.touch \
	$(builddir)/distcheck.build-html.touch \
	$(builddir)/distcheck.build-book.touch \
	$(builddir)/distcheck.lint-man.touch \
	$(builddir)/distcheck.lint-mdoc.touch
$(builddir)/distcheck.all.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	#$(info	$(INFO_)MAKE		all)
	#$(MAKE) $(_MAKE_OPTS) all \
	#	'INFO_= all:			'
	$(TOUCH) $@


endif  # include guard
