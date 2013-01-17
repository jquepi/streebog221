# $Id$

NAME=GOST34.11-2012
VERSION=`cat VERSION`

DISTNAME=$(NAME)-$(VERSION)

SOURCES=gost3411-2012.c gost3411-2012-core.h gost3411-2012-intrin.h gost3411-2012-core.c

CC?=cc
WARN?=-pedantic -Wall -Wstrict-prototypes -Wmissing-prototypes -Wshadow -Wconversion -Wno-long-long -Wextra -Wpointer-arith -Wcast-qual -Winline
OPTIMIZE?=-O2 -msse2 # -mmmx -msse -msse3 -msse4 -msse4.1 -msse4.2 
CFLAGS+=-g $(OPTIMIZE) $(WARN)
DEFAULT_INCLUDES=-I.
COMPILE=$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(CFLAGS) 

all: gost3411

gost3411: $(SOURCES)
	$(COMPILE) -o gost3411 gost3411-2012-core.c gost3411-2012.c

remake: clean all

clean:
	-rm gost3411 *.core 2>/dev/null

dist: clean
	mkdir -p $(DISTNAME)
	cp $(SOURCES) Makefile VERSION Changelog $(DISTNAME)
	tar czf $(DISTNAME).tar.gz $(DISTNAME)
	rm -r $(DISTNAME)

distclean: 
	-rm $(DISTNAME).tar.gz 2>/dev/null

bench: 
	make remake CC=clang && ./gost3411 -b
	make remake CC=gcc46 && ./gost3411 -b
	make remake CC=gcc47 && ./gost3411 -b
	make remake CC=gcc && ./gost3411 -b
