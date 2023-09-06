########################################################################
# Copyright 2021-2022, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_LINT_C_INCLUDED
MAKEFILE_LINT_C_INCLUDED := 1


include $(MAKEFILEDIR)/build/src.mk
include $(MAKEFILEDIR)/cmd.mk
include $(MAKEFILEDIR)/lint/_.mk


DEFAULT_CHECKPATCHFLAGS :=
EXTRA_CHECKPATCHFLAGS   :=
CHECKPATCHFLAGS         := $(DEFAULT_CHECKPATCHFLAGS) $(EXTRA_CHECKPATCHFLAGS)
CHECKPATCH              := checkpatch

clang-tidy_config       := $(SYSCONFDIR)/clang-tidy/config.yaml
DEFAULT_CLANG-TIDYFLAGS := \
	--config-file=$(clang-tidy_config) \
	--quiet \
	--use-color
EXTRA_CLANG-TIDYFLAGS   :=
CLANG-TIDYFLAGS         := $(DEFAULT_CLANG-TIDYFLAGS) $(EXTRA_CLANG-TIDYFLAGS)
CLANG-TIDY              := clang-tidy

CPPCHECK_SUPPRESS     := $(SYSCONFDIR)/cppcheck/cppcheck.suppress
DEFAULT_CPPCHECKFLAGS := \
	--enable=all \
	--error-exitcode=2 \
	--inconclusive \
	--quiet \
	--suppressions-list=$(CPPCHECK_SUPPRESS)
EXTRA_CPPCHECKFLAGS   :=
CPPCHECKFLAGS         := $(DEFAULT_CPPCHECKFLAGS) $(EXTRA_CPPCHECKFLAGS)
CPPCHECK              := cppcheck

DEFAULT_CPPLINTFLAGS :=
EXTRA_CPPLINTFLAGS   :=
CPPLINTFLAGS         := $(DEFAULT_CPPLINTFLAGS) $(EXTRA_CPPLINTFLAGS)
CPPLINT              := cpplint

DEFAULT_IWYUFLAGS := \
	-Xiwyu --no_fwd_decls \
	-Xiwyu --error
EXTRA_IWYUFLAGS   :=
IWYUFLAGS         := $(DEFAULT_IWYUFLAGS) $(EXTRA_IWYUFLAGS)
IWYU              := iwyu


linters_c := checkpatch clang-tidy cppcheck cpplint iwyu


$(foreach l, $(linters_c),                                                    \
	$(eval _LINT_c_$(l) :=                                                \
		$(patsubst %.c, %.lint-c.$(l).touch,                          \
			$(_UNITS_src_c))))


$(_LINT_c_checkpatch): %.lint-c.checkpatch.touch: %.c $(MK)
	$(info LINT (checkpatch)	$@)
	$(CHECKPATCH) $(CHECKPATCHFLAGS) -f $< >&2
	touch $@

$(_LINT_c_clang-tidy): %.lint-c.clang-tidy.touch: %.c $(MK)
	$(info LINT (clang-tidy)	$@)
	$(CLANG-TIDY) $(CLANG-TIDYFLAGS) $< -- $(CPPFLAGS) $(CFLAGS) 2>&1 \
	| $(SED) '/generated\.$$/d' >&2
	touch $@

$(_LINT_c_cppcheck): %.lint-c.cppcheck.touch: %.c $(MK)
	$(info LINT (cppcheck)	$@)
	$(CPPCHECK) $(CPPCHECKFLAGS) $<
	touch $@

$(_LINT_c_cpplint): %.lint-c.cpplint.touch: %.c $(MK)
	$(info LINT (cpplint)	$@)
	$(CPPLINT) $(CPPLINTFLAGS) $< >/dev/null
	touch $@

$(_LINT_c_iwyu): %.lint-c.iwyu.touch: %.c $(MK)
	$(info LINT (iwyu)	$@)
	! ($(IWYU) $(IWYUFLAGS) $(CPPFLAGS) $(CFLAGS) $< 2>&1 \
	   | $(SED) -n '/should add these lines:/,$$p' \
	   | $(TAC) \
	   | $(SED) '/correct/{N;d}' \
	   | $(TAC) \
	   ||:; \
	) \
	| $(GREP) ^ >&2
	touch $@


$(foreach l, $(linters_c),                                                    \
	$(eval .PHONY: lint-c-$(l)))
$(foreach l, $(linters_c),                                                    \
	$(eval lint-c-$(l): $(_LINT_c_$(l));))
.PHONY: lint-c
lint-c: $(foreach l, $(linters_c), lint-c-$(l));


endif  # include guard
