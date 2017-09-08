BINARY := vater
FONTCONF := fonts.conf
SOURCES != find . -maxdepth 1 -name '*.vala'

VALAC ?= valac
VALAFLAGS += --pkg gtk+-3.0 --pkg vte-2.91

all: generate compile install

generate: $(FONTCONF)

compile: $(BINARY)

install: compile
	install -t ~/bin $(BINARY)

uninstall:
	rm ~/bin/$(BINARY)

$(BINARY): $(SOURCES)
	$(VALAC) -o $(BINARY) $(VALAFLAGS) $(SOURCES)

clean:
	-rm -f $(FONTCONF)
	-rm -f $(BINARY)
	-rm -f *~

$(FONTCONF):
	./generate-fonts.conf.pl > $(FONTCONF)
