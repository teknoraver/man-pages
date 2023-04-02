########################################################################
# Copyright (C) 2021 - 2023  Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier:  GPL-3.0-or-later  OR  LGPL-3.0-or-later
########################################################################


ifndef MAKEFILE_LINT_MAN_INCLUDED
MAKEFILE_LINT_MAN_INCLUDED := 1


include $(srcdir)/lib/cmd.mk
include $(srcdir)/lib/build.mk
include $(srcdir)/lib/lint.mk
include $(srcdir)/lib/src.mk


DEFAULT_MANDOCFLAGS := -man
DEFAULT_MANDOCFLAGS += -Tlint
EXTRA_MANDOCFLAGS   :=
MANDOCFLAGS         := $(DEFAULT_MANDOCFLAGS) $(EXTRA_MANDOCFLAGS)
MANDOC              := mandoc


_LINT_man_mandoc:=$(patsubst $(MANDIR)/%,$(_MANDIR)/%.lint-man.mandoc.touch,$(NONSO_MAN))
_LINT_man_tbl   :=$(patsubst $(MANDIR)/%,$(_MANDIR)/%.lint-man.tbl.touch,$(NONSO_MAN))


linters_man := mandoc tbl
lint_man    := $(foreach x,$(linters_man),lint-man-$(x))


$(_LINT_man_mandoc): $(_MANDIR)/%.lint-man.mandoc.touch: $(MANDIR)/% | $$(@D)/
	$(info LINT (mandoc)	$@)
	! ($(MANDOC) $(MANDOCFLAGS) $< 2>&1 \
	   | $(GREP) -v 'STYLE: lower case character in document title:' \
	   | $(GREP) -v 'UNSUPP: ignoring macro in table:' \
	   | $(GREP) -v 'WARNING: cannot parse date, using it verbatim: TH (date)' \
	   | $(GREP) -v 'WARNING: empty block: UR' \
	   | $(GREP) -v 'WARNING: missing date, using "": TH' \
	   | $(GREP) -v 'WARNING: undefined escape, printing literally: \\\\' \
	   ||:; \
	) \
	| $(GREP) '.' >&2
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


.PHONY: $(lint_man)
$(lint_man): lint-man-%: $$(_LINT_man_%)
	@:

.PHONY: lint-man
lint-man: $(lint_man)
	@:


endif  # MAKEFILE_LINT_MAN_INCLUDED
