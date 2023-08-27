########################################################################
# Copyright 2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_LINT_MAN_MDOC_INCLUDED
MAKEFILE_LINT_MAN_MDOC_INCLUDED := 1


include $(MAKEFILEDIR)/cmd.mk
include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/lint/_.mk
include $(MAKEFILEDIR)/lint/man/_.mk
include $(MAKEFILEDIR)/src.mk


mandoc_mdoc_ignore_grep := $(DATAROOTDIR)/lint/mandoc/mdoc.ignore.grep


linters_mdoc := mandoc


$(foreach l, $(linters_mdoc),                                                 \
	$(eval _LINT_mdoc_$(l) :=                                             \
		$(patsubst $(MANDIR)/%, $(_MANDIR)/%.lint-mdoc.$(l).touch,    \
			$(NONSO_MDOC))))


$(_LINT_mdoc_mandoc): $(_MANDIR)/%.lint-mdoc.mandoc.touch: $(MANDIR)/% $(mandoc_mdoc_ignore_grep) | $$(@D)/
	$(info LINT (mandoc)	$@)
	! ($(MANDOC) -mdoc $(MANDOCFLAGS) $< 2>&1 \
	   | $(GREP) -v -f '$(mandoc_mdoc_ignore_grep)' \
	   ||:; \
	) \
	| $(GREP) ^ >&2
	touch $@


$(foreach l, $(linters_mdoc),                                                 \
	$(eval .PHONY: lint-mdoc-$(l)))
$(foreach l, $(linters_mdoc),                                                 \
	$(eval lint-mdoc-$(l): $(_LINT_mdoc_$(l));))
.PHONY: lint-mdoc
lint-mdoc: $(foreach l, $(linters_mdoc), lint-mdoc-$(l));


endif  # include guard
