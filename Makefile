export OPENRC_RUN ?= /usr/bin/openrc-run
export BINDIR ?= /usr/bin
export SYSCONFDIR ?= /etc
export OPENRC_DIR ?= /etc

MACRO_PROG = ./replace.sh
INIT_FILES = $(shell find init.d.in -type f | sed -e 's/\.in$$//g' -e 's/init\.d\.in/init.d/g')
CONF_FILES = $(shell find conf.d.in -type f | sed -e 's/\.in$$//g' -e 's/conf\.d\.in/conf.d/g')
DEST_INIT_D = $(DESTDIR)/$(OPENRC_DIR)/init.d
DEST_CONF_D = $(DESTDIR)/$(OPENRC_DIR)/conf.d

all: $(INIT_FILES) $(CONF_FILES)

init.d:
	mkdir $@

conf.d:
	mkdir $@

init.d/%: init.d.in/%.in init.d
	$(MACRO_PROG) $< > $@
	chmod +x $@

conf.d/%: conf.d.in/%.in conf.d
	$(MACRO_PROG) $< > $@
	chmod +x $@

.PHONY: clean install
clean:
	rm $(INIT_FILES) $(CONF_FILES)

install:
	install -d "$(DEST_INIT_D)"
	install -d "$(DEST_CONF_D)"

	$(foreach file,$(INIT_FILES),install -Dm 755 "$(file)" "$(DEST_INIT_D)";)
	$(foreach file,$(CONF_FILES),install -Dm 755 "$(file)" "$(DEST_CONF_D)";)
