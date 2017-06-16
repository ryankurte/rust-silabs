# Helper to generate silabs micro support libraries from SVD files
# Requires svd2rust and rustfmt

OUTDIR = ./src/devices
DIRS = $(patsubst ./svd/%,$(OUTDIR)/%,$(dir $(wildcard ./svd/*/)))
SVDS = $(sort $(wildcard ./svd/*/*.svd))
LIBS = $(patsubst ./svd/%,$(OUTDIR)/%,$(SVDS:%.svd=%.rs))


# Helper to simplify building
all: dirs generate build

# Create output directories
dirs: 
	@mkdir -p ${DIRS}

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
	-rustfmt $@

# Helper to clean source outputs
clean:
	@rm -rf ./src/devices/*

.PHONY: all
