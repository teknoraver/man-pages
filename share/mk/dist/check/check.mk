# Copyright 2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_CHECK_CHECK_INCLUDED
MAKEFILE_DIST_CHECK_CHECK_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/tar.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/configure/verbose.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/dist/check/_.mk


$(builddir)/distcheck.check-catman.touch: \
	$(builddir)/distcheck.build-catman.touch
$(builddir)/distcheck.check-catman.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		check-catman)
	$(MAKE) $(_MAKE_OPTS) check-catman \
		'INFO_= check-catman:		'
	$(TOUCH) $@

$(builddir)/distcheck.check.touch: \
	$(builddir)/distcheck.check-catman.touch
$(builddir)/distcheck.check.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		check)
	$(MAKE) $(_MAKE_OPTS) check \
		'INFO_= check:			'
	$(TOUCH) $@


.PHONY: distcheck-check
distcheck-check: $(builddir)/distcheck.check.touch;


endif  # include guard
