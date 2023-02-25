ASMFLAGS += -f elf

BUILD_DIR := $(BUILD_DIR)/boot

BOOT_OBJ = $(BUILD_DIR)/boot.o

.PHONY: all clean

all: $(BOOT_OBJ)

$(BOOT_OBJ): boot.asm always
	$(TARGET_ASM) $(ASMFLAGS) -o $@ $<

always:
	@mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)
