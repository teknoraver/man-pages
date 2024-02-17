# Copyright 2021-2024 Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_CLEAN_INCLUDED
MAKEFILE_CLEAN_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils.mk
include $(MAKEFILEDIR)/configure/directory_variables.mk
include $(MAKEFILEDIR)/dist/check/tar.mk


.PHONY: clean
clean:
	$(info	RM -rf		$(builddir))
	$(RM) -rf $(builddir)
	$(info	RM -rf		$(TMPDIR1))
	$(RM) -rf $(TMPDIR1)
	$(info	RM -rf		$(TMPDIR2))
	$(RM) -rf $(TMPDIR2)


endif  # include guard
