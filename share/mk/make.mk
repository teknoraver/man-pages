########################################################################
# Copyright 2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_MAKE_INCLUDED
MAKEFILE_MAKE_INCLUDED := 1


include $(MAKEFILEDIR)/cmd.mk


MK := $(srcdir)/Makefile
MK += $(shell $(FIND) $(MAKEFILEDIR) -type f \
	| $(GREP) '\.mk$$' \
	| $(SORT))


$(MK):: ;


endif  # include guard
