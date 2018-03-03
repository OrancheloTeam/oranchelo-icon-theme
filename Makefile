INSTALLDIR=$(DESTDIR)/usr/share/icons
THEMES_BASE_NAME=Oranchelo

install:
	# Removing icons execute permissions
	find -type f -executable -exec chmod -x {} \;

	# Installing Oranchelo
	mkdir -p $(INSTALLDIR)
	cp -r $(THEMES_BASE_NAME)* $(INSTALLDIR)

uninstall:
	# Removing Oranchelo
	rm -rf $(INSTALLDIR)/$(THEMES_BASE_NAME)*
