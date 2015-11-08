INSTALLDIR=$(DESTDIR)/usr/share/icons/

install:
	# Installing Oranchelo
	cp -rf Oranchelo* $(INSTALLDIR)

uninstall:
	# Removing Oranchelo
	rm -rf $(INSTALLDIR)Oranchelo*