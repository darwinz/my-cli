prefix=/usr/local
exec_prefix=$(prefix)
bindir=$(exec_prefix)/bin
datarootdir=$(prefix)/share
datadir=$(datarootdir)
mandir=$(datarootdir)/man

# files that need mode 755
EXEC_FILES=bin/mycli

.PHONY: all install uninstall

all:
	@echo "usage: make install"
	@echo "       make uninstall"

install:
	mkdir -p $(bindir)
	./installer.sh -f

uninstall:
	test -d $(bindir) && \
	cd $(bindir) && \
	rm -f $(EXEC_FILES)
