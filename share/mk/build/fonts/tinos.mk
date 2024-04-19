# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_BUILD_FONTS_TINOS_INCLUDED
MAKEFILE_BUILD_FONTS_TINOS_INCLUDED := 1


include $(MAKEFILEDIR)/build/fonts/_.mk
include $(MAKEFILEDIR)/configure/build-depends/texlive-fonts-extra/Tinos.pfb.mk
include $(MAKEFILEDIR)/configure/build-depends/texlive-fonts-extra-links/Tinos-Regular.ttf.mk
include $(MAKEFILEDIR)/configure/build-depends/fontforge/fontforge.mk
include $(MAKEFILEDIR)/configure/build-depends/groff/afmtodit.mk
include $(MAKEFILEDIR)/configure/build-depends/groff/pfbtops.mk


_TINOS_PFA  := $(_FONTSDIR)/devpdf/Tinos.pfa
_TINOSR_AFM := $(_FONTSDIR)/devpdf/TinosR.afm
_TINOSR     := $(_FONTSDIR)/devpdf/TinosR
_TINOS      := $(_TINOS_PFA) $(_TINOSR)


$(_TINOS_PFA): $(TINOS_PFB) $(MK) | $$(@D)/
	$(info	$(INFO_)PFBTOPS		$@)
	$(PFBTOPS) <$< >$@

$(_TINOSR_AFM): $(TINOSR_TTF) $(MK) | $$(@D)/
	$(info	$(INFO_)FONTFORGE	$@)
	$(FONTFORGE) $(FONTFORGEFLAGS) -lang=ff -c 'Open("$<");Generate("$@");'

$(_TINOSR): $(_FONTSDIR)/%: $(PDF_TEXT_ENC) $(_TINOSR_AFM) $(PDF_TEXT_MAP) $(MK) | $$(@D)/
	$(info	$(INFO_)AFMTODIT	$@)
	$(AFMTODIT) -e $(PDF_TEXT_ENC) $(_TINOSR_AFM) $(PDF_TEXT_MAP) $@


.PHONY: build-fonts-tinos
build-fonts-tinos: $(_TINOS)


endif  # include guard
