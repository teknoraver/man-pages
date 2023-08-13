########################################################################
# Copyright 2022, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_CMD_INCLUDED
MAKEFILE_CMD_INCLUDED := 1


BZIP2      := bzip2
CP         := cp
ECHO       := echo
EXPR       := expr
FIND       := find
GIT        := git
GREP       := grep
GZIP       := gzip
HEAD       := head
INSTALL    := install
LN         := ln
LOCALE     := locale
LZIP       := lzip
MANDOC     := mandoc
PKGCONF    := pkgconf
SED        := sed
SORTMAN    := $(srcdir)/scripts/sortman
SPONGE     := sponge
TAC        := tac
TAIL       := tail
TAR        := tar
TEST       := test
XARGS      := xargs
XZ         := xz

INSTALL_DATA := $(INSTALL) -m 644
INSTALL_DIR  := $(INSTALL) -m 755 -d


endif  # include guard
