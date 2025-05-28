BUTANES = $(wildcard *.bu)
MACHINECONFIGS = $(BUTANES:.bu=.yaml)
INCLUDES_DIR = inc
DEPS_DIR = .deps

# Find all script files that might be referenced
INCLUDE_FILES = $(wildcard $(INCLUDES_DIR)/*)

# Create deps directory if it doesn't exist
$(shell mkdir -p $(DEPS_DIR))

all: $(BUTANES:.bu=.yaml)

# Generate dependencies for each butane file
$(DEPS_DIR)/%.d: %.bu
	@echo "Generating dependencies for $<"
	@printf "%s: %s %s\n" "$*.yaml" "$<" "$$(grep -o 'local: [^[:space:]]*' $< | cut -d' ' -f2 | sed 's|^|$(INCLUDES_DIR)/|' | tr '\n' ' ' | sed 's/ *$$//')" > $@

# Include all dependency files
-include $(BUTANES:%.bu=$(DEPS_DIR)/%.d)

%.yaml: %.bu
	butane -d $(INCLUDES_DIR) < $< > $@

# rm the machineconfigs and dependency files generated from butane files
clean:
	rm -f $(MACHINECONFIGS)
	rm -rf $(DEPS_DIR)
