BUTANES = $(wildcard butane/*.bu)
MACHINECONFIGS = $(BUTANES:butane/%.bu=%.yaml)
INCLUDES_DIR = inc
DEPS_DIR = .deps

# Enumerate all files that might be included
INCLUDE_FILES = $(wildcard $(INCLUDES_DIR)/*)

# Create deps directory if it doesn't exist
$(shell mkdir -p $(DEPS_DIR))

all: $(MACHINECONFIGS)

# Generate dependencies for each butane file
$(DEPS_DIR)/%.d: butane/%.bu
	@echo "Generating dependencies for $<"
	@printf "%s: %s %s\n" "$*.yaml" "$<" "$$(grep -o 'local: [^[:space:]]*' $< | cut -d' ' -f2 | sed 's|^|$(INCLUDES_DIR)/|' | tr '\n' ' ' | sed 's/ *$$//')" > $@

# Include all dependency files
-include $(BUTANES:butane/%.bu=$(DEPS_DIR)/%.d)

# Each machineconfig ends in yaml and depends on the same named file ending in bu
%.yaml: butane/%.bu
	butane -d $(INCLUDES_DIR) < $< > $@

# rm the machineconfigs and dependency files generated from butane files
clean:
	rm -f $(MACHINECONFIGS)
	rm -rf $(DEPS_DIR)