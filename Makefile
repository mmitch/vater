BINARY := vater
SOURCES != find . -maxdepth 1 -name '*.vala'

VALAC ?= valac
VALAFLAGS += --pkg gtk+-3.0 --pkg vte-2.91

all: $(BINARY)

$(BINARY): $(SOURCES)
	$(VALAC) -o $(BINARY) $(VALAFLAGS) $(SOURCES)

clean:
	-rm -f *~

