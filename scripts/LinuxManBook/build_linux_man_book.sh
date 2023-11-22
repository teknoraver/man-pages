#!/bin/sh
# Copyright 2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later

(
	./prepare_linux_man_book.pl "$1" \
	| groff -z -dPDF.EXPORT=1 -dLABEL.REFS=1 -dpaper=a4 -Tpdf -k -pet \
		-M. -F. -mandoc -manmark -P-pa4 \-rC1 -rCHECKSTYLE=3 2>&1 \
	| LC_ALL=C grep '^\. *ds ';

	./prepare_linux_man_book.pl "$1";
) \
| preconv \
| tbl \
| eqn -Tpdf \
| (
	troff -Tpdf -ms <LMBfront.ms;
	troff -Tpdf -M. -F. -mandoc -manmark -dpaper=a4;
) \
| gropdf -F. -pa4;
