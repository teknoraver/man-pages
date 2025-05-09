# Copyright, The authors of the Linux man-pages project
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_CONFIGURE_BUILD_DEPENDS_GROFF_BASE_GROPS_INCLUDED
MAKEFILE_CONFIGURE_BUILD_DEPENDS_GROFF_BASE_GROPS_INCLUDED := 1


DEFAULT_GROPSFLAGS :=
ifndef GROPSFLAGS
GROPSFLAGS         :=
endif
ifndef GROPSFLAGS_
GROPSFLAGS_        := $(DEFAULT_GROPSFLAGS) $(GROPSFLAGS)
endif
ifndef GROPS
GROPS              := grops
endif


endif  # include guard
