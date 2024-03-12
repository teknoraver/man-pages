#!/usr/bin/env -Sbash
# Copyright 2023-2024, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later


test -v CAT     || CAT=cat;
test -v PRECONV || PRECONV=preconv;
test -v PIC     || PIC=pic;
test -v TBL     || TBL=tbl;
test -v EQN     || EQN=eqn;
test -v TROFF   || TROFF=troff;
test -v GROPDF  || GROPDF=gropdf;


(
	$CAT "$(dirname "$0")"/LMBfront.roff;
	$CAT "$(dirname "$0")"/an.tmac;
	"$(dirname "$0")"/prepare.pl "$1";
) \
| $PRECONV \
| $PIC \
| $TBL \
| $EQN -Tpdf \
| $TROFF -Tpdf -F"$(dirname "$0")" -dpaper=a4 \
| $GROPDF -F"$(dirname "$0")" -pa4;
