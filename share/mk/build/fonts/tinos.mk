# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_BUILD_FONTS_TINOS_INCLUDED
MAKEFILE_BUILD_FONTS_TINOS_INCLUDED := 1


include $(MAKEFILEDIR)/build/fonts/_.mk
include $(MAKEFILEDIR)/configure/build-depends/texlive-fonts-extra/Tinos.pfb.mk
include $(MAKEFILEDIR)/configure/build-depends/groff/pfbtops.mk


TINOR := $(MAKEFILEDIR)/build/fonts/devpdf/TINOR


_TINOS_PFA := $(_FONTSDIR)/devpdf/Tinos.pfa
_TINOR     := $(_FONTSDIR)/devpdf/TINOR

_TINOS := $(_TINOS_PFA) $(_TINOR)


$(_TINOS_PFA): $(TINOS_PFB) $(MK) | $$(@D)/
	$(info	$(INFO_)PFBTOPS		$@)
	$(PFBTOPS) <$< >$@

$(_TINOR): $(_FONTSDIR)/%: $(MAKEFILEDIR)/build/fonts/% $(MK) | $$(@D)/
	$(info	$(INFO_)CP		$@)
	$(CP) -T $< $@


.PHONY: build-fonts-tinos
build-fonts-tinos: $(_TINOS)


endif  # include guard
