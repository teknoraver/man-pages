########################################################################
# Copyright 2021-2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_DIST_INCLUDED
MAKEFILE_DIST_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/cmd.mk
include $(MAKEFILEDIR)/compress.mk
include $(MAKEFILEDIR)/install/_.mk
include $(MAKEFILEDIR)/version.mk
include $(MAKEFILEDIR)/verbose.mk


_DISTDIR := $(builddir)/dist


DEFAULT_TARFLAGS := \
	--sort=name \
	--owner=root:0 \
	--group=root:0 \
	--mtime='$(DISTDATE)'
EXTRA_TARFLAGS   :=
TARFLAGS         := $(DEFAULT_TARFLAGS) $(EXTRA_TARFLAGS)


DISTFILES   := $(shell $(GIT) ls-files $(HIDE_ERR) \
			| $(SED) 's,^,$(srcdir)/,' \
			| $(SED) 's,:,\\:,g')
_DISTFILES  := $(patsubst $(srcdir)/%,$(_DISTDIR)/%,$(DISTFILES))
_DISTPAGES  := $(filter     $(_DISTDIR)/man%,$(_DISTFILES))
_DISTOTHERS := $(filter-out $(_DISTDIR)/man%,$(_DISTFILES))

DISTFILE    := $(builddir)/$(DISTNAME).tar
compression := bz2 gz lz xz


$(builddir)/dist/%/:
	+$(info INSTALL	$@)
	+$(INSTALL_DIR) $@


$(_DISTPAGES): $(_DISTDIR)/man%: $(srcdir)/man% | $$(@D)/
	$(info INSTALL	$@)
	<$< \
	$(SED) "/^.TH/s/(date)/$$(git log --format=%cs -1 -- $< $(HIDE_ERR))/" \
	| $(SED) '/^.TH/s/(unreleased)/$(DISTVERSION)/' \
	| $(INSTALL_DATA) -T /dev/stdin $@

$(_DISTOTHERS): $(_DISTDIR)/%: $(srcdir)/% | $$(@D)/
	$(info CP	$@)
	$(CP) -T $< $@


$(DISTFILE): $(_DISTFILES) | $$(@D)/
	$(info TAR	$@)
	$(TAR) $(TARFLAGS) -cf $@ -T /dev/null
	$(GIT) ls-files \
	| $(SED) 's,^,$(_DISTDIR)/,' \
	| $(XARGS) $(TAR) $(TARFLAGS) -rf $@ -C $(srcdir) \
		--transform 's,^$(_DISTDIR),$(DISTNAME),'

$(DISTFILE).bz2: %.bz2: % | $$(@D)/
	$(info BZIP2	$@)
	$(BZIP2) $(BZIP2FLAGS) -kf $<
	touch $@

$(DISTFILE).gz: %.gz: % | $$(@D)/
	$(info GZIP	$@)
	$(GZIP) $(GZIPFLAGS) -knf $<

$(DISTFILE).lz: %.lz: % | $$(@D)/
	$(info LZIP	$@)
	$(LZIP) $(LZIPFLAGS) -kf $<
	touch $@

$(DISTFILE).xz: %.xz: % | $$(@D)/
	$(info XZ	$@)
	$(XZ) $(XZFLAGS) -kf $<


.PHONY: dist-tar
dist-tar: $(DISTFILE);


$(foreach z, $(compression),                                                  \
	$(eval .PHONY: dist-$(z)))
$(foreach z, $(compression),                                                  \
	$(eval dist-$(z): $(DISTFILE).$(z);))
.PHONY: dist
dist: $(foreach z, $(compression), dist-$(z));


endif  # include guard
