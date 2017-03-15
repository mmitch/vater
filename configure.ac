# This file is processed by autoconf to create a configure script
AC_INIT([vater], 0.1)
AM_INIT_AUTOMAKE([1.10 no-define foreign dist-xz no-dist-gzip])
AC_PROG_CC
AM_PROG_VALAC([0.16])
PKG_CHECK_MODULES(gtk, gtk+-3.0)
PKG_CHECK_MODULES(vte, vte-2.91)
AC_CONFIG_FILES([Makefile vater.desktop])

AC_OUTPUT
