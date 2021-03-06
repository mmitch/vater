BINARY := vater
SOURCES := vater.vala

VALAC ?= valac
VALAFLAGS += --pkg gtk+-3.0 --pkg vte-2.91

all: compile install

compile: $(BINARY)

install: compile
	install -t ~/bin $(BINARY)

uninstall:
	rm ~/bin/$(BINARY)

$(BINARY): $(SOURCES)
	$(VALAC) -o $(BINARY) $(VALAFLAGS) $(SOURCES)

clean:
	-rm -f $(BINARY)
	-rm -f *~
