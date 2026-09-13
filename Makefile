RGBASM ?= rgbasm
BUILD_DIR := build

.PHONY: all check-source clean

all: check-source

check-source:
	@mkdir -p $(BUILD_DIR)
	$(RGBASM) -D _REV0 -o $(BUILD_DIR)/home_rev0.o main.asm
	$(RGBASM) -D _REVA -o $(BUILD_DIR)/home_reva.o main.asm

clean:
	rm -rf $(BUILD_DIR)
