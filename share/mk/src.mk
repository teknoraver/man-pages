########################################################################
# Copyright 2021-2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_SRC_INCLUDED
MAKEFILE_SRC_INCLUDED := 1


include $(MAKEFILEDIR)/cmd.mk


MANDIR := $(srcdir)
MANEXT := \.[[:digit:]]\([[:alpha:]][[:alnum:]]*\)\?\>\(\.man\|\.in\)*$


MANPAGES := $(shell $(FIND) $(MANDIR)/* -type f \
		| $(GREP) '$(MANEXT)' \
		| $(SORTMAN) \
		| $(SED) 's,:,\\:,g')


MANINTROPAGES := $(shell $(FIND) $(MANDIR)/* -type f \
		| $(GREP) '$(MANEXT)' \
		| $(GREP) '/intro$(MANEXT)' \
		| $(SORTMAN) \
		| $(SED) 's,:,\\:,g')


MANSECTIONS := $(patsubst $(MANDIR)/man%/, %, $(wildcard $(MANDIR)/man*/))


$(foreach s, $(MANSECTIONS),                                                  \
	$(eval MAN$(s)DIR := $(MANDIR)/man$(s)))

$(foreach s, $(MANSECTIONS),                                                  \
	$(eval MAN$(s)PAGES :=                                                \
		$(filter-out $(MANINTROPAGES),                                \
			$(filter $(MANDIR)/man$(s)/%,                         \
				$(filter %.$(s),                              \
					$(MANPAGES))))))
$(foreach s, $(MANSECTIONS),                                                  \
	$(eval MAN$(s)INTROPAGE :=                                            \
		$(filter $(MANDIR)/man$(s)/%,                                 \
			$(filter %.$(s),                                      \
				$(MANINTROPAGES)))))


endif  # include guard
