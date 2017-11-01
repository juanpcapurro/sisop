#include "decls.h"

static unsigned ticks=0;

void timer() {
    if (++ticks == 15) {
        vga_write("Transcurrieron 15 ticks", 20, 0x07);
    }
    if (ticks == 30) {
        vga_write("Transcurrieron 15 ticks", 20, 0x70);
        ticks=0;
    }
}
