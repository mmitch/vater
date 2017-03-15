# The actual runnable program is set to the SCRIPTS primitive.
# # Prefix bin_ tells where to copy this
bin_PROGRAMS = vater
vater_CFLAGS = $(gtk_CFLAGS) $(vte_CFLAGS)
vater_LDADD = $(gtk_LIBS) $(vte_LIBS)
vater_VALAFLAGS = --pkg gtk+-3.0 --pkg vte-2.91
vater_SOURCES = vater.vala

desktopdir = $(datadir)/applications
desktop_DATA = \
	vater.desktop
