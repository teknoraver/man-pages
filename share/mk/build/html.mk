########################################################################
# Copyright 2021-2022, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_BUILD_HTML_INCLUDED
MAKEFILE_BUILD_HTML_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/build-depends/man2html.mk
include $(MAKEFILEDIR)/configure/build-depends/sed.mk
include $(MAKEFILEDIR)/src.mk


htmlext  := .html
_HTMLDIR := $(builddir)/html


_HTMLPAGES := $(patsubst $(MANDIR)/%,$(_HTMLDIR)/%$(htmlext),$(MANPAGES))


# Use with
#  make MAN2HTMLFLAGS=whatever html
# The sed removes the lines "Content-type: text/html\n\n"
$(_HTMLPAGES): $(_HTMLDIR)/%$(htmlext): $(MANDIR)/% $(MK) | $$(@D)/
	$(info MAN2HTML	$@)
	$(MAN2HTML) $(MAN2HTMLFLAGS) $< \
	| $(SED) -e 1,2d >$@


.PHONY: build-html html
build-html html: $(_HTMLPAGES);


endif  # include guard
