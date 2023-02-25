CFLAGS += -ffreestanding
LDFLAGS := -nostdlib

BUILD_DIR := $(BUILD_DIR)/kernel

SRC = $(wildcard *.c */*.c)
OBJ = $(patsubst %.c, $(BUILD_DIR)/%.o, $(SRC))

.PHONY: all clean

all: $(OBJ)

$(BUILD_DIR)/vga/vga.o: vga/vga.c always
	$(TARGET_CC) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR)/main.o: main.c always
	$(TARGET_CC) $(CFLAGS) -c -o $@ $<

always:
	@mkdir -p $(BUILD_DIR)/vga

clean:
	rm -rf $(BUILD_DIR)
