########################################################################
# Copyright 2021-2022, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_INSTALL_INCLUDED
MAKEFILE_INSTALL_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk


DESTDIR     :=
prefix      := /usr/local
datarootdir := $(prefix)/share
docdir      := $(datarootdir)/doc


%/:
	+$(info	MKDIR	$@)
	+$(INSTALL_DIR) $@

%-rm:
	$(info RM	$*)
	$(RM) $*


.PHONY: install
install: install-man;

.PHONY: uninstall
uninstall: uninstall-man;


endif  # include guard
