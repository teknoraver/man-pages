########################################################################
# Copyright 2023 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_COMPRESS_INCLUDED
MAKEFILE_COMPRESS_INCLUDED := 1


Z :=
ifeq ($(Z),)
else ifeq ($(Z),.bz2)
else ifeq ($(Z),.gz)
else ifeq ($(Z),.lz)
else ifeq ($(Z),.xz)
else
$(warning "Z": "$(Z)")
$(error Valid values for "Z": ["", ".bz2", ".gz", ".lz", ".xz"])
endif


DEFAULT_BZIP2FLAGS :=
EXTRA_BZIP2FLAGS   :=
BZIP2FLAGS         := $(DEFAULT_BZIP2FLAGS) $(EXTRA_BZIP2FLAGS)

DEFAULT_GZIPFLAGS  := -n
EXTRA_GZIPFLAGS    :=
GZIPFLAGS          := $(DEFAULT_GZIPFLAGS) $(EXTRA_GZIPFLAGS)

DEFAULT_LZIPFLAGS  :=
EXTRA_LZIPFLAGS    :=
LZIPFLAGS          := $(DEFAULT_LZIPFLAGS) $(EXTRA_LZIPFLAGS)

DEFAULT_XZFLAGS    :=
EXTRA_XZFLAGS      :=
XZFLAGS            := $(DEFAULT_XZFLAGS) $(EXTRA_XZFLAGS)


endif  # include guard
