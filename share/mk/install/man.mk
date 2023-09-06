########################################################################
# Copyright 2021-2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later
########################################################################


ifndef MAKEFILE_INSTALL_MAN_INCLUDED
MAKEFILE_INSTALL_MAN_INCLUDED := 1


include $(MAKEFILEDIR)/cmd.mk
include $(MAKEFILEDIR)/compress.mk
include $(MAKEFILEDIR)/install/_.mk
include $(MAKEFILEDIR)/src.mk


LINK_PAGES := .so
ifeq ($(LINK_PAGES),.so)
else ifeq ($(LINK_PAGES),symlink)
else
$(warning "LINK_PAGES": "$(LINK_PAGES)")
$(error Valid values for "LINK_PAGES": [".so", "symlink"])
endif


mandir := $(datarootdir)/man
$(foreach s, $(MANSECTIONS),                                                  \
	$(eval man$(s)dir := $(mandir)/man$(s)))
$(foreach s, $(MANSECTIONS),                                                  \
	$(eval man$(s)ext := .$(s)))


_mandir := $(DESTDIR)$(mandir)
$(foreach s, $(MANSECTIONS),                                                  \
	$(eval _man$(s)dir := $(DESTDIR)$(man$(s)dir)))

$(foreach s, $(MANSECTIONS),                                                  \
	$(eval _man$(s)pages :=                                               \
		$(patsubst $(MAN$(s)DIR)/%.$(s), $(_man$(s)dir)/%$(man$(s)ext)$(Z), \
			$(MAN$(s)PAGES))))
$(foreach s, $(MANSECTIONS),                                                  \
	$(eval _man$(s)intropage :=                                           \
		$(patsubst $(MAN$(s)DIR)/%.$(s), $(_man$(s)dir)/%$(man$(s)ext)$(Z), \
			$(MAN$(s)INTROPAGE))))
_manintropages := $(foreach s, $(MANSECTIONS), $(_man$(s)intropage))
_manpages := $(_manintropages) $(foreach s, $(MANSECTIONS), $(_man$(s)pages))

_manintropages_rm := $(addsuffix -rm, $(wildcard $(_manintropages)))
$(foreach s, $(MANSECTIONS),                                                  \
	$(eval _man$(s)pages_rm :=                                            \
		$(addsuffix -rm,                                              \
			$(wildcard $(_man$(s)pages)))))


$(foreach s, $(MANSECTIONS),                                                  \
	$(eval $(_man$(s)pages) $(_man$(s)intropage):                         \
		$(_man$(s)dir)/%$(man$(s)ext)$(Z):                            \
			$(MAN$(s)DIR)/%.$(s) $(MK) | $$$$(@D)/))


$(_manpages):
	$(info INSTALL	$@)
	<$< \
	$(SED) $(foreach s, $(MANSECTIONS), \
		-e '/^\.so /s, man$(s)/\(.*\)\.$(s)$$, $(notdir $(man$(s)dir))/\1$(man$(s)ext)$(Z),') \
	| $(INSTALL_DATA) -T /dev/stdin $@
ifeq ($(LINK_PAGES),symlink)
	if $(GREP) '^\.so ' <$@ >/dev/null; then \
		$(GREP) '^\.so ' <$@ \
		| $(SED) 's,^\.so \(.*\),../\1,' \
		| $(XARGS) -I tgt $(LN) -fsT tgt $@; \
	fi
endif
ifeq ($(Z),.bz2)
	if ! $(TEST) -L $@; then \
		$(BZIP2) $(BZIP2FLAGS) <$@ \
		| $(SPONGE) $@; \
	fi
else ifeq ($(Z),.gz)
	if ! $(TEST) -L $@; then \
		$(GZIP) $(GZIPFLAGS) <$@ \
		| $(SPONGE) $@; \
	fi
else ifeq ($(Z),.lz)
	if ! $(TEST) -L $@; then \
		$(LZIP) $(LZIPFLAGS) <$@ \
		| $(SPONGE) $@; \
	fi
else ifeq ($(Z),.xz)
	if ! $(TEST) -L $@; then \
		$(XZ) $(XZFLAGS) <$@ \
		| $(SPONGE) $@; \
	fi
endif


.PHONY: install-manintro
install-manintro:  $(_manintropages);
$(foreach s, $(MANSECTIONS),                                                  \
	$(eval .PHONY: install-man$(s)))
$(foreach s, $(MANSECTIONS),                                                  \
	$(eval install-man$(s): $(_man$(s)pages);))
.PHONY: install-man
install-man: install-manintro $(foreach s, $(MANSECTIONS), install-man$(s));

.PHONY: uninstall-manintro
uninstall-manintro: $(_manintropages_rm);
$(foreach s, $(MANSECTIONS),                                                  \
	$(eval .PHONY: uninstall-man$(s)))
$(foreach s, $(MANSECTIONS),                                                  \
	$(eval uninstall-man$(s): $(_man$(s)pages_rm);))
.PHONY: uninstall-man
uninstall-man: uninstall-manintro $(foreach s, $(MANSECTIONS), uninstall-man$(s));


endif  # include guard
