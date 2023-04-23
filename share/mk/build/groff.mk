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

DEFAULT_TROFFFLAGS   := -ww
EXTRA_TROFFFLAGS     :=
TROFFFLAGS           := $(DEFAULT_TROFFFLAGS) $(EXTRA_TROFFFLAGS)
TROFF                := troff

TROFF_CHECKSTYLE_LVL   := 3
DEFAULT_TROFFFLAGS_MAN := $(TROFFFLAGS)
DEFAULT_TROFFFLAGS_MAN += -man
DEFAULT_TROFFFLAGS_MAN += -rCHECKSTYLE=$(TROFF_CHECKSTYLE_LVL)
EXTRA_TROFFFLAGS_MAN   :=
TROFFFLAGS_MAN         := $(DEFAULT_TROFFFLAGS_MAN) $(EXTRA_TROFFFLAGS_MAN)

DEFAULT_TROFFFLAGS_MDOC := $(TROFFFLAGS)
DEFAULT_TROFFFLAGS_MDOC += -mdoc
EXTRA_TROFFFLAGS_MDOC   :=
TROFFFLAGS_MDOC         := $(DEFAULT_TROFFFLAGS_MDOC) $(EXTRA_TROFFFLAGS_MDOC)


endif  # include guard
