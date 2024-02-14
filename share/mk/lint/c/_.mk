# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_C_INCLUDED
MAKEFILE_LINT_C_INCLUDED := 1


include $(MAKEFILEDIR)/build/examples/src.mk


linters_c := checkpatch clang-tidy cppcheck cpplint iwyu


$(foreach l, $(linters_c),                                                    \
	$(eval _LINT_c_$(l) :=                                                \
		$(patsubst %.c, %.lint-c.$(l).touch,                          \
			$(_UNITS_ex_c))))


$(foreach l, $(linters_c),                                                    \
	$(eval .PHONY: lint-c-$(l)))
$(foreach l, $(linters_c),                                                    \
	$(eval lint-c-$(l): $(_LINT_c_$(l));))
.PHONY: lint-c
lint-c: $(foreach l, $(linters_c), lint-c-$(l));


endif  # include guard
