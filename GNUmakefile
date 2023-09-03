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


.PHONY: all
all: build;

.PHONY: help
help:
	$(info	all			Alias for "build")
	$(info	)
	$(info	clean			Remove $$(builddir))
	$(info	)
	$(info	build			Wrapper for build-* targets)
	$(info	)
	$(info	build-pre		Preprocess man pages; alias for "build-pre-tbl")
	$(info	build-pre-preconv	Preprocess man pages with preconv(1))
	$(info	build-pre-tbl		Preprocess man pages with tbl(1))
	$(info	)
	$(info	build-catman		Build cat pages; alias for "build-catman-grotty")
	$(info	build-catman-eqn	eqn(1) step of "build-catman")
	$(info	build-catman-troff	Wrapper for build-catman-troff-* targets)
	$(info	build-catman-troff-man	troff(1) step of "build-catman" for man(7) pages)
	$(info	build-catman-troff-mdoc	troff(1) step of "build-catman" for mdoc(7) pages)
	$(info	build-catman-grotty	grotty(1) step of "build-catman")
	$(info	)
	$(info	build-html		Build HTML manual pages)
	$(info	html			Alias for "build-html")
	$(info	)
	$(info	build-pdf		Build PDF manual pages; alias for "build-pdf-grops")
	$(info	build-pdf-eqn		eqn(1) step of "build-pdf")
	$(info	build-pdf-troff		Wrapper for build-pdf-troff-* targets)
	$(info	build-pdf-troff-man	troff(1) step of "build-pdf" for man(7) pages)
	$(info	build-pdf-troff-mdoc	troff(1) step of "build-pdf" for mdoc(7) pages)
	$(info	build-pdf-gropdf	gropdf(1) step of "build-pdf")
	$(info	)
	$(info	build-ps		Build PostScript manual pages; alias for "build-ps-grops")
	$(info	build-ps-eqn		eqn(1) step of "build-ps")
	$(info	build-ps-troff		Wrapper for build-ps-troff-* targets)
	$(info	build-ps-troff-man	troff(1) step of "build-ps" for man(7) pages)
	$(info	build-ps-troff-mdoc	troff(1) step of "build-ps" for mdoc(7) pages)
	$(info	build-ps-grops		grops(1) step of "build-ps")
	$(info	)
	$(info	build-src		Alias for "build-src-ld")
	$(info	build-src-c		Extract C programs from EXAMPLES)
	$(info	build-src-cc		Compile C programs from EXAMPLES)
	$(info	build-src-ld		Link C programs from EXAMPLES)
	$(info	)
	$(info	lint			Wrapper for "lint-c lint-man lint-mdoc")
	$(info	lint-c			Wrapper for lint-c-* targets)
	$(info	lint-c-checkpatch	Lint C programs from EXAMPLES with checkpatch(1))
	$(info	lint-c-clang-tidy	Lint C programs from EXAMPLES with clang-tidy(1))
	$(info	lint-c-cppcheck		Lint C programs from EXAMPLES with cppcheck(1))
	$(info	lint-c-cpplint		Lint C programs from EXAMPLES with cpplint(1))
	$(info	lint-c-iwyu		Lint C programs from EXAMPLES with iwyu(1))
	$(info	lint-man		Wrapper for lint-man-* targets)
	$(info	lint-man-mandoc		Lint man(7) pages with mandoc(1))
	$(info	lint-man-tbl		Lint man(7) pages about '\" t' comment for tbl(1))
	$(info	lint-mdoc		Wrapper for lint-mdoc-* targets)
	$(info	lint-mdoc-mandoc	Lint mdoc(7) pages with mandoc(1))
	$(info	)
	$(info	check			Alias for "check-catman")
	$(info	check-catman		Check cat pages; alias for "check-catman-grep")
	$(info	check-catman-col	Filter cat pages with col(1))
	$(info	check-catman-grep	Check cat pages with grep(1))
	$(info	)
	$(info	[un]install		Alias for "[un]install-man")
	$(info	[un]install-man		Wrapper for [un]install-man* targets)
	$(info	[un]install-manintro	[Un]install intro(*) man pages)
	$(info	[un]install-man{1,...}	[Un]install man pages in the corresponding section)
	$(info	)
	$(info	[un]install-html	[Un]install HTML manual pages)
	$(info	)
	$(info	dist			Wrapper for dist-* targets)
	$(info	dist-tar		Create a tarball of the repository)
	$(info	dist-bz2		Create a compressed tarball (.tar.bz2))
	$(info	dist-gz			Create a compressed tarball (.tar.gz))
	$(info	dist-lz			Create a compressed tarball (.tar.lz))
	$(info	dist-xz			Create a compressed tarball (.tar.xz))
	$(info	)
	$(info	help			Print this help)
	$(info	help-variables		Print all variables available, and their default values)
	$(info	)
	$(info	nothing			Make nothing.  It's useful for debug purposes)
	$(info	)


.SECONDEXPANSION:


MK := $(wildcard $(addprefix $(MAKEFILEDIR)/, *.mk */*.mk */*/*.mk))
include $(MK)
$(srcdir)/GNUMakefile $(MK):: ;


.PHONY: help-variables
help-variables:
	$(info	LINK_PAGES	How to install link pages.  [".so", "symlink"])
	$(info	Z		Install pages compressed.  ["", ".bz2", ".gz", ".lz", ".xz"])
	$(info	)
	$(info	DISTNAME	$$(git describe))
	$(info	DISTVERSION	/$$DISTNAME/s/man-pages-//)
	$(info	)
	$(info	HIDE_ERR	Define to empty string to debug some errors)
	$(info	)
	$(info	# Directory variables:)
	$(info	)
	$(info	builddir	.tmp)
	$(info	DESTDIR		)
	$(info	prefix		/usr/local)
	$(info	mandir		$$(datarootdir)/man)
	$(info	docdir		$$(datarootdir)/doc)
	$(info	)
	$(info	man{1,...}dir	$$(mandir)/man{1,...})
	$(info	man{1,...}ext	.{1,...})
	$(info	)
	$(info	htmldir		$$(docdir))
	$(info	htmlext		.html)
	$(info	)
	$(info	# Command variables (and flags):)
	$(info	)
	$(info	-		MANWIDTH)
	$(info	-		NROFF_OUT_DEVICE)
	$(info	PRECONV		{EXTRA_,}PRECONVFLAGS)
	$(info	TBL)
	$(info	EQN		{EXTRA_,}EQNFLAGS)
	$(info	TROFF		{EXTRA_,}TROFFFLAGS{,_MAN,_MDOC}	{EXTRA_,}NROFFFLAGS)
	$(info	GROPDF		{EXTRA_,}GROPDFFLAGS)
	$(info	GROPS		{EXTRA_,}GROPSFLAGS)
	$(info	GROTTY		{EXTRA_,}GROTTYFLAGS)
	$(info	COL		{EXTRA_,}COLFLAGS)
	$(info	)
	$(info	MANDOC		{EXTRA_,}MANDOCFLAGS)
	$(info	MAN2HTML	{EXTRA_,}MAN2HTMLFLAGS)
	$(info	)
	$(info	BZIP2		{EXTRA_,}BZIP2FLAGS)
	$(info	CP)
	$(info	ECHO)
	$(info	EXPR)
	$(info	FIND)
	$(info	GIT)
	$(info	GZIP		{EXTRA_,}GZIPFLAGS)
	$(info	HEAD)
	$(info	LN)
	$(info	LOCALE)
	$(info	LZIP		{EXTRA_,}LZIPFLAGS)
	$(info	PKGCONF)
	$(info	SED)
	$(info	SORTMAN)
	$(info	SPONGE)
	$(info	TAC)
	$(info	TAIL)
	$(info	TAR)
	$(info	TEST)
	$(info	XARGS)
	$(info	XZ		{EXTRA_,}XZFLAGS)
	$(info	)
	$(info	INSTALL)
	$(info	INSTALL_DATA)
	$(info	MKDIR)
	$(info	RM)
	$(info	)
	$(info	-		{EXTRA_,}CPPFLAGS)
	$(info	CC		{EXTRA_,}CFLAGS)
	$(info	LD		{EXTRA_,}LDFLAGS	{EXTRA_,}LDLIBS)
	$(info	)
	$(info	CHECKPATCH	{EXTRA_,}CHECKPATCHFLAGS)
	$(info	CLANG-TIDY	{EXTRA_,}CLANG-TIDYFLAGS)
	$(info	CPPCHECK	{EXTRA_,}CPPCHECKFLAGS)
	$(info	CPPLINT		{EXTRA_,}CPPLINTFLAGS)
	$(info	IWYU		{EXTRA_,}IWYUFLAGS)
	$(info	)


.PHONY: nothing
nothing:;


.DELETE_ON_ERROR:
