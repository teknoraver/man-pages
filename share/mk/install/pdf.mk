# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_INSTALL_PDF_INCLUDED
MAKEFILE_INSTALL_PDF_INCLUDED := 1


include $(MAKEFILEDIR)/build/book.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/install.mk
include $(MAKEFILEDIR)/configure/directory_variables/install.mk


_pdfdir := $(DESTDIR)$(pdfdir)


_pdf    := $(patsubst $(_BOOKDIR)/%,$(_pdfdir)/%,$(_BOOK))
_pdf_rm := $(addsuffix -rm,$(wildcard $(_pdf)))


$(_pdf): $(_pdfdir)/%: $(_BOOKDIR)/% $(MK) | $$(@D)/
	$(info	$(INFO_)INSTALL		$@)
	$(INSTALL_DATA) -T $< $@


.PHONY: install-pdf
install-pdf: $(_pdf);

.PHONY: uninstall-pdf
uninstall-pdf: $(_pdf_rm);


endif  # include guard
