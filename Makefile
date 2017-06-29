# Helper to generate silabs micro support libraries from SVD files
# Requires svd2rust and rustfmt

OUTDIR = ./src/devices
DIRS = $(patsubst ./svd/%,$(OUTDIR)/%,$(dir $(wildcard ./svd/*/)))
SVDS = $(sort $(wildcard ./svd/*/*.svd))
LIBS = $(patsubst ./svd/%,$(OUTDIR)/%,$(SVDS:%.svd=%.rs))
FAMILIES = $(subst /,,$(subst ./src/devices/,,$(DIRS)))

# Helper functions
device = $(notdir $(subst svd/,,$(subst .rs,,$1)))
family = $(subst /,,$(dir $(subst svd/,,$1)))

# Helper to simplify building
all: dirs generate index build

# Create output directories
dirs:
	@mkdir -p ${DIRS}

index: $(OUTDIR)/mod.rs

# Helper to create devices module
$(OUTDIR)/mod.rs:
	echo "//! Generated efm32 device index file" > $@
	echo $(foreach FAMILY,$(FAMILIES),"\npub mod $(FAMILY);\n") >> $@

# Build the library
build:
	xargo build

# Create generate command to convert all SVDs
generate: ${LIBS}

# Map library outputs from SVD inputs
${LIBS}: ${SVDS}

# Rule to build .rs files from SVDs
%.rs:
	svd2rust -i $< > $@
	-rustfmt --write-mode=replace $@
	@touch $(dir $@)mod.rs
	echo "pub mod $(call device,$@);\n" >> $(dir $@)mod.rs


# Helper to clean source outputs
clean:
	@rm -rf ./src/devices/*

.PHONY: all index 
