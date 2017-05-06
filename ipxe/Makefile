DEBUG_OPS :=

CONSOLE_TYPES := console
#CONSOLE_TYPES := console tty0 tty1 tty2 tty3

TARGET_LIST := $(foreach console,  $(CONSOLE_TYPES), bin/undionly_$(console).kpxe)

all: $(TARGET_LIST)

bin/undionly_console.kpxe: script.ipxe source.touch
	$(MAKE) -C src veryclean
	env -i PATH=$(PATH) $(MAKE) $(MFLAGS) -C src bin/undionly.kpxe EMBED=../../script.ipxe EXTRAVERSION="+(console)" $(DEBUG_OPS)
	cp src/bin/undionly.kpxe bin/undionly_console.kpxe

bin/undionly_ttys0.kpxe: script.ipxe source.touch
	$(MAKE) -C src veryclean
	env -i PATH=$(PATH) $(MAKE) $(MFLAGS) -C src bin/undionly.kpxe EMBED=../../script.ipxe EXTRAVERSION="+(ttys0)" T3KTON_SOL=0 $(DEBUG_OPS)
	cp bin/undionly.kpxe bin/undionly_ttys0.kpxe

bin/undionly_ttys1.kpxe: script.ipxe source.touch
	$(MAKE) -C src veryclean
	env -i PATH=$(PATH) $(MAKE) $(MFLAGS) -C src bin/undionly.kpxe EMBED=../../script.ipxe EXTRAVERSION="+(ttys1)" T3KTON_SOL=1 $(DEBUG_OPS)
	cp bin/undionly.kpxe bin/undionly_ttys1.kpxe

bin/undionly_ttys2.kpxe: script.ipxe source.touch
	$(MAKE) -C src veryclean
	env -i PATH=$(PATH) $(MAKE) $(MFLAGS) -C src bin/undionly.kpxe EMBED=../../script.ipxe EXTRAVERSION="+(ttys2)" T3KTON_SOL=2 $(DEBUG_OPS)
	cp bin/undionly.kpxe bin/undionly_ttys2.kpxe

bin/undionly_ttys3.kpxe: script.ipxe source.touch
	$(MAKE) -C src veryclean
	env -i PATH=$(PATH) $(MAKE) $(MFLAGS) -C src bin/undionly.kpxe EMBED=../../script.ipxe EXTRAVERSION="+(ttys3)" T3KTON_SOL=3 $(DEBUG_OPS)
	cp bin/undionly.kpxe bin/undionly_ttys3.kpxe

source.touch:
	git clone git://git.ipxe.org/ipxe.git github_source
	$(RM) -f src/config/local/*
	ln -sr config/* src/config/local
	touch source.touch

clean:
	$(RM) bin/*.kpxe

full-clean: clean
	$(RM) -r github_source
	$(RM) source.touch

.PHONY: all clean full-clean
