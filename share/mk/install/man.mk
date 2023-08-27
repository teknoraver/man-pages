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
	$(eval man$(s)ext := .$(s)$(Z)))


_mandir := $(DESTDIR)$(mandir)
$(foreach s, $(MANSECTIONS),                                                  \
	$(eval _man$(s)dir := $(DESTDIR)$(man$(s)dir)))

_manintropages := $(patsubst $(MANDIR)/%, $(_mandir)/%$(Z), $(MANINTROPAGES))
$(foreach s, $(MANSECTIONS),                                                  \
	$(eval _man$(s)pages :=                                               \
		$(patsubst $(MANDIR)/man$(s)/%, $(_man$(s)dir)/%$(Z),         \
			$(MAN$(s)PAGES))))
_manpages := $(_manintropages) $(foreach s, $(MANSECTIONS), $(_man$(s)pages))

_manintropages_rm := $(addsuffix -rm, $(wildcard $(_manintropages)))
$(foreach s, $(MANSECTIONS),                                                  \
	$(eval _man$(s)pages_rm :=                                            \
		$(addsuffix -rm,                                              \
			$(wildcard $(_man$(s)pages)))))


$(_manintropages): $(_mandir)/%$(Z): $(MANDIR)/% | $$(@D)/
$(foreach s, $(MANSECTIONS),                                                  \
	$(eval $(_man$(s)pages): $(_man$(s)dir)/%$(Z): $(MAN$(s)DIR)/% | $$$$(@D)/))


$(_manpages):
	$(info INSTALL	$@)
	<$< \
	$(SED) \
		-e '/^\.so /s, man1/\(.*\)\.1$$, $(notdir $(man1dir))/\1$(man1ext),' \
		-e '/^\.so /s, man2/\(.*\)\.2$$, $(notdir $(man2dir))/\1$(man2ext),' \
		-e '/^\.so /s, man2type/\(.*\)\.2type$$, $(notdir $(man2typedir))/\1$(man2typeext),' \
		-e '/^\.so /s, man3/\(.*\)\.3$$, $(notdir $(man3dir))/\1$(man3ext),' \
		-e '/^\.so /s, man3const/\(.*\)\.3const$$, $(notdir $(man3constdir))/\1$(man3constext),' \
		-e '/^\.so /s, man3head/\(.*\)\.3head$$, $(notdir $(man3headdir))/\1$(man3headext),' \
		-e '/^\.so /s, man3type/\(.*\)\.3type$$, $(notdir $(man3typedir))/\1$(man3typeext),' \
		-e '/^\.so /s, man4/\(.*\)\.4$$, $(notdir $(man4dir))/\1$(man4ext),' \
		-e '/^\.so /s, man5/\(.*\)\.5$$, $(notdir $(man5dir))/\1$(man5ext),' \
		-e '/^\.so /s, man6/\(.*\)\.6$$, $(notdir $(man6dir))/\1$(man6ext),' \
		-e '/^\.so /s, man7/\(.*\)\.7$$, $(notdir $(man7dir))/\1$(man7ext),' \
		-e '/^\.so /s, man8/\(.*\)\.8$$, $(notdir $(man8dir))/\1$(man8ext),' \
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
		$(GZIP) $(GZIPFLAGS) - <$@ \
		| $(SPONGE) $@; \
	fi
else ifeq ($(Z),.lz)
	if ! $(TEST) -L $@; then \
		$(LZIP) $(LZIPFLAGS) - <$@ \
		| $(SPONGE) $@; \
	fi
else ifeq ($(Z),.xz)
	if ! $(TEST) -L $@; then \
		$(XZ) $(XZFLAGS) - <$@ \
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
