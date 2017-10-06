#ifndef KERN1_DECL_H
#define KERN1_DECL_H

#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#define BLACK_ON_WHITE    0x70
#define GREEN_ON_BLACK    0x02
#define GREEN_ON_GREEN    0x2a
#define DOS_BSOD_COLORS   0x1f
#define BLACK_ON_YELLOW   0xe0

#define LARGO_LINEA       80
#define CANT_LINEAS       25

// write.c (función de kern0-vga copiada no-static).
void vga_write(const char *s, int8_t linea, uint8_t color);
void console_out(const char *string);
void two_stacks();

bool fmt_int(uint32_t value, char *str, size_t bufsize);

#endif
