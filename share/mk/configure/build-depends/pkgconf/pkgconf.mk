# Copyright 2022-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_CONFIGURE_BUILD_DEPENDS_PKGCONF_PKGCONF_INCLUDED
MAKEFILE_CONFIGURE_BUILD_DEPENDS_PKGCONF_PKGCONF_INCLUDED := 1


# Compat
PKG_CONFIG ?= pkgconf


DEFAULT_PKGCONFFLAGS :=
PKGCONFFLAGS         ?=
PKGCONFFLAGS_        ?= $(DEFAULT_PKGCONFFLAGS) $(PKGCONFFLAGS)
PKGCONF              ?= $(PKG_CONFIG)
PKGCONF_CMD          := $(PKGCONF) $(PKGCONFFLAGS_)


PKGCONF_LIBS := libbsd-overlay


endif  # include guard
