#!/bin/sh
# Copyright 2023, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later

(
	cat "$(dirname "$0")"/LMBfront.roff;
	cat "$(dirname "$0")"/an.tmac;
	"$(dirname "$0")"/prepare.pl "$1";
) \
| preconv \
| pic \
| tbl \
| eqn -Tpdf \
| troff -Tpdf -F"$(dirname "$0")" -dpaper=a4 \
| gropdf -F"$(dirname "$0")" -pa4;
