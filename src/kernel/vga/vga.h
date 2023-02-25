#ifndef VGA_H
#define VGA_H

#include <stdint.h>

void vga_init();
void vga_clear();
void vga_putc(char c);
void vga_puts(const char *s);
void vga_set_color(uint8_t color);
void vga_set_cursor(uint8_t x, uint8_t y);
void vga_get_cursor(uint8_t *x, uint8_t *y);

#endif
