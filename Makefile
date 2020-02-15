PREFIX=/usr/local
INSTALL_DIR=$(PREFIX)/bin
Mochi_SYSTEM=$(INSTALL_DIR)/mochi

OUT_DIR=$(CURDIR)/bin
Mochi=$(OUT_DIR)/mochi
Mochi_SOURCES=$(shell find src/ -type f -name '*.cr')

all: build

build: lib $(Mochi)

lib:
	@shards install --production

$(Mochi): $(Mochi_SOURCES) | $(OUT_DIR)
	@echo "Building mochi in $@"
	@crystal build -o $@ src/mochi/cli.cr -p --no-debug

$(OUT_DIR) $(INSTALL_DIR):
	 @mkdir -p $@

run:
	$(Mochi)

install: build | $(INSTALL_DIR)
	@rm -f $(Mochi_SYSTEM)
	@cp $(Mochi) $(Mochi_SYSTEM)

link: build | $(INSTALL_DIR)
	@echo "Symlinking $(Mochi) to $(Mochi_SYSTEM)"
	@ln -s $(Mochi) $(Mochi_SYSTEM)

force_link: build | $(INSTALL_DIR)
	@echo "Symlinking $(Mochi) to $(Mochi_SYSTEM)"
	@ln -sf $(Mochi) $(Mochi_SYSTEM)

clean:
	rm -rf $(Mochi)

distclean:
	rm -rf $(Mochi) .crystal .shards libs lib
