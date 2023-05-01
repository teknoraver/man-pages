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

_LINT_man_mandoc :=$(patsubst $(MANDIR)/%,$(_MANDIR)/%.lint-man.mandoc.touch,$(NONSO_MAN))
_LINT_man_tbl    :=$(patsubst $(MANDIR)/%,$(_MANDIR)/%.lint-man.tbl.touch,$(NONSO_MAN))


linters_man := mandoc tbl
lint_man    := $(foreach x,$(linters_man),lint-man-$(x))


$(_LINT_man_mandoc): $(_MANDIR)/%.lint-man.mandoc.touch: $(MANDIR)/% $(mandoc_man_ignore_grep) | $$(@D)/
	$(info LINT (mandoc)	$@)
	! ($(MANDOC) -man $(MANDOCFLAGS) $< 2>&1 \
	   | $(GREP) -v -f '$(mandoc_man_ignore_grep)' \
	   ||:; \
	) \
	| $(GREP) ^ >&2
	touch $@

$(_LINT_man_tbl): $(_MANDIR)/%.lint-man.tbl.touch: $(MANDIR)/% | $$(@D)/
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


.PHONY: lint-man-mandoc
lint-man-mandoc: $(_LINT_man_mandoc);
.PHONY: lint-man-tbl
lint-man-tbl:    $(_LINT_man_tbl);

.PHONY: lint-man
lint-man: $(lint_man);


endif  # include guard
