Version=18.0

PREFIX = /usr/local

CFG = $(wildcard cfg/*.cfg)

THEME = \
	$(wildcard blackbird-live/*.png) \
	blackbird-live/theme.txt \
	blackbird-live/*.pf2

ICONS= $(wildcard blackbird-live/icons/*.png)

TZ = $(wildcard tz/*)

LOCALES = $(wildcard locales/*)

install:
	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/themes/blackbird-live
	install -m0644 ${THEME} $(DESTDIR)$(PREFIX)/share/grub/themes/blackbird-live

	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/themes/blackbird-live/icons
	install -m0644 ${ICONS} $(DESTDIR)$(PREFIX)/share/grub/themes/blackbird-live/icons

uninstall:
	for f in ${THEME}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/theme/blackbird-live/$$f; done
	for f in ${ICONS}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/theme/blackbird-live/icons/$$f; done

dist:
	git archive --format=tar --prefix=grub-theme-$(Version)/ $(Version) | gzip -9 > grub-theme-$(Version).tar.gz
	gpg --detach-sign --use-agent grub-theme-$(Version).tar.gz

.PHONY: install uninstall dist
