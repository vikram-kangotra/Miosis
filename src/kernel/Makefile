CFLAGS += -ffreestanding

KERNEL_OBJ = $(BUILD_DIR)/kernel.o

.PHONY: all clean

all: $(KERNEL_OBJ)

$(KERNEL_OBJ): main.c
	$(TARGET_CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf $(BUILD_DIR)
