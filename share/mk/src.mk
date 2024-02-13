# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_SRC_INCLUDED
MAKEFILE_SRC_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/findutils.mk
include $(MAKEFILEDIR)/configure/build-depends/grep.mk
include $(MAKEFILEDIR)/configure/build-depends/sed.mk
include $(MAKEFILEDIR)/configure/build-depends/sortman.mk


SYSCONFDIR := $(srcdir)/etc
MANDIR     := $(srcdir)

MANEXT := \(\.[[:digit:]]\([[:alpha:]][[:alnum:]]*\)\?\>\|\.man\)\+\(\.man\|\.in\)*$


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
