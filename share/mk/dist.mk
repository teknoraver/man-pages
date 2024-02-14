########################################################################
# Copyright 2021-2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_DIST_INCLUDED
MAKEFILE_DIST_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/configure/build-depends/bzip2.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/build-depends/findutils.mk
include $(MAKEFILEDIR)/configure/build-depends/git.mk
include $(MAKEFILEDIR)/configure/build-depends/gzip.mk
include $(MAKEFILEDIR)/configure/build-depends/lzip.mk
include $(MAKEFILEDIR)/configure/build-depends/sed.mk
include $(MAKEFILEDIR)/configure/build-depends/tar.mk
include $(MAKEFILEDIR)/configure/build-depends/xz-utils.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/configure/verbose.mk
include $(MAKEFILEDIR)/configure/version.mk
include $(MAKEFILEDIR)/install/_.mk


_DISTDIR := $(builddir)/dist


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


$(_DISTPAGES): $(_DISTDIR)/man%: $(srcdir)/man% $(MK) | $$(@D)/
	$(info INSTALL	$@)
	<$< \
	$(SED) "/^.TH/s/(date)/$$(git log --format=%cs -1 -- $< $(HIDE_ERR))/" \
	| $(SED) '/^.TH/s/(unreleased)/$(DISTVERSION)/' \
	| $(INSTALL_DATA) -T /dev/stdin $@

$(_DISTOTHERS): $(_DISTDIR)/%: $(srcdir)/% $(MK) | $$(@D)/
	$(info CP	$@)
	$(CP) -T $< $@


$(DISTFILE): $(_DISTFILES) $(MK) | $$(@D)/
	$(info TAR	$@)
	$(TAR) $(TARFLAGS) -cf $@ -T /dev/null
	$(GIT) ls-files \
	| $(SED) 's,^,$(_DISTDIR)/,' \
	| $(XARGS) $(TAR) $(TARFLAGS) -rf $@ -C $(srcdir) \
		--transform 's,^$(_DISTDIR),$(DISTNAME),'

define DISTFILE_z_rule
$(DISTFILE).$(2): %.$(2): % $(MK) | $$$$(@D)/
	$$(info	$(1)	$$@)
	$($(1)) $($(1)FLAGS) -kf $$<
	$(TOUCH) $$@
endef

$(eval $(call DISTFILE_z_rule,BZIP2,bz2))
$(eval $(call DISTFILE_z_rule,GZIP,gz))
$(eval $(call DISTFILE_z_rule,LZIP,lz))
$(eval $(call DISTFILE_z_rule,XZ,xz))


.PHONY: dist-tar
dist-tar: $(DISTFILE);


$(foreach z, $(compression),                                                  \
	$(eval .PHONY: dist-$(z)))
$(foreach z, $(compression),                                                  \
	$(eval dist-$(z): $(DISTFILE).$(z);))
.PHONY: dist
dist: $(foreach z, $(compression), dist-$(z));


endif  # include guard
