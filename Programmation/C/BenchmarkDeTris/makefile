SRCDIR=src
LIBDIR=lib
BINDIR=bin
INCLUDEDIR=include
TESTDIR=tests
CC = gcc
AR = ar
CFLAGS=-Wall -pedantic -g -std=gnu99  -I$(INCLUDEDIR)
LDFLAGS=-lm
EXEC=main

all :  $(BINDIR)/$(EXEC)

tests: $(SRCDIR)/testTris.o $(SRCDIR)/echanger.o $(SRCDIR)/triParInsertion.o $(SRCDIR)/triParMinSuccessif.o $(SRCDIR)/triRapide.o $(SRCDIR)/triFusion.o
	gcc -o $(TESTDIR)/testTris $(SRCDIR)/echanger.o $(SRCDIR)/testTris.o $(SRCDIR)/triParInsertion.o $(SRCDIR)/triParMinSuccessif.o $(SRCDIR)/triRapide.o $(SRCDIR)/triFusion.o $(LDFLAGS) -lcunit

$(BINDIR)/$(EXEC) : $(SRCDIR)/main.o $(SRCDIR)/echanger.o $(SRCDIR)/triParInsertion.o $(SRCDIR)/triParMinSuccessif.o $(SRCDIR)/triRapide.o $(SRCDIR)/triFusion.o
	$(CC)  -o $@ $^ $(LDFLAGS)

$(SRCDIR)/%.o : $(SRCDIR)/%.c
	$(CC) -o $@ -c $< $(CFLAGS)

clean :
	rm -rf $(BINDIR)/*
	rm -rf $(LIBDIR)/*
	rm -rf $(SRCDIR)/*.o
	rm -rf $(TESTDIR)/*
