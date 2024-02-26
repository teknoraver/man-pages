# Copyright 2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_DIST_CHECK_BUILD_INCLUDED
MAKEFILE_DIST_CHECK_BUILD_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/configure/verbose.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/dist/check/_.mk
include $(MAKEFILEDIR)/dist/tar.mk


$(builddir)/distcheck.build-pre.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		build-pre)
	$(MAKE) $(_MAKE_OPTS) build-pre \
		'INFO_= build-pre:		'
	$(TOUCH) $@

$(builddir)/distcheck.build-catman.touch: $(builddir)/distcheck.build-pre.touch
$(builddir)/distcheck.build-catman.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		build-catman)
	$(MAKE) $(_MAKE_OPTS) build-catman \
		'INFO_= build-catman:		'
	$(TOUCH) $@

$(builddir)/distcheck.build-ps.touch: $(builddir)/distcheck.build-pre.touch
$(builddir)/distcheck.build-ps.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		build-ps)
	$(MAKE) $(_MAKE_OPTS) build-ps \
		'INFO_= build-ps:		'
	$(TOUCH) $@

$(builddir)/distcheck.build-pdf.touch: $(builddir)/distcheck.build-pre.touch
$(builddir)/distcheck.build-pdf.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		build-pdf)
	$(MAKE) $(_MAKE_OPTS) build-pdf \
		'INFO_= build-pdf:		'
	$(TOUCH) $@

$(builddir)/distcheck.build-html.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		build-html)
	$(MAKE) $(_MAKE_OPTS) build-html \
		'INFO_= build-html:		'
	$(TOUCH) $@

$(builddir)/distcheck.build-book.touch: $(_DISTCHECKDIR)/$(DISTNAME) $(MK) | $$(@D)/
	$(info	$(INFO_)MAKE		build-book)
	$(MAKE) $(_MAKE_OPTS) -k build-book \
		'INFO_= build-book -k:		' \
		$(HIDE_ERR) \
	|| $(TRUE)
	$(MAKE) $(_MAKE_OPTS) build-book \
		'INFO_= build-book:		'
	$(TOUCH) $@


.PHONY: distcheck-build-pre
distcheck-build-pre: $(builddir)/distcheck.build-pre.touch;

.PHONY: distcheck-build-catman
distcheck-build-catman: $(builddir)/distcheck.build-catman.touch;

.PHONY: distcheck-build-ps
distcheck-build-ps: $(builddir)/distcheck.build-ps.touch;

.PHONY: distcheck-build-pdf
distcheck-build-pdf: $(builddir)/distcheck.build-pdf.touch;

.PHONY: distcheck-build-html
distcheck-build-html: $(builddir)/distcheck.build-html.touch;

.PHONY: distcheck-build-book
distcheck-build-book: $(builddir)/distcheck.build-book.touch;


.PHONY: distcheck-build
distcheck-build: \
	distcheck-build-pre \
	distcheck-build-catman \
	distcheck-build-ps \
	distcheck-build-pdf \
	distcheck-build-html \
	distcheck-build-book;


endif  # include guard
