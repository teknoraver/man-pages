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


endif  # include guard
