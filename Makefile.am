## Process this file with automake to produce Makefile.in
## Created by Anjuta

SUBDIRS = src 

platinedocdir = ${prefix}/doc/platine
platinedoc_DATA = \
	README \
	COPYING \
	AUTHORS \
	NEWS


EXTRA_DIST = $(platinedoc_DATA)


# Remove doc directory on uninstall
uninstall-local:
	-rm -r $(platinedocdir)
