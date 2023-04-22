########################################################################
# Copyright (C) 2021 - 2023  Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier:  GPL-3.0-or-later  OR  LGPL-3.0-or-later
########################################################################


ifndef MAKEFILE_LINT_INCLUDED
MAKEFILE_LINT_INCLUDED := 1


lint := lint-c lint-man lint-mdoc


.PHONY: lint
lint: $(lint)
	@:


endif  # MAKEFILE_LINT_INCLUDED
