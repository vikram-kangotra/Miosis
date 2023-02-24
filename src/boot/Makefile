ASMFLAGS += -f elf

BOOT_OBJ = $(BUILD_DIR)/boot.o

.PHONY: all clean

all: $(BOOT_OBJ)

$(BOOT_OBJ): boot.asm
	$(TARGET_ASM) $(ASMFLAGS) -o $@ $<

clean:
	rm -rf $(BUILD_DIR)
