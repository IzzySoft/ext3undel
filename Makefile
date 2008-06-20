# Makefile for ext3undel
# $Id: Makefile 43 2008-05-27 15:30:53Z izzy $

DESTDIR=
INSTALL=install
INSTALL_PROGRAM=$(INSTALL)
INSTALL_DATA=$(INSTALL) -m 644
prefix=/usr/local
exec_prefix=$(prefix)
bindir=$(exec_prefix)/bin
datarootdir=$(prefix)/share
datadir=$(datarootdir)
docdir=$(datarootdir)/doc/ext3undel
sysconfdir=/etc/ext3undel
mandir=$(datarootdir)/man
man5dir=$(mandir)/man5
man8dir=$(mandir)/man8

install: installdirs
	$(INSTALL) -c ralf gabi ext3undel $(DESTDIR)$(bindir)
	$(INSTALL_DATA) -c doc/* $(DESTDIR)$(docdir)
	$(INSTALL_DATA) -c ext3undelrc $(DESTDIR)$(sysconfdir)
	gzip man/*
	$(INSTALL_DATA) -c man/*.8* $(DESTDIR)$(man8dir)

uninstall:
	rm -f $(DESTDIR)$(bindir)/ralf
	rm -f $(DESTDIR)$(bindir)/gabi
	rm -f $(DESTDIR)$(bindir)/ext3undel
	rm -rf $(DESTDIR)$(sysconfdir)
	rm -rf $(DESTDIR)$(docdir)
	rm -f $(DESTDIR)$(man8dir)/ralf.*
	rm -f $(DESTDIR)$(man8dir)/gabi.*
	rm -f $(DESTDIR)$(man8dir)/ext3undel.*

installdirs:
	# Generate all required target directories (due to DESTDIR, i.e. all)
	mkdir -p $(DESTDIR)$(docdir)
	mkdir -p $(DESTDIR)$(sysconfdir)
	if [ ! -d $(DESTDIR)$(bindir) ]; then mkdir -p $(DESTDIR)$(bindir); fi
	if [ ! -d $(DESTDIR)$(man8dir) ]; then mkdir -p $(DESTDIR)$(man8dir); fi
