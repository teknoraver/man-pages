########################################################################
# Copyright 2022, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_CONFIGURE_VERSION_INCLUDED
MAKEFILE_CONFIGURE_VERSION_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/git.mk
include $(MAKEFILEDIR)/configure/verbose.mk


DISTNAME    := $(shell $(GIT) describe)
DISTVERSION := $(patsubst man-pages-%,%,$(DISTNAME))
DISTDATE    := $(shell $(GIT) log -1 --format='%aD')


endif  # include guard
