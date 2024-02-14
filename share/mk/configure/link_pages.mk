########################################################################
# Copyright 2023 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_CONFIGURE_LINK_PAGES_INCLUDED
MAKEFILE_CONFIGURE_LINK_PAGES_INCLUDED := 1


LINK_PAGES := .so
ifeq ($(LINK_PAGES),.so)
else ifeq ($(LINK_PAGES),symlink)
else
$(warning "LINK_PAGES": "$(LINK_PAGES)")
$(error Valid values for "LINK_PAGES": [".so", "symlink"])
endif


endif  # include guard
