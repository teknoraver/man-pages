#!/bin/sh
# Copyright 2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later

(
	"$(dirname "$0")"/prepare_linux_man_book.pl "$1" \
	| groff -z -dPDF.EXPORT=1 -dLABEL.REFS=1 -dpaper=a4 -Tpdf -k -pet \
		-M"$(dirname "$0")" -mandoc -manmark \
		-F"$(dirname "$0")" -P-pa4 \-rC1 -rCHECKSTYLE=3 2>&1 \
	| LC_ALL=C grep '^\. *ds ';

	"$(dirname "$0")"/prepare_linux_man_book.pl "$1";
) \
| preconv \
| tbl \
| eqn -Tpdf \
| (
	troff -Tpdf -ms <"$(dirname "$0")"/LMBfront.ms;
	troff -Tpdf -M"$(dirname "$0")" -mandoc -manmark \
		-F"$(dirname "$0")" -dpaper=a4;
) \
| gropdf -F"$(dirname "$0")" -pa4;
