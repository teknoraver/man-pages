#!/bin/sh


./prepare_linux_man_book.pl "$@" >LMBpages.man;


groff -z -dPDF.EXPORT=1 -dLABEL.REFS=1 -dpaper=a4 \
	-Tpdf -k -pet -M. -F. -mandoc -manmark -P-pa4 -rC1 -rCHECKSTYLE=3 \
	LMBpages.man 2>&1 \
| LC_ALL=C grep '^\. *ds ' >LMBbkmark.man;

cat LMBbkmark.man LMBpages.man >LMBbody.man;
preconv LMBbody.man >LMBbody.tbl;
tbl <LMBbody.tbl >LMBbody.eqn;
eqn -Tpdf <LMBbody.eqn >LMBbody.pdf.troff.man;
troff -Tpdf -ms LMBfront.ms >LMBfront.pdf.set;
troff -Tpdf -M. -F. -mandoc -manmark -dpaper=a4 <LMBbody.pdf.troff.man >LMBbody.pdf.set;
gropdf -F. LMBfront.pdf.set LMBbody.pdf.set -pa4 >LinuxManBook.pdf;
