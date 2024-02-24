########################################################################
# Copyright 2022, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_CONFIGURE_VERSION_INCLUDED
MAKEFILE_CONFIGURE_VERSION_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/findutils.mk
include $(MAKEFILEDIR)/configure/build-depends/git.mk
include $(MAKEFILEDIR)/configure/build-depends/grep.mk
include $(MAKEFILEDIR)/configure/verbose.mk


DISTNAME    := $(shell $(GIT) describe --dirty)
DISTVERSION := $(patsubst man-pages-%,%,$(DISTNAME))


DISTFILESCMD := \
	$(FIND) $(srcdir) -not -type d \
	| $(GREP) -v '^$(srcdir)/.git$$' \
	| $(GREP) -v '^$(srcdir)/.tmp/' \
	| $(GREP) -v '^$(srcdir)/.checkpatch-camelcase.' \
	| $(SORT)

DISTDATECMD := \
	$(ECHO) '$(DISTVERSION)' \
	| if $(GREP) -- '-dirty$$' >/dev/null; then \
		$(DISTFILESCMD) \
		| $(XARGS) $(STAT) -c %y \
		| $(SORT) -n \
		| $(TAIL) -n1; \
	else \
		$(GIT) log -1 --format='%aD'; \
	fi;


DISTDATE := $(shell $(DISTDATECMD))


endif  # include guard
