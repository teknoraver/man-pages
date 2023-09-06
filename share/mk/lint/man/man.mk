########################################################################
# Copyright 2021-2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_LINT_MAN_MAN_INCLUDED
MAKEFILE_LINT_MAN_MAN_INCLUDED := 1


include $(MAKEFILEDIR)/cmd.mk
include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/lint/_.mk
include $(MAKEFILEDIR)/lint/man/_.mk
include $(MAKEFILEDIR)/src.mk


mandoc_man_ignore_grep := $(DATAROOTDIR)/lint/mandoc/man.ignore.grep


linters_man := mandoc tbl


$(foreach l, $(linters_man),                                                  \
	$(eval _LINT_man_$(l) :=                                              \
		$(patsubst $(MANDIR)/%, $(_MANDIR)/%.lint-man.$(l).touch,     \
			$(NONSO_MAN))))


$(_LINT_man_mandoc): $(_MANDIR)/%.lint-man.mandoc.touch: $(MANDIR)/% $(mandoc_man_ignore_grep) $(MK) | $$(@D)/
	$(info LINT (mandoc)	$@)
	! ($(MANDOC) -man $(MANDOCFLAGS) $< 2>&1 \
	   | $(GREP) -v -f '$(mandoc_man_ignore_grep)' \
	   ||:; \
	) \
	| $(GREP) ^ >&2
	touch $@

$(_LINT_man_tbl): $(_MANDIR)/%.lint-man.tbl.touch: $(MANDIR)/% $(MK) | $$(@D)/
	$(info LINT (tbl comment)	$@)
	if $(GREP) -q '^\.TS$$' $< && ! $(HEAD) -n1 $< | $(GREP) -q '\\" t$$'; \
	then \
		>&2 $(ECHO) "$<:1: missing '\\\" t' comment:"; \
		>&2 $(HEAD) -n1 <$<; \
		exit 1; \
	fi
	if $(HEAD) -n1 $< | $(GREP) -q '\\" t$$' && ! $(GREP) -q '^\.TS$$' $<; \
	then \
		>&2 $(ECHO) "$<:1: spurious '\\\" t' comment:"; \
		>&2 $(HEAD) -n1 <$<; \
		exit 1; \
	fi
	if $(TAIL) -n+2 <$< | $(GREP) -q '\\" t$$'; \
	then \
		>&2 $(ECHO) "$<: spurious '\\\" t' not in first line:"; \
		>&2 $(GREP) -n '\\" t$$' $< /dev/null; \
		exit 1; \
	fi
	touch $@


$(foreach l, $(linters_man),                                                  \
	$(eval .PHONY: lint-man-$(l)))
$(foreach l, $(linters_man),                                                  \
	$(eval lint-man-$(l): $(_LINT_man_$(l));))
.PHONY: lint-man
lint-man: $(foreach l, $(linters_man), lint-man-$(l));


endif  # include guard
