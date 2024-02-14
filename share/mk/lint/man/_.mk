# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_MAN_INCLUDED
MAKEFILE_LINT_MAN_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/src.mk


linters_man := mandoc tbl


$(foreach l, $(linters_man),                                                  \
	$(eval _LINT_man_$(l) :=                                              \
		$(patsubst $(MANDIR)/%, $(_MANDIR)/%.lint-man.$(l).touch,     \
			$(NONSO_MAN))))


$(foreach l, $(linters_man),                                                  \
	$(eval .PHONY: lint-man-$(l)))
$(foreach l, $(linters_man),                                                  \
	$(eval lint-man-$(l): $(_LINT_man_$(l));))
.PHONY: lint-man
lint-man: $(foreach l, $(linters_man), lint-man-$(l));


endif  # include guard
