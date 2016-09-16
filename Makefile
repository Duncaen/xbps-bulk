TOBUILD = $(wildcard tobuild/*)
BUILT		= $(patsubst tobuild/%,built/%,$(TOBUILD))

all: $(BUILT)
	@echo "[Done]"

print_pkgs:
	@echo $(nodir $(TOBUILD))

built/%: tobuild/%
	@echo "[xbps-src]	${@F}"
	@$(DISTDIR)/xbps-src -L -m $(MASTERDIR) -H $(HOSTDIR) pkg ${@F}; \
		rval=$$?; [ $$rval -eq 2 ] && exit 0 || exit $$rval
	@touch $@
	@rm tobuild/${@F}

-include deps.mk
-include config.mk

clean:
	@rm -f built/*
	@echo "[Clean]"

.PHONY: all print_pkgs clean
