#include <stdint.h>

void kernel_main() {
    uint16_t *video_memory = (uint16_t *)0xb8000;
    video_memory[0] = 'H' | (0x0f << 8);
}
