export OPENRC_RUN = /usr/bin/openrc-run
export BINDIR = /usr/bin

MACRO_PROG = ./replace.sh
INIT_FILES = $(shell find init.d.in -type f | sed -e 's/\.in$$//g' -e 's/init\.d\.in/init.d/g')
CONF_FILES = $(shell find conf.d.in -type f | sed -e 's/\.in$$//g' -e 's/conf\.d\.in/conf.d/g')

all: $(INIT_FILES) $(CONF_FILES)

init.d:
	mkdir $@

conf.d:
	mkdir $@

init.d/%: init.d.in/%.in init.d
	$(MACRO_PROG) $< > $@

conf.d/%: conf.d.in/%.in conf.d
	$(MACRO_PROG) $< > $@

.PHONY: clean
clean:
	rm $(INIT_FILES) $(CONF_FILES)
