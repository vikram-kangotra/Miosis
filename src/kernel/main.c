#include <stdint.h>
#include "vga/vga.h"

void kernel_main() {
    vga_init();
    vga_puts("Hello, world!");
}
