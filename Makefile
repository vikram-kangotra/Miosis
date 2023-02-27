include build_scripts/config.mk

LDFLAGS += -n -T src/linker.ld -nostdlib

BOOT_OBJ = $(BUILD_DIR)/boot/boot.o
KERNEL_OBJ = $(wildcard $(BUILD_DIR)/kernel/*.o $(BUILD_DIR)/kernel/*/*.o)

ELF_FILE = $(BUILD_DIR)/miosis.elf
ISO_FILE = $(BUILD_DIR)/miosis.iso
ISO_DIR = $(BUILD_DIR)/isodir
GRUB_CFG = $(ISO_DIR)/boot/grub/grub.cfg

.PHONY: all clean always iso

all: iso

include build_scripts/toolchain.mk

check_multiboot: 
	@if grub-file --is-x86-multiboot $(ELF_FILE); then \
		echo "Multiboot confirmed"; \
	else \
		echo "The file is not multiboot"; \
		exit 1; \
	fi

iso: $(ISO_FILE)
$(ISO_FILE): $(GRUB_CFG) $(ELF_FILE) | check_multiboot
	@cp $(ELF_FILE) $(ISO_DIR)/boot/miosis.elf
	@grub-mkrescue /usr/lib/grub/i386-pc -o $(ISO_FILE) $(ISO_DIR)

$(ELF_FILE): boot kernel
	$(TARGET_LD) $(LDFLAGS) -o $(ELF_FILE) $(BOOT_OBJ) $(KERNEL_OBJ)

$(GRUB_CFG): always
	@mkdir -p $(ISO_DIR)/boot/grub
	@cp grub.cfg $(GRUB_CFG)

boot: always
	$(MAKE) -C src/boot

kernel: always
	$(MAKE) -C src/kernel

always:
	@mkdir -p $(BUILD_DIR)

clean:
	@rm -rf $(BUILD_DIR)
