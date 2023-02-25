include build_scripts/config.mk

LDFLAGS += -n -T src/linker.ld -nostdlib

BOOT_OBJ = $(BUILD_DIR)/boot/boot.o
KERNEL_OBJ = $(wildcard $(BUILD_DIR)/kernel/*.o $(BUILD_DIR)/kernel/*/*.o)

ELF_FILE = $(BUILD_DIR)/miosis.elf
ISO_FILE = $(BUILD_DIR)/miosis.iso

.PHONY: all clean always iso

all: iso

include build_scripts/toolchain.mk

check_multiboot: $(ELF_FILE)
	@if grub-file --is-x86-multiboot $(ELF_FILE); then \
		echo "Multiboot confirmed"; \
	else \
		echo "The file is not multiboot"; \
		exit 1; \
	fi

iso: $(ISO_FILE)
$(ISO_FILE): $(ELF_FILE) check_multiboot
	@mkdir -p $(BUILD_DIR)/isodir/boot/grub
	@cp $(ELF_FILE) $(BUILD_DIR)/isodir/boot/miosis.elf
	@cp grub.cfg $(BUILD_DIR)/isodir/boot/grub/grub.cfg
	@grub-mkrescue /usr/lib/grub/i386-pc -o $(ISO_FILE) $(BUILD_DIR)/isodir

$(ELF_FILE): $(BOOT_OBJ) $(KERNEL_OBJ)
	$(TARGET_LD) $(LDFLAGS) -o $(ELF_FILE) $^

$(BOOT_OBJ): always
	$(MAKE) -C src/boot

$(KERNEL_OBJ): always
	$(MAKE) -C src/kernel

always:
	@mkdir -p $(BUILD_DIR)

clean:
	@rm -rf $(BUILD_DIR)
