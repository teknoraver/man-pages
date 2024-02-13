########################################################################
# Copyright 2021-2022, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_LINT_C_INCLUDED
MAKEFILE_LINT_C_INCLUDED := 1


include $(MAKEFILEDIR)/build/src.mk
include $(MAKEFILEDIR)/configure/build-depends/checkpatch.mk
include $(MAKEFILEDIR)/configure/build-depends/clang.mk
include $(MAKEFILEDIR)/configure/build-depends/clang-tidy.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/cpp.mk
include $(MAKEFILEDIR)/configure/build-depends/cppcheck.mk
include $(MAKEFILEDIR)/configure/build-depends/cpplint.mk
include $(MAKEFILEDIR)/configure/build-depends/grep.mk
include $(MAKEFILEDIR)/configure/build-depends/iwyu.mk
include $(MAKEFILEDIR)/configure/build-depends/sed.mk
include $(MAKEFILEDIR)/lint/_.mk


linters_c := checkpatch clang-tidy cppcheck cpplint iwyu


$(foreach l, $(linters_c),                                                    \
	$(eval _LINT_c_$(l) :=                                                \
		$(patsubst %.c, %.lint-c.$(l).touch,                          \
			$(_UNITS_src_c))))


$(_LINT_c_checkpatch): %.lint-c.checkpatch.touch: %.c $(MK)
	$(info LINT (checkpatch)	$@)
	$(CHECKPATCH) $(CHECKPATCHFLAGS) -f $< >&2
	$(TOUCH) $@

$(_LINT_c_clang-tidy): %.lint-c.clang-tidy.touch: %.c $(MK)
	$(info LINT (clang-tidy)	$@)
	$(CLANG_TIDY) $(CLANG_TIDYFLAGS) $< -- $(CPPFLAGS) $(CLANGFLAGS) 2>&1 \
	| $(SED) '/generated\.$$/d' >&2
	$(TOUCH) $@

$(_LINT_c_cppcheck): %.lint-c.cppcheck.touch: %.c $(MK)
	$(info LINT (cppcheck)	$@)
	$(CPPCHECK) $(CPPCHECKFLAGS) $<
	$(TOUCH) $@

$(_LINT_c_cpplint): %.lint-c.cpplint.touch: %.c $(MK)
	$(info LINT (cpplint)	$@)
	$(CPPLINT) $(CPPLINTFLAGS) $< >/dev/null
	$(TOUCH) $@

$(_LINT_c_iwyu): %.lint-c.iwyu.touch: %.c $(MK)
	$(info LINT (iwyu)	$@)
	! ($(IWYU) $(IWYUFLAGS) $(CPPFLAGS) $(CLANGFLAGS) $< 2>&1 \
	   | $(SED) -n '/should add these lines:/,$$p' \
	   | $(TAC) \
	   | $(SED) '/correct/{N;d}' \
	   | $(TAC) \
	   ||:; \
	) \
	| $(GREP) ^ >&2
	$(TOUCH) $@


$(foreach l, $(linters_c),                                                    \
	$(eval .PHONY: lint-c-$(l)))
$(foreach l, $(linters_c),                                                    \
	$(eval lint-c-$(l): $(_LINT_c_$(l));))
.PHONY: lint-c
lint-c: $(foreach l, $(linters_c), lint-c-$(l));


endif  # include guard
