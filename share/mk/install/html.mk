########################################################################
# Copyright 2021-2022, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_INSTALL_HTML_INCLUDED
MAKEFILE_INSTALL_HTML_INCLUDED := 1


include $(MAKEFILEDIR)/build/html.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/install/_.mk


htmldir  := $(docdir)
htmldir_ := $(htmldir)/man
_htmldir := $(DESTDIR)$(htmldir_)


_htmlpages      := $(patsubst $(_HTMLDIR)/%,$(_htmldir)/%,$(_HTMLPAGES))
_htmlpages_rm   := $(addsuffix -rm,$(wildcard $(_htmlpages)))


$(_htmlpages): $(_htmldir)/%: $(_HTMLDIR)/% $(MK) | $$(@D)/
	$(info INSTALL	$@)
	$(INSTALL_DATA) -T $< $@


.PHONY: install-html
install-html: $(_htmlpages);

.PHONY: uninstall-html
uninstall-html: $(_htmlpages_rm);


endif  # include guard
