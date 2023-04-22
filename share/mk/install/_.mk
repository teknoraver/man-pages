########################################################################
# Copyright 2021-2022, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_INSTALL_INCLUDED
MAKEFILE_INSTALL_INCLUDED := 1


include $(MAKEFILEDIR)/cmd.mk


DESTDIR :=
prefix  := /usr/local

datarootdir := $(prefix)/share
docdir      := $(datarootdir)/doc


%/:
	+$(info INSTALL	$@/)
	+$(INSTALL_DIR) $@

%-rm:
	$(info RM	$*)
	$(RM) $*

%-rmdir:
	$(info RMDIR	$(@D))
	$(RMDIR) $(@D)


.PHONY: install
install: install-man
	@:

.PHONY: uninstall
uninstall: uninstall-man
	@:


endif  # MAKEFILE_INSTALL_INCLUDED
