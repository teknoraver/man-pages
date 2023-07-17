########################################################################
# Copyright 2021-2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_BUILD_GROFF_INCLUDED
MAKEFILE_BUILD_GROFF_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/cmd.mk
include $(MAKEFILEDIR)/src.mk


DEFAULT_EQNFLAGS :=
EXTRA_EQNFLAGS   :=
EQNFLAGS         := $(DEFAULT_EQNFLAGS) $(EXTRA_EQNFLAGS)
EQN              := eqn

DEFAULT_TROFFFLAGS   := -wbreak
EXTRA_TROFFFLAGS     :=
TROFFFLAGS           := $(DEFAULT_TROFFFLAGS) $(EXTRA_TROFFFLAGS)
TROFF                := troff

DEFAULT_TROFFFLAGS_MAN := \
	$(TROFFFLAGS) \
	-man
EXTRA_TROFFFLAGS_MAN   :=
TROFFFLAGS_MAN         := $(DEFAULT_TROFFFLAGS_MAN) $(EXTRA_TROFFFLAGS_MAN)

DEFAULT_TROFFFLAGS_MDOC := \
	$(TROFFFLAGS) \
	-mdoc
EXTRA_TROFFFLAGS_MDOC   :=
TROFFFLAGS_MDOC         := $(DEFAULT_TROFFFLAGS_MDOC) $(EXTRA_TROFFFLAGS_MDOC)


endif  # include guard
