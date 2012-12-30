# Makefile
prefix ?= /usr
version = txt2man-1.5.6
BIN = src2man bookman txt2man
MAN1 = src2man.1 txt2man.1 bookman.1

all: $(MAN1)

install: $(MAN1)
	mkdir -p $(DESTDIR)$(prefix)/bin $(DESTDIR)$(prefix)/share/man/man1
	cp $(BIN) $(DESTDIR)$(prefix)/bin/
	cp $(MAN1) $(DESTDIR)$(prefix)/share/man/man1

clean:
	rm -f *.1 *.txt *.ps *.pdf *.html

%.1:%.txt; ./txt2man -s 1 -t $* -r $(version) $< > $@
%.txt:%; ./$< -h 2>&1 > $@
%.html:%.1; rman -f HTML $< > $@
%.ps:%.1; groff -man $< > $@
%.pdf:%.ps; ps2pdf $< > $@
