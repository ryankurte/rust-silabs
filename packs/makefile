# Helper makefile to extract Keil .pack files into this repo
# Place .pack files in PDIR, SVD files will be placed in family
# subdirectories under ODIR.

PDIR=./
WDIR=./work
ODIR=../svd

PACKS=$(wildcard $(PDIR)/*.pack)
ZIPS=$(subst $(PDIR),$(WDIR),$(PACKS:.pack=.zip))
DIRS=$(ZIPS:.zip=)

family = $(firstword $(subst _, ,$(notdir $(subst Keil.,,$1))))
FAMILIES = $(foreach d,$(DIRS),$(call family,$d))
OUTPUTS = $(foreach f,$(FAMILIES),$(ODIR)/$f)

all: info wdir extract

wdir:
	mkdir -p $(WDIR)

info:
	@echo "Detected families: $(FAMILIES)"
	
dbg:
	@echo "Detected families: $(FAMILIES)"
	@echo "Detected packs: $(PACKS)"
	@echo "Detected zips: $(ZIPS)"
	@echo "Detected dirs: $(DIRS)"
	@echo "Detected outputs: $(OUTPUTS)"

$(WDIR)/%.zip: $(PDIR)/%.pack
	@mkdir -p $(WDIR)
	@cp $< $@
zips: $(ZIPS)

$(WDIR)/%: $(WDIR)/%.zip
	@unzip $< -d $@
unpack: $(DIRS)

$(ODIR)/%: unpack
	@ echo "Family: $(notdir $@)"
	@ mkdir -p $@
	cp $(wildcard $(WDIR)/Keil.$(notdir $@)*/SVD/*/*) $@
	
extract: $(OUTPUTS)

.PHONY: zips dirs
