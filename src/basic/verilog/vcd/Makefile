PACKAGE = sg48
DEVICE = up5k
PROJ = peter
PIN_DEF = 5k.pcf
SEED = 10
SHELL := /bin/bash # Use bash syntax
BUILD_DIR = ./build
SRC_DIR = ./
TEST_DIR = ./

all: $(BUILD_DIR) $(BUILD_DIR)/$(PROJ).bin 

VERILOG = top.v
SRC = $(foreach ii,$(VERILOG),$(addprefix $(SRC_DIR)/, $(ii)))

# $@ The file name of the target of the rule.rule
# $< first pre requisite
# $^ names of all preerquisites

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# rules for building the blif file
$(BUILD_DIR)/%.json: $(SRC)
	yosys -l $(BUILD_DIR)/build.log -p 'synth_ice40 -top top -json $(BUILD_DIR)/$(PROJ).json' $(SRC)

# asc
$(BUILD_DIR)/%.asc: $(BUILD_DIR)/%.json $(PIN_DEF) 
	nextpnr-ice40 -l $(BUILD_DIR)/nextpnr.log --seed $(SEED) --freq 20 --package $(PACKAGE) --$(DEVICE) --asc $@ --pcf $(PIN_DEF) --json $<

# bin, for programming
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.asc
	icepack $< $@

# timing
$(BUILD_DIR)/%.rpt: $(BUILD_DIR)/%.asc
	icetime -d $(DEVICE) -mtr $@ $<

debug:
	iverilog -o peter.out top.v peter_tb.v
	vvp peter.out -fst
	gtkwave test.vcd peter.gtkw

prog: $(BUILD_DIR)/$(PROJ).bin
	icesprog $<

clean:
	rm -f $(BUILD_DIR)/*

#secondary needed or make will remove useful intermediate files
.SECONDARY:
.PHONY: all prog clean formal debug

