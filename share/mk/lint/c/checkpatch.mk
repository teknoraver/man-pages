# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_C_CHECKPATCH_INCLUDED
MAKEFILE_LINT_C_CHECKPATCH_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/build/examples/src.mk
include $(MAKEFILEDIR)/configure/build-depends/checkpatch/checkpatch.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/touch.mk
include $(MAKEFILEDIR)/configure/xfail.mk


_XFAIL_LINT_c_checkpatch := $(_MANDIR)/man2/bpf.2.d/bpf.lint-c.checkpatch.touch


_LINT_c_checkpatch := $(patsubst %.c, %.lint-c.checkpatch.touch, $(_EX_TU_c))
ifeq ($(SKIP_XFAIL),yes)
_LINT_c_checkpatch := $(filter-out $(_XFAIL_LINT_c_checkpatch), $(_LINT_c_checkpatch))
endif


$(_LINT_c_checkpatch): %.lint-c.checkpatch.touch: %.c $(CHECKPATCH_CONF) $(MK)
	$(info	$(INFO_)CHECKPATCH	$@)
	$(CHECKPATCH) $(CHECKPATCHFLAGS) -f $< >&2
	$(TOUCH) $@


.PHONY: lint-c-checkpatch
lint-c-checkpatch: $(_LINT_c_checkpatch);


endif  # include guard
