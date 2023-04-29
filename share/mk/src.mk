########################################################################
# Copyright 2021-2022, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_SRC_INCLUDED
MAKEFILE_SRC_INCLUDED := 1


include $(MAKEFILEDIR)/cmd.mk


MANDIR := $(srcdir)
MANEXT := \.[0-9]\w*\(\.man\)\?\(\.in\)\?$


MANPAGES := $(shell $(FIND) $(MANDIR)/man*/ -type f \
		| $(GREP) '$(MANEXT)' \
		| $(SORT) \
		| $(SED) 's,:,\\:,g')

MAN1PAGES      := $(filter %.1,$(MANPAGES))
MAN2PAGES      := $(filter %.2,$(MANPAGES))
MAN2TYPEPAGES  := $(filter %.2type,$(MANPAGES))
MAN3PAGES      := $(filter %.3,$(MANPAGES))
MAN3CONSTPAGES := $(filter %.3const,$(MANPAGES))
MAN3HEADPAGES  := $(filter %.3head,$(MANPAGES))
MAN3TYPEPAGES  := $(filter %.3type,$(MANPAGES))
MAN4PAGES      := $(filter %.4,$(MANPAGES))
MAN5PAGES      := $(filter %.5,$(MANPAGES))
MAN6PAGES      := $(filter %.6,$(MANPAGES))
MAN7PAGES      := $(filter %.7,$(MANPAGES))
MAN8PAGES      := $(filter %.8,$(MANPAGES))


endif  # include guard
