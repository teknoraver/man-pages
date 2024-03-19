# Copyright 2021-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


BASH        := bash
SHELL       := /usr/bin/env
.SHELLFLAGS := -S '$(BASH) -Eeuo pipefail -c'


MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
MAKEFLAGS += --warn-undefined-variables


srcdir      := .
DATAROOTDIR := $(srcdir)/share
MAKEFILEDIR := $(DATAROOTDIR)/mk


INFO_ :=


.PHONY: all
all: build;


.SECONDEXPANSION:


MK_ := $(wildcard $(addprefix $(MAKEFILEDIR)/, *.mk */*.mk */*/*.mk */*/*/*.mk))
MK  := $(srcdir)/GNUmakefile $(MK_)
include $(MK_)
$(MK):: ;


.PHONY: nothing
nothing:;


.PHONY: help
help:
	$(info	$(INFO_)To see a list of .PHONY targets, run:)
	$(info	$(INFO_)	$$ make nothing -p \)
	$(info	$(INFO_)	| grep '^\.PHONY:' \)
	$(info	$(INFO_)	| tr ' ' '\n' \)
	$(info	$(INFO_)	| grep -v '^\.PHONY:' \)
	$(info	$(INFO_)	| sort;)
	$(info	)
	$(info	$(INFO_)To see a list of available variables, run:)
	$(info	$(INFO_)	$$ find GNUmakefile share/mk/configure -type f \)
	$(info	$(INFO_)	| sort \)
	$(info	$(INFO_)	| xargs grep '^[^[:space:]].*=' \)
	$(info	$(INFO_)	| sed 's/=.*/=/' \)
	$(info	$(INFO_)	| grep -v -e ':DEFAULT_.*=' -e ':MAKEFILE_.*INCLUDED :=';)
	$(info	)
	$(info	$(INFO_)To see a list of dependencies (package/program), run:)
	$(info	$(INFO_)	$$ find share/mk/configure/build-depends -type f \)
	$(info	$(INFO_)	| sed 's,share/mk/configure/build-depends/,,' \)
	$(info	$(INFO_)	| sed 's,\.mk,,' \)
	$(info	$(INFO_)	| sort;)
	$(info	)


.DELETE_ON_ERROR:
.SILENT:
FORCE:
