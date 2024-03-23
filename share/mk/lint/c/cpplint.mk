# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_C_CPPLINT_INCLUDED
MAKEFILE_LINT_C_CPPLINT_INCLUDED := 1


include $(MAKEFILEDIR)/build/examples/src.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/touch.mk
include $(MAKEFILEDIR)/configure/build-depends/cpplint/cpplint.mk


_LINT_c_cpplint := $(patsubst %.c, %.lint-c.cpplint.touch, $(_EX_TU_c))


$(_LINT_c_cpplint): %.lint-c.cpplint.touch: %.c $(CPPLINT_CONF) $(MK)
	$(info	$(INFO_)CPPLINT		$@)
	$(CPPLINT) $(CPPLINTFLAGS) $< >/dev/null
	$(TOUCH) $@


.PHONY: lint-c-cpplint
lint-c-cpplint: $(_LINT_c_cpplint);


endif  # include guard
