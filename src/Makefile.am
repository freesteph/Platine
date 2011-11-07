## Process this file with automake to produce Makefile.in

## Created by Anjuta


uidir = $(datadir)/platine/ui
ui_DATA = main.ui


AM_CPPFLAGS = \
	-DPACKAGE_LOCALE_DIR=\""$(prefix)/$(DATADIRNAME)/locale"\" \
	-DPACKAGE_SRC_DIR=\""$(srcdir)"\" \
	-DPACKAGE_DATA_DIR=\""$(datadir)"\" \
	$(PLATINE_CFLAGS)

AM_CFLAGS =\
	 -Wall\
	 -g

VALAFLAGS =  \
	--pkg gtk+-3.0 \
	--pkg gee-1.0 \
	--pkg gstreamer-0.10 \
	--pkg gmodule-2.0 \
	--vapidir . \
	--pkg config

bin_PROGRAMS = platine

platine_SOURCES = \
	platine-main.vala

platine_LDFLAGS = \
	-Wl,--export-dynamic

platine_LDADD = $(PLATINE_LIBS)


EXTRA_DIST = $(ui_DATA)

# Remove ui directory on uninstall
uninstall-local:
	-rm -r $(uidir)
	-rm -r $(datadir)/platine
