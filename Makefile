# Helper to generate silabs micro support libraries from SVD files
# Requires svd2rust and rustfmt

DIRS = $(patsubst ./svd/%,./src/%,$(dir $(wildcard ./svd/*/)))
SVDS = $(sort $(wildcard ./svd/*/*.svd))
LIBS = $(patsubst ./svd/%,./src/%,$(SVDS:%.svd=%.rs))

# Helper to simplify building
build: dirs ${LIBS}

# Create output directories
dirs: 
	@mkdir -p ${DIRS}

# Map library outputs from SVD inputs
${LIBS}: ${SVDS}

# Rule to build .rs files from SVDs
%.rs:
	svd2rust -i $< > $@

# Reformat newly created libs
reformat: ${LIBS}
	-rustfmt $<

# Helper to clean source outputs
clean:
	@rm -rf ./src/*

.PHONY: all
