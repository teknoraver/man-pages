# Copyright 2023-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_MDOC_INCLUDED
MAKEFILE_LINT_MDOC_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/src.mk


linters_mdoc := mandoc


$(foreach l, $(linters_mdoc),                                                 \
	$(eval _LINT_mdoc_$(l) :=                                             \
		$(patsubst $(MANDIR)/%, $(_MANDIR)/%.lint-mdoc.$(l).touch,    \
			$(NONSO_MDOC))))


$(foreach l, $(linters_mdoc),                                                 \
	$(eval .PHONY: lint-mdoc-$(l)))
$(foreach l, $(linters_mdoc),                                                 \
	$(eval lint-mdoc-$(l): $(_LINT_mdoc_$(l));))
.PHONY: lint-mdoc
lint-mdoc: $(foreach l, $(linters_mdoc), lint-mdoc-$(l));


endif  # include guard
