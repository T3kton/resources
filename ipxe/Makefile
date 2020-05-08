DEBUG_OPS :=

all:
	$(MAKE) $(MFLAGS) bin/console.kpxe
	$(MAKE) $(MFLAGS) bin/ttyS0.kpxe
	$(MAKE) $(MFLAGS) bin/ttyS1.kpxe
	$(MAKE) $(MFLAGS) bin/ttyS2.kpxe
	$(MAKE) $(MFLAGS) bin/ttyS3.kpxe
	$(MAKE) $(MFLAGS) bin/console.efi
	$(MAKE) $(MFLAGS) bin/ttyS0.efi
	$(MAKE) $(MFLAGS) bin/ttyS1.efi
	$(MAKE) $(MFLAGS) bin/ttyS2.efi
	$(MAKE) $(MFLAGS) bin/ttyS3.efi

# $(1) console/1/2/3/4 (com numbering)
# $(2) efi/kpxe
define configure_src
	@echo " ---- Configuring for output: $(1) target: $(2) ----"
	REG=""; \
	if [ "x$(1)" = "xconsole" ]; then REG="$$REG; s/T3KTON_COM/0/"; else REG="$$REG; s/T3KTON_COM/$(1)/"; fi; \
	if [ "x$(2)" = "xefi" ]; then REG="$$REG; s/T3KTON_EFI/1/"; else REG="$$REG; s/T3KTON_EFI/0/"; fi; \
	for FILE in config/*; do cat $$FILE | sed "$$REG" > src/config/local/$$(basename $$FILE); done
endef

# https://ipxe.org/appnote/buildtargets

bin/console.kpxe: script.ipxe source.touch
	mkdir -p bin
	$(MAKE) -C src veryclean
	$(call configure_src,console,kpxe)
	env -i PATH=$(PATH) $(MAKE) $(MFLAGS) -C src bin-i386-pcbios/undionly.kpxe EMBED=../../script.ipxe EXTRAVERSION="+(console)" $(DEBUG_OPS)
	cp src/bin-i386-pcbios/undionly.kpxe bin/console.kpxe

bin/ttyS0.kpxe: script.ipxe source.touch
	mkdir -p bin
	$(MAKE) -C src veryclean
	$(call configure_src,1,kpxe)
	env -i PATH=$(PATH) $(MAKE) $(MFLAGS) -C src bin-i386-pcbios/undionly.kpxe EMBED=../../script.ipxe EXTRAVERSION="+(ttys0)" $(DEBUG_OPS)
	cp src/bin-i386-pcbios/undionly.kpxe bin/ttyS0.kpxe

bin/ttyS1.kpxe: script.ipxe source.touch
	mkdir -p bin
	$(MAKE) -C src veryclean
	$(call configure_src,2,kpxe)
	env -i PATH=$(PATH) $(MAKE) $(MFLAGS) -C src bin-i386-pcbios/undionly.kpxe EMBED=../../script.ipxe EXTRAVERSION="+(ttys1)" $(DEBUG_OPS)
	cp src/bin-i386-pcbios/undionly.kpxe bin/ttyS1.kpxe

bin/ttyS2.kpxe: script.ipxe source.touch
	mkdir -p bin
	$(MAKE) -C src veryclean
	$(call configure_src,3,kpxe)
	env -i PATH=$(PATH) $(MAKE) $(MFLAGS) -C src bin-i386-pcbios/undionly.kpxe EMBED=../../script.ipxe EXTRAVERSION="+(ttys2)" $(DEBUG_OPS)
	cp src/bin-i386-pcbios/undionly.kpxe bin/ttyS2.kpxe

bin/ttyS3.kpxe: script.ipxe source.touch
	mkdir -p bin
	$(MAKE) -C src veryclean
	$(call configure_src,4,kpxe)
	env -i PATH=$(PATH) $(MAKE) $(MFLAGS) -C src bin-i386-pcbios/undionly.kpxe EMBED=../../script.ipxe EXTRAVERSION="+(ttys3)" $(DEBUG_OPS)
	cp src/bin-i386-pcbios/undionly.kpxe bin/ttyS3.kpxe

bin/console.efi: script.ipxe source.touch
	mkdir -p bin
	$(MAKE) -C src veryclean
	$(call configure_src,console,efi)
	env -i PATH=$(PATH) $(MAKE) $(MFLAGS) -C src bin-x86_64-efi/snponly.efi EMBED=../../script.ipxe EXTRAVERSION="+(console)" $(DEBUG_OPS)
	cp src/bin-x86_64-efi/snponly.efi bin/console.efi

bin/ttyS0.efi: script.ipxe source.touch
	mkdir -p bin
	$(MAKE) -C src veryclean
	$(call configure_src,1,efi)
	env -i PATH=$(PATH) $(MAKE) $(MFLAGS) -C src bin-x86_64-efi/snponly.efi EMBED=../../script.ipxe EXTRAVERSION="+(ttys0)" $(DEBUG_OPS)
	cp src/bin-x86_64-efi/snponly.efi bin/ttyS0.efi

bin/ttyS1.efi: script.ipxe source.touch
	mkdir -p bin
	$(MAKE) -C src veryclean
	$(call configure_src,2,efi)
	env -i PATH=$(PATH) $(MAKE) $(MFLAGS) -C src bin-x86_64-efi/snponly.efi EMBED=../../script.ipxe EXTRAVERSION="+(ttys1)" $(DEBUG_OPS)
	cp src/bin-x86_64-efi/snponly.efi bin/ttyS1.efi

bin/ttyS2.efi: script.ipxe source.touch
	mkdir -p bin
	$(MAKE) -C src veryclean
	$(call configure_src,3,efi)
	env -i PATH=$(PATH) $(MAKE) $(MFLAGS) -C src bin-x86_64-efi/snponly.efi EMBED=../../script.ipxe EXTRAVERSION="+(ttys2)" $(DEBUG_OPS)
	cp src/bin-x86_64-efi/snponly.efi bin/ttyS2.efi

bin/ttyS3.efi: script.ipxe source.touch
	mkdir -p bin
	$(MAKE) -C src veryclean
	$(call configure_src,4,efi)
	env -i PATH=$(PATH) $(MAKE) $(MFLAGS) -C src bin-x86_64-efi/snponly.efi EMBED=../../script.ipxe EXTRAVERSION="+(ttys3)" $(DEBUG_OPS)
	cp src/bin-x86_64-efi/snponly.efi bin/ttyS3.efi

source.touch:
	git clone http://git.ipxe.org/ipxe.git github_source
	$(RM) -f src/config/local/*
	touch source.touch

clean:
	$(RM) -r bin
	$(MAKE) -C src veryclean || true

dist-clean: clean
	$(RM) -r github_source
	$(RM) source.touch

.PHONY: all clean dist-clean
