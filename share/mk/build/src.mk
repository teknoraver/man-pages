########################################################################
# Copyright 2021-2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_BUILD_SRC_INCLUDED
MAKEFILE_BUILD_SRC_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/cmd.mk
include $(MAKEFILEDIR)/src.mk
include $(MAKEFILEDIR)/verbose.mk


PKGCONF_LIBS := libbsd-overlay


DEFAULT_CPPFLAGS := $(shell $(PKGCONF) --cflags $(PKGCONF_LIBS) $(HIDE_ERR))
EXTRA_CPPFLAGS   :=
CPPFLAGS         := $(DEFAULT_CPPFLAGS) $(EXTRA_CPPFLAGS)

DEFAULT_CFLAGS := \
	-std=gnu17 \
	-Wall \
	-Wextra \
	-Wstrict-prototypes \
	-Wdeclaration-after-statement \
	-Werror \
	-Wno-error=unused-parameter \
	-Wno-error=sign-compare \
	-Wno-error=format \
	-Wno-error=uninitialized
	#-Wno-error=declaration-after-statement
EXTRA_CFLAGS   :=
CFLAGS         := $(DEFAULT_CFLAGS) $(EXTRA_CFLAGS)

DEFAULT_LDFLAGS := \
	-Wl,--as-needed \
	-Wl,--no-allow-shlib-undefined \
	-Wl,--no-copy-dt-needed-entries \
	-Wl,--no-undefined \
	$(shell $(PKGCONF) --libs-only-L $(PKGCONF_LIBS) $(HIDE_ERR)) \
	$(shell $(PKGCONF) --libs-only-other $(PKGCONF_LIBS) $(HIDE_ERR))
EXTRA_LDFLAGS   :=
LDFLAGS         := $(DEFAULT_LDFLAGS) $(EXTRA_LDFLAGS)

DEFAULT_LDLIBS := \
	-lc \
	$(shell $(PKGCONF) --libs-only-l $(PKGCONF_LIBS) $(HIDE_ERR))
EXTRA_LDLIBS   :=
LDLIBS         := $(DEFAULT_LDLIBS) $(EXTRA_LDLIBS)


CC  := cc
LD  := $(CC) $(CFLAGS)


_SRCPAGEDIRS   := $(patsubst $(MANDIR)/%,$(_MANDIR)/%.d/,$(NONSO_MAN))

_UNITS_src_src := $(patsubst $(MANDIR)/%,$(_MANDIR)/%,$(shell \
		$(FIND) $(MANDIR)/* -type f \
		| $(GREP) '$(MANEXT)' \
		| $(XARGS) $(GREP) -H '^\.\\" SRC BEGIN ' \
		| $(SED) 's,:\.\\" SRC BEGIN (,.d/,' \
		| $(SED) 's/)//' \
		| $(SORTMAN) \
		| $(SED) 's,:,\\:,g'))
_UNITS_src_h   := $(filter %.h,$(_UNITS_src_src))
_UNITS_src_c   := $(filter %.c,$(_UNITS_src_src))
_UNITS_src_o   := $(patsubst %.c,%.o,$(_UNITS_src_c))
_UNITS_src_bin := $(patsubst %.c,%,$(_UNITS_src_c))


$(_SRCPAGEDIRS): $(_MANDIR)/%.d/: $(MANDIR)/%
	+$(info MKDIR	$@)
	+$(MKDIR) $@
	+touch $@

$(_UNITS_src_src): $$(patsubst $(_MANDIR)/%.d,$(MANDIR)/%,$$(@D)) $(MK) | $$(@D)/
$(_UNITS_src_c):   $$(filter $$(@D)/%.h,$(_UNITS_src_h))
$(_UNITS_src_src):
	$(info SED	$@)
	<$< \
	$(SED) -n \
		-e '/^\.TH/,/^\.SH/{/^\.SH/!p}' \
		-e '/^\.SH EXAMPLES/p' \
		-e "/^\... SRC BEGIN ($(@F))$$/,/^\... SRC END$$/p" \
	| $(MANDOC) -Tutf8 \
	| $(SED) '/^[^ ]/d' \
	| $(SED) 's/^       //' \
	>$@

$(_UNITS_src_o): %.o: %.c $(MK)
	$(info CC	$@)
	$(CC) -c $(CPPFLAGS) $(CFLAGS) -o $@ $<

$(_UNITS_src_bin): %: %.o $(MK)
	$(info LD	$@)
	$(LD) $(LDFLAGS) -o $@ $< $(LDLIBS)


.PHONY: build-src-c
build-src-c:   $(_UNITS_src_c);

.PHONY: build-src-cc
build-src-cc:  $(_UNITS_src_o);

.PHONY: build-src-ld
build-src-ld:  $(_UNITS_src_bin);

.PHONY: build-src
build-src: build-src-ld


endif  # include guard
