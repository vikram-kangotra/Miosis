#include "vga.h"
#include <stddef.h>

typedef enum {
    VGA_COLOR_BLACK = 0,
    VGA_COLOR_BLUE = 1,
    VGA_COLOR_GREEN = 2,
    VGA_COLOR_CYAN = 3,
    VGA_COLOR_RED = 4,
    VGA_COLOR_MAGENTA = 5,
    VGA_COLOR_BROWN = 6,
    VGA_COLOR_LIGHT_GREY = 7,
    VGA_COLOR_DARK_GREY = 8,
    VGA_COLOR_LIGHT_BLUE = 9,
    VGA_COLOR_LIGHT_GREEN = 10,
    VGA_COLOR_LIGHT_CYAN = 11,
    VGA_COLOR_LIGHT_RED = 12,
    VGA_COLOR_LIGHT_MAGENTA = 13,
    VGA_COLOR_LIGHT_BROWN = 14,
    VGA_COLOR_WHITE = 15,
} vga_color_t;

uint16_t* vga_buffer = (uint16_t*) 0xB8000;

const uint8_t VGA_WIDTH = 80;
const uint8_t VGA_HEIGHT = 25;

uint8_t vga_x = 0;
uint8_t vga_y = 0;

vga_color_t vga_color;

uint8_t vga_entry_color(vga_color_t fg, vga_color_t bg) {
    return fg | bg << 4;
}

void vga_entry_at(char c, uint8_t color, uint8_t x, uint8_t y) {
    const uint16_t index = y * VGA_WIDTH + x;
    vga_buffer[index] = c | color << 8;
}

void vga_init() {
    vga_color = vga_entry_color(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);
    vga_clear();
}

void vga_clear() {

    for (uint8_t y = 0; y < VGA_HEIGHT; y++) {
        for (uint8_t x = 0; x < VGA_WIDTH; x++) {
            vga_entry_at(' ', vga_color, x, y);
        }
    }
}

void vga_putc(char c) {
    vga_entry_at(c, vga_color, vga_x, vga_y);
    vga_x++;
    if (vga_x >= VGA_WIDTH) {
        vga_x = 0;
        vga_y++;
    }
}

void vga_puts(const char *s) {
    for (size_t i = 0; s[i] != '\0'; i++) {
        vga_putc(s[i]);
    }
}

void vga_set_color(uint8_t color) {
    vga_color = color;
}

void vga_set_cursor(uint8_t x, uint8_t y) {
    // ...
}

void vga_get_cursor(uint8_t *x, uint8_t *y) {
    // ...
}
