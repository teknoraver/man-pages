########################################################################
# Copyright 2021-2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################
# Conventions:
#
# - Follow "Makefile Conventions" from the "GNU Coding Standards" closely.
#   However, when something could be improved, don't follow those.
# - Uppercase variables, when referring files, refer to files in this repo.
# - Lowercase variables, when referring files, refer to system files.
# - Lowercase variables starting with '_' refer to absolute paths,
#   including $(DESTDIR).
# - Uppercase variables starting with '_' refer to temporary files produced
#   in $builddir.
# - Variables ending with '_' refer to a subdir of their parent dir, which
#   is in a variable of the same name but without the '_'.  The subdir is
#   named after this project: <*/man>.
# - Variables ending in '_rm' refer to files that can be removed (exist).
# - Targets of the form '%-rm' remove their corresponding file '%'.
#
########################################################################


SHELL := /usr/bin/env
.SHELLFLAGS := -S bash -Eeuo pipefail -c


MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
MAKEFLAGS += --warn-undefined-variables


srcdir      := .
DATAROOTDIR := $(srcdir)/share
MAKEFILEDIR := $(DATAROOTDIR)/mk


INFO_ :=


.PHONY: all
all: build;

.PHONY: help
help:
	$(info	$(INFO_)all			Alias for "build")
	$(info	)
	$(info	$(INFO_)clean			Remove $$(builddir))
	$(info	)
	$(info	$(INFO_)build			Wrapper for build-* targets)
	$(info	)
	$(info	$(INFO_)build-book		Build the Linux Man Book (PDF))
	$(info	)
	$(info	$(INFO_)build-pre		Preprocess man pages; alias for "build-pre-tbl")
	$(info	$(INFO_)build-pre-preconv	Preprocess man pages with preconv(1))
	$(info	$(INFO_)build-pre-tbl		Preprocess man pages with tbl(1))
	$(info	)
	$(info	$(INFO_)build-catman		Build cat pages; alias for "build-catman-grotty")
	$(info	$(INFO_)build-catman-eqn	eqn(1) step of "build-catman")
	$(info	$(INFO_)build-catman-troff	Wrapper for build-catman-troff-* targets)
	$(info	$(INFO_)build-catman-troff-man	troff(1) step of "build-catman" for man(7) pages)
	$(info	$(INFO_)build-catman-troff-mdoc	troff(1) step of "build-catman" for mdoc(7) pages)
	$(info	$(INFO_)build-catman-grotty	grotty(1) step of "build-catman")
	$(info	)
	$(info	$(INFO_)build-html		Build HTML manual pages)
	$(info	$(INFO_)html			Alias for "build-html")
	$(info	)
	$(info	$(INFO_)build-pdf		Build PDF manual pages; alias for "build-pdf-grops")
	$(info	$(INFO_)build-pdf-eqn		eqn(1) step of "build-pdf")
	$(info	$(INFO_)build-pdf-troff		Wrapper for build-pdf-troff-* targets)
	$(info	$(INFO_)build-pdf-troff-man	troff(1) step of "build-pdf" for man(7) pages)
	$(info	$(INFO_)build-pdf-troff-mdoc	troff(1) step of "build-pdf" for mdoc(7) pages)
	$(info	$(INFO_)build-pdf-gropdf	gropdf(1) step of "build-pdf")
	$(info	)
	$(info	$(INFO_)build-ps		Build PostScript manual pages; alias for "build-ps-grops")
	$(info	$(INFO_)build-ps-eqn		eqn(1) step of "build-ps")
	$(info	$(INFO_)build-ps-troff		Wrapper for build-ps-troff-* targets)
	$(info	$(INFO_)build-ps-troff-man	troff(1) step of "build-ps" for man(7) pages)
	$(info	$(INFO_)build-ps-troff-mdoc	troff(1) step of "build-ps" for mdoc(7) pages)
	$(info	$(INFO_)build-ps-grops		grops(1) step of "build-ps")
	$(info	)
	$(info	$(INFO_)build-src		Alias for "build-src-ld")
	$(info	$(INFO_)build-src-c		Extract C programs from EXAMPLES)
	$(info	$(INFO_)build-src-cc		Compile C programs from EXAMPLES)
	$(info	$(INFO_)build-src-ld		Link C programs from EXAMPLES)
	$(info	)
	$(info	$(INFO_)lint			Wrapper for "lint-c lint-man lint-mdoc")
	$(info	$(INFO_)lint-c			Wrapper for lint-c-* targets)
	$(info	$(INFO_)lint-c-checkpatch	Lint C programs from EXAMPLES with checkpatch(1))
	$(info	$(INFO_)lint-c-clang-tidy	Lint C programs from EXAMPLES with clang-tidy(1))
	$(info	$(INFO_)lint-c-cppcheck		Lint C programs from EXAMPLES with cppcheck(1))
	$(info	$(INFO_)lint-c-cpplint		Lint C programs from EXAMPLES with cpplint(1))
	$(info	$(INFO_)lint-c-iwyu		Lint C programs from EXAMPLES with iwyu(1))
	$(info	$(INFO_)lint-man		Wrapper for lint-man-* targets)
	$(info	$(INFO_)lint-man-mandoc		Lint man(7) pages with mandoc(1))
	$(info	$(INFO_)lint-man-tbl		Lint man(7) pages about '\" t' comment for tbl(1))
	$(info	$(INFO_)lint-mdoc		Wrapper for lint-mdoc-* targets)
	$(info	$(INFO_)lint-mdoc-mandoc	Lint mdoc(7) pages with mandoc(1))
	$(info	)
	$(info	$(INFO_)check			Alias for "check-catman")
	$(info	$(INFO_)check-catman		Check cat pages; alias for "check-catman-grep")
	$(info	$(INFO_)check-catman-col	Filter cat pages with col(1))
	$(info	$(INFO_)check-catman-grep	Check cat pages with grep(1))
	$(info	)
	$(info	$(INFO_)[un]install		Alias for "[un]install-man")
	$(info	$(INFO_)[un]install-man		Wrapper for [un]install-man* targets)
	$(info	$(INFO_)[un]install-manintro	[Un]install intro(*) man pages)
	$(info	$(INFO_)[un]install-man{1,...}	[Un]install man pages in the corresponding section)
	$(info	)
	$(info	$(INFO_)[un]install-html	[Un]install HTML manual pages)
	$(info	)
	$(info	$(INFO_)dist			Wrapper for dist-* targets)
	$(info	$(INFO_)dist-tar		Create a tarball of the repository)
	$(info	$(INFO_)dist-z			Wrapper for dist-z-* targets)
	$(info	$(INFO_)dist-z-bz2		Create a compressed tarball (.tar.bz2))
	$(info	$(INFO_)dist-z-gz		Create a compressed tarball (.tar.gz))
	$(info	$(INFO_)dist-z-lz		Create a compressed tarball (.tar.lz))
	$(info	$(INFO_)dist-z-xz		Create a compressed tarball (.tar.xz))
	$(info	$(INFO_)distcheck		Check the distribution tarball)
	$(info	)
	$(info	$(INFO_)help			Print this help)
	$(info	$(INFO_)help-variables		Print all variables available, and their default values)
	$(info	)
	$(info	$(INFO_)nothing			Make nothing.  It's useful for debug purposes)
	$(info	)


.SECONDEXPANSION:


MK_ := $(wildcard $(addprefix $(MAKEFILEDIR)/, *.mk */*.mk */*/*.mk))
MK  := $(srcdir)/GNUmakefile $(MK_)
include $(MK_)
$(MK):: ;


.PHONY: help-variables
help-variables:
	$(info	$(INFO_)LINK_PAGES	How to install link pages.  [".so", "symlink"])
	$(info	$(INFO_)Z		Install pages compressed.  ["", ".bz2", ".gz", ".lz", ".xz"])
	$(info	$(INFO_)SKIP_XFAIL	Skip expected failures.  ["yes", "no"])
	$(info	)
	$(info	$(INFO_)DISTNAME	$$(git describe))
	$(info	$(INFO_)DISTVERSION	/$$DISTNAME/s/man-pages-//)
	$(info	)
	$(info	$(INFO_)HIDE_ERR	Define to empty string to debug some errors)
	$(info	)
	$(info	$(INFO_)# Directory variables:)
	$(info	)
	$(info	$(INFO_)builddir	.tmp)
	$(info	$(INFO_)DESTDIR		)
	$(info	$(INFO_)prefix		/usr/local)
	$(info	$(INFO_)mandir		$$(datarootdir)/man)
	$(info	$(INFO_)docdir		$$(datarootdir)/doc)
	$(info	)
	$(info	$(INFO_)man{1,...}dir	$$(mandir)/man{1,...})
	$(info	$(INFO_)man{1,...}ext	.{1,...})
	$(info	)
	$(info	$(INFO_)htmldir		$$(docdir))
	$(info	$(INFO_)htmlext		.html)
	$(info	)
	$(info	$(INFO_)# Command variables (and flags):)
	$(info	)
	$(info	$(INFO_)-		MANWIDTH)
	$(info	$(INFO_)-		NROFF_OUT_DEVICE)
	$(info	$(INFO_)PRECONV		{EXTRA_,}PRECONVFLAGS)
	$(info	$(INFO_)TBL)
	$(info	$(INFO_)EQN		{EXTRA_,}EQNFLAGS)
	$(info	$(INFO_)TROFF		{EXTRA_,}TROFFFLAGS{,_MAN,_MDOC}	{EXTRA_,}NROFFFLAGS)
	$(info	$(INFO_)GROPDF		{EXTRA_,}GROPDFFLAGS)
	$(info	$(INFO_)GROPS		{EXTRA_,}GROPSFLAGS)
	$(info	$(INFO_)GROTTY		{EXTRA_,}GROTTYFLAGS)
	$(info	$(INFO_)COL		{EXTRA_,}COLFLAGS)
	$(info	)
	$(info	$(INFO_)MANDOC		{EXTRA_,}MANDOCFLAGS)
	$(info	$(INFO_)MAN2HTML	{EXTRA_,}MAN2HTMLFLAGS)
	$(info	)
	$(info	$(INFO_)BZIP2		{EXTRA_,}BZIP2FLAGS)
	$(info	$(INFO_)CP)
	$(info	$(INFO_)ECHO)
	$(info	$(INFO_)EXPR)
	$(info	$(INFO_)FIND)
	$(info	$(INFO_)GIT)
	$(info	$(INFO_)GZIP		{EXTRA_,}GZIPFLAGS)
	$(info	$(INFO_)HEAD)
	$(info	$(INFO_)LN)
	$(info	$(INFO_)LOCALE)
	$(info	$(INFO_)LZIP		{EXTRA_,}LZIPFLAGS)
	$(info	$(INFO_)PKGCONF)
	$(info	$(INFO_)SED)
	$(info	$(INFO_)SORTMAN)
	$(info	$(INFO_)SPONGE)
	$(info	$(INFO_)TAC)
	$(info	$(INFO_)TAIL)
	$(info	$(INFO_)TAR)
	$(info	$(INFO_)TEST)
	$(info	$(INFO_)XARGS)
	$(info	$(INFO_)XZ		{EXTRA_,}XZFLAGS)
	$(info	)
	$(info	$(INFO_)INSTALL)
	$(info	$(INFO_)INSTALL_DATA)
	$(info	$(INFO_)MKDIR)
	$(info	$(INFO_)RM)
	$(info	)
	$(info	$(INFO_)-		{EXTRA_,}CPPFLAGS)
	$(info	$(INFO_)CC		{EXTRA_,}CFLAGS)
	$(info	$(INFO_)LD		{EXTRA_,}LDFLAGS	{EXTRA_,}LDLIBS)
	$(info	)
	$(info	$(INFO_)-		{EXTRA_,}CLANGFLAGS)
	$(info	$(INFO_)CHECKPATCH	{EXTRA_,}CHECKPATCHFLAGS)
	$(info	$(INFO_)CLANG-TIDY	{EXTRA_,}CLANG-TIDYFLAGS)
	$(info	$(INFO_)CPPCHECK	{EXTRA_,}CPPCHECKFLAGS)
	$(info	$(INFO_)CPPLINT		{EXTRA_,}CPPLINTFLAGS)
	$(info	$(INFO_)IWYU		{EXTRA_,}IWYUFLAGS)
	$(info	)


.PHONY: nothing
nothing:;


.DELETE_ON_ERROR:
.SILENT:
FORCE:
