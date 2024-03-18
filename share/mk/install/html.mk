########################################################################
# Copyright 2021-2022, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_INSTALL_HTML_INCLUDED
MAKEFILE_INSTALL_HTML_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/build/html/post-grohtml.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/install/_.mk


_htmldir := $(DESTDIR)$(htmldir)


_htmlpages      := $(patsubst $(_MANDIR)/%,$(_htmldir)/%,$(_HTMLMAN))
_htmlpages_rm   := $(addsuffix -rm,$(wildcard $(_htmlpages)))


$(_htmlpages): $(_htmldir)/%: $(_MANDIR)/% $(MK) | $$(@D)/
	$(info	$(INFO_)INSTALL		$@)
	$(INSTALL_DATA) -T $< $@


.PHONY: install-html
install-html: $(_htmlpages);

.PHONY: uninstall-html
uninstall-html: $(_htmlpages_rm);


endif  # include guard
